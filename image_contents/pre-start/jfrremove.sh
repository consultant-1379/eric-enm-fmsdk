#!/bin/bash

THIS_HOST=`/bin/hostname`
ls -t /ericsson/enm/dumps/${THIS_HOST}_*.jfr | tail -n +2 | xargs rm --
