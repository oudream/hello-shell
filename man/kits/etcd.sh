#!/usr/bin/env bash


scp -r /eee/tmp/etcd.bin.tar.gz  oudream@10.31.58.75:/fff/etcd/
tar zxvf /fff/etcd/etcd.bin.tar.gz
PATH=${PATH}:/fff/etcd/bin

## e.g. : Operating normally on macos
# On each etcd node, specify the cluster members:
# etcd
TOKEN=token-01
CLUSTER_STATE=new
NAME_1=machine-1
NAME_2=machine-2
NAME_3=machine-3
HOST_1=192.168.169.1
HOST_2=192.168.169.131
HOST_3=192.168.169.132
CLUSTER=${NAME_1}=http://${HOST_1}:2380,${NAME_2}=http://${HOST_2}:2380,${NAME_3}=http://${HOST_3}:2380

# Run this on each machine:
# For machine 1
THIS_NAME=${NAME_1}
THIS_IP=${HOST_1}
/fff/etcd/bin/etcd --data-dir=data.etcd --name ${THIS_NAME} \
	--initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
	--advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
	--initial-cluster ${CLUSTER} \
	--initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

# For machine 2
THIS_NAME=${NAME_2}
THIS_IP=${HOST_2}
/fff/etcd/bin/etcd --data-dir=data.etcd --name ${THIS_NAME} \
	--initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
	--advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
	--initial-cluster ${CLUSTER} \
	--initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}

# For machine 3
THIS_NAME=${NAME_3}
THIS_IP=${HOST_3}
/fff/etcd/bin/etcd --data-dir=data.etcd --name ${THIS_NAME} \
	--initial-advertise-peer-urls http://${THIS_IP}:2380 --listen-peer-urls http://${THIS_IP}:2380 \
	--advertise-client-urls http://${THIS_IP}:2379 --listen-client-urls http://${THIS_IP}:2379 \
	--initial-cluster ${CLUSTER} \
	--initial-cluster-state ${CLUSTER_STATE} --initial-cluster-token ${TOKEN}


# 注意出现以下错误，是拷贝粘贴时要注意（mac 用原来的 TAB 不替换，而 linux 用 4 spaces来替换）
2019-05-27 03:42:31.939489 E | etcdmain: error verifying flags, 'etcd--initial-advertise-peer-urls' is not a valid flag. See 'etcd --help'.


# Now etcd is ready! To connect to etcd with etcdctl:
export ETCDCTL_API=3
HOST_1=192.168.169.1
HOST_2=192.168.169.131
HOST_3=192.168.169.132
ENDPOINTS=$HOST_1:2379,$HOST_2:2379,$HOST_3:2379

etcdctl --endpoints=$ENDPOINTS member list


# put command to write:
etcdctl --endpoints=$ENDPOINTS put foo "Hello World!"


# get to read from etcd:
etcdctl --endpoints=$ENDPOINTS get foo
etcdctl --endpoints=$ENDPOINTS --write-out="json" get foo




# root@ics-ubuntu2:/fff/kubernetes# ETCDCTL_API=2 etcdctl -h
# NAME:
#    etcdctl - A simple command line client for etcd.
#
# USAGE:
#    etcdctl [global options] command [command options] [arguments...]
#
# VERSION:
#    3.3.13
#
# COMMANDS:
#      backup          backup an etcd directory
#      cluster-health  check the health of the etcd cluster
#      mk              make a new key with a given value
#      mkdir           make a new directory
#      rm              remove a key or a directory
#      rmdir           removes the key if it is an empty directory or a key-value pair
#      get             retrieve the value of a key
#      ls              retrieve a directory
#      set             set the value of a key
#      setdir          create a new directory or update an existing directory TTL
#      update          update an existing key with a given value
#      updatedir       update an existing directory
#      watch           watch a key for changes
#      exec-watch      watch a key for changes and exec an executable
#      member          member add, remove and list subcommands
#      user            user add, grant and revoke subcommands
#      role            role add, grant and revoke subcommands
#      auth            overall auth controls
#      help, h         Shows a list of commands or help for one command
#
# GLOBAL OPTIONS:
#    --debug                          output cURL commands which can be used to reproduce the request
#    --no-sync                        don't synchronize cluster information before sending request
#    --output simple, -o simple       output response in the given format (simple, `extended` or `json`) (default: "simple")
#    --discovery-srv value, -D value  domain name to query for SRV records describing cluster endpoints
#    --insecure-discovery             accept insecure SRV records describing cluster endpoints
#    --peers value, -C value          DEPRECATED - "--endpoints" should be used instead
#    --endpoint value                 DEPRECATED - "--endpoints" should be used instead
#    --endpoints value                a comma-delimited list of machine addresses in the cluster (default: "http://127.0.0.1:2379,http://127.0.0.1:4001")
#    --cert-file value                identify HTTPS client using this SSL certificate file
#    --key-file value                 identify HTTPS client using this SSL key file
#    --ca-file value                  verify certificates of HTTPS-enabled servers using this CA bundle
#    --username value, -u value       provide username[:password] and prompt if password is not supplied.
#    --timeout value                  connection timeout per request (default: 2s)
#    --total-timeout value            timeout for the command execution (except watch) (default: 5s)
#    --help, -h                       show help
#    --version, -v                    print the version



