#!/usr/bin/env bash

# Step 1 - Deploy the Rook Operator
# Deploy the Rook system components, which include the Rook agent and Rook operator pods.

kubectl create -f operator.yaml

# Verify that rook-ceph-operator, rook-ceph-agent, and rook-discover pods are Running.

watch kubectl -n rook-ceph-system get pod
# When all pods show status Running, hit clear to ctrl-c and clear the screen.

ctrl-c


# Step 2 - Deploy OPA on top of Kubernetes
kubectl apply -f opa.yaml

# The OPA spec contains a ConfigMap where an OPA policy has been defined. This policy will be used to authorize requests
#    received by the Ceph Object Gateway. More details on this policy will be covered later in the tutorial.

# Verify that the OPA pod is Running.

watch kubectl -n rook-ceph get pod -l app=opa
# When the OPA pod show status Running, hit clear to ctrl-c and clear the screen.
ctrl-c


# Step 3 - Create a Ceph Cluster
# For the cluster to survive reboots, make sure you set the dataDirHostPath property that is valid for your hosts.
#    For minikube, dataDirHostPath is set to /data/rook.

Create the cluster: kubectl create -f cluster.yaml

# Verify that rook-ceph-mgr-a, rook-ceph-mon-a, rook-ceph-mon-b, rook-ceph-mon-c and rook-ceph-osd-0 pods are Running.

watch kubectl -n rook-ceph get pod
# When all pods show status Running, hit clear to ctrl-c and clear the screen.
ctrl-c


# Step 4 - Configure Ceph to use OPA
# The Ceph Object Gateway needs to be configured to use OPA for authorization decisions. The following configuration
#    options are available for the OPA integration with the gateway:

# rgw use opa authz = {use opa server to authorize client requests}
# rgw opa url = {opa server url:opa server port}
# rgw opa token = {opa bearer token}
# rgw opa verify ssl = {verify opa server ssl certificate}

# More information on the OPA - Ceph Object Gateway integration can be found in the Ceph docs.

# When the Rook Operator creates a cluster, a placeholder ConfigMap is created that can be used to override Ceph's
#    configuration settings.

# Update the ConfigMap to include the OPA-related options.

kubectl -n rook-ceph edit configmap rook-config-override

# Modify the settings and save. Each line you add should be indented from the config property as such:

#   apiVersion: v1
#   kind: ConfigMap
#   metadata:
#     name: rook-config-override
#     namespace: rook-ceph
#   data:
#     config: |
#       [client.radosgw.gateway]
#       rgw use opa authz = true
#       rgw opa url = opa.rook-ceph:8181/v1/data/ceph/authz/allow


# Step 5 - Create the Ceph Object Store
kubectl create -f object.yaml

# When the object store is created, the RGW service with the S3 API will be started in the cluster. The Rook operator
#     will create all the pools and other resources necessary to start the service.

# Check that the RGW pod is Running.

watch kubectl -n rook-ceph get pod -l app=rook-ceph-rgw
# When the RGW pod shows status Running, hit clear to ctrl-c and clear the screen.

# Rook sets up the object storage so pods will have access internal to the cluster. Create a new service for external
#     access. We will need the external RGW service for exercising our OPA policy.
ctrl-c

# Create the external service.

kubectl create -f rgw-external.yaml

# Check that both the internal and external RGW services are Running.

kubectl -n rook-ceph get service rook-ceph-rgw-my-store rook-ceph-rgw-my-store-external


# Step 6 - Create Object Store Users
# Create two object store users Alice and Bob.

# Now create the users.

kubectl create -f object-user-alice.yaml

kubectl create -f object-user-bob.yaml

# When the object store user is created, the Rook operator will create the RGW user on the object store my-store,
#     and store the user's Access Key and Secret Key in a Kubernetes secret in the namespace rook-ceph.



# Step 7 - Understanding the OPA policy
# As we saw earlier, the OPA spec contained a ConfigMap that defined the policy to be used to authorize requests received by the Ceph Object Gateway. Below is the policy:

# Copy to Editor


