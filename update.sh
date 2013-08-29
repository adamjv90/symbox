#!/bin/sh

SOURCE="https://codeload.github.com/sweikenb/symbox/zip/master"
TARGET="./master.zip"
TMPDIR="./symbox-master"

if [ -z `which curl` ]
    then
    echo; echo "[symbox] -> Please install 'curl' to use this updater."; echo;
    exit 1
fi

if [ -z `which unzip` ]
    then
    echo; echo "[symbox] -> Please install 'unzip' to use this updater."; echo;
    exit 1
fi

if [ -z `which rsync` ]
    then
    echo; echo "[symbox] -> Please install 'rsync' to use this updater."; echo;
    exit 1
fi

if [ ! -d "./symbox" ]
    then
    echo; echo "[symbox] -> Can't find existing installation - stopping."; echo;
    exit 1
fi

# download current master and unzip
curl $SOURCE > $TARGET
unzip $TARGET > /dev/null

# updaty now using an local rsync
echo; echo "[symbox] -> Starging update"; echo;
rsync -abviuzP $TMPDIR/symbox/ ./symbox/ --suffix .bak

# create Vagrantfile-backup if needed
if [ -f "./Vagrantfile" ]
    then
    BAKUP_NAME="Vagrantfile_"`eval date +%Y%m%d`".bak"
    echo; echo "[symbox] -> Existing Vagrantfile found, creating backup: Vagrantfile -> $BAKUP_NAME"; echo;
    mv "./Vagrantfile" "$BAKUP_NAME"
fi

# copy vagrant file
cp $TMPDIR/Vagrantfile ./Vagrantfile

# cleanup
rm -rf $TMPDIR $TARGET

# done
echo; echo "[symbox] -> Update done"; echo;
