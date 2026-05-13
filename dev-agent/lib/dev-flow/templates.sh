#!/usr/bin/env bash

dev_flow_escape_sed_replacement() {
  printf '%s' "${1:-}" | sed -e 's/[\/&]/\\&/g'
}

dev_flow_render_template() {
  local template="$1"
  local project="$2"
  local project_type="$3"
  local escaped_project escaped_type escaped_schema
  escaped_project="$(dev_flow_escape_sed_replacement "$project")"
  escaped_type="$(dev_flow_escape_sed_replacement "$project_type")"
  escaped_schema="$(dev_flow_escape_sed_replacement "$DEV_FLOW_PROJECT_SCHEMA_VERSION")"
  sed \
    -e "s/{{PROJECT}}/$escaped_project/g" \
    -e "s/{{PROJECT_TYPE}}/$escaped_type/g" \
    -e "s/{{SCHEMA_VERSION}}/$escaped_schema/g" \
    "$template"
}

dev_flow_write_template_if_missing() {
  local path="$1"
  local template="$2"
  local project="$3"
  local project_type="$4"
  if [[ ! -e "$path" ]]; then
    mkdir -p "$(dirname "$path")"
    dev_flow_render_template "$template" "$project" "$project_type" > "$path"
  fi
}
