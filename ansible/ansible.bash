#!/bin/bash -xe

main() {
  load_pubkey
  run_plabook "$(create_vault_password_file)"
}

load_pubkey() {
  local private_key_path=$TMPDIR/ssh-key

  if [ -s "$private_key_path" ]; then
    chmod 0600 "$private_key_path"
    echo "$SSH_PRIVATE_KEY" > "$private_key_path"

    eval "$(ssh-agent)" >/dev/null 2>&1
    trap 'kill $SSH_AGENT_PID' 0

    ssh-add "$private_key_path" >/dev/null
  fi
}

create_vault_password_file() {
  local ansible_vault_password_path="$TMPDIR/ansible-vault"
  echo "$ANSIBLE_VAULT_PASSWORD" > "$(ansible_vault_password_path)"
  echo "$ansible_vault_password_path"
}

run_plabook() {
  local ansible_vault_password_path
  ansible_vault_password_path="$1"

  # shellcheck disable=2164
  cd ansible-playbooks

  ansible-playbook "$ANSIBLE_PLAYBOOK" -t "$ANSIBLE_TAG" -l all --vault-password-file="$ansible_vault_password_path"
}

main
