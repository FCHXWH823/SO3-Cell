import gurobipy as gp
m = gp.read('/home/wx2356/SO3-Cell/Framework/CellGen/gurobi_dumps/P360_MINITNTK_misalign.lp')
m.computeIIS()
m.write('iis_misalign.ilp')
print('IIS written to iis_misalign.ilp')
# Print the IIS constraints
for c in m.getConstrs():
    if c.IISConstr:
        print(f"  IIS: {c.ConstrName}")
