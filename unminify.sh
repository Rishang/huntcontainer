#!/usr/bin/bash

# This script is made for Kali-Linux only,
# unminify.sh Get's copied to the seccontainer docker image an unminify command

# This script can work well on your Kali OS as well same as it works insider the contaienr

# To run this script on you OS, run the command given below.
# sudo bash unminify.sh

# colors
GREEN="\033[0;32m"
LightBlue="\033[1;34m"
RED="\033[0;31m"
CYAN="\033[0;36m"
NC='\033[0m' # No Color

if ! [[ $(grep -i "kali-rolling" /etc/apt/sources.list) ]];then
    echo "Script works on Kali-Linux other OS can have issues"
    exit 1
fi

# directory for git-cone tools
toolsDir="$HOME/tools"

if ! [ -e $toolsDir ];then
    mkdir $toolsDir;
fi

# apt, pip, git tool name list
aptTools=()
pipTools=()
gitRepos=()
otherTools=()

# print values present in array
function _showList
{
    list="$*"
    for i in ${list[@]};do
        echo -e "${GREEN} $i ${NC}"
    done
}

# clone git repos to $toolsDir path
function _gitClone
{
    local list="$*"
    
    for repo in ${list[@]};do
        folderName="$(echo $repo | grep -oE '\w+\.\w+$' | grep -oE '^\w+')"
        git clone --depth 1 "$repo" "$toolsDir/$folderName"
    done
}


# print list of tools which will get installed & ask to continue
function _askContinue 
{
    echo
    echo -e "${LightBlue}Following tools will get installed: at ${CYAN} $toolsDir ${NC}"
    
    _showList "${aptTools[@]}"
    _showList "${pipTools[@]}"
    _showList "${otherTools[@]}"

    echo -e "\n${LightBlue}Git clone repos${NC}\n"
    _showList "${gitRepos[@]}"
    
    echo 
    echo -e "Press ${CYAN}any-key${NC} to Continue -OR- ${RED}Ctrl-C${NC} to abort"
    read
}
# -------------------------------------------------

# web testing tools
function _web {
        
    local aptTools=(
        "hydra"
        "wpscan"
        "wafw00f"
        "whatweb"
        "sublist3r"
        "subjack"
        "wfuzz"
        "sqlmap"
        "sslscan"
        "knockpy"
    )

    local pipTools=(
        "shodan"
        "dnstwist"
        "py-altdns"
    )

    local gitRepos=(
        # Photon
        "https://github.com/s0md3v/Photon.git"
        # XSStrike XSS scanner.
        "https://github.com/s0md3v/XSStrike.git"
    )
    _askContinue

    apt install -y "${aptTools[@]}"
    pip install -U "${pipTools[@]}"
    _gitClone "${gitRepos[@]}"

    # find all requirements.txt in $toolsDir and pip install
    for requirements in $(find $toolsDir -type f -name "requirements.txt");do
        pip install -U -r $requirements;
    done

}

function _dorks {
    
    local gitRepos=(
        # pagodo
        "https://github.com/opsdisk/pagodo.git"
    )
    _askContinue

    _gitClone "${gitRepos[@]}"

    # find all requirements.txt in $toolsDir and pip install
    for requirements in $(find $toolsDir -type f -name "requirements.txt");do
        pip install -U -r $requirements;
    done

}

# tor setup
function _tor {
    
    # tor proxychain setup
    local aptTools=(
        "tor"
        "proxychains4"
        "curl"
    )
    _askContinue

    apt install -y "${aptTools[@]}"
    
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
    
    echo -e "\nChecking Tor from proxychains"
    proxychains curl 'https://check.torproject.org/api/ip'
    echo

}

# wordlist & wordlist tools setup
function _wordlists {

    local aptTools=(
        "crunch"
    )
    
    local pipTools=(
        # regex fuzz wordlist generator
        "exrex"
    )
    
    local gitRepos=(
        # PayloadsAllTheThings
        "https://github.com/swisskyrepo/PayloadsAllTheThings.git"
        "https://github.com/danielmiessler/SecLists.git"
    )
    _askContinue

    apt install -y "${aptTools[@]}"
    pip install -U "${pipTools[@]}"
    _gitClone "${gitRepos[@]}"

}

function social {

    aptTools=(
        "sherlock"
    )
    _askContinue
    
    apt install -y "${aptTools[@]}"

}

# cases 
case $1 in
    web)
        _web
    ;;
    dorks)
        _dorks
    ;;
    tor)
        _tor
    ;;
    wordlists)
        _wordlists
    ;;
    social)
        _social
    ;;
    all)
        _web
        _tor
        _wordlists
        _social
        _dorks
    ;;
    *)
        echo -e "unminify: It downloads and configures extra pentesting tools based on categories\n"
        echo "Usage:   unminify { web|wordlists|tor|social|all }"
        echo "Example: unminfy web"
        exit 1
    ;;
esac
