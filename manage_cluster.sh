# A) Manage Nodes and Cluster
# provision a node with the cli
couchbase-cli cluster-init -c 192.168.56.3 \
--cluster-username Administrator \
--cluster-password password \
--services data,index,query \
--cluster-ramsize 512 \
--cluster-index-ramsize 256

# add a Node and rebalance with the cli
couchbase-cli server-add -c 192.168.56.3:8091 \
--username Administrator \
--password password \
--server-add http://192.168.56.4:8091 \
--server-add-username someName \
--server-add-password somePassword \
--services data,query,index
# output success
SUCCESS: Server added

#rebalanced new node
couchbase-cli rebalance -c 192.168.56.3:8091 \
--username Administrator \
--password password
# output
Rebalancing
Bucket: 01/01 (travel-sample)                      60714 docs remaining
[=====                                                          ] 4.56%
# after susccess rebance:
SUCCESS: Rebalance complete
# cancel retries with the cli
/opt/couchbase/bin/couchbase-cli setting-rebalance \
-c 192.168.56.3 \
-u Administrator \
-p password \
--pending-info | jq '.'

# => cancel the pending rebalance-id
/opt/couchbase/bin/couchbase-cli setting-rebalance \
-c 10.143.192.101 \
-u Administrator \
-p password \
--cancel \
--rebalance-id <rebalance-id-get-from-below-command> 

# join a cluster and rebance
# Warning: Adding a server to this cluster means any previous Couchbase Server data on that server will be removed.
# Adding a dependent couchbase server to couchbase cluster

#List cluster Nodes
couchbase-cli server-list -c 192.168.56.3:8091 \
--username Administrator \
--password password
# host-list command
couchbase-cli host-list -c 192.168.56.3:8091 --username Administrator --password password

# Remove a Node with the cli
couchbase-cli rebalance -c 192.168.56.3:8091 \
--username Administrator \
--password password --server-remove 192.168.56.4:8091

#Fail a Node Over and Rebalance
#Graceful Failover with cli
couchbase-cli failover -c 192.168.56.3:8091 \
--username Administrator \
--password password \
--server-failover 192.168.56.4:8091

#Hard Failover with cli
# Warning: Failing over the node will remove it from the cluster and activate a replica. Operations currently in flight and not yet replicated, will be lost. Rebalancing will be required to add the node back into the cluster. Consider using "Remove" and rebalancing instead of Failover, to avoid any loss of data.
couchbase-cli failover -c 192.168.56.3:8091 \
--username Administrator \
--password password \
--server-failover 192.168.56.4:8091 --hard
# Recover a Node and Rebalance
# full recovery
couchbase-cli recovery -c 192.168.56.3:8091 \
--username Administrator \
--password password \
--server-recovery 192.168.56.4:8091 \
--recovery-type full
# delta recovery
couchbase-cli recovery -c 192.168.56.3:8091 \
--username Administrator \
--password password \
--server-recovery 192.168.56.4:8091 \
--recovery-type delta
# rebalance after recorvery
couchbase-cli rebalance -c 192.168.56.3:8091 --username Administrator --password password

# Node-to-node encryption | this only available on EE 
# 1, Turn off auto-failover
/opt/couchbase/bin/couchbase-cli setting-autofailover \
-c http://192.168.56.3:8091 \
-u Administrator \
-p password \
--enable-auto-failover 0
# 2, Pause Eveting Service and eventing functions
# + find the set of deployed Eveting functions | this is only on EE now
/opt/couchbase/bin/couchbase-cli eventing-function-setup \
-c http://192.168.56.3:8091 \
-u Administrator \
-p password \
--list
# + pause deployed eventing function via cli
/opt/couchbase/bin/couchbase-cli eventing-function-setup \
-c http://192.168.56.3:8091 \
-u Administrator \
-p password \
--pause \
--name my_evt_function_a
# 3, Enable node-to-node encryption for the cluster | this is only on EE edition
/opt/couchbase/bin/couchbase-cli node-to-node-encryption \
-c http://192.168.56.3:8091 \
-u Administrator \
-p password \
--enable
# 4, Establish an appropriate encryption-level for the cluster 
/opt/couchbase/bin/couchbase-cli setting-security \
-c http://192.168.56.3:8091 \
-u Administrator \
-p password \
--set \
--cluster-encryption-level all
# 5, Resume stoped Eventing service
/opt/couchbase/bin/couchbase-cli eventing-function-setup \
-c http://192.168.56.3:8091 \
-u Administrator \
-p password \
--resume \
--name my_evt_function_a
# 6, Switch auto-failover back on 
/opt/couchbase/bin/couchbase-cli setting-autofailover \
-c 192.168.56.3:8091 \
-u Administrator \
-p password \
--enable-auto-failover 1 \
--auto-failover-timeout 120 \
--enable-failover-of-server-groups 1 \
--max-failovers 2 \
--can-abort-rebalance 1
# 7, Confirm that node-to-node encryption is enabled
/opt/couchbase/bin/couchbase-cli node-to-node-encryption \
-c http://192.168.56.3:8091 \
-u Administrator \
-p password \
--get
# 8, Confirm the establised encryption level
/opt/couchbase/bin/couchbase-cli setting-security \
-c http://192.168.56.3:8091 \
-u Administrator \
-p password \
--get | jq '.'

# Manage Address Family
/opt/couchbase/bin/couchbase-cli ip-family \
-c http://192.168.56.3:8091 \
-u Administrator \
-p password \
--get 