#!/bin/bash

# Grab a copy of kernel messages, so we can inspect it later.
# Note that the harness will upload *and clear* dmesg every time we report
# a result, so we need to grab it here before we do anything else.
dmesg >"$RSTRNT_TASKPATH"/dmesg.log

# Make this more RHTS because it is like plague
export TEST=/distribution/check-install
if [ -z "$OUTPUTFILE" ]; then
        OUTPUTFILE="$(mktemp /mnt/testarea/tmp.XXXXXX)"
        export OUTPUTFILE
fi

# Check that /root/RECIPE.TXT matches the running recipe id.
# This is a sanity check to catch the case where the harness is configured to
# run a different recipe than the one this system was provisioned for.
# It should be impossible in Beaker.
if [ -e "/root/RECIPE.TXT" ]; then
    if [[ "$RSTRNT_RECIPEID" != "$(cat /root/RECIPE.TXT)" ]] ; then
        echo "/root/RECIPE.TXT contents $(cat /root/RECIPE.TXT) does not match \$RSTRNT_RECIPEID $RECIPEID" >>"$OUTPUTFILE"
        echo "Did the installation fail?" >>"$OUTPUTFILE"
        rstrnt-report-result -o "$OUTPUTFILE" Recipe-ID-mismatch FAIL
        rstrnt-abort recipe
    fi
else
    echo "/root/RECIPE.TXT does not exist. Did the installation fail?" >>"$OUTPUTFILE"
    rstrnt-report-result -o "$OUTPUTFILE" Recipe-ID-missing FAIL
fi

# Populate /etc/motd with a notice and some extra useful information.
echo "**  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **" >/etc/motd
echo "  This system is part of Beaker. It was provisioned for:              " >>/etc/motd
echo "    $BEAKER/recipes/$RECIPEID                                         " >>/etc/motd
echo "                                                                      " >>/etc/motd
echo "  Beaker test information:                                            " >>/etc/motd
echo "                            JOBID=$JOBID                              " >>/etc/motd
echo "                        SUBMITTER=$SUBMITTER                          " >>/etc/motd
echo "                         RECIPEID=$RECIPEID                           " >>/etc/motd
echo "                           DISTRO=$DISTRO                             " >>/etc/motd
echo "                           DISTRO=$DISTRO                             " >>/etc/motd
echo "                                                                      " >>/etc/motd
echo "  Job whiteboard: $BEAKER_JOB_WHITEBOARD                              " >>/etc/motd
echo "                                                                      " >>/etc/motd
echo "  Recipe whiteboard: $BEAKER_RECIPE_WHITEBOARD                        " >>/etc/motd
echo "**  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **  **" >>/etc/motd

SCORE=$(rpm -qa | wc -l)
rstrnt-report-result -o "$OUTPUTFILE" "$TEST" PASS "$SCORE"

# Collect some rudimentary information about the installed system and report it back.
./sysinfo.sh 2>&1 >"$RSTRNT_TASKPATH"/sysinfo.log
rstrnt-report-result -o "$OUTPUTFILE" $TEST/Sysinfo PASS "$RSTRNT_TASKPATH"/sysinfo.log
