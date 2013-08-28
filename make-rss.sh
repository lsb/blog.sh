#!/bin/bash
blogtitle=`cat assets/blog-title`
url=`cat assets/url`
echo '<?xml version="1.0" encoding="UTF-8" ?><rss version="2.0"><channel>'
echo "<title>${blogtitle}</title><link>${url}/</link><description>${blogtitle}</description>"
for f in "$@"
do
    base=`basename $f`
    echo "<item><title>${base}</title><link>${url}/${base}.html</link></item>"
done
echo "</channel></rss>"