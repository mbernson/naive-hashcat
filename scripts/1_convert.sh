#!/bin/bash
echo "Converting handshakes..."
cap2hccapx=hashcat-utils/bin/cap2hccapx
for fullfile in handshakes/*.pcap; do
  filename=$(basename -- "$fullfile")
  extension="${filename##*.}"
  filename="${filename%.*}"
  $cap2hccapx $fullfile hccapx/$filename.hccapx
  echo hccapx/$filename.hccapx
done
echo "Removing incomplete handshakes"
find ./hccapx -name "*.hccapx" -type 'f' -size 0 -delete