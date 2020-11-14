#!/usr/bin/bash

function askContinue {
    echo "Press any-key to continue Or Ctrl+C to abort"
    read
}

function web {
    askContinue

    apt install -y \
                wpscan \
                wafw00f \
                whatweb \
                sublist3r \
                subjack \
                wfuzz \
                dirbuster \
                sqlmap \
                sslscan
    
    # python tools
    pip3 install -U shodan
    pip3 install -U dnstwist
}

function tor {
    askContinue

    # tor proxychain setup
    apt install -y tor proxychains4 
    service tor start
    
    # config proxychains to be quite
    if [ -e /etc/proxychains4.conf ];then
        echo 'Congiguring /etc/proxychains4.conf'
        sed -i 's/#quiet_mode/quiet_mode/g' /etc/proxychains4.conf
        echo 'Done.'
    fi
    
    # check tor
    echo "Checking Tor"
    curl -s --socks5 127.0.0.1:9050 'https://check.torproject.org/api/ip'
    echo
}

function wordlists {
    askContinue

    apt install seclists
    
    # regex fuzz wordlist generator
    pip3 install -U exrex
}

function socialeng {
    askContinue

    apt install -y sherlock
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
        wordlists
        socialeng
    ;;
    wordlists)
        wordlists
    ;;
    *)
        echo "Usage:   unminify { web|wordlists|tor|socialeng|all }"
        echo "Example: unminfy web"
        exit 1
    ;;
esac
