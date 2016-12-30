#!/bin/bash -e

main() {
  disable_strict_host_checking
  local ssh_key_path
  ssh_key_path="$(load_private_key)"
  run_plabook "$ssh_key_path"
}

disable_strict_host_checking() {
  mkdir -p ~/.ssh
  cat > ~/.ssh/config <<EOF
StrictHostKeyChecking no
LogLevel quiet
EOF
  chmod 0600 ~/.ssh/config
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

  if [ -n "$ANSIBLE_TAG" ]; then
    ansible-playbook "$ANSIBLE_PLAYBOOK" -l all -t "$ANSIBLE_TAG" --private-key="$ansible_private_key_path"
  else
    ansible-playbook "$ANSIBLE_PLAYBOOK" -l all --private-key="$ansible_private_key_path"
  fi
}

main
