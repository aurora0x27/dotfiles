function proxy --description 'Manage proxy variables'
    if test (count $argv) -ne 1
        echo 'Usage: proxy [-on|-off|-stat|-h]'
        return 1
    end

    argparse h/help on off stat -- $argv
    or return 1

    if set -q _flag_h
        echo 'Usage: proxy [-on|-off|-stat|-h]'
        return 0
    end

    if set -q _flag_on
        set -gx ALL_PROXY socks5://127.0.0.1:2080
        echo 'Proxy enabled'
        return
    end

    if set -q _flag_off
        set -e ALL_PROXY
        echo 'Proxy disabled'
        return
    end

    if set -q _flag_stat
        if set -q ALL_PROXY
            echo "ALL_PROXY=$ALL_PROXY"
        else
            echo 'ALL_PROXY is unset'
        end
    end
end
