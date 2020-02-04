#!/bin/bash

# Downloads all handshakes (pcap files) from these pwnagotchi's to the 'handshakes' folder
# pwnagotchis=("172.20.10.7" "172.20.10.6")
pwnagotchis=("172.20.10.6")

for ip in $pwnagotchis; do
  echo "Connecting to $ip..."
  ssh "pi@$ip" "sudo cp -n /root/handshakes/* /home/pi/hanshakes/ && sudo chown -R pi:pi /home/pi/handshakes"
  echo "Downloading handshakes..."
  rsync -avz "pi@$ip:/home/pi/handshakes/" "./handshakes"
done