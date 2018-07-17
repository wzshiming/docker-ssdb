#!/bin/sh

sed -e "s@home.*@home $(dirname /ssdb/var)@" \
           -e "s/loglevel.*/loglevel info/" \
           -e "s@work_dir = .*@work_dir = /ssdb/var@" \
           -e "s@pidfile = .*@pidfile = /run/ssdb.pid@" \
           -e "s@output:.*@output: stdout@" \
           -e "s@level:.*@level: info@" \
           -e "s@ip:.*@ip: 0.0.0.0@" \
           -i /ssdb/ssdb.conf 

/ssdb/ssdb-server /ssdb/ssdb.conf

