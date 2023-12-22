#!/bin/bash

files=()
keystore=""
password=""

help() {
  echo "
  Usage:
    -f <file> (repeatable)
    -k <keystore>
    -p <password>
  "
}

if [[ "${1}" == "" ]]; then
    help
    exit 1
fi

while getopts "f:k:p:" o; do
  case "${o}" in
    f) files+=("${OPTARG}") ;;
    k) keystore="${OPTARG}" ;;
    p) password="${OPTARG}" ;;
    *) help
       exit 1 ;;
  esac
done

for f in "${files[@]}" ; do
  yes | keytool -import \
    -alias "$(basename "${f}")" \
    -file "${f}" \
    -keystore "${keystore}" \
    -storepass "${password}"
done