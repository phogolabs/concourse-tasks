#!/bin/bash -e

main() {
  local ssh_key_path
  ssh_key_path="$(load_private_key)"
  set -x
  run_plabook "$ssh_key_path"
}

load_private_key() {
  local private_key_path
  private_key_path="$(mktemp)"

  chmod 0600 "$private_key_path"
  echo "$SSH_PRIVATE_KEY" > "$private_key_path"
  echo "$private_key_path"
}

run_plabook() {
  local ansible_private_key_path
  ansible_private_key_path="$1"

  # shellcheck disable=2164
  cd ansible-playbooks/"$ANSIBLE_PLAYBOOK_DIR"

  ansible-playbook "$ANSIBLE_PLAYBOOK" -t "$ANSIBLE_TAG" -l all  --private-key="$ansible_private_key_path"
}

main
