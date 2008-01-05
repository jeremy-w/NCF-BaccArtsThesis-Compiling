#!/bin/bash
# Archive the cleanup log monthly.
cd "$HOME/thesis-backups/"
tar -cjf cleanup-log-`date +"%Y-%m"`.tbz2 cleanup.log
# cleanup.log -> cleanup-log-2008-01.tbz2
