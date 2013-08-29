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

if [ -d "./symbox" ]
    then
    echo; echo "[symbox] -> Existing installation found, stopping. Run the update.sh-script to apply updates."; echo;
    exit 1
fi

if [ -f "./Vagrantfile" ]
    then
    BAKUP_NAME="Vagrantfile_"`eval date +%Y%m%d`".bak"
    echo; echo "[symbox] -> Existing Vagrantfile found, creating backup: Vagrantfile -> $BAKUP_NAME"; echo;
    mv "./Vagrantfile" "$BAKUP_NAME"
fi

# download current master and unzip
curl $SOURCE > $TARGET
unzip $TARGET > /dev/null

# remove symbox git-irgnore to prevent collisions
rm $TMPDIR/.gitignore

# move the symbox license and readme file
mv $TMPDIR/LICENSE.md $TMPDIR/symbox/
mv $TMPDIR/README.md $TMPDIR/symbox/

# move symbox file to theinstallation target
mv $TMPDIR/* ./

# cleanup
rm -rf $TMPDIR $TARGET

# done
echo; echo "[symbox] -> Installation done"; echo;
