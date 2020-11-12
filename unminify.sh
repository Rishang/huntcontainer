#!/usr/bin/bash

function web {
    
    apt install -y \
                wpscan \
                wafw00f \
                whatweb \
                sherlock \
                sublist3r \
                subjack \
                wfuzz \
                dirbuster \
                sqlmap
    
    # python tools
    pip3 install shodan
}

function tor {
    # tor proxychain setup
    apt install -y tor proxychains4 
    service tor start
    if [ -e /etc/proxychains4.conf ];then
        echo 'Congiguring /etc/proxychains4.conf'
        sed -i 's/#quiet_mode/quiet_mode/g' /etc/proxychains4.conf
        echo 'Done.'
    fi
    
    #check tor
    echo "Checking Tor"
    curl -s --socks5 127.0.0.1:9050 'https://check.torproject.org/api/ip'
    echo
}

function wordlists {
    apt install seclists
}

case $1 in
    web)
        web
    ;;
    tor)
        tor
    ;;
    all)
        web
        tor
    ;;
    wordlists)
        wordlists
    ;;
    *)
        echo "Usage: unminify {all|web|wordlists|tor}"
        exit 1
    ;;
esac
