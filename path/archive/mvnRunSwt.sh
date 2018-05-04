#!/bin/bash
export SWT_WEBKIT2=1
export SWT_GTK3=1
export DISPLAY=:2
mvn clean verify -Pbuild-individual-bundles 
