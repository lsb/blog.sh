#!/bin/bash
echo "<!DOCTYPE html><html><head><title>"
cat assets/blog-title
echo "</title><style type='text/css'>"
cat assets/css
echo "</style></head><body>"
cat assets/frontispiece
for f in "$@"
do
    echo "<div class=post><p class=timestamp>"
    date --date="`stat -c %y $f`" +"%Y-%m-%d %H:%M %Z"
    echo "</p>"
    echo "<p class=permalink><a href='`basename $f`.html'>`basename $f|tr '-' ' '`</a></p>"
    cat $f
    echo "</div><hr>"
done
cat assets/colophon
echo "</body></html>"