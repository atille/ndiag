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
```

## Todo

Use argument --port to define specific ports to scan ; it should override the list of currently support TCP ports.

```bash
ndiag domain.com --ports=80,443
```
