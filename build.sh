#!/bin/bash -e

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
bpmn_dir="$script_dir/bpmn"
out_dir="$bpmn_dir/exports"

build_tok() {
	local file="$1"
	tok check "$file"
	tok fmt -w "$file"
	tok bpmn "$file" >/dev/null
	tok svg "$file" >/dev/null
}

build_all_toks() {
	for file in $(find "$bpmn_dir"); do
		if [[ -f "$file" && "${file##*.}" == 'tok' ]]; then
			build_tok "$file"
		fi
	done
}

if [ "$1" = "layout" ]; then
	name="$2"
	tok import "$name.bpmn" -o "$name.tok"
	while ! build_tok "$name.tok"; do
		vim "$name.tok"
	done
else
	build_all_toks
fi
