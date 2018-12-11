# nginx_deny_awslist
A shell that generates a setting to reject IP originated from aws with the deny directive of nginx

## Getting Started

### Prerequisites

Install plz.

- curl
- jq
- awscli

Change ENV

```shell
$ cp .env.sample .env
$ vim .env # edit your environment
```

## Run

```shell
$ gen.sh > awsblockips.conf
$ cat awsblockips.conf
deny 18.208.0.0/13; #From AWS
deny 52.95.245.0/24; #From AWS
deny 52.194.0.0/15; #From AWS
deny 54.155.0.0/16; #From AWS
deny 54.196.0.0/15; #From AWS
deny 52.94.22.0/24; #From AWS
deny 52.95.255.112/28; #From AWS
deny 13.210.0.0/15; #From AWS
deny 52.94.17.0/24; #From AWS
deny 52.95.154.0/23; #From AWS
...
allow 52.199.187.25/32; # Instance-ID: XXXXXXXX
```

