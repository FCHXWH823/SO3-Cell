#!/bin/sh

if [ -z "$1" ]; then
  echo "Error: An argument is required."
  echo "Usage: $0 <your_argument>"
  exit 1
fi

module load pegasus/21.3
module load quantus/21.1
module load liberate/23.1

echo "Argument provided: $1"

export BASE_DIR=$(cd "$(dirname "$0")" && pwd)

export INPUT_DIR="${BASE_DIR}/inputs"
export SCRIPT_DIR="${BASE_DIR}/scripts"

export RESULT_DIR="${BASE_DIR}/results"
export LOG_DIR="${BASE_DIR}/logs"
export DONE_DIR="${BASE_DIR}/done"

mkdir -p ${LOG_DIR}
mkdir -p ${RESULT_DIR}
mkdir -p ${DONE_DIR}

export PVL_FILE="${INPUT_DIR}/lvs.pvl"
export LIB_NAME=$1

### DEFAULT USER INPUT
export PROCESS=tt
export VDD=0.7
export TEMP=25
export MIN_TRAN=6e-12
export MAX_TRAN=7e-11
export MIN_OUT_CAP=1e-16
export INV_X1_PIN_CAP=0.0003096

CDL_FILE="${BASE_DIR}/../../Enablement/cdl/${LIB_NAME}.cdl"
GDS_FILE="${BASE_DIR}/../../Enablement/gds/${LIB_NAME}.gds"

CELLS=`cat ${CDL_FILE} | grep -i .SUBCKT | awk '{print $2}'`

for CELL in $CELLS; do
	if [ ! -e ${DONE_DIR}/${CELL}_${LIB_NAME}_lvs.done ]; then
		export LVS_LOG_FILE="${LOG_DIR}/${CELL}_${LIB_NAME}.lvs.log"

		### PEGASUS LVS ###
		pegasus \
			-lvs \
			-gds ${GDS_FILE} \
			-source_cdl ${CDL_FILE} \
			-spice ${CELL}_${LIB_NAME}.cdl \
			-source_top_cell ${CELL} \
			-layout_top_cell ${CELL} \
			${PVL_FILE} |& tee ${LVS_LOG_FILE} 

		touch ${DONE_DIR}/${CELL}_${LIB_NAME}_lvs.done
	fi

done
wait


for CELL in $CELLS; do
	if [ ! -e ${DONE_DIR}/${CELL}_${LIB_NAME}_pvspex.done ]; then
		export PEX_LOG_FILE="${LOG_DIR}/${CELL}_${LIB_NAME}.pex.log"

		### PEGASUS PEX ###
		pegasus \
			-ext \
			-gds ${GDS_FILE} \
			-spice ${CELL}_${LIB_NAME}.cdl \
			-rc_data \
			-top_cell ${CELL} \
			${PVL_FILE} |& tee ${PEX_LOG_FILE}
		rm *.cdl
		rm *.lmap
		rm *.lvsrpt*
		rm -rf pegasus-*
		rm lvs.pvl.rsf
		rm result.sum

		mkdir -p ${RESULT_DIR}/pex/${CELL}_${LIB_NAME}
		mv svdb ${RESULT_DIR}/pex/${CELL}_${LIB_NAME}/
		touch ${DONE_DIR}/${CELL}_${LIB_NAME}_pvspex.done
	fi
done
wait

for CELL in $CELLS; do
	if [ ! -e ${DONE_DIR}/${CELL}_${LIB_NAME}_qtspex.done ]; then
		### QUANTUS PEX ###
		export QTSPEX_LOG_FILE="${LOG_DIR}/${CELL}_${LIB_NAME}.qtspex.log"

		echo "DEFINE ${LIB_NAME} ${INPUT_DIR}/stdqrc" > ${INPUT_DIR}/techlib.defs

		mkdir -p ${RESULT_DIR}/pex/${CELL}_${LIB_NAME}

		cd ${RESULT_DIR}/pex/${CELL}_${LIB_NAME}
		${SCRIPT_DIR}/genQuantusCmd.tcl ${LIB_NAME} ${CELL} ./svdb 25 
		quantus \
			-multi_cpu 16 \
			-log_file $QTSPEX_LOG_FILE \
			-cmd run_quantus_${CELL}_${LIB_NAME}.cmd

		mv ${CELL}_${LIB_NAME}.sp ../
		cd ${BASE_DIR}
		touch ${DONE_DIR}/${CELL}_${LIB_NAME}_qtspex.done
	fi

done
wait


if [ ! -e ${DONE_DIR}/${LIB_NAME}_char.done ]; then
	### Liberate Characterization ###

	mkdir -p ${RESULT_DIR}/libchar
	mkdir -p ${RESULT_DIR}/cell_info

	python3 ${SCRIPT_DIR}/get_cell_info.py --gds ${GDS_FILE} --info_dir ${RESULT_DIR}/cell_info
	${SCRIPT_DIR}/genLibTemplate.tcl ${INPUT_DIR} ${RESULT_DIR} ${LIB_NAME} ${CELLS}
	${SCRIPT_DIR}/genCellList.tcl ${RESULT_DIR} ${SCRIPT_DIR} ${LIB_NAME} ${CELLS}
	liberate --lorder TOKENS ${SCRIPT_DIR}/char.tcl ${PROCESS} ${VDD} ${TEMP} ${MIN_TRAN} ${MAX_TRAN} ${MIN_OUT_CAP} ${INV_X1_PIN_CAP} 2>&1 | tee ${LOG_DIR}/char.log
	touch ${DONE_DIR}/${LIB_NAME}_char.done
fi
