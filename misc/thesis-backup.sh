#!/bin/bash
hgRepo="/Users/jeremy/Projects/thesis"
sshUser='student_jeremy.sherman'
backupHost='students.ncf.edu:thesis-backups/'
hg='/opt/local/bin/hg'

# build filename
cd $hgRepo
echo "$0: building filename..."
myFilename="`$hg tip --template 'thesis-r{rev}({node|short}).tbz2'`"
myRevInfo="`$hg tip --template '{rev}:{node|short}'`"
if (test $? -ne 0); then echo "$0: Error building filename; aborting backup. Is the path to hg still $hg?"; exit 1; fi

# create backup file
cd ..
echo "$0: creating backup archive..."
tar -cjf "$myFilename" "$hgRepo"
if (test $? -ne 0); then echo "$0: Unable to create $myFilename via tar. Aborting backup."; exit 1; fi

# script convo with host
mySftpScript="put \"$myFilename\""

# perform the backup
echo "$0: connecting to backup server $backupHost..."
echo $mySftpScript | sftp -b - $sshUser@$backupHost
if (test $? -ne 0); then echo "$0: Transfer of $myFilename to $backupHost failed. Unable to perform backup."; exit 1; fi

# clean up
echo "$0: transfer complete, removing temporary files..."
rm "$myFilename"

echo "$0: backup of tip (revision $myRevInfo) completed at" `date +"%F %T"`
