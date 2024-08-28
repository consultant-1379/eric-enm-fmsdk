#!/bin/bash
# The copyrght to the computer program(s) herein is the property of
# Ericsson Inc. The programs may be used and/or copied only with written
# permission from Ericsson Inc. or in accordance with the terms and
# conditions stipulated in the agreement/contract under which the
# program(s) have been supplied.
#
# Performs file descriptor resize
# This is to avoid "to many open file" when the complete GC is not 
# triggered often, this because "pipe and eventpool" are correctly
# removed by full GC.
##########################################################################
sed -i 's/jboss_user          -    nofile     10240/jboss_user          -    nofile     40960/g' /etc/security/limits.d/99-enmlimits.conf
sed -i 's/jboss_user          -    nproc      10240/jboss_user          -    nproc      40960/g' /etc/security/limits.d/99-enmlimits.conf
