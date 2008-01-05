#!/bin/bash
# Delete thesis backups that are more than a week old.
# Deleted files are logged to $LOGFILE.
DEBUG=1
if (test $DEBUG -gt 0)
then
    echo "Running in debug mode..."
    LOGFILE="DEBUG.LOG"
    BACKUPFILES="*"
else
    LOGFILE="$HOME/thesis-backups/cleanup.log"
    BACKUPFILES="$HOME/thesis-backups/thesis-*.tbz2"
fi
DATEFMT="%a %d %b %Y: " # "Mon 01 Jan 2008: "

# list files newest->oldest; since we backup once a day, every file past the seventh is more than 7 days old
if (test $DEBUG -gt 0)
then
    date +$DATEFMT
    # echo the files to be deleted, rather than actually deleting them
    ls -t $BACKUPFILES | awk 'BEGIN {x=""}; NR > 7 {x=x"\n\t"$0; cmd="echo \"" $0 "\""; system(cmd)}; END {if (x != "") print "deleted:" x}'
else
    date +$DATEFMT >>$LOGFILE
    ls -t $BACKUPFILES | awk 'BEGIN {x=""}; NR > 7 {x=x"\n\t"$0; cmd="rm \"" $0 "\""; system(cmd)}; END {if (x != "") print "deleted:" x}' >> $LOGFILE 2>> $LOGFILE
fi
