#!/bin/bash

echo "********** hostname -f ************************************"
hostname -f
echo "********** uname -a ***************************************"
uname -a
echo "********** Potential kernel error messages ****************"
grep -P '(?i:error|collision|fail|temperature|command not found)|(BUG|INFO|FATAL|WARNING):' "$RSTRNT_TASKPATH"/dmesg.log
if [ -e /etc/os-release ] ; then
    echo "********** /etc/os-release ********************************"
    cat /etc/os-release
fi
if [ -e /etc/redhat-release ] ; then
    echo "********** /etc/redhat-release ****************************"
    cat /etc/redhat-release
fi
echo "********** /proc/cmdline **********************************"
cat /proc/cmdline
echo "********** /proc/swaps ************************************"
cat /proc/swaps
echo "********** /proc/meminfo **********************************"
cat /proc/meminfo
if command -v blkid >/dev/null ; then
    echo "********** blkid ******************************************"
    blkid
fi
if command -v ip >/dev/null ; then
    echo "********** ip addr ****************************************"
    ip addr
    echo "********** ip route ***************************************"
    ip route
    echo "********** ip -6 route ************************************"
    ip -6 route
fi
if command -v lsmod >/dev/null ; then
    echo "********** lsmod ******************************************"
    lsmod
fi
if command -v sestatus >/dev/null ; then
    echo "********** sestatus ***************************************"
    sestatus
fi
if command -v semodule >/dev/null ; then
    echo "********** semodule -l ************************************"
    semodule -l
fi
