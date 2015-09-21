#!/bin/sh

cd `dirname $0`

if [ $# != 2 ] ; then
	echo Usage: $0 homes-dir dist-dir
	exit
fi

HOMES=`realpath "$1"`
DIST=`realpath "$2"`

if [ ! -d $HOMES ] ; then
	echo "[!] the homes-dir is not exsist."
	exit
fi
if [ ! -d $DIST ] ; then
	echo "[!] the dist-dir is not exsist."
	exit
fi

ls ${HOMES}/*/.backuplist | xargs -I @ ./arrenge-backuplist.sh "@"
ls ${HOMES}/*/.backuplist | xargs -I @ ./scanlist-and-backup.sh "${DIST}" "@"

