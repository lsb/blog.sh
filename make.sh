#!/bin/bash
function permalink {
    base=`basename $1`
    name=${base%.*}
    spacedname=`echo $name | tr - ' '`
    echo -n "<p class=permalink><a href='${base}' name='${name}'>${spacedname}</a></p>"
}
function crumb {
    if [ $2 ]
    then 
	echo "<div class=${1}crumb>"
	permalink $2
	echo -n "</div>"
    fi
}
echo -n "<!DOCTYPE html><html><head><link rel='alternate' type='application/rss+xml' title='RSS' href='rss.xml' /><title>"
cat assets/blog-title
echo -n "</title><style type='text/css'>"
cat assets/css
echo -n "</style></head><body>"
cat assets/frontispiece
echo -n "<div class=crumbs><div class=crumbwrapper>"
crumb next $NEXTLINK
crumb up $UPLINK
crumb prev $PREVLINK
echo "</div></div>"

for f in "$@"
do
    echo -n "<div class=post><p class=timestamp>"
    date --date="`stat -c %y $f`" +"%Y-%m-%d %H:%M %Z"
    echo -n "</p>"
    permalink ${f}.html
    cat $f
    echo "</div><hr>"
done
cat assets/colophon
echo "</body></html>"