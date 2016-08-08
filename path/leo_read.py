#!/usr/bin/env python
# This is my first script.

import sys
from select import select

timeout = 60
rlist, _, _ = select([sys.stdin], [], [], timeout)
if rlist:
    s = sys.stdin.readline()
    print s


# src:
# http://stackoverflow.com/questions/3471461/raw-input-and-timeout
