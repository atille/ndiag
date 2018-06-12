# ndiag
Network analysis tool for monitoring purposes.
Current: alpha 0.1

## Requirements

* Julia v0.6+ (from https://julialang.org)
* HTTP.jl : $ julia -e 'Pkg.add("HTTP")' 

## Usage

Clone this repository and move into the ndiag/src folder. Perform the following command from the src folder to get a full report regarding the domain domain.com.

```julia
$ julia ndiag.jl domain.com
```
It'll produce a full report onto the STDOUT.

```text
Supported ports and actions:

- 80 - http - drops the head
- 443 - https - drops the head
- 21 - ftp - drops the banner
- 22 - ssh - drops the banner and version
- 5000 - rocket - drops the head
- 8080 - http alternative - drops the head
- (new) NS Zone - fetch from external API
```

## Todo

Use argument --port to define specific ports to scan ; it should override the list of currently support TCP ports.

## What is the result ?

```bash
ndiag domain.com --ports=80,443
```

```julia
# example

(prealpha) ndiag xxx.me
-- Target: xxx.me / 51.15.224.xx --
-- Port analysis --
	* 8080 : closed (or filtered)
	* 80 : open (available)
	* 443 : open (available)
	* 53 :closed (or filtered)
	* 5000 : open (available)
	* 22 : open (available)
	* 21 : closed (or filtered)

-- HTTP request on port 80 --
    |> Webserver: Apache/2.4.18 (Ubuntu)
    |> Request date: Tue, 12 Jun 2018 23:15:59 GMT
    |> HTTP code: 200
    |> Related link: 
    
-- HTTP request on port 443 --
    |> Webserver: Apache/2.4.18 (Ubuntu)
    |> Request date: Tue, 12 Jun 2018 23:16:01 GMT
    |> HTTP code: 200
    |> Related link: <https://xxx.me/wp-json/>; rel="https://api.w.org/"
    
-- HTTP request on port 5000 --
    |> Webserver: Apache/2.4.18 (Ubuntu)
    |> Request date: Tue, 12 Jun 2018 23:16:02 GMT
    |> HTTP code: 200
    |> Related link: 
    
-- SSH banner dropped on port 22 --
    |> SSH-2.0-OpenSSH_7.2p2 Ubuntu-4ubuntu2.4
    
-- DNS Zone --
name: xxx.me.	value: 51.15.224.xx	type: A	
name: xxx.me.	value: ns-xx-b.gandi.net.	type: NS	
```
