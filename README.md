# Simple script for testing BLD DNS servers

* Resolving target DNS name by IP
* Detect response server speed

## Usage

```
./bld-lookup.sh google.com
```

Example result:

```
----------------------- Starting from IP: 212.19.134.52 -----------------------

Server:     212.19.134.52
Address:    212.19.134.52#53

Non-authoritative answer:
Name:   google.com
Address: 64.233.164.139
...
Response speed:  63 ms
```
## Additional links

* BLD Project site: https://lab.sys-adm.in/
* BLD Repo: https://github.com/m0zgen/blocky-listener-daemon