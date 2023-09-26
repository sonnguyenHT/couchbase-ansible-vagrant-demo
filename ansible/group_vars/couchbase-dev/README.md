# Command to encrypt vault file
```
cd ansible/group_vars/couchbase-dev
ansible-vault encrypt --vault-password-file ../../../.vault_pass vault.yml 
```

# Command to view decrypted vault file
```
ansible-vault view --vault-password-file ../../../.vault_pass vault.yml
```