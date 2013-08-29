#!/bin/sh

SOURCE="https://codeload.github.com/sweikenb/symbox/zip/master"
TARGET="./master.zip"
TMPDIR="./symbox-master"

if [ -z `which curl` ]
    then
    echo; echo "[symbox] -> Please install 'curl' to use this installer."; echo;
    exit 1
fi

if [ -z `which unzip` ]
    then
    echo; echo "[symbox] -> Please install 'unzip' to use this installer."; echo;
    exit 1
fi

if [ ! -d "./symbox" ]
    then
    echo; echo "[symbox] -> Can't find existing installation - stopping."; echo;
    exit 1
fi


# TODO: fillme
