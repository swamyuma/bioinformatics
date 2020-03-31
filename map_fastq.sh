#!/bin/bash

# define usage

usage() {
    echo -e "./map_fastq.sh\n \
           -r <ref_genome>\n \
           -i <input_fq>\n \
           -o <mapping_dir>\n \
           -e <run_id>\n \
           -g <genome>\n"
    exit 1
}

while getopts ":r:i:o:e:g:" option; do

    case $option in
        r) REF_FILE=$OPTARG ;;
        i) INPUT_FASTQ_FILE=$OPTARG ;;
        o) MAPPING_DIR=$OPTARG ;;
        e) RUN_ID=$OPTARG ;;
        g) GENOME=$OPTARG ;;
        *) usage ;;
    esac
done


TODAY=$(date)

MAPPING_PERM="BwaC"

echo "==================================="
echo ${TODAY}
echo "-----------------------------------"
echo -e "ref_name: ${REF_FILE}\nparams: ${MAPPING_PERM}\ninput: ${INPUT_FASTQ_FILE}\noutput:${MAPPING_DIR}\nref_name: ${GENOME}\nrun_id: ${RUN_ID}"
echo "==================================="

make -j -f Makefile \
   ref_fasta=${REF_FILE} \
   input_fastq=${INPUT_FASTQ_FILE} \
   output_dir=${MAPPING_DIR} \
   run_id=${EXP_ID} \
   ref_name=${GENOME}
