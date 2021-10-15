#!/bin/bash
#
# Show file description open for process and limit

SCRIPT_NAME=`basename $0`;

SORT="fd"; # {pid|fd|name} as first parameter, [default: fd]

[ "$1" != "" ] && { SORT="$1"; }

[ ! -x `which mktemp` ] && { echo "ERROR: mktemp is not available!"; exit; }
MKTEMP=`which mktemp`;
TMP=`${MKTEMP} -d`;
[ ! -d "${TMP}" ] && { echo "ERROR: unable to create temp dir!"; exit; }

>${TMP}/${SCRIPT_NAME}.pid;
>${TMP}/${SCRIPT_NAME}.fd;
>${TMP}/${SCRIPT_NAME}.name;

OVERALL=0;

echo "${OVERALL}" > ${TMP}/${SCRIPT_NAME}.overal;

for DIR in `find /proc/ -maxdepth 1 -type d -regex "^/proc/[0-9]+"`;
do
    PID=`echo $DIR | cut -d / -f 3`

    if [ -d "/proc/$PID/fd" ]; then
        FD_COUNT=`ls -1 /proc/$PID/fd | wc -l`
        FD_LIMIT=`prlimit --pid $PID -n -o SOFT --noheadings`
        PROGNAME=`ps -p $PID -o comm --no-headers`

        let "LIMIT_PERC=$FD_COUNT*100/$FD_LIMIT"

        if (( $LIMIT_PERC > 1 ));
            then
            echo -n ".";
            echo -e "${PROGNAME}\t${LIMIT_PERC}\t${PID}" >> ${TMP}/${SCRIPT_NAME}.name;
            echo -e "${PID}\t${PROGNAME}\t${LIMIT_PERC}" >> ${TMP}/${SCRIPT_NAME}.pid;
            echo -e "${LIMIT_PERC}\t${PROGNAME}\t${PID}" >> ${TMP}/${SCRIPT_NAME}.fd;
        fi

        let OVERALL=$OVERALL+$FD_COUNT
    fi
done

### render
echo "${OVERALL}" > ${TMP}/${SCRIPT_NAME}.overal;
echo;
echo "Overall fd opened: ${OVERALL}";
echo "========================================================================";
case "${SORT}" in
    name )
	echo -e "name\tfd%\tpid";
	echo "========================================================================";
	cat ${TMP}/${SCRIPT_NAME}.name|sort -r;
    ;;

    fd )
	echo -e "fd%\tname\tpid";
	echo "========================================================================";
	cat ${TMP}/${SCRIPT_NAME}.fd|sort -rh;
    ;;

    pid | * )
	echo -e "pid\tname\tfd%";
	echo "========================================================================";
	cat ${TMP}/${SCRIPT_NAME}.pid|sort -rh;
    ;;
esac

rm -fR "${TMP}/";
