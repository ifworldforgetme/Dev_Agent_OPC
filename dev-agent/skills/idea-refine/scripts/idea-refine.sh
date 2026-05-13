#!/bin/bash
set -e

# This script helps initialize the project-local ideas directory for the idea-refine skill.

PROJECT_NAME="${1:-${PROJECT_NAME:-}}"

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: idea-refine.sh <project-name>" >&2
  echo "{\"status\": \"error\", \"message\": \"project name is required\"}"
  exit 1
fi

IDEAS_DIR="work/$PROJECT_NAME/ideas"

if [ ! -d "$IDEAS_DIR" ]; then
  mkdir -p "$IDEAS_DIR"
  echo "Created directory: $IDEAS_DIR" >&2
else
  echo "Directory already exists: $IDEAS_DIR" >&2
fi

echo "{\"status\": \"ready\", \"directory\": \"$IDEAS_DIR\"}"
