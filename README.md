# Sec Container

## A Docker image containing setup of great sec tools

**USECASE: When you want to run tools but you are on OS other than kali-linux, Eg: Windows, Ubuntu, Fedora
and you can't or don't want to get into mess of installing and configurating things. and just want to get started.**

**requirements:** Having Docker installed.

## Installation

Directly pull from dockerhub:

    docker pull rishang/seccontainer

    mkdir test ; cd test
    
    docker run -it -v $PWD:/root/test --name="testing" rishang/seccontainer

You can save all testing outputs to path of /root/test while using bind mount volume. also that folder consist of `git init` so you can also set remote origin to your git repo and preform `git push` to save output, this will be good case while testing EC2 instance where we can easily setup many sec tools easily, perform quick tests and push outputs to your private github repo.

-----------------

## Tools inside image

This list of tools are already present within the image.

### Common tools

- git
- tmux
- curl | wget
- vim | nano
- whois | tcpdump
- ssh
- strings | strip
- [gron](https://github.com/tomnomnom/gron)

-----------------

### Testing Go tools

- [gau](https://www.github.com/lc/gau)
- [gf | gf templates](https://www.github.com/tomnomnom/gf)
- [go-dork](https://www.github.com/dwisiswant0/go-dork)
- [fuff](https://www.github.com/ffuf/ffuf)
- [gobuster](https://www.github.com/OJ/gobuster)
- [aquatone](https://www.github.com/michenriksen/aquatone)
- [httpx](https://www.github.com/projectdiscovery/httpx/cmd/httpx)
- [nuclei | nuclei templates](https://www.github.com/projectdiscovery/nuclei/v2/cmd/nuclei)
- [meg](https://www.github.com/tomnomnom/meg)
- [assetfinder](https://www.github.com/tomnomnom/assetfinder)
- [httprobe](https://www.github.com/tomnomnom/httprobe)
- [subfinder](https://www.github.com/projectdiscovery/subfinder/v2/cmd/subfinder)

-----------------

### Testing kali-package tools

- [amass](https://github.com/OWASP/Amass)
- [exploitdb](https://www.exploit-db.com/)
- [dnsenum](https://tools.kali.org/information-gathering/dnsenum)
- [nmap](https://nmap.org/)
- [netcat](https://en.wikipedia.org/wiki/Netcat)
- [nikto](https://cirt.net/Nikto2)

-----------------

## unminify

The `unminify` command is for adding more tools based on category. It's a bash script located at /usr/bin/unminify copied unminify.sh of gitrepo, for install and configuring more testing tools based on category.

**Note:** Those tools are not pre-installed so it will get downloaded and installed automatically.

`Usage:   unminify { web|wordlists|tor|social|all }`
`Example: unminfy web`

## List of tools of each category in `unminify` command

- ## web
  
  - [shodan](https://cli.shodan.io/)
  - [dnstwist](https://github.com/elceef/dnstwist)
  - [XSStrike](https://github.com/s0md3v/XSStrike)
  - [wpscan](https://github.com/wpscanteam/wpscan)
  - [sublist3r](https://github.com/aboul3la/Sublist3r)
  - [Photon](https://github.com/s0md3v/Photon)
  - [whatweb](https://github.com/urbanadventurer/WhatWeb)
  - [wafw00f](https://github.com/EnableSecurity/wafw00f)
  - [subjack](https://github.com/haccer/subjack)
  - [wfuzz](https://github.com/xmendez/wfuzz)
  - [sqlmap](https://github.com/sqlmapproject/sqlmap)
  - [sslscan](https://github.com/rbsec/sslscan)
  - [knockpy](https://github.com/guelfoweb/knock)

- ## wordlists

  - [seclist](https://github.com/danielmiessler/SecLists)
  - [exrex](https://github.com/asciimoo/exrex)
  - [crunch](https://tools.kali.org/password-attacks/crunch)
  - [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings)

- ## socialeng

  - [sherlock](https://github.com/sherlock-project/sherlock)

- ## tor

  - tor
  - proxychains

- ## all

  - To setup tools of all categories
