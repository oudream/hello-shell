#!/usr/bin/env python

import sys
import boto.s3.connection
from boto.s3.key import Key
import os


def create_bucket(conn, bucket_name):
    try:
        bucket = conn.create_bucket(bucket_name)
    except Exception as e:
        print('Unable to create bucket: Forbidden')


def delete_bucket(conn, bucket_name):
    try:
        bucket = conn.delete_bucket(bucket_name)
    except Exception as e:
        print('Unable to delete bucket: Forbidden')


def list_bucket(conn):
    buckets = conn.get_all_buckets()
    if len(buckets) == 0:
        print('No Buckets')
        return
    for bucket in buckets:
        print ("{name} {created}".format(
            name=bucket.name,
            created=bucket.creation_date,
    ))


def upload_data(conn, bucket_name, data):
    bucket = conn.get_bucket(bucket_name)
    k = Key(bucket)
    k.key = 'foobar'
    k.set_contents_from_string(data)


def download_data(conn, user, bucket_name):
    try:
        bucket = conn.get_bucket(bucket_name)
    except Exception as e:
        print ('Not allowed to access bucket "{}": User "{}" not in the same location as bucket "{}"'.format(bucket_name, user, bucket_name))
    else:
        k = Key(bucket)
        k.key = 'foobar'
        print (k.get_contents_as_string())


if __name__ == '__main__':
    user = sys.argv[1]
    action = sys.argv[2]

    if len(sys.argv) == 4:
        bucket_name = sys.argv[3]

    if len(sys.argv) == 5:
        bucket_name = sys.argv[3]
        data = sys.argv[4]

    access_key_env_name = '{}_ACCESS_KEY'.format(user.upper())
    secret_key_env_name = '{}_SECRET_KEY'.format(user.upper())

    access_key = os.getenv(access_key_env_name)
    secret_key = os.getenv(secret_key_env_name)

    conn = boto.connect_s3(
            aws_access_key_id=access_key,
            aws_secret_access_key=secret_key,
            host=os.getenv("HOST"), port=int(os.getenv("PORT")),
            is_secure=False, calling_format=boto.s3.connection.OrdinaryCallingFormat(),
    )

    if action == 'create':
            create_bucket(conn, bucket_name)

    if action == 'list':
            list_bucket(conn)

    if action == 'delete':
            delete_bucket(conn, bucket_name)

    if action == 'upload_data':
        upload_data(conn, bucket_name, data)

    if action == 'download_data':
        download_data(conn, user, bucket_name)
