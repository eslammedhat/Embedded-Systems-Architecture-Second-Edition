#!/bin/bash

BIN_IMAGE=""
ENABLE_DEBUG=""

VERBOSE_MODE=""

print_help() {
  echo "About: run qemu emulator"
  echo "Usage: ${0} -i <image> [-d]"
  echo "-d | --debug : enable debugging"
  echo "-v | --verbose: verbose mode"s
}

parse_args() {
	while [[ $# -gt 0 ]]; do
		case $1 in
			-i|--image)
				BIN_IMAGE="$2"
				shift # past argument
				shift # past value
				;;
			-d|--debug)
				ENABLE_DEBUG="-S -gdb tcp::3333"
				shift # past argument
				;;
      -v|--verbose)
				VERBOSE_MODE="x"
				shift # past argument
				;;
			-h|--help)
				print_help
				exit 0
				;;
			*)
				shift # past argument
				;;
		esac
	done
}

log_message() {
  if [[ -n $VERBOSE_MODE ]]; then
    echo $1
  fi
}


run_qemu() {
  local IMAGE="$(realpath $(pwd)/${1} 2> /dev/null)"
  local ret=$?
  log_message "v : image path is ${IMAGE}"
  if [[ -n $BIN_IMAGE && $ret -eq 0 && -f $IMAGE ]]; then
    local COMMAND="qemu-system-arm \
            -M lm3s6965evb \
            --kernel ${IMAGE} \
            -nographic \
            ${ENABLE_DEBUG}"
            log_message "v : command is ${COMMAND}"
    eval ${COMMAND}
 else
    echo "Error: file not found: $BIN_IMAGE, please provide a valid image path."
    exit 1
  fi
}

parse_args "$@"
run_qemu ${BIN_IMAGE}
