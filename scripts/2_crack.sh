#!/bin/bash

# Word list to use
DICT="dicts/rockyou.txt"
HASH_FILE="q42iot.hccapx"
RULESET="hashcat-src/rules/best64.rule"

hashcat=./hashcat-src/hashcat

# Release the cracken
echo "Starting hashcat..."
echo "Dictionary: $DICT"
echo "Rules: $RULESET"
$hashcat -a 0 -m 2500 "$HASH_FILE" "$DICT" --potfile-path hashcat.pot -o outfile.txt