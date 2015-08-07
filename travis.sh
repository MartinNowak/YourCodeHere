#!/bin/bash

set -e -o pipefail

for file in $(ls *.d); do
    NAME=$(basename $file .d)
    echo "Running ${NAME}"
    if [ -r ${NAME}.inp ]; then
        dmd -run $file < ${NAME}.inp | tee ${NAME}.out
    else
        dmd -run $file | tee ${NAME}.out
    fi
    if [ -f ${NAME}.exp ]; then
        diff -u ${NAME}.exp ${NAME}.out
    fi
    rm ${NAME}.out
done
