#!/bin/bash
ls ./handshakes | awk -F '_' '{print $1}' | uniq | sort