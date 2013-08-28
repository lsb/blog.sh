#!/bin/bash
function permalink {
    base=`basename $1`
    name=${base%.*}
    spacedname=`echo $name | tr - ' '`
    echo "<p class=permalink><a href='${base}' name='${name}'>${spacedname}</a></p>"
}
function crumb {
    if [ $2 ]
    then 
	echo "<div class=${1}crumb>"
	permalink $2
	echo "</div>"
    fi
}
echo "<!DOCTYPE html><html><head><title>"
cat assets/blog-title
echo "</title><style type='text/css'>"
cat assets/css
echo "</style></head><body>"
cat assets/frontispiece
crumb next $NEXTLINK
crumb prev $PREVLINK
crumb up $UPLINK

for f in "$@"
do
    echo "<div class=post><p class=timestamp>"
    date --date="`stat -c %y $f`" +"%Y-%m-%d %H:%M %Z"
    echo "</p>"
    permalink ${f}.html
    cat $f
    echo "</div><hr>"
done
cat assets/colophon
echo "</body></html>"