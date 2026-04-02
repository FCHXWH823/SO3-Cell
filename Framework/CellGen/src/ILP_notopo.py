"""
ILP_notopo.py – dispatcher for topology-optimization-free ILP scripts.

Usage (identical interface to ILP_SO3_flex.py):
    python ILP_notopo.py --arch SH --cdl ... --cell ... [other args]
    python ILP_notopo.py --arch DH --cdl ... --cell ... --mh-order N_FIRST [other args]

Dispatches to:
    SH  ->  ILP_SH_notopo.py
    DH  ->  ILP_DH_notopo.py
"""
import subprocess
import sys
from pathlib import Path

SRC = Path(__file__).resolve().parent


def main():
    # run_cell.py does NOT forward --arch to ILP scripts.
    # Detect DH by presence of --mh-order (only added for DH cells).
    # Also support explicit --arch override if caller does pass it.
    args_raw = sys.argv[1:]
    is_dh = ("--mh-order" in args_raw or
              "--arch=DH" in args_raw or
              ("--arch" in args_raw and
               args_raw[args_raw.index("--arch") + 1] == "DH"))

    if is_dh:
        target = SRC / "ILP_DH_notopo.py"
    else:
        target = SRC / "ILP_SH_notopo.py"

    # Strip --arch <value> or --arch=DH from forwarded args (inner scripts don't accept it)
    filtered = []
    skip_next = False
    for tok in args_raw:
        if skip_next:
            skip_next = False
            continue
        if tok == "--arch":
            skip_next = True
            continue
        if tok.startswith("--arch="):
            continue
        filtered.append(tok)

    final_cmd = [sys.executable, str(target)] + filtered
    result = subprocess.run(final_cmd)
    sys.exit(result.returncode)


if __name__ == "__main__":
    main()