# root@ics-ubuntu2:/fff/kubernetes# ETCDCTL_API=3 etcdctl -h
# NAME:
#    etcdctl - A simple command line client for etcd3.
#
# USAGE:
#    etcdctl
#
# VERSION:
#    3.3.13
#
# API VERSION:
#    3.3
#
#
# COMMANDS:
#    get			        Gets the key or a range of keys
#    put			        Puts the given key into the store
#    del			        Removes the specified key or range of keys [key, range_end)
#    txn			        Txn processes all the requests in one transaction
#    compaction		        Compacts the event history in etcd
#    alarm disarm		    Disarms all alarms
#    alarm list		        Lists all alarms
#    defrag			        Defragments the storage of the etcd members with given endpoints
#    endpoint health		Checks the healthiness of endpoints specified in `--endpoints` flag
#    endpoint status		Prints out the status of endpoints specified in `--endpoints` flag
#    endpoint hashkv		Prints the KV history hash for each endpoint in --endpoints
#    move-leader		    Transfers leadership to another etcd cluster member.
#    watch			        Watches events stream on keys or prefixes
#    version			    Prints the version of etcdctl
#    lease grant		    Creates leases
#    lease revoke		    Revokes leases
#    lease timetolive	    Get lease information
#    lease list		        List all active leases
#    lease keep-alive	    Keeps leases alive (renew)
#    member add		        Adds a member into the cluster
#    member remove		    Removes a member from the cluster
#    member update		    Updates a member in the cluster
#    member list		    Lists all members in the cluster
#    snapshot save		    Stores an etcd node backend snapshot to a given file
#    snapshot restore	    Restores an etcd member snapshot to an etcd directory
#    snapshot status		Gets backend snapshot status of a given file
#    make-mirror		    Makes a mirror at the destination etcd cluster
#    migrate			    Migrates keys in a v2 store to a mvcc store
#    lock			        Acquires a named lock
#    elect			        Observes and participates in leader election
#    auth enable		    Enables authentication
#    auth disable		    Disables authentication
#    user add		        Adds a new user
#    user delete		    Deletes a user
#    user get		        Gets detailed information of a user
#    user list		        Lists all users
#    user passwd		    Changes password of user
#    user grant-role		Grants a role to a user
#    user revoke-role	    Revokes a role from a user
#    role add		        Adds a new role
#    role delete		    Deletes a role
#    role get		        Gets detailed information of a role
#    role list		        Lists all roles
#    role grant-permission	Grants a key to a role
#    role revoke-permission	Revokes a key from a role
#    check perf		        Check the performance of the etcd cluster
#    help			        Help about any command
#
# OPTIONS:
#      --cacert=""				          verify certificates of TLS-enabled secure servers using this CA bundle
#      --cert=""					      identify secure client using this TLS certificate file
#      --command-timeout=5s			      timeout for short running command (excluding dial timeout)
#      --debug[=false]				      enable client-side debug logging
#      --dial-timeout=2s				  dial timeout for client connections
#      -d, --discovery-srv=""	          domain name to query for SRV records describing cluster endpoints
#      --endpoints=[127.0.0.1:2379]		  gRPC endpoints
#      --hex[=false]				      print byte strings as hex encoded strings
#      --insecure-discovery[=true]		  accept insecure SRV records describing cluster endpoints
#      --insecure-skip-tls-verify[=false] skip server certificate verification
#      --insecure-transport[=true]		  disable transport security for client connections
#      --keepalive-time=2s			      keepalive time for client connections
#      --keepalive-timeout=6s			  keepalive timeout for client connections
#      --key=""					          identify secure client using this TLS key file
#      --user=""					      username[:password] for authentication (prompt if password is not supplied)
#      -w, --write-out="simple"			  set the output format (fields, json, protobuf, simple, table)
