#!/bin/bash
set -e

readonly ROOT_DIR="$( cd "$( dirname "${0}" )" && cd .. && pwd )"
readonly SHA_VALUE=$(cd "${ROOT_DIR}" && git rev-parse HEAD)

readonly GITHUB_ORG=https://raw.githubusercontent.com/cyber-dojo
readonly REPO_NAME=commander
readonly BRANCH_NAME=master
readonly SCRIPT_NAME=cyber-dojo
readonly TMP_DIR=$(mktemp -d /tmp/cyber-dojo-custom.XXXXXXXXX)

remove_tmp_dir() { rm -rf ${TMP_DIR} > /dev/null; }
trap remove_tmp_dir EXIT

cd ${TMP_DIR}
curl -O --silent --fail "${GITHUB_ORG}/${REPO_NAME}/${BRANCH_NAME}/${SCRIPT_NAME}"
chmod 700 ./${SCRIPT_NAME}

readonly IMAGE_NAME=cyberdojo/custom-start-points

SHA="${SHA_VALUE}" \
  ./${SCRIPT_NAME} start-point create \
    ${IMAGE_NAME} \
      --custom \
        https://github.com/cyber-dojo/custom-start-points.git
