#!/bin/bash

set -ex

export FROM_TS="$1" # "1490745600"
export TO_TS="$2" # "1490832000"
export OUT_DIR="$3"

mkdir -p ${OUT_DIR}

curl "https://atlas.ripe.net/api/v2/measurements/10001/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/k-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10004/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/f-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10005/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/i-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10006/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/m-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10008/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/l-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10009/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/a-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10010/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/b-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10011/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/c-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10012/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/d-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10013/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/e-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10015/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/h-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
curl "https://atlas.ripe.net/api/v2/measurements/10016/results?start=${FROM_TS}&stop=${TO_TS}&format=json" | jq '.[]' -Mc | gzip > ${OUT_DIR}/j-root-`date -r ${FROM_TS} +%Y-%m-%d`-v4.json.gz
