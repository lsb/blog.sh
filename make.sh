#!/bin/bash -xe
function permalink {
    base=${1##*/}
    name=${base%.*}
    spacedname=${name//-/ }
    echo -n "<p class=permalink><a href='${base}' name='${name}'>${spacedname}</a></p>"
}
function crumb {
    if [ $2 ]
    then 
	echo -n "<div class=${1}crumb>"
	permalink $2
	echo -n "</div>"
    else
	echo -n "<div class=${1}crumb>&nbsp;</div>"
    fi
}
echo -n "<!DOCTYPE html><html><head><link rel=alternate type='application/rss+xml' title=RSS href=rss.xml />"
if [ -e assets/favico64 ]
then
  echo -n "<link rel='shortcut icon' href='` cat assets/favico64 `' />"
fi
echo -n "<meta name=viewport content='width=device-width'><meta charset='UTF-8'><title>"
cat assets/blog-title
echo -n "</title><style type='text/css'>"
tr -d '\n' < assets/css
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