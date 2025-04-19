#!/bin/bash

find home -name '*.md' | sort | while read -r file; do
  title=$(basename "$file" .md)
  relpath="${file#home/}"
  echo "- [${title}](./${relpath})"
done
