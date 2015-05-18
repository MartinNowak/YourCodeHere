#!/bin/bash

set -e -o pipefail

for file in $(ls *.d); do
    NAME=$(basename $file .d)
    echo "Running ${NAME}"
    if [ -r ${NAME}.inp ]; then
	    exec < ${NAME}.inp
    fi
    dmd -run $file | tee ${NAME}.out
    if [ -f ${NAME}.exp ]; then
        diff -u ${NAME}.exp ${NAME}.out
    fi
    rm ${NAME}.out
done
