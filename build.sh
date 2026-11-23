#!/bin/bash -e

bpmn_dir="bpmn"
out_dir="$bpmn_dir/exports"

for file in $(find "$bpmn_dir"); do
	if [[ -f "$file" && "${file##*.}" == 'tok' ]]; then
		tok check "$file"
	fi
done

for file in $(find "$bpmn_dir"); do
	if [[ -f "$file" && "${file##*.}" == 'tok' ]]; then
		tok bpmn "$file"
		tok svg "$file"
	fi
done
