#!/bin/bash
set +x
rm -rf sos/
mkdir -p sos
cp -v $(find . | grep '\.so') ./sos
set -x
