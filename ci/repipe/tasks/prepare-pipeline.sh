#!/usr/bin/env bash

set -ueo pipefail

function main() {
    assemble_pipeline
}

function assemble_pipeline() {
    if ! ls -1 automation/ci/deploy-infra/per-env-tasks/${ENV_NAME}/*.yml &> /dev/null; then
        echo "INFO: copying pipeline definition"
        cp -p automation/ci/deploy-infra/pipeline.yml \
            prepared-pipeline/assembled-pipeline.yml
        return
    fi
    echo "INFO: assembling pipeline definition"
    spruce merge \
        automation/ci/deploy-infra/pipeline.yml \
        automation/ci/deploy-infra/per-env-tasks/${ENV_NAME}/*.yml \
        > prepared-pipeline/assembled-pipeline.yml
}

main "$@"
