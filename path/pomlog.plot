#!/bin/bash
set style fill solid
set xtic rotate by -30 scale 0
plot "/tmp/pomlog.dat" using 0:2:xtic(1) with boxes
