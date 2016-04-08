#!/bin/sh

if [ "$#" -ne 1 ];
then
    echo "Usage: makepost.sh \"PostTitle\""
    exit 1
else
    mkdir -p _posts
    POSTDATE=`date "+%Y-%m-%d"`
    POSTNAME=`echo "$1" | sed "s/[^a-zA-Z0-9 ]//g" | sed "s/ /-/g" | awk '{print tolower($0)}'`
    echo "---\nlayout: post\ntitle: \"$1\"\n---\n" > _posts/${POSTDATE}-${POSTNAME}.md
fi