#    package ceph.authz
#
#    default allow = false
#
#    #-----------------------------------------------------------------------------
#    # Data structures containing location info about users and buckets.
#    # In real-world deployments, these data structures could be loaded into
#    # OPA as raw JSON data. The JSON data could also be pulled from external
#    # sources like AD, Git, etc.
#    #-----------------------------------------------------------------------------
#
#    # user-location information
#    user_location = {
#        "alice": "UK",
#        "bob":   "USA"
#    }
#
#    # bucket-location information
#    bucket_location = {
#        "supersecretbucket": "USA"
#    }
#
#    # Allow access to bucket in same location as user.
#    allow {
#        input.method = "HEAD"
#        is_user_in_bucket_location(input.user_info.user_id, input.bucket_info.bucket.name)
#    }
#
#    allow {
#        input.method = "GET"
#    }
#
#    allow {
#        input.method = "PUT"
#        input.user_info.display_name = "Bob"
#    }
#
#    allow {
#        input.method = "DELETE"
#        input.user_info.display_name = "Bob"
#    }
#
#    # Check if the user and the bucket being accessed belong to the same
#    # location.
#    is_user_in_bucket_location(user, bucket) {
#        user_location[user] == bucket_location[bucket]
#    }

# The above policy will restrict a user from accessing a bucket whose location does not match the user's location..
#    The user's and bucket's location is hardcoded in the policy for simplicity and in the real-world can be fetched
#    from external sources or pushed into OPA using it's REST API.

# In the above policy, Bob's location is USA while Alice's is UK. Since the bucket supersecretbucket is located in the
#    USA, Alice should not be able to access it.



# Step 8 use python2 
# Step 8 - Create the S3 access test script
# The below Python S3 access test script connects to the Ceph Object Store Gateway to perform actions such as creating
#    and deleting buckets.

# Install the python-boto package to run the test script. pip install boto

# python2 -> s3test.py
# 
# The script needs the following environment variables:
# 
# HOST - Hostname of the machine running the RGW service in the cluster.
# PORT - External Port of the RGW service.
# <USER>_ACCESS_KEY - USER's ACCESS_KEY
# <USER>_SECRET_KEY - USER's SECRET_KEY
# We previously created a service to provide external access to the RGW.

kubectl -n rook-ceph describe service rook-ceph-rgw-my-store-external

# Internally the RGW service is running on a port indicated by the Port field. Externally it is running on a port
#    indicated by the NodePort field.

# Set the HOST and PORT environment variables:

export HOST=$(minikube ip)

export PORT=$(kubectl -n rook-ceph get service rook-ceph-rgw-my-store-external -o jsonpath='{.spec.ports[?(@.name=="rgw")].nodePort}')

# Get Alice's and Bob's ACCESS_KEY and SECRET_KEY from the Kubernetes Secret and set the following environment variables:

export ALICE_ACCESS_KEY=$(kubectl get secret rook-ceph-object-user-my-store-alice -n rook-ceph -o yaml | grep AccessKey | awk '{print $2}' | base64 --decode)

export ALICE_SECRET_KEY=$(kubectl get secret rook-ceph-object-user-my-store-alice -n rook-ceph -o yaml | grep SecretKey | awk '{print $2}' | base64 --decode)

export BOB_ACCESS_KEY=$(kubectl get secret rook-ceph-object-user-my-store-bob -n rook-ceph -o yaml | grep AccessKey | awk '{print $2}' | base64 --decode)

export BOB_SECRET_KEY=$(kubectl get secret rook-ceph-object-user-my-store-bob -n rook-ceph -o yaml | grep SecretKey | awk '{print $2}' | base64 --decode)

# Now let's create a bucket and add some data to it.
# 
# First, Bob creates a bucket supersecretbucket

python s3test.py Bob create supersecretbucket

# List the bucket just created

python s3test.py Bob list

# The output will be something like:

#   supersecretbucket 2019-01-14T21:18:03.872Z
# Add some data to the bucket supersecretbucket

python s3test.py Bob upload_data supersecretbucket "This is some secret data"



# Step 9 - Exercise the OPA policy
# To recap, the policy we are going to test will restrict a user from accessing a bucket whose location does not match 
#     the user's location..

# Check that Alice cannot access the contents of the bucket supersecretbucket.

python s3test.py Alice download_data supersecretbucket

# Since Alice is located in UK and and the bucket supersecretbucket in the USA, she would be denied access.

# Check that Bob can access the contents of the bucket  supersecretbucket.

python s3test.py Bob download_data supersecretbucket

# Since Bob and the bucket supersecretbucket are both located in the USA, Bob is granted access to the contents in the 
#     bucket.
