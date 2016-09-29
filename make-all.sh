#!/bin/bash -xe
# make a page for each post.

rm -rf compiled misnamed
mkdir compiled misnamed
for misnamed in `ls posts/ | grep -E -v '^[-0-9a-zA-Z]+$'`
do
    mv posts/${misnamed} misnamed/${misnamed}
    echo "posts/${misnamed} is misnamed, just use [-0-9a-zA-Z] in the title; temporarily moved to misnamed/" > /dev/stderr
done
for f in `ls -t posts/*`
do
    current=`basename $f`
    if [ $old ]
    then
	if [ $oldold ]
	then
	    UPLINK=all-posts.html#${old%.*} PREVLINK=${current}.html NEXTLINK=${oldold}.html `dirname $0`/make.sh posts/${old} > compiled/${old}.html
	else
	    UPLINK=all-posts.html#${old%.*} PREVLINK=${current}.html `dirname $0`/make.sh posts/${old} > compiled/${old}.html
	fi
    fi
    oldold=$old
    old=$current
done

UPLINK=all-posts.html#${old%.*} NEXTLINK=${oldold}.html `dirname $0`/make.sh posts/${old} > compiled/${old}.html

UPLINK=all-posts.html `dirname $0`/make.sh `ls -t posts/* | head` > compiled/index.html
UPLINK=index.html `dirname $0`/make.sh `ls -t posts/*` > compiled/all-posts.html

`dirname $0`/make-rss.sh `ls -t posts/* | head` > compiled/rss.xml