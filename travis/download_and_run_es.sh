#!/bin/sh
if [ -z $ES_VERSION ]; then
    echo "No ES_VERSION specified";
    exit 1;
fi;

ES_DIR="elasticsearch-latest-SNAPSHOT"

killall java 2>/dev/null

if [ ! -d $ES_DIR ]; then
    echo "Downloading Elasticsearch v${ES_VERSION}-SNAPSHOT"
    ES_URL="http://s3-eu-west-1.amazonaws.com/build.eu-west-1.elastic.co/origin/$ES_VERSION/nightly/JDK7/elasticsearch-latest-SNAPSHOT.zip"
    curl -L -O $ES_URL
    unzip "elasticsearch-latest-SNAPSHOT.zip" -d "${ES_DIR}"
fi;

echo "Starting Elasticsearch v${ES_VERSION}"
./${ES_DIR}/bin/elasticsearch \
    -Des.network.host=localhost \
    -Des.discovery.zen.ping.multicast.enabled=false \
    -Des.discovery.zen.ping_timeout=1s \
    -Des.http.port=9200 \
    -d

sleep 3
