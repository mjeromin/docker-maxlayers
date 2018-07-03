#!/usr/bin/env bash

# accept user parameter, otherwise default to 124
bloat_file_count=${1:-124}
bloat_file_size="10M"

# print the usage message and exit
function usage(){
	echo "USAGE: $0 [<number of bloat files to generate>]"
	exit 1
}

# tests ensure operator has provided a param and it is an INT
if [[ -z "$bloat_file_count" ]] || [[ ! $bloat_file_count =~ ^-?[0-9]+$ ]]; then
	usage
fi

for ((i=1; i<=bloat_file_count; i++))
do
	dd if=/dev/urandom of=layer${i} bs=${bloat_file_size} count=1
done

