import re
import os
import gurobipy as gp
print(gp.__file__)
print(gp.__version__)
from gurobipy import GRB
import time, math
import argparse
import atexit

model = gp.Model("placement_min_cpp")
model.setParam('OutputFlag', 1)
model.setParam('LogFile', 'gurobi.log')
model.setParam('LogToConsole', 1)
model.setParam('DisplayInterval', 1)
model.setParam('TimeLimit', 120)

_log = None

def parse_args():
    p = argparse.ArgumentParser()
    p.add_argument("--cdl", required=True, help="Path to input CDL")
    p.add_argument("--cell", required=False, help="Cell name")
    p.add_argument("--subckt", required=False, help="(Deprecated) same as --cell")
    p.add_argument("--out-cell-name", default=None,
                   help="(optional) override cell name used for outputs")
    return p.parse_args()

args = parse_args()
cell_name = args.cell or args.subckt
cell_name_for_io = args.out_cell_name or args.cell

if not cell_name:
    raise SystemExit("ERROR: --cell is required (or use --subckt)")

with open(args.cdl, 'r') as f:
    lines = f.readlines()

########################################################## user define
unit_fin = 2
subckt_name = cell_name
power_net = {'VDD', 'VSS'}
######################################################################

def pr(*a, sep=" ", end="\n"):
    global _log
    if _log is None:
        _log = open(cell_name_for_io, "w", encoding="utf-8", buffering=1)
        atexit.register(_log.close)
    s = sep.join(str(x) for x in a)
    print(s, end=end)
    _log.write(s + ("" if end is None else end))
    _log.flush()

# ---- CDL parsing ----
subckt_found = False
top_trans = []
bot_trans = []
io_pins = []

nfin_pattern = re.compile(r'nfin\s*=\s*(\d+)')

net_count = {}
g_net_count = {}
sd_net_count = {}

for line in lines:
    line_strip = line.strip()
    if line_strip.upper().startswith('.SUBCKT '):
        parts = line_strip.split()
        if len(parts) > 1 and parts[1].upper() == subckt_name.upper():
            subckt_found = True
            io_pins = parts[2:]
            print("IO pins:", io_pins)
            continue

    if subckt_found:
        if line_strip.upper().startswith('.ENDS'):
            subckt_found = False
            break

        if line_strip.upper().startswith('M'):
            parts = line_strip.split()
            if len(parts) < 6:
                continue
            name = parts[0]
            D = parts[1]
            G = parts[2]
            S = parts[3]
            B = parts[4]
            ttype = parts[5].lower()

            param_str = ' '.join(parts[6:])
            nfin_match = nfin_pattern.search(param_str)
            nfin_val = 1
            if nfin_match:
                nfin_val = int(nfin_match.group(1))
            replica_count = nfin_val // unit_fin if nfin_val % unit_fin == 0 else 1

            for net in [D, G, S]:
                net_count[net] = net_count.get(net, 0) + replica_count
            for net in [D, S]:
                sd_net_count[net] = sd_net_count.get(net, 0) + replica_count
            for net in [G]:
                g_net_count[net] = g_net_count.get(net, 0) + replica_count

            for k in range(replica_count):
                new_name = name if k == 0 else f"{name}_f{k}"
                if 'pmos' in ttype:
                    top_trans.append((new_name, G, D, S, B, unit_fin))
                elif 'nmos' in ttype:
                    bot_trans.append((new_name, G, D, S, B, unit_fin))

print(net_count)
print(g_net_count)
print(sd_net_count)

print("Top Transistors (PMOS):")
for t in top_trans:
    print(t)

print("\nBottom Transistors (NMOS):")
for t in bot_trans:
    print(t)

# ---- Over-allocate columns (no predefined CPP) ----
max_trans = max(len(top_trans), len(bot_trans))
num_cols = 4 * max_trans + 3  # generous upper bound

gate_cols = [c for c in range(num_cols) if c % 2 == 1]
columns = list(range(num_cols))

print(f"num_cols={num_cols}, gate_cols={gate_cols}")

# ---- Placement variables ----

c_top = {}
for i, t in enumerate(top_trans):
    name = t[0]
    for c in gate_cols:
        for o in [0, 1]:
            c_top[(i, c, o)] = model.addVar(vtype=GRB.BINARY, name=f"c_top_{name}_c{c}_o{o}")

