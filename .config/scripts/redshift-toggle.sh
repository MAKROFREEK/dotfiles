#!/bin/bash
stat="/tmp/redshift_stat.txt"
if [[ ! -f $stat ]]; then
  redshift -O 4000
  echo "night protection is on" > "$stat"
else
  redshift -x
  rm "$stat"
fi
