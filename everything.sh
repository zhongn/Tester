#!/bin/bash

helpu() {
	echo " "
	echo "Fuzzy search for filename."
	echo "$0 [--match-case|--path] filename"
	echo ""
	exit
}

## set variables

MATCH="-iname"
SEARCH="."

## parse options

while [ True ]; do
if [ "$1" = "--help" -o "$1" = "-h" ]; then
	helpu
elif [ "$1" = "--match-case" -o "$1" = "-m" ]; then
	MATCH="-name"
	shift 1
elif [ "$1" = "--path" -o "$1" = "-p" ]; then
	SEARCH="${2}"
	shift 2
else
	break
fi
done

## sanitize input filenames
## create array, retain spaces

ARG=( "${@}" )
set -e

## catch obvious input error

if [ "X$ARG" = "X" ]; then
	helpu
fi

## perform search

for query in ${ARG[*]}; do
	/usr/bin/find "${SEARCH}" "${MATCH}" "*${ARG}*"
done
