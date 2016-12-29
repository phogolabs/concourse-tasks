#!/bin/bash -xe

main() {
  load_pubkey
  run_plabook "$(create_vault_password_file)" "$(load_pubkey)"
}

load_pubkey() {
  local private_key_path=$TMPDIR/ssh-key

  chmod 0600 "$private_key_path"
  echo "$SSH_PRIVATE_KEY" > "$private_key_path"
  echo "$private_key_path"
}

create_vault_password_file() {
  local ansible_vault_password_path="$TMPDIR/ansible-vault"
  echo "$ANSIBLE_VAULT_PASSWORD" > "$(ansible_vault_password_path)"
  echo "$ansible_vault_password_path"
}

run_plabook() {
  local ansible_vault_password_path
  ansible_vault_password_path="$1"

  local ansible_private_key_path
  ansible_private_key_path="$2"

  # shellcheck disable=2164
  cd ansible-playbooks/"$ANSIBLE_PLAYBOOK_DIR"

  ansible-playbook "$ANSIBLE_PLAYBOOK" -t "$ANSIBLE_TAG" -l all --vault-password-file="$ansible_vault_password_path"  --private-key="$ansible_private_key_path"
}

main
