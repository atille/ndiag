include("libs/net.jl")
include("libs/view.jl")

using HTTP
using JSON

function main(args::Array)

    if isassigned(args, 1)
        target = args[1]
        main(target)
    end
end

function main(target::String)
    ip, isdomain = Net.getip(target)
    println(string("-- Target: $target / $ip --"))
    port_status = Dict()
    for port in [22, 80, 443, 21, 53, 8080, 5000]
        port_status[port] = Net.portcall(target, port)
    end

    println(View.format_ports(port_status))

    if port_status[80] == true
        head = Net.get_http_head(HTTP, target, false)
        println(View.format(80, head))
    end

    if port_status[443] == true
        head = Net.get_http_head(HTTP, target, true)
        println(View.format(443, head))
    end

    if port_status[8080] == true
        head = Net.get_http_head(HTTP, target, false, 8080)
        println(View.format(8080, head))
    end

    if port_status[5000] == true
        head = Net.get_http_head(HTTP, target, true, 5000)
        println(View.format(5000, head))
    end

    if port_status[22] == true
        content = Net.get_ssh_banner(target)
        println(View.format_ssh(22, content))
    end

    if isdomain == true
        println("-- DNS Zone --")
        println(View.format_dns(Net.get_dns(JSON, target)))
    end
end

main(ARGS)