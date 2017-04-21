#!/usr/bin/python
import requests
from datetime import datetime
from elasticsearch import Elasticsearch,helpers
es = Elasticsearch()
import argparse
import base64
import dnslib
import binascii
import re

parser = argparse.ArgumentParser()
parser.add_argument("--start", type=int, nargs=1)
parser.add_argument("--stop", type=int, nargs=1)
parser.add_argument("--test", type=int, nargs=1)
parser.add_argument("--interval", default=60, type=int, nargs=1)
parser.add_argument("--tag", type=str, nargs=1)
parser.add_argument("--index", type=str, nargs=1)
args = parser.parse_args()

first = {}

index = args.index[0]
test = args.test[0]
start = args.start[0]
stop = args.stop[0]
interval = args.interval[0]
tag = args.tag[0]
print "Pulling data for {} and pushing to index: {}".format(test, index)
try:
    res = es.indices.create(index = index)
except Exception as e:
    monsters = "are scary"
    #do nothing

while ( start < stop ):
    url = "https://atlas.ripe.net/api/v2/measurements/{}/results?start={}&stop={}&format=json".format(test, start, start+interval)
    data = requests.get(url)
    j = data.json()
    bulk_data=[]
    for i in range(0,len(j)-1):
        doc = j[i]
        if 'result' not in doc:
            continue
        if 'answers' not in doc['result']:
            continue
        if doc['result']['answers'] < 1:
            continue

        coded_string = doc['result']['abuf']
        b64d = base64.b64decode(coded_string)
        h = binascii.hexlify(b64d)
        packet = dnslib.binascii.unhexlify(h)
        d = dnslib.DNSRecord.parse(packet)
        str_d = str(d)
        pattern = re.compile(r";EDNS: code: (.*); data: (.*)")
        try:
            nsid = pattern.search(str_d).group(2)
        except: 
            nsid = "na"
        doc['NSID'] = nsid

        serial = doc['result']['answers'][0]['SERIAL']
        if serial not in first:
            first[serial] = doc['timestamp']
        delta = doc['timestamp'] - first[serial]
        doc['first_timestamp'] = first[serial]
        if 'timestamp' in doc:
            doc['timestamp'] = datetime.fromtimestamp(doc['timestamp'])
        else:
            doc['timestamp'] = datetime.now()
        op_dict = {
            "index": {
                "_index": index, 
                "_type": 'soa', 
                "_id": "{}{}".format(doc['prb_id'],doc['result']['ID']) 
            }
        }
    
        doc['delta'] = delta
        doc['tag'] = tag
        bulk_data.append(op_dict)
        bulk_data.append(doc)
       
        #res = es.index(index="madprops-balls", doc_type='soa', body=doc)
    try:
        es.bulk(index = index, body = bulk_data, refresh = True)
    except Exception as e:
        print e
    start = start + interval
