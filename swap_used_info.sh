#!/bin/bash

SCRIPT_NAME=`basename $0`;

SORT="kb"; # {pid|kb|name} as first parameter, [default: kb]

[ "$1" != "" ] && { SORT="$1"; }

[ ! -x `which mktemp` ] && { echo "ERROR: mktemp is not available!"; exit; }
MKTEMP=`which mktemp`;
TMP=`${MKTEMP} -d`;
[ ! -d "${TMP}" ] && { echo "ERROR: unable to create temp dir!"; exit; }

>${TMP}/${SCRIPT_NAME}.pid;
>${TMP}/${SCRIPT_NAME}.kb;
>${TMP}/${SCRIPT_NAME}.name;

SUM=0;
OVERALL=0;

echo "${OVERALL}" > ${TMP}/${SCRIPT_NAME}.overal;

for DIR in `find /proc/ -maxdepth 1 -type d -regex "^/proc/[0-9]+"`;
do
    PID=`echo $DIR | cut -d / -f 3`
    CGROUP=`ps -p $PID -o cgroup --no-header | cut -d ',' -f1`
    PROGNAME=`ps -p $PID -o comm --no-headers`

    for SWAP in `grep Swap $DIR/smaps 2>/dev/null| awk '{ print $2 }'`
    do
	let SUM=$SUM+$SWAP
    done

    if (( $SUM > 0 ));
        then
        echo -n ".";
        echo -e "${PID}\t${SUM}\t${PROGNAME}\t\t\t${CGROUP}" >> ${TMP}/${SCRIPT_NAME}.pid;
        echo -e "${SUM}\t${PID}\t${PROGNAME}\t\t\t${CGROUP}" >> ${TMP}/${SCRIPT_NAME}.kb;
        echo -e "${PROGNAME}\t${SUM}\t${PID}\t\t\t${CGROUP}" >> ${TMP}/${SCRIPT_NAME}.name;
    fi
    let OVERALL=$OVERALL+$SUM
    SUM=0
done

### render
echo "${OVERALL}" > ${TMP}/${SCRIPT_NAME}.overal;
echo;
echo "Overall swap used: ${OVERALL} kb";
echo "========================================================================";
case "${SORT}" in
    name )
	echo -e "name\tkb\tpid\t\t\tchild pids,cgroup";
	echo "========================================================================";
	cat ${TMP}/${SCRIPT_NAME}.name|sort -r;
    ;;

    kb )
	echo -e "kb\tpid\tname\t\t\tchild pids,cgroup";
	echo "========================================================================";
	cat ${TMP}/${SCRIPT_NAME}.kb|sort -rh;
    ;;

    pid | * )
	echo -e "pid\tkb\tname\t\t\tchild pids,cgroup";
	echo "========================================================================";
	cat ${TMP}/${SCRIPT_NAME}.pid|sort -rh;
    ;;
esac

rm -fR "${TMP}/";