unique_pmos_nets = set(net for t in top_trans for net in [t[1], t[2], t[3]])
unique_pmos_nets.add("dummy")

pmos_net = {}
for c in columns:
    for net in unique_pmos_nets:
        pmos_net[(net, c)] = model.addVar(vtype=GRB.BINARY, name=f"pmos_net_{net}_c{c}")

c_bot = {}
for j, t in enumerate(bot_trans):
    name = t[0]
    for c in gate_cols:
        for o in [0, 1]:
            c_bot[(j, c, o)] = model.addVar(vtype=GRB.BINARY, name=f"c_bot_{name}_c{c}_o{o}")

unique_nmos_nets = set(net for t in bot_trans for net in [t[1], t[2], t[3]])
unique_nmos_nets.add("dummy")

nmos_net = {}
for c in columns:
    for net in unique_nmos_nets:
        nmos_net[(net, c)] = model.addVar(vtype=GRB.BINARY, name=f"nmos_net_{net}_c{c}")

# Pre-define mode4 variables (used in gate alignment constraints below)
# mode4[c] = 1 iff column c is a poly-cut column: both rows real, different gate nets
mode4 = {}
for c in gate_cols:
    mode4[c] = model.addVar(vtype=GRB.BINARY, name=f"mode4_c{c}")

# ---- Placement constraints ----

# Each PMOS transistor placed exactly once
for i, t in enumerate(top_trans):
    name, G, D, S, B, nfin = t
    if i == 0:  # symmetry breaking: fix first PMOS to orientation 0
        model.addConstr(gp.quicksum(c_top[(i, c, 0)] for c in gate_cols) == 1,
                        name=f"top_assign_orient0_{name}")
        model.addConstr(gp.quicksum(c_top[(i, c, 1)] for c in gate_cols) == 0,
                        name=f"top_assign_orient1_{name}")
    else:
        model.addConstr(gp.quicksum(c_top[(i, c, o)] for c in gate_cols for o in [0, 1]) == 1,
                        name=f"top_assign_{name}")
    for c in gate_cols:
        # Gate net link
        model.addConstr(c_top[(i, c, 0)] + c_top[(i, c, 1)] <= pmos_net[(G, c)],
                        name=f"pmos_gate_{name}_c{c}")
        # S/D net link (orientation 0: S left, D right)
        model.addConstr(c_top[(i, c, 0)] <= pmos_net[(S, c - 1)],
                        name=f"pmos_S_{name}_c{c}_o0")
        model.addConstr(c_top[(i, c, 0)] <= pmos_net[(D, c + 1)],
                        name=f"pmos_D_{name}_c{c}_o0")
        # S/D net link (orientation 1: D left, S right)
        model.addConstr(c_top[(i, c, 1)] <= pmos_net[(D, c - 1)],
                        name=f"pmos_D_{name}_c{c}_o1")
        model.addConstr(c_top[(i, c, 1)] <= pmos_net[(S, c + 1)],
                        name=f"pmos_S_{name}_c{c}_o1")
        # Gate alignment: NMOS must carry gate net G (Mode 1), be dummy (Mode 3), or poly-cut (Mode 4).
        if G in unique_nmos_nets:
            model.addConstr(c_top[(i, c, 0)] + c_top[(i, c, 1)] <= nmos_net[(G, c)] + nmos_net[("dummy", c)] + mode4[c],
                            name=f"gate_align_top_{name}_c{c}")
        else:
            # G absent from NMOS universe -> Mode 3 (NMOS dummy) or Mode 4 (NMOS real, different net).
            model.addConstr(c_top[(i, c, 0)] + c_top[(i, c, 1)] <= nmos_net[("dummy", c)] + mode4[c],
                            name=f"gate_align_top_{name}_c{c}")

