#!/bin/sh

if [ $# != 2 ] ; then
	echo Usage: $0 dist-dir .backup
	exit
fi

DIST=`realpath "$1"`
LIST=`realpath "$2"`
HOME=`dirname "${LIST}"`

if [ ! -d $DIST ] ; then
	echo "[!] the dist-dir is not exsist."
	exit
fi
if [ ! -f $LIST ] ; then
	echo "[!] the list is not exsist."
	exit
fi

cat $LIST | xargs -I @ ./safe-rdiff-backup.sh "${HOME}" "`dirname $LIST`/@" "${DIST}"

