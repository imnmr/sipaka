#!/bin/bash -e

bpmn_dir="bpmn"
out_dir="$bpmn_dir/exports"

for file in $(find "$bpmn_dir"); do
	if [[ -f "$file" && "${file##*.}" == 'tok' ]]; then
		tok check "$file"
		tok bpmn "$file" >/dev/null
		tok svg "$file" >/dev/null
	fi
done
