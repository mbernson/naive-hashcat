#!/bin/bash
awk -F ':' '{
  print $4 "," $5
}' outfile.txt | sort | uniq | column -s ',' -t
