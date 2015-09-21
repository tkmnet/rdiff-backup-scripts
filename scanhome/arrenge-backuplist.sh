#!/bin/sh

if [ $# != 1 ] ; then
	echo Usage: $0 .backuplist
	exit
fi

LIST=`realpath "$1"`

if [ ! -f $LIST ] ; then
	echo "[!] the list is not exsist."
	exit
fi

cd `dirname $LIST`

TMP="/tmp/ab.$$.tmp"
TMP2="/tmp/ab2.$$.tmp"

cat $LIST | xargs -I @ realpath "@" >> $TMP
awk '!a[$0]++' $TMP > $TMP2
rm $TMP

HOME=`dirname $LIST`
cat $TMP2 | sed -e "s%^${HOME}/%%" | sed "/^\//d" >> $TMP
rm $TMP2

cat $TMP | while read x; do
	if [ -d $x ] ; then
		echo $x >> $TMP2
	fi
done
rm $TMP

cat $TMP2 > $LIST
rm $TMP2
