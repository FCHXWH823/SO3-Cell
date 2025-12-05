#!/usr/bin/env bash
set -euo pipefail

# repo root
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PYTHON="${PYTHON:-python3}"
RUNNER="$ROOT/bin/run_cell.py"
KLAYOUT="${KLAYOUT:-klayout}"

# Base setting (modify whatever you want)
# e.g, for DFFHQN_X1, if you want to make it with DUMMY_FOR_IDEAL 0, MISALIGN_COL has to be 4.
CDL_ROOT="$ROOT/../../Enablement/cdl"
CDL="${CDL:-$CDL_ROOT/SO3_L1.cdl}"
GDS_OUT="${GDS_OUT:-gds_result}"
D_GDS_OUT="$ROOT/results/gds"
if [ "$GDS_OUT" = "gds_result" ]; then
  GDS_OUT="$D_GDS_OUT"
fi
DUMMY_FOR_IDEAL="${DUMMY_FOR_IDEAL:-0}"
DUMMY_PADDING="${DUMMY_PADDING:-0}"
MISALIGN_COL="${MISALIGN_COL:-0}"

# New: architecture + multi-height order
# ARCH: SH (single-height) or DH (double-height)
ARCH="${ARCH:-SH}"
# MH_ORDER used only when ARCH=DH
MH_ORDER="${MH_ORDER:-N_FIRST}"   # or P_FIRST

# Usage helper
usage() {
  cat <<'EOF'
Usage: ./run_cell.sh [options] [cells...]
Options:
  --cdl <path>           Explicit CDL file path
  --cdl-name <name>      Use <name>.cdl under Enablement/cdl (e.g., SO3_L1)
  --cells "<c1 c2>"      Space-separated cell list to generate
  --gds-out <dir>        GDS output directory (default: gds_result)
  --dummy-for-ideal N    DUMMY_FOR_IDEAL value
  --dummy-padding N      DUMMY_PADDING value
  --misalign-col N       MISALIGN_COL value
  --arch SH|DH           Cell architecture (default: SH)
  --mh-order N_FIRST|P_FIRST  Only used when ARCH=DH
  --python <path>        Python interpreter (default: python3)
  --klayout <path>       KLayout executable (default: klayout)
  -h, --help             Show this help

Behavior:
  1) --cdl-name SO3_L1   → Generate all .SUBCKT entries in SO3_L1.cdl
  2) --cdl <file> --cells "INV_X1 NAND2_X1" → Generate only those cells
  3) Run with no args to show this help.

Examples:
  ./run_cell.sh --cdl-name SO3_L1
  ./run_cell.sh --cdl-name SO3_L1 --cells "INV_X1 NAND2_X1"
  ARCH=DH MH_ORDER=P_FIRST ./run_cell.sh --cdl-name SO3_L1 --cells "NAND2_X1"
EOF
}

ORIG_ARGC=$#
AUTO_CELLS_FROM_CDL=0
CELLS=()
CDL_NAME=""

# Parse options / arguments
while [ $# -gt 0 ]; do
  case "$1" in
    --cdl)
      CDL="$2"
      shift 2
      ;;
    --cdl-name)
      CDL_NAME="$2"
      shift 2
      ;;
    --cells)
      IFS=' ' read -r -a CELLS <<< "$2"
      shift 2
      ;;
    --gds-out)
      GDS_OUT="$2"
      shift 2
      ;;
    --dummy-for-ideal)
      DUMMY_FOR_IDEAL="$2"
      shift 2
      ;;
    --dummy-padding)
      DUMMY_PADDING="$2"
      shift 2
      ;;
    --misalign-col)
      MISALIGN_COL="$2"
      shift 2
      ;;
    --arch)
      ARCH="$2"
      shift 2
      ;;
    --mh-order)
      MH_ORDER="$2"
      shift 2
      ;;
    --python)
      PYTHON="$2"
      shift 2
      ;;
    --klayout)
      KLAYOUT="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
      shift
      CELLS+=("$@")
      break
      ;;
    *)
      # Positional handling:
      # - If it matches a CDL name under CDL_ROOT and no --cdl/--cdl-name given, use it.
      if [ -z "$CDL_NAME" ] && [ -z "${CDL_OVERRIDE_SET:-}" ] && [ -f "$CDL_ROOT/${1}.cdl" ]; then
        CDL_NAME="$1"
        shift
      else
        CELLS+=("$1")
        shift
      fi
      ;;
  esac
done

if [ -n "$CDL_NAME" ]; then
  CDL="$CDL_ROOT/${CDL_NAME}.cdl"
fi

# If the first argument matches a CDL basename (e.g., SO3_L1) under $CDL_ROOT,
# use that CDL and generate all subckts in the file.
if [ -n "$CDL_NAME" ]; then
  AUTO_CELLS_FROM_CDL=1
fi

# When nothing is specified, show usage and exit.
if [ $ORIG_ARGC -eq 0 ]; then
  usage
  exit 0
fi

# cell list you want
if [ ${#CELLS[@]} -eq 0 ]; then
  if [ "$AUTO_CELLS_FROM_CDL" -eq 1 ]; then
    mapfile -t CELLS < <("$PYTHON" - "$CDL" <<'PY'
import sys
path = sys.argv[1]
names = []
with open(path, encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        if not line or line.startswith("*"):
            continue
        if line.upper().startswith(".SUBCKT "):
            parts = line.split()
            if len(parts) > 1:
                name = parts[1]
                if name not in names:
                    names.append(name)
for n in names:
    print(n)
PY
)
    if [ ${#CELLS[@]} -eq 0 ]; then
      echo "[WARN] No .SUBCKT entries found in $CDL; defaulting to INV_X1" >&2
      CELLS=(INV_X1)
    fi
  else
    #CELLS=(INV_X1 NAND2_X1)
    ##CELLS=(NAND2_X1)
    CELLS=(INV_X1)
  fi
fi

echo "[RUN]" "$PYTHON" "$RUNNER" \
  --cdl "$CDL" \
  --cell "${CELLS[@]}" \
  --dummy-for-ideal "$DUMMY_FOR_IDEAL" \
  --dummy-padding "$DUMMY_PADDING" \
  --misalign-col "$MISALIGN_COL" \
  --gds-out "$GDS_OUT" \
  --arch "$ARCH" \
  --mh-order "$MH_ORDER" \
  --klayout "$KLAYOUT"

exec "$PYTHON" "$RUNNER" \
  --cdl "$CDL" \
  --cell "${CELLS[@]}" \
  --dummy-for-ideal "$DUMMY_FOR_IDEAL" \
  --dummy-padding "$DUMMY_PADDING" \
  --misalign-col "$MISALIGN_COL" \
  --gds-out "$GDS_OUT" \
  --arch "$ARCH" \
  --mh-order "$MH_ORDER" \
  --klayout "$KLAYOUT"
