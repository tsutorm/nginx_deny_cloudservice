#!/bin/sh
curl -s https://ip-ranges.amazonaws.com/ip-ranges.json | jq -r '.prefixes[].ip_prefix' | awk '{print "deny",$1";","#From AWS"}'
