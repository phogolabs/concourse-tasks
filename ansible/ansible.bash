#!/bin/bash -xe

main() {
  run_plabook "$(load_private_key)"
}

load_private_key() {
  local private_key_path=$TMPDIR/ssh-key

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
