#!/bin/bash
echo "Converting handshakes..."
cap2hccapx=hashcat-utils/src/cap2hccapx.bin
for fullfile in handshakes/*.pcap; do
  filename=$(basename -- "$fullfile")
  extension="${filename##*.}"
  filename="${filename%.*}"
  $cap2hccapx $fullfile hccapx/$filename.hccapx
  echo hccapx/$filename.hccapx
done
echo "Removing incomplete handshakes"
find ./hccapx -name "*.hccapx" -type 'f' -size 0 -delete

# Combine hccapx files into one
# echo "Creating master hccapx file..."
# cat hccapx/*.hccapx > ./master.hccapx