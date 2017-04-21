

## ripe-ncc-hackathon-2017

### `change_delta.py`

This script scans a json file that contains Atlas measurements, and
calculates the delta between the first time an SOA serial was seen and when it
was first seen for each (authoritative) server that returned that data to a probe.

#### Definitions

If a dns probe failed (missing ['result'] key or missing ['result']['answers'] key), the serial was not seen.

If a probe result contains a high *lts* value (which documents the **Last time seen**), the serial was not seen.

#### Output

```
  {"dst_first_appeared": 1492560020, "serial": 2017041801, "serial_first_appeared": 1492560020, "dst": "198.41.0.4", "delta": 0}

  {"dst_first_appeared": 1492577930, "serial": 2017041900, "serial_first_appeared": 1492577930, "dst": "198.41.0.4", "delta": 0}

  {"dst_first_appeared": 1492592252, "serial": 2017041901, "serial_first_appeared": 1492592252, "dst": "198.41.0.4", "delta": 0}
```

This output then can be ingested in elasticsearch to show results.

#### What do these fields mean

  serial: The serial in question
  dst_first_appeared: The time this serial appeared on this **dst**.
  serial_first_appeared: The first time this serial appeared on any **dst**
  dst: The thestination **server** that included the soa in the answer.
  delta: The difference between first time the serial was ever seen and seen for this **dst**.


### New probe #1 in atlas

We setup a new probe in atlas that monitors the SOA record on levington25.com on amir.ns.cloudflare.com (anycast address).

https://atlas.ripe.net/measurements/8311800/


### New probe #2 in atlas

This monitors the SOA for townsend101.com on amir.ns.cloudflare.com

https://atlas.ripe.net/measurements/8311819/


### Visualisation

Shane thinks this is a good way to show the life and death of a serial:

```
                                  >--------- Time ---->

  Serial 2017032901:             |---------|
  Serial 2017032902:                   |-----------|
  Serial 20170330:                               |----|
  Serial 2017033001:                                 |-----------|
  Serial 2017033002:                                          |-----------|
```


### Running madprops

You need to set up elasticsearch mapping template:

    $ curl -X PUT http://localhost:9200/_template/madprops -d @madprops.mapping 

You may need some dependencies:

    $ pip install --user elasticsearch
    $ pip install --user dnslib

Then you can run the command:

    $ ./madprops.py -h
    usage: madprops.py [-h] [--start START] [--stop STOP] [--test TEST]
                       [--interval INTERVAL] [--tag TAG] [--index INDEX]

    optional arguments:
      -h, --help           show this help message and exit
      --start START
      --stop STOP
      --test TEST
      --interval INTERVAL
      --tag TAG
      --index INDEX

