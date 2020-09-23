#!/bin/bash

HASH_FILE="q42iot.hccapx"
POT_FILE="hashcat.pot"
HASH_TYPE="16800"
DICT_FILE="dicts/rockyou.txt"

# check OSX
if [ "$(uname)" == 'Darwin' ] ; then
	if [ -f hashcat-src/hashcat ] ; then
		HASHCAT="./hashcat-src/hashcat"
	else
		echo "You are running naive-hashcat on a MacOS/OSX machine but have not yet built the hashcat binary."
		echo "Please run ./build-hashcat-osx.sh and try again."
		exit 1
	fi
# check Linux
elif [ "$(uname)" == 'Linux' ] ; then
	if [ $(uname -m) == 'x86_64' ]; then
		HASHCAT="./hashcat-src/hashcat64.bin"
	else
		HASHCAT="./hashcat-src/hashcat32.bin"
	fi
# check Windows
elif [ "$(uname)" == 'MINGW64_NT-10.0' ] ; then
	if [ $(uname -m) == 'x86_64' ]; then
		HASHCAT="./hashcat-src/hashcat64.exe"
	else
		HASHCAT="./hashcat-src/hashcat32.exe"
	fi
fi

# LIGHT
# DICTIONARY ATTACK-----------------------------------------------------------------------
# begin with a _very_ simple and naive dictionary attack. This is blazing fast and 
# I've seen it crack ~20% of hashes
"$HASHCAT" -m "$HASH_TYPE" -a 0 "$HASH_FILE" "$DICT_FILE" --potfile-path "$POT_FILE"

# DICTIONARY ATTACK WITH RULES------------------------------------------------------------
# now lets move on to a rule based attack, d3ad0ne.rule is a great one to start with
"$HASHCAT" -m "$HASH_TYPE" -a 0 "$HASH_FILE" "$DICT_FILE" -r hashcat-src/rules/d3ad0ne.rule -o outfile.txt --potfile-path "$POT_FILE"

# rockyou is pretty good, and not too slow
"$HASHCAT" -m "$HASH_TYPE" -a 0 "$HASH_FILE" "$DICT_FILE" -r hashcat-src/rules/rockyou-30000.rule -o outfile.txt --potfile-path "$POT_FILE"


# MEDIUM
# dive is a great rule file, but it takes a bit longer to run, so we will run it after d3ad0ne and rockyou
"$HASHCAT" -m "$HASH_TYPE" -a 0 "$HASH_FILE" "$DICT_FILE" -r hashcat-src/rules/dive.rule -o outfile.txt --potfile-path "$POT_FILE"

# HEAVY
# MASK ATTACK (BRUTE-FORCE)---------------------------------------------------------------
"$HASHCAT" -m "$HASH_TYPE" -a 3 "$HASH_FILE" hashcat-src/masks/rockyou-1-60.hcmask -o outfile.txt --potfile-path "$POT_FILE"

# COMBINATION ATTACK---------------------------------------------------------------------- 
# this one can take 12+ hours, don't use it by default
# "$HASHCAT" -m "$HASH_TYPE" -a 1 "$HASH_FILE" "$DICT_FILE" "$DICT_FILE" --potfile-path "POT_FILE" 
