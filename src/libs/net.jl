module Net

    export getip
    export portcall
    export get_http_head
    export get_ssh_banner
    export get_dns

    function getip(target::String)

        dot_counter = 0

        for letter in target
            if letter == '.'
                dot_counter = dot_counter + 1
            end
        end

        if dot_counter == 3
            isdomain = false
            return target, isdomain
        else
            isdomain = true
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

    function get_dns(JSON, target::String)

        types = ["A", "AAAA", "CNAME", "NS"]
        results = Dict()
        for dns_type in types
            results[dns_type] = Dict()
            f = silent_download("https://dns-api.org/$dns_type/$target")
            d = JSON.parse(readstring(f))

            try
                results[dns_type]["type"] = d[1]["type"]
                results[dns_type]["name"] = d[1]["name"]
                results[dns_type]["value"] = d[1]["value"]
            catch
                println("No data regarding $dns_type DNS type.")
            end
        end

        return results
    end

    function silent_download(url::AbstractString, filename::AbstractString)
        downloadcmd = nothing
        if downloadcmd === nothing
            for checkcmd in (:curl, :wget, :fetch)
                if success(pipeline(`which $checkcmd`, DevNull))
                    downloadcmd = checkcmd
                    break
                end
            end
        end
        if downloadcmd == :wget
            try
                run(`wget -O $filename $url -q`)
            catch
                rm(filename)  # wget always creates a file
                rethrow()
            end
        elseif downloadcmd == :curl
            run(`curl -L -f -o $filename $url -s`)
        elseif downloadcmd == :fetch
            run(`fetch -f $filename $url`)
        else
            error("no download agent available; install curl, wget, or fetch")
        end
        filename
    end

    function silent_download(url::AbstractString)
        filename = tempname()
        silent_download(url, filename)
    end
end