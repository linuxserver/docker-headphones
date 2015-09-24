![http://linuxserver.io](http://www.linuxserver.io/wp-content/uploads/2015/06/linuxserver_medium.png)

The [LinuxServer.io](http://linuxserver.io) team brings you another quality container release featuring auto-update on startup, easy user mapping and community support. Be sure to checkout our [forums](http://forum.linuxserver.io) or for real-time support our [IRC](http://www.linuxserver.io/index.php/irc/) on freenode at `#linuxserver.io`.

# linuxserver/Headphones
![https://github.com/rembo10/headphones](http://i.imgur.com/5vSV3Gkl.png)

Headphones is an automated music downloader for NZB and Torrent, written in Python. It supports SABnzbd, NZBget, Transmission, µTorrent and Blackhole.

## Usage

```
docker create --name="Headphones" -v /path/to/headphones/data:/config -v /path/to/downloads:/downloads -v /path/to/music:/music -v /etc/localtime:/etc/localtime:ro -p 8181:8181 linuxserver/headphones
```

**Parameters**

* `-p 8181` - the port(s)
* `-v /etc/localhost` for timesync - *optional*
* `-v /config` - Configuration file location
* `-v /music` - Location of music. (i.e. /opt/downloads/music or /var/music)
* `-v /downloads` - Location of downloads folder
* `-e PGID` for for GroupID - see below for explanation - *optional*
* `-e PUID` for for UserID - see below for explanation - *optional*

It is based on phusion-baseimage with ssh removed, for shell access whilst the container is running do `docker exec -it Headphones /bin/bash`.

### User / Group Identifiers

**TL;DR** - The `PGID` and `PUID` values set the user / group you'd like your container to 'run as' to the host OS. This can be a user you've created or even root (not recommended).

Part of what makes our containers work so well is by allowing you to specify your own `PUID` and `PGID`. This avoids nasty permissions errors with relation to data volumes (`-v` flags). When an application is installed on the host OS it is normally added to the common group called users, Docker apps due to the nature of the technology can't be added to this group. So we added this feature to let you easily choose when running your containers.

## Setting up the application 

Access WebUI at http://localhost:8181 and walk through the wizard.

## Updates

* Upgrade to the latest version simply `docker restart Headphones`.
* To monitor the logs of the container in realtime `docker logs -f Headphones`.



## Version History

+ **18.07.2015:** Inital Release