# Each NMOS transistor placed exactly once
for j, t in enumerate(bot_trans):
    name, G, D, S, B, nfin = t
    model.addConstr(gp.quicksum(c_bot[(j, c, o)] for c in gate_cols for o in [0, 1]) == 1,
                    name=f"bot_assign_{name}")
    for c in gate_cols:
        model.addConstr(c_bot[(j, c, 0)] + c_bot[(j, c, 1)] <= nmos_net[(G, c)],
                        name=f"nmos_gate_{name}_c{c}")
        model.addConstr(c_bot[(j, c, 0)] <= nmos_net[(S, c - 1)],
                        name=f"nmos_S_{name}_c{c}_o0")
        model.addConstr(c_bot[(j, c, 0)] <= nmos_net[(D, c + 1)],
                        name=f"nmos_D_{name}_c{c}_o0")
        model.addConstr(c_bot[(j, c, 1)] <= nmos_net[(D, c - 1)],
                        name=f"nmos_D_{name}_c{c}_o1")
        model.addConstr(c_bot[(j, c, 1)] <= nmos_net[(S, c + 1)],
                        name=f"nmos_S_{name}_c{c}_o1")
        # Gate alignment: PMOS must carry gate net G (Mode 1), be dummy (Mode 3), or poly-cut (Mode 4).
        if G in unique_pmos_nets:
            model.addConstr(c_bot[(j, c, 0)] + c_bot[(j, c, 1)] <= pmos_net[(G, c)] + pmos_net[("dummy", c)] + mode4[c],
                            name=f"gate_align_bot_{name}_c{c}")
        else:
            # G absent from PMOS universe -> Mode 3 (PMOS dummy) or Mode 4 (PMOS real, different net).
            model.addConstr(c_bot[(j, c, 0)] + c_bot[(j, c, 1)] <= pmos_net[("dummy", c)] + mode4[c],
                            name=f"gate_align_bot_{name}_c{c}")

# At most one transistor per gate column per row; dummy if empty
for c in gate_cols:
    model.addConstr(
        gp.quicksum(c_top[(i, c, o)] for i in range(len(top_trans)) for o in [0, 1]) <= 1,
        name=f"pmos_one_per_col_{c}")
    model.addConstr(
        gp.quicksum(c_top[(i, c, o)] for i in range(len(top_trans)) for o in [0, 1])
        + pmos_net[("dummy", c)] == 1,
        name=f"dummy_assign_pmos_col_{c}")
    model.addConstr(
        gp.quicksum(c_bot[(j, c, o)] for j in range(len(bot_trans)) for o in [0, 1]) <= 1,
        name=f"nmos_one_per_col_{c}")
    model.addConstr(
        gp.quicksum(c_bot[(j, c, o)] for j in range(len(bot_trans)) for o in [0, 1])
        + nmos_net[("dummy", c)] == 1,
        name=f"dummy_assign_nmos_col_{c}")

# Exactly one net per column per row
for c in columns:
    model.addConstr(gp.quicksum(pmos_net[(net, c)] for net in unique_pmos_nets) == 1,
                    name=f"pmos_one_net_col_{c}")
    model.addConstr(gp.quicksum(nmos_net[(net, c)] for net in unique_nmos_nets) == 1,
                    name=f"nmos_one_net_col_{c}")

# ---- Mode 3 support: XOR / guard / col_used / spacer ----
# Mode 1: both rows real (same gate net)   — always valid.
# Mode 2: both rows dummy                  — always valid.
# Mode 3: exactly one row is dummy         — valid iff both adjacent gate columns
#          are fully dummy guards (isolates the half-driven poly stripe).
gate_cols_set = set(gate_cols)
mode3   = {}
col_used = {}
spacer  = {}
for c in gate_cols:
    mode3[c]    = model.addVar(vtype=GRB.BINARY, name=f"mode3_c{c}")
    col_used[c] = model.addVar(vtype=GRB.BINARY, name=f"col_used_c{c}")
    spacer[c]   = model.addVar(vtype=GRB.BINARY, name=f"spacer_c{c}")

