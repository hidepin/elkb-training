#!/usr/bin/env bash

remote_host="192.168.0.xx"
dest_host="192.168.0.yy"

for index in `curl -XGET "http://${remote_host}:9200/_cat/indices?h=index&s=index"`
do
    if [[ $index =~ "metric" ]]; then
        curl -XPUT "http://${dest_host}:9200/${index}" -H 'Content-Type: application/json' -d'{
          "settings": {
                      "number_of_shards": 1,
                      "number_of_replicas": 0,
                      "index.codec": "best_compression"
          }
        }'
        curl -XPOST "http://${dest_host}:9200/_reindex?pretty" -H 'Content-Type: application/json' -d"
        {
          \"source\": {
              \"remote\": {
                    \"host\": \"http://${remote_host}:9200\"
              },
              \"index\": \"${index}\"
          },
           \"dest\": {
                \"index\": \"${index}\"
          }
        }
"
    fi
done
