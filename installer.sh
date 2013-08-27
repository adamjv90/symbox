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

curl $SOURCE > $TARGET
unzip $TARGET > /dev/null
rm $TMPDIR/.gitignore
mv $TMPDIR/* ./
rm -rf $TMPDIR $TARGET

echo; echo "[symbox] -> Installation done"; echo;
