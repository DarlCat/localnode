# Localnode

Localnode is an configuration atop Nginx which acts as an additional cache layer for the Second Life asset CDN. The intended purpose is to alleviate slowdowns caused by geography or locale, and ease the pain of clearing your viewer cache for development or stability purposes. Setup and maintenance are intended to be easy and straightforward.

## Requirements

1. Ability to modify name resolution for the Second Life CDN endpoint
2. Docker, and docker-compose compatible with compose file version 3.3 or higher
3. Availability of port 80 on your Docker host (Required for SL viewer compatibility)

## Setup

### Application

1. Pull the repo
2. Run `docker-compose up -d` within the repo directory
3. Verify that the application is running by visiting <http://localhost:80>

### DNS

For requests to the SL Assets CDN to be passed through localnode, it is important that `asset-cdn.glb.agni.lindenlab.com` resolves to your Docker host using one of the following methods:

#### Hosts entry

The hosts file takes priority over the DNS resolver, but it is compatible with portable setups as you're not likely to carry your own DNS server with you when you travel.

- `C:\Windows\System32\drivers\etc\hosts` on Windows
- `/etc/hosts` on Linux
- `/private/etc/hosts` on macOS

Add the following line to the end of your hosts file, replacing `<ip>` with your Docker host IP

`<ip> asset-cdn.glb.agni.lindenlab.com`

#### DNS server record

If you host your own DNS server, it is likely that you are able to insert custom records. It's impossible to include documentation for every DNS server here, so look up the instructions for your system and follow them.
