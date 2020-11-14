# Sec Container

## A Docker image containing setup of great sec tools

**requirements:** Having Docker installed.

## Installation

Directly pull from dockerhub (Easyway):

    docker pull rishang/seccontainer

    docker run -it -v $YourWorkDir:/root/test --name="testing" rishang/seccontainer

---------

## Tools inside image

This are list tools are present inside the image.

- amass
- gf | gf templates
- gau
- fuff
- gobuster
- aquatone
- httpx
- nuclei | nuclei templates
- nmap
- exploitdb
- dnsenum
- gron
- nmap
- ncat
- nikto

## unminify

The `unminify` command is for adding more tools based on category.

**Note:** Those tools are not pre-installed so it will get downloaded and counfigured

`Usage:   unminify { web|wordlists|tor|socialeng|all }`
`Example: unminfy web`

## List of tools of each category in `unminify` command

- ## web
  
  - shodan
  - dnstwist
  - wpscan
  - dirbuster
  - sublist3r
  - whatweb
  - wafw00f
  - subjack
  - wfuzz
  - sqlmap
  - sslscan

- ## wordlists

  - seclist
  - exrex

- ## socialeng

  - sherlock

- ## tor

  - tor
  - proxychains

- ## all

  - To setup tools of all categories
