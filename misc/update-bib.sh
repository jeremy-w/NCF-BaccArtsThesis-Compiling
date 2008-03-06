#!/bin/sh
masterbib="/Users/jeremy/Documents/Thesis Scaffold and Some Papers/master-bibliography.bib"
thesisbib="/Users/jeremy/Projects/thesis/bibliography.bib"
thesisdir=`dirname "$thesisbib"`
if test -a "$masterbib" -a -d "$thesisdir"; then
    echo "Copying $masterbib to $thesisbib..."
    cp "$masterbib" "$thesisbib"
elif test ! -a "$masterbib"; then
    echo "$0: error: $masterbib not found. Cannot copy nonexistent bibliography $masterbib to $thesisbib."
elif test ! -d "$thesisdir"; then
    echo "$0: error: $thesisdir not found. Cannot copy $masterbib to nonexistent directory $thesisdir."
else
    echo "$0: error: Unknown error."
fi

