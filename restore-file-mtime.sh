#!/bin/bash -ex
touch -t $(git log --pretty=%ai -n1 -- $1 | tr -- '-:' '  ' | cut -d ' ' -f 1-5 | tr -d ' ') $1
