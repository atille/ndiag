module Net

    export getip
    export portcall
    export get_http_head
    export get_ssh_banner

    function getip(target::String)

        dot_counter = 0

        for letter in target
            if letter == '.'
                dot_counter = dot_counter + 1
            end
        end

        if dot_counter == "3"
            isdomain = true
            return target, isdomain
        else
            isdomain = false
            return getaddrinfo(target), isdomain
        end
    end

    function portcall(target::String, port::Int64)
        try
            connect(target, port)
            return true
        catch
            return false
        end
    end

    function get_http_head(HTTP, target::String, isssl::Bool=false, port::Int64=80)
        if port != 80
            if isssl == true
                r = HTTP.request("HEAD", "https://$target:$port", require_ssl_verification = false)
            else
                r = HTTP.request("HEAD", "http://$target:$port")
            end
        else
            if isssl == true
                r = HTTP.request("HEAD", "https://$target:443", require_ssl_verification = false)
            else
                r = HTTP.request("HEAD", "http://$target:80")
            end
        end

        return r;
    end

    function get_ssh_banner(target::String)

        w = connect(target, 22)
        data = readline(w)
        close(w)
        return data        
    end
end