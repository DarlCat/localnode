# Localnode

Localnode is a configuration atop Nginx which acts as an additional cache layer for the Second Life asset CDN. The intended purpose is to alleviate slowdowns caused by geography or locale, ease the pain of clearing your viewer cache for development or stability purposes, and decrease WAN bandwidth usage by avoiding multiple SL CDN requests for the same resource.

**A note about content theft**: I shouldn't have to say this, but this system does not enable or make easier the act of "copybotting" or stealing content, it simply serves as a cache layer to speed up content loading in the viewer. Cache files are not stored in a human-readable format, nor are they mapped to their asset UUID. This is identical in purpose and form to the SL viewer cache itself, it just sits in another location and is usable by a network of users.

## Requirements

1. Ability to modify name resolution for the Second Life CDN endpoint
2. Docker version 17.06.0 or higher, and support for compose file format version 3.3 or higher
3. Availability of port 80 on your Docker host (Required for SL viewer compatibility)

## Setup

### Application

1. Pull the repo
2. Run `docker-compose up -d` within the repo directory
3. Verify that the application is running by visiting <http://localhost:80>

After completing these steps, you are ready to proceed to the DNS setup phase.

### DNS

For requests to the SL Assets CDN to be passed through localnode, it is important that `asset-cdn.glb.agni.lindenlab.com` resolves to your Docker host using one of the following methods, and then verify that the reroute works by visiting <http://asset-cdn.glb.agni.lindenlab.com/ping> and checking for the "pong" text. (SL CDN will show "Incorrect Syntax" if you did not complete the DNS setup correctly.)

#### Hosts entry

The hosts file takes priority over the DNS resolver, but it is compatible with portable setups as you're not likely to carry your own DNS server with you when you travel.

- `C:\Windows\System32\drivers\etc\hosts` on Windows
- `/etc/hosts` on Linux
- `/private/etc/hosts` on macOS

Add the following line to the end of your hosts file, replacing `<ip>` with your Docker host IP

`<ip> asset-cdn.glb.agni.lindenlab.com`

#### DNS server record

If you host your own DNS server, it is likely that you are able to insert custom records. It's impossible to include documentation for every DNS server here, so look up the instructions for your system and follow them.

### Troubleshooting / FAQ

**Q**: I've completed both the app and DNS setups, but assets aren't loading in my viewer after I restart my viewer.

**A**: Confirm that the QA steps in both setups are passing, you probably forgot one, or the application is not running.

&nbsp;

**Q**: My cache directory does not seem to be populating.

**A**: First, try restarting your viewer if it was running during setup. If that does not resolve this, if running on Linux or macOS, verify your UNIX permissions are configured correctly. If on Windows, verify that the filesystem location is shared with Docker Desktop.
