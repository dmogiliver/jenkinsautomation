#!/bin/bash

diff_file=$1

while read line; do
    ./transform.sh $line
done < ${diff_file}
