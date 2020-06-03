#!/usr/bin/env bash

# https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html
docker pull docker.elastic.co/elasticsearch/elasticsearch:7.7.0
docker run -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:7.7.0
curl -X GET "localhost:9200/_cat/nodes?v&pretty"


# doc
# https://www.elastic.co/cn/
# https://www.elastic.co/guide/cn/elasticsearch/guide/current/distributed-cluster.html
# download
# https://www.elastic.co/cn/downloads/elasticsearch


Chrome 扩展程序
# ElasticSearch Head

# example
# https://www.ruanyifeng.com/blog/2017/08/elasticsearch.html