for c in gate_cols:
    pd = pmos_net[("dummy", c)]
    nd = nmos_net[("dummy", c)]
    # mode3[c] = XOR(pd, nd): 1 iff exactly one row is dummy
    model.addConstr(mode3[c] >= pd - nd,       name=f"mode3_lb1_c{c}")
    model.addConstr(mode3[c] >= nd - pd,       name=f"mode3_lb2_c{c}")
    model.addConstr(mode3[c] <= pd + nd,       name=f"mode3_ub1_c{c}")
    model.addConstr(mode3[c] <= 2 - pd - nd,   name=f"mode3_ub2_c{c}")
    # mode4[c]: both rows real, different gate nets (poly cut). No guards needed.
    model.addConstr(mode4[c] <= 1 - pd, name=f"mode4_pmos_real_c{c}")
    model.addConstr(mode4[c] <= 1 - nd, name=f"mode4_nmos_real_c{c}")
    # Guard columns: adjacent gate cols must be fully dummy, and count toward CPP
    if (c - 2) in gate_cols_set:
        model.addConstr(pmos_net[("dummy", c - 2)] >= mode3[c], name=f"guard_pmos_left_c{c}")
        model.addConstr(nmos_net[("dummy", c - 2)] >= mode3[c], name=f"guard_nmos_left_c{c}")
        model.addConstr(col_used[c - 2]            >= mode3[c], name=f"col_used_guard_left_c{c}")
    if (c + 2) in gate_cols_set:
        model.addConstr(pmos_net[("dummy", c + 2)] >= mode3[c], name=f"guard_pmos_right_c{c}")
        model.addConstr(nmos_net[("dummy", c + 2)] >= mode3[c], name=f"guard_nmos_right_c{c}")
        model.addConstr(col_used[c + 2]            >= mode3[c], name=f"col_used_guard_right_c{c}")
    # col_used[c] = 1 if >=1 row is real; guards forced by constraints above
    model.addConstr(col_used[c] >= 1 - pd, name=f"col_used_pmos_c{c}")
    model.addConstr(col_used[c] >= 1 - nd, name=f"col_used_nmos_c{c}")
    # Voluntary Mode 2 spacer: optimizer can mark any both-dummy col as counting toward CPP
    model.addConstr(spacer[c] <= pd, name=f"spacer_dummy_pmos_c{c}")
    model.addConstr(spacer[c] <= nd, name=f"spacer_dummy_nmos_c{c}")
    model.addConstr(col_used[c] >= spacer[c], name=f"col_used_spacer_c{c}")

# ---- CPP = rightmost used gate slot (1-indexed) ----
cpp_var = model.addVar(vtype=GRB.INTEGER, lb=1, name="cpp")
BIG_M = len(gate_cols) + 2
for c in gate_cols:
    gate_pos = (c + 1) // 2  # 1-indexed: col 1->1, col 3->2, col 5->3, ...
    model.addConstr(cpp_var >= gate_pos - BIG_M * (1 - col_used[c]),
                    name=f"cpp_ge_c{c}")

# Secondary objective: minimize misaligned columns (Mode 3 + Mode 4) after CPP.
# Epsilon is small enough (<1) that it never changes the optimal CPP.
misalign_penalty = gp.quicksum(mode3[c] + mode4[c] for c in gate_cols)
model.setObjective(cpp_var + misalign_penalty, GRB.MINIMIZE)

# ---- Solve ----
start_time = time.perf_counter()
model.optimize()
end_time = time.perf_counter()

