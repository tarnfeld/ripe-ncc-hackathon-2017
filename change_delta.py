"""
Consumes raw atlas probe SOA data and calculates a delta between the first
time an SOA serial was seen, and when it was updated on each destination address.
"""

import sys
import json
from collections import defaultdict
from collections import Counter

dst_serials = defaultdict(dict)
dst_serials_counts = defaultdict(Counter)

for line in sys.stdin:
    blob = json.loads(line.rstrip())
    if 'result' not in blob or 'answers' not in blob['result']:
        continue

    if 'lts' not in blob or blob['lts'] > 100:
        continue

    dst = blob['dst_addr']
    serial = blob['result']['answers'][0]['SERIAL']

    dst_serials[serial][dst] = dst_serials[serial].get(dst, blob['timestamp'])
    dst_serials_counts[serial][dst] += 1

for serial in dst_serials.keys():
    serial_first_appeared = min(dst_serials[serial].values())

    for dst, dst_first in dst_serials[serial].items():
        delta = dst_first - serial_first_appeared
        frequency_per_dst = dst_serials_counts[serial][dst]
        if frequency_per_dst > 1000:
            print json.dumps({
                "serial": serial,
                "serial_first_appeared": serial_first_appeared,
                "dst": dst,
                "dst_first_appeared": dst_first,
                "delta": delta
            })
