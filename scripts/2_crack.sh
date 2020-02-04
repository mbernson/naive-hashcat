#!/bin/bash

# Combine hccapx files into one
echo "Creating master hccapx file..."
cat hccapx/*.hccapx > ./master.hccapx

# Word list to use
DICT="dicts/seclists.txt"
HASH_FILE="master.hccapx"
RULESET="hashcat-src/rules/best64.rule"
# SESSION_NAME="pwnagotchi2"

# Release the cracken
echo "Starting hashcat..."
echo "Dictionary: $DICT"
echo "Rules: $RULESET"
# hashcat -a 0 -m 2500 "$HASH_FILE" "$DICT" -r "$RULESET" --potfile-path hashcat.pot -o outfile.txt # --session $SESSION_NAME
hashcat -a 0 -m 2500 "$HASH_FILE" "$DICT" --potfile-path hashcat.pot -o outfile.txt # --session $SESSION_NAME

