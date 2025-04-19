#!/bin/bash

# Function to clean text by removing emojis, converting to lowercase, and replacing spaces with dashes
clean_text() {
  local text="$1"
  # Remove all emoji characters and other special characters
  cleaned=$(echo "$text" | perl -C -pe 's/\p{Emoji_Presentation}|\p{Extended_Pictographic}|\p{Emoji}//g')

  # Trim leading/trailing whitespace
  cleaned=$(echo "$cleaned" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')

  # Convert to lowercase
  cleaned=$(echo "$cleaned" | tr '[:upper:]' '[:lower:]')

  # Replace spaces with dashes and remove multiple consecutive dashes
  cleaned=$(echo "$cleaned" | tr ' ' '-' | sed -e 's/-\+/-/g')

  # Remove any remaining non-alphanumeric characters except dashes
  cleaned=$(echo "$cleaned" | sed -e 's/[^a-z0-9-]//g')

  # Remove leading and trailing dashes
  cleaned=$(echo "$cleaned" | sed -e 's/^-*//' -e 's/-*$//')

  echo "$cleaned"
}

# Function to normalize a path component by component
normalize_path() {
  local path="$1"
  local normalized=""
  local IFS="/"

  # Split the path and process each component
  for component in $path; do
    if [ -n "$component" ]; then
      clean_component=$(clean_text "$component")
      if [ -n "$normalized" ]; then
        normalized="${normalized}/${clean_component}"
      else
        normalized="${clean_component}"
      fi
    fi
  done

  echo "$normalized"
}

# Function to build a hierarchical TOC structure
build_hierarchical_toc() {
  local codex_path="home/codex"
  local output_file=".docs/codex/toc.yml"

  mkdir -p "$(dirname "$output_file")"
  > "$output_file"

  echo "# Hierarchical TOC for Codex" >> "$output_file"
  echo "# Generated on $(date)" >> "$output_file"
  echo "" >> "$output_file"

  echo "# Root level entries" >> "$output_file"
  find "$codex_path" -maxdepth 1 -name "*.md" | sort | while read -r file; do
    filename=$(basename "$file" .md)
    clean_filename=$(clean_text "$filename")
    echo "- name: \"$filename\"" >> "$output_file"
    echo "  href: \"${clean_filename}.md\"" >> "$output_file"
  done

  find "$codex_path" -mindepth 1 -type d | sort | while read -r dir; do
    dir_name=$(basename "$dir")
    clean_dir_name=$(clean_text "$dir_name")
    normalized_dir_path=$(normalize_path "${dir#home/}")

    echo "" >> "$output_file"
    echo "# Entries for $dir_name" >> "$output_file"
    echo "- name: \"$dir_name\"" >> "$output_file"
    echo "  items:" >> "$output_file"

    find "$dir" -maxdepth 1 -name "*.md" | sort | while read -r file; do
      filename=$(basename "$file" .md)
      clean_filename=$(clean_text "$filename")
      echo "    - name: \"$filename\"" >> "$output_file"
      echo "      href: \"${normalized_dir_path}/${clean_filename}.md\"" >> "$output_file"
    done

    process_subdirectories "$dir" "$output_file" "    "
  done

  echo "Hierarchical TOC generated at $output_file"
}

# Function to recursively process subdirectories
process_subdirectories() {
  local dir="$1"
  local output_file="$2"
  local indent="$3"

  find "$dir" -mindepth 1 -maxdepth 1 -type d | sort | while read -r subdir; do
    subdir_name=$(basename "$subdir")
    clean_subdir_name=$(clean_text "$subdir_name")

    # Count markdown files in this subdirectory
    file_count=$(find "$subdir" -maxdepth 1 -name "*.md" | wc -l)

    # Only process subdirectories that have markdown files or sub-subdirectories with markdown files
    if [ "$file_count" -gt 0 ] || [ "$(find "$subdir" -type f -name "*.md" | wc -l)" -gt 0 ]; then
      echo "${indent}- name: \"$subdir_name\"" >> "$output_file"

      # Check if subdirectory has an index.md file
      if [ -f "$subdir/index.md" ]; then
        echo "${indent}  href: \"$(normalize_path "${subdir#home/}")/index.md\"" >> "$output_file"
      fi

      echo "${indent}  items:" >> "$output_file"

      # Add markdown files in this subdirectory
      find "$subdir" -maxdepth 1 -name "*.md" | sort | while read -r file; do
        filename=$(basename "$file" .md)
        # Skip index.md as it's already handled above
        if [ "$filename" != "index" ]; then
          clean_filename=$(clean_text "$filename")
          normalized_path="$(normalize_path "${subdir#home/}")"
          echo "${indent}    - name: \"$filename\"" >> "$output_file"
          echo "${indent}      href: \"${normalized_path}/${clean_filename}.md\"" >> "$output_file"
        fi
      done

      # Recursively process sub-subdirectories
      process_subdirectories "$subdir" "$output_file" "${indent}    "
    fi
  done
}

# Process all markdown files for normalization
find home -name '*.md' | sort | while read -r file; do
  # Get original filename and directory
  original_filename=$(basename "$file" .md)
  original_dirname=$(dirname "$file")

  # Clean the filename
  clean_filename=$(clean_text "$original_filename")
if [ "$original_dirname" = "home" ]; then
  full_normalized_dir=".docs"
  normalized_dirname=""
else
  normalized_dirname=$(normalize_path "${original_dirname#home/}")
  full_normalized_dir=".docs/${normalized_dirname}"
fi

  # Create the normalized path
  normalized_path="${full_normalized_dir}/${clean_filename}.md"
  echo "Processing: $file -> $normalized_path"

  # Create directory and copy file
  mkdir -p "$full_normalized_dir"
  cp "$file" "$normalized_path"
done

# Build the hierarchical TOC for codex
build_hierarchical_toc

generate_flat_tocs() {
  find home -mindepth 1 -maxdepth 1 -type d ! -name "codex" ! -name "api"| while read -r dir; do
    has_md=$(find "$dir" -maxdepth 1 -name '*.md' | wc -l)
    if [ "$has_md" -gt 0 ]; then
      normalized_dir=$(normalize_path "${dir#home/}")
      toc_path=".docs/${normalized_dir}/toc.yml"
      mkdir -p "$(dirname "$toc_path")"
      > "$toc_path"
      echo "# Flat TOC for ${dir}" >> "$toc_path"
      echo "# Generated on $(date)" >> "$toc_path"
      echo "" >> "$toc_path"

      find "$dir" -maxdepth 1 -name '*.md' | sort | while read -r file; do
        raw_name=$(basename "$file" .md)
        slug_name=$(clean_text "$raw_name")
        echo "- name: \"$raw_name\"" >> "$toc_path"
        echo "  href: \"${slug_name}.md\"" >> "$toc_path"

      done
    fi
  done
}

generate_flat_tocs

generate_root_toc() {
  toc_path=".docs/toc.yml"
  echo "# Generated on $(date)" > "$toc_path"
  echo "" >> "$toc_path"
  echo "- name: Home" >> "$toc_path"
  echo "  href: /" >> "$toc_path"

  find home -mindepth 1 -maxdepth 1 -type d | sort | while read -r dir; do
    section_name=$(basename "$dir") # Keep emoji & original casing
    slug_name=$(clean_text "$section_name") # Normalized path

    echo "- name: \"$section_name\"" >> "$toc_path"
    echo "  href: \"$slug_name\"" >> "$toc_path"
  done
}


generate_root_toc