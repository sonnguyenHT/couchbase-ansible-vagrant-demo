This is repo for demo couchbase cluster with vagrant(provider virtualbox)
Using in this demo:
couchbase-server-commumity version: 7.2.1-5934-1 amd64

## Reference docs link:
# Bucket
https://docs.couchbase.com/server/current/learn/buckets-memory-and-storage/buckets.html

# Start virtual machine
```
vagrant up
```
# Start couchbase cluster
```
cd ansible
ansible-playbook main.yml -i inventory --vault-password-file .vault_pass
```