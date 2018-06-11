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

## Todo

Use argument --port to define specific ports to scan.

```bash
ndiag domain.com --ports=80,443
```
