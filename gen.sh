#!/bin/bash
source $(pwd)/.env

aws ec2 describe-instances | jq -r '.Reservations[].Instances[] | select(.State.Name == "running") | [.PublicIpAddress, .InstanceId] | @tsv' | awk '{print "allow",$1"/32;","# Instance-ID:"$2}'
curl -s https://ip-ranges.amazonaws.com/ip-ranges.json | jq -r '.prefixes[].ip_prefix' | awk '{print "deny",$1";","#From AWS"}'

# https://cloud.google.com/compute/docs/faq#ipranges
#nslookup -q=TXT _cloud-netblocks.googleusercontent.com  8.8.8.8
for LINE in `dig txt _cloud-netblocks.googleusercontent.com +short | tr " " "\n" | grep include | cut -f 2 -d :`
do
  dig txt $LINE +short
done | tr " " "\n" | sed '/ip4/s/$/; #From GCP/' | grep ip4  | cut -f 2 -d : | sort -n | sed '/From/s/^/deny /'
