#!/bin/bash -ex
touch -d "$(git log --pretty=%ai -n1 -- $1)" $1

