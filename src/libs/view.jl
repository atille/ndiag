__precompile__
module View

    export format
    export format_ssh
    export format_ports
    export format_dns

    function format(port::Int64, head)
        server = head["Server"]
        date = head["Date"]
        status = string(head.status)
        link = head["Link"]

        content = "-- HTTP request on port $port --
    |> Webserver: $server
    |> Request date: $date
    |> HTTP code: $status
    |> Related link: $link
    "
        return content
    end

    function format_ssh(port::Int64, content::String)
        data = "-- SSH banner dropped on port $port --
    |> $content
    "
        return data
    end

    function format_ports(port_status::Dict)

        data = "-- Port analysis --\n"
        for (port, status) in port_status
            if status == true
                data = string(data,  "\t* $port : open (available)\n")
            else
                data = string(data, "\t* $port :closed (or filtered)\n")
            end
        end

        return data
    end
    
    function format_dns(results::Dict)
        
        # results[dns_type]["name"]
        e_data = ""
        for (key, value) in results
            for (kl, vl) in value
                e_data = string(e_data, kl, ": ", vl, "\t")
            end
            e_data = string(e_data, "\n")
        end
        
        return e_data
    end
end