if model.status == GRB.OPTIMAL or (model.status == GRB.TIME_LIMIT and model.SolCount > 0):
    real_cpp = 0
    for c in gate_cols:
        if col_used[c].X > 0.5:
            real_cpp = max(real_cpp, (c + 1) // 2)
    if model.status == GRB.OPTIMAL:
        pr("Optimal solution found.")
    else:
        pr(f"Time limit reached. Best solution CPP={real_cpp} (lower bound {int(round(model.ObjBound))}).")
    n_misalign = sum(1 for c in gate_cols if mode3[c].X > 0.5 or mode4[c].X > 0.5)
    pr(f"Optimal CPP: {real_cpp}  (misaligned columns: {n_misalign})")

    # Print transistor placements with mode annotation
    for i, t in enumerate(top_trans):
        for c in gate_cols:
            for o in [0, 1]:
                if c_top[(i, c, o)].X > 0.5:
                    m = int(round(mode3[c].X))
                    m4 = int(round(mode4[c].X))
                    if m:
                        mode_str = "Mode3(PMOS-only)"
                    elif m4:
                        mode_str = "Mode4(poly-cut)"
                    else:
                        mode_str = "Mode1"
                    pr(f"  PMOS {t[0]}: gate_col={c}, gate_pos={(c+1)//2}, orient={o}, "
                       f"G={t[1]}, D={t[2]}, S={t[3]}, {mode_str}")

    for j, t in enumerate(bot_trans):
        for c in gate_cols:
            for o in [0, 1]:
                if c_bot[(j, c, o)].X > 0.5:
                    m = int(round(mode3[c].X))
                    m4 = int(round(mode4[c].X))
                    if m:
                        mode_str = "Mode3(NMOS-only)"
                    elif m4:
                        mode_str = "Mode4(poly-cut)"
                    else:
                        mode_str = "Mode1"
                    pr(f"  NMOS {t[0]}: gate_col={c}, gate_pos={(c+1)//2}, orient={o}, "
                       f"G={t[1]}, D={t[2]}, S={t[3]}, {mode_str}")

    # Column net map (trim to real CPP)
    used_num_cols = 2 * real_cpp - 1
    pmos_columns = [None] * used_num_cols
    nmos_columns = [None] * used_num_cols
    for c in range(used_num_cols):
        for net in unique_pmos_nets:
            if pmos_net[(net, c)].X > 0.5:
                pmos_columns[c] = net
        for net in unique_nmos_nets:
            if nmos_net[(net, c)].X > 0.5:
                nmos_columns[c] = net
    pr("PMOS:", 1, pmos_columns)
    pr("NMOS:", 1, nmos_columns)

    # Report voluntary spacers
    spacer_cols = [c for c in gate_cols if spacer[c].X > 0.5
                   and int(round(mode3[c].X)) == 0
                   and (c + 1) // 2 <= real_cpp]
    if spacer_cols:
        pr("Voluntary Mode-2 spacers at gate_cols:", spacer_cols)

    # Mode breakdown
    n_mode1 = sum(1 for c in gate_cols if col_used[c].X > 0.5 and mode3[c].X < 0.5
                  and mode4[c].X < 0.5
                  and (pmos_net[('dummy', c)].X < 0.5 or nmos_net[('dummy', c)].X < 0.5))
    n_mode3 = sum(1 for c in gate_cols if mode3[c].X > 0.5)
    n_mode4 = sum(1 for c in gate_cols if mode4[c].X > 0.5)
    n_mode2 = sum(1 for c in gate_cols if col_used[c].X > 0.5
                  and pmos_net[('dummy', c)].X > 0.5 and nmos_net[('dummy', c)].X > 0.5)
    pr(f"  Mode 1 columns: {n_mode1}")
    pr(f"  Mode 3 columns: {n_mode3}")
    pr(f"  Mode 4 (poly-cut) columns: {n_mode4}")
    pr(f"  Mode 2 (guard/spacer) columns: {n_mode2}")

elif model.status == GRB.INFEASIBLE:
    pr("INFEASIBLE: Cannot satisfy placement constraints.")
    pr("  Possible cause: no matching gate literal between PMOS and NMOS rows.")
    try:
        model.computeIIS()
        model.write("iis.ilp")
        pr("  IIS written to iis.ilp")
    except gp.GurobiError:
        pass
else:
    pr(f"No optimal solution found. Status: {model.status}")

pr(f"Runtime: {round(end_time - start_time, 3)}s")

# ---- Write metrics CSV ----
import csv as _csv_mod
_runtime = round(end_time - start_time, 3)
if model.status == GRB.OPTIMAL:
    _status = "optimal"; _gap = 0.0
elif model.status == GRB.TIME_LIMIT and model.SolCount > 0:
    _status = "time_limit_feasible"; _gap = round(model.MIPGap * 100, 4)
elif model.status == GRB.INFEASIBLE:
    _status = "infeasible"; _gap = ""
else:
    _status = f"status_{model.status}"; _gap = ""

def _safe(fn):
    try: return fn()
    except Exception: return ""

_row = {
    "cell":        cell_name_for_io,
    "status":      _status,
    "mip_gap_pct": _gap,
    "runtime_s":   _runtime,
    "cpp_real":    _safe(lambda: real_cpp),
}
_csv_path = cell_name_for_io + ".csv"
with open(_csv_path, "w", newline="", encoding="utf-8") as _fcsv:
    _w = _csv_mod.DictWriter(_fcsv, fieldnames=list(_row.keys()))
    _w.writeheader()
    _w.writerow(_row)
print(f"Metrics CSV written: {_csv_path}")