package ceph.authz

default allow = false

#-----------------------------------------------------------------------------
# Data structures containing location info about users and buckets.
# In real-world deployments, these data structures could be loaded into
# OPA as raw JSON data. The JSON data could also be pulled from external
# sources like AD, Git, etc.
#-----------------------------------------------------------------------------

# user-location information
user_location = {
    "alice": "UK",
    "bob":   "USA"
}

# bucket-location information
bucket_location = {
    "supersecretbucket": "USA"
}

# Allow access to bucket in same location as user.
allow {
    input.method = "HEAD"
    is_user_in_bucket_location(input.user_info.user_id, input.bucket_info.bucket.name)
}

allow {
    input.method = "GET"
}

allow {
    input.method = "PUT"
    input.user_info.display_name = "Bob"
}

allow {
    input.method = "DELETE"
    input.user_info.display_name = "Bob"
}

# Check if the user and the bucket being accessed belong to the same
# location.
is_user_in_bucket_location(user, bucket) {
    user_location[user] == bucket_location[bucket]
}
