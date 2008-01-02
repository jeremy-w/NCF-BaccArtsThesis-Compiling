#!/bin/bash
myRepo="/Users/jeremy/Projects/thesis"
myUser='student_jeremy.sherman'
myHost='students.ncf.edu:thesis-backups/'

# build filename
cd $myRepo
echo "$0: building filename..."
myRevId=`hg heads | awk '/changeset/ {print $2}'`
myFileId=`echo $myRevId | awk -F ':' '{print "r" $1 "(" $2 ")"}'`
# keeping a colon in the name messed with Mac OS X's mind
myFilename="thesis-$myFileId.tbz2"
if (test $? -ne 0); then echo "$0: ERROR backing up thesis!"; exit 1; fi

# create backup file
cd ..
echo "$0: creating backup archive..."
tar -cjf "$myFilename" $myRepo
if (test $? -ne 0); then echo "$0: ERROR backing up thesis!"; exit 1; fi

# script convo with host
mySftpScript="put $myFilename"

# perform the backup
echo "$0: connecting to backup server $myHost..."
echo $mySftpScript | sftp -b - $myUser@$myHost
if (test $? -ne 0); then echo "$0: ERROR backing up thesis!"; exit 1; fi

# clean up
echo "$0: transfer complete, removing temporary files..."
rm $myFilename

echo "$0: backup of current revision $myRevId completed at " `date +"%F %T"`
