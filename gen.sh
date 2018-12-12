#!/bin/sh
source $(pwd)/.env

curl -s https://ip-ranges.amazonaws.com/ip-ranges.json | jq -r '.prefixes[].ip_prefix' | awk '{print "deny",$1";","#From AWS"}'
aws ec2 describe-addresses | jq -r '.Addresses[] | [.PublicIp, .InstanceId] | @tsv' | awk '{print "allow",$1"/32;","# Instance-ID:"$2}'
