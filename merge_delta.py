"""
Consume delta output and merge:

It finds the ealiest occurrence for this serial on a destination server.
"""

import sys
import json
from collections import defaultdict
from collections import Counter

earliest = defaultdict(dict)

for line in sys.stdin:
    blob = json.loads(line.rstrip())

    key = "{}&{}".format(blob['serial'], blob['dst'])

    dst_first_appeared = blob['dst_first_appeared']

    if key in earliest:
        if dst_first_appeared < earliest[key]['dst_first_appeared']:
            earliest[key] = blob
        continue
    earliest[key] = blob

for k, v in earliest.items():
    print(json.dumps(v))
