#!/usr/bin/bash

# colors
GREEN="\033[0;32m"
LightBlue="\033[1;34m"
RED="\033[0;31m"
CYAN="\033[0;36m"
NC='\033[0m' # No Color

# directory for git-cone tools
toolsDir="~/tools"

# apt and pip tool name list
aptTools=()
pipTools=()

# print values present in array
function showList
{
    list="$*"
    for i in ${list[@]};do
        echo -e "${GREEN} $i ${NC}"
    done
}

# apt install values present in array
function aptInstall
{
    list="$*"
    for i in "${list[@]}";do
        apt install -y $i
    done
}

# pip install values present in array
function pipInstall
{
    list="$*"
    for i in ${list[@]};do
        pip install -U "$i"
    done
}

# print list of tools which will get installed & ask to continue
function askContinue 
{
    echo -e "${LightBlue}Following tools will get installed:${NC}"
    
    showList "${aptTools[@]}"
    showList "${pipTools[@]}"

    echo -e "Press ${CYAN}any-key${NC} to Continue -OR- ${RED}Ctrl-C${NC} to abort"
    read
}

# web testing tools
function web {
        
    local aptTools=(
        "wpscan"
        "wafw00f"
        "whatweb"
        "sublist3r"
        "subjack"
        "wfuzz"
        "dirbuster"
        "sqlmap"
        "sslscan"
        "knockpy"
    )

    local pipTools=(
        "shodan"
        "dnstwist"
    )

    askContinue

    aptInstall ${aptTools[@]}
    pipInstall "${pipTools[@]}"
    

    # Photon
    git clone --depth 1 https://github.com/s0md3v/Photon $toolsDir/Photon
    if [ -e $toolsDir/Photon/requirements.txt ];then pip install -r $toolsDir/Photon/requirements.txt;fi

    # XSStrike XSS scanner.
    git clone https://github.com/s0md3v/XSStrike.git $toolsDir/XSStrike
    if [ -e $toolsDir/XSStrike/requirements.txt ];then pip install -r $toolsDir/XSStrike/requirements.txt;fi

}

# tor setup
function tor {
    
    # tor proxychain setup
    local aptTools=(
        "tor"
        "proxychains4"
        "curl"
    )
    askContinue

    aptInstall "${aptTools[@]}"
    
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

# wordlist & wordlist tools setup
function wordlists {

    local aptTools=(
        "seclists"
    )
    
    local pipTools=(
    # regex fuzz wordlist generator
        "exrex"
    )

    askContinue

    aptInstall "${aptTools[@]}"
    pipInstall "${pipTools[@]}"

    # PayloadsAllTheThings
    git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git $toolsDir/PayloadsAllTheThings
}

function social {

    aptTools=(
        "sherlock"
    )

    askContinue
    
    aptInstall "${aptTools[@]}"
}

# cases 
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
        social
    ;;
    wordlists)
        wordlists
    ;;
    social)
        social
    ;;
    *)
        echo "Usage:   unminify { web|wordlists|tor|social|all }"
        echo "Example: unminfy web"
        exit 1
    ;;
esac
