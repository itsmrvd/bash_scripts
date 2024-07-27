#!/bin/bash
# This script will create text files in a directory
# Usage: generate_files.sh 10 /home/vd9801/bash_scripts/junk

#Set params using flags
while getopts n:d: OPTIONS; do
	case ${OPTIONS} in
		n) PARAM1=${OPTARG};;
		d) PARAM2=${OPTARG};;
	esac
done

MAX_FILES=999
CREATED_FILES=0

#Set num_files to zero if parameter is not a number
[[ ${PARAM1} =~ ^[0-9]+$ ]] && NUM_FILES=${PARAM1} || NUM_FILES=0 

#Set num_files to max_files if input is greater than max_files
(( ${NUM_FILES} > ${MAX_FILES} )) && NUM_FILES=${MAX_FILES}

#Set directory to current directory if not passed
[ -z ${PARAM2} ] && WORK_DIR=$(pwd) || WORK_DIR=${PARAM2}

#Check directory exists and had write permission and files to be generated are more than zero
if [ -d "${WORK_DIR}" ] && [ -w "${WORK_DIR}" ] && (( ${NUM_FILES} > 0 )); then
	for((i=1;i<=${NUM_FILES};i++)); do
		RNDM_NUM=${RANDOM}
		echo "File $i : ${RNDM_NUM}" > ${WORK_DIR}/file_$(printf %03d ${i})$(printf %08d ${RNDM_NUM}).txt
		(( $? == 0 )) && ((CREATED_FILES++))
	done
else
	echo "ERROR: Directory not available/writable!"
fi

echo ${CREATED_FILES}/${NUM_FILES} files created in ${WORK_DIR}

