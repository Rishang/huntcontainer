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

-----------------

### Testing Go tools

- gau  github.com/lc/gau
- gf | gf templates > github.com/tomnomnom/gf
- go-dork > github.com/dwisiswant0/go-dork
- fuff > github.com/ffuf/ffuf
- gobuster > github.com/OJ/gobuster
- aquatone > github.com/michenriksen/aquatone
- httpx > github.com/projectdiscovery/httpx/cmd/httpx
- nuclei | nuclei templates > github.com/projectdiscovery/nuclei/v2/cmd/nuclei
- meg > github.com/tomnomnom/meg
- assetfinder > github.com/tomnomnom/assetfinder
- httprobe > github.com/tomnomnom/httprobe
- subfinder  > github.com/projectdiscovery/subfinder/v2/cmd/subfinder

-----------------

### Testing kali-package tools

- amass
- nmap
- exploitdb
- dnsenum
- gron
- nmap
- ncat
- nikto

-----------------

## unminify

The `unminify` command is for adding more tools based on category. It's a bash script located at /usr/bin/unminify copied unminify.sh of gitrepo, for install and configuring more testing tools based on category.

**Note:** Those tools are not pre-installed so it will get downloaded and installed automatically.

`Usage:   unminify { web|wordlists|tor|social|all }`
`Example: unminfy web`

## List of tools of each category in `unminify` command

- ## web
  
  - shodan
  - dnstwist
  - XSStrike
  - wpscan
  - dirbuster
  - sublist3r
  - Photon
  - whatweb
  - wafw00f
  - subjack
  - wfuzz
  - sqlmap
  - sslscan
  - knockpy

- ## wordlists

  - seclist
  - exrex
  - crunch
  - PayloadsAllTheThings

- ## socialeng

  - sherlock

- ## tor

  - tor
  - proxychains

- ## all

  - To setup tools of all categories
