#!/usr/bin/env bash
set -euo pipefail

# repo root
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

PYTHON="${PYTHON:-python3}"
RUNNER="$ROOT/bin/run_cell.py"

# Base setting (modify whaever you want)
# e.g, for DFFHQN_X1, if you want to make it with DUMMY_FOR_IDEAL 0, MISALIGN_COL has to be 4.
CDL="${CDL:-$ROOT/../../Enablement/cdl/SO3_L1.cdl}"
GDS_OUT="${GDS_OUT:-gds_result}"
DUMMY_FOR_IDEAL="${DUMMY_FOR_IDEAL:-0}"
DUMMY_PADDING="${DUMMY_PADDING:-0}"
MISALIGN_COL="${MISALIGN_COL:-0}"

# New: architecture + multi-height order
# ARCH: SH (single-height) or DH (double-height)
ARCH="${ARCH:-SH}"
# MH_ORDER used only when ARCH=DH
MH_ORDER="${MH_ORDER:-N_FIRST}"   # or P_FIRST

# cell list you want
CELLS=("$@")
if [ ${#CELLS[@]} -eq 0 ]; then
  #CELLS=(INV_X1 NAND2_X1)
  #CELLS=(NAND2_X1)
  #CELLS=(INV_X1)
fi

echo "[RUN]" "$PYTHON" "$RUNNER" \
  --cdl "$CDL" \
  --cell "${CELLS[@]}" \
  --dummy-for-ideal "$DUMMY_FOR_IDEAL" \
  --dummy-padding "$DUMMY_PADDING" \
  --misalign-col "$MISALIGN_COL" \
  --gds-out "$GDS_OUT" \
  --arch "$ARCH" \
  --mh-order "$MH_ORDER"

exec "$PYTHON" "$RUNNER" \
  --cdl "$CDL" \
  --cell "${CELLS[@]}" \
  --dummy-for-ideal "$DUMMY_FOR_IDEAL" \
  --dummy-padding "$DUMMY_PADDING" \
  --misalign-col "$MISALIGN_COL" \
  --gds-out "$GDS_OUT" \
  --arch "$ARCH" \
  --mh-order "$MH_ORDER"
