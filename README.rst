ripe-ncc-hackathon-2017
=======================



change_delta.py
---------------

This script scans a json file that contains Atlas measurements, and
calculates the delta between the first time an SOA serial was seen and when it
was first seen for each (authoritative) server that returned that data to a probe.

Definitions
~~~~~~~~~~~

If a dns probe failed (missing ['result'] key or missing ['result']['answers'] key), the serial was not seen.

If a probe result contains a high *lts* value (which documents the **Last time seen**), the serial was not seen.

Output
~~~~~~

  {"dst_first_appeared": 1492560020, "serial": 2017041801, "serial_first_appeared": 1492560020, "dst": "198.41.0.4", "delta": 0}

  {"dst_first_appeared": 1492577930, "serial": 2017041900, "serial_first_appeared": 1492577930, "dst": "198.41.0.4", "delta": 0}

  {"dst_first_appeared": 1492592252, "serial": 2017041901, "serial_first_appeared": 1492592252, "dst": "198.41.0.4", "delta": 0}


This output then can be ingested in elasticsearch to show results.



New probe in atlas
------------------

We setup a new probe in atlas that monitors the SOA record on levington25.com on amir.ns.cloudflare.com (anycast address).


