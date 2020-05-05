#!/bin/bash

set -e

if [[ -n "${COVID19_DEBUG}" ]]; then
    set -x
fi

function usage() {
    echo -n \
        "Usage: $(basename "$0")
Process data for CovidCareMap.
"
}

UPDATE_ROOT=${1}

NOTEBOOKS_TO_RUN=(
    "processing/Process_IHME_data.ipynb"
)

if [ "${BASH_SOURCE[0]}" = "${0}" ]; then

    if [ "${UPDATE_ROOT}" ]
    then
        pushd ${UPDATE_ROOT}
    fi

    echo "PWD"
    pwd

    mkdir -p ${UPDATE_ROOT}notebook-logs

    for notebook in "${NOTEBOOKS_TO_RUN[@]}"; do
        echo
        echo "==RUNNING ${notebook}=="
        echo


        mkdir -p ${UPDATE_ROOT}notebook-logs/$(dirname $notebook)
        papermill \
            ${UPDATE_ROOT}notebooks/${notebook} \
            ${UPDATE_ROOT}notebook-logs/${notebook}
    done

    if [ "${UPDATE_ROOT}" ]
    then
        popd
    fi

fi
