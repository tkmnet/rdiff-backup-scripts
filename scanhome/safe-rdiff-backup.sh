#!/bin/sh

cd `dirname $0`

if [ $# != 3 ] ; then
	echo Usage: $0 home-dir src-dir dist-dir
	exit
fi

HOME=`realpath "$1"`
SRC=`realpath "$2"`
DIST=`realpath "$3"`

if [ ! -d $HOMES ] ; then
	echo "[!] home-dir[${HOME}] is not exsist."
	exit
fi
if [ ! -d $SRC ] ; then
	echo "[!] src-dir[${SRC}] is not exsist."
	exit
fi
if [ ! `expr "${SRC}" : "^${HOME}/"` -gt 0 ] ; then
	echo "[!] src-dir[${SRC}] is invalid."
	exit
fi
if [ ! -d $DIST ] ; then
	echo "[!] dist-dir[${DIST}] is not exsist."
	exit
fi

HOMES=`dirname "$HOME"`
DIST="${DIST}/`echo ${HOME} | sed -e \"s%^${HOMES}%%\"`/`echo ${SRC} | sed -e \"s%^${HOME}/%%\" | sed -e \"s%/%-%\"`"

mkdir -p "$DIST"
rdiff-backup "$SRC" "$DIST"
