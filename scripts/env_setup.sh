#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

set_path() {
  export PATH=${PATH}:"${SCRIPT_DIR}/tools"
}

set_path