#!/bin/sh

SUBDIRS="catppuccin everforest"

# For each theme directory
for dir in $SUBDIRS; do
	# Create the -all directory if it doesn't exist
	mkdir -p "${dir}-all"

	# Find all regular files in the source directory recursively, excluding dot files
	find "$dir" -type f ! -name ".*" -print0 | while IFS= read -r -d '' file; do
		# Get the relative path from the theme directory
		relpath=${file#"$dir/"}
		# Replace directory separators with underscores
		newname=$(echo "$relpath" | tr '/' '_')

		# Create the symlink in the -all directory
		# If a file with same name exists, it will be skipped
		if [ ! -e "${dir}-all/$newname" ]; then
			ln -s "../$file" "${dir}-all/$newname"
		else
			echo "Warning: Skipping duplicate filename: $filename"
		fi
	done
done
