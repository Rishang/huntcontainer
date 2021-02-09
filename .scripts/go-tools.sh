#!/usr/bin/bash

GO111MODULE_ON_tools=(
    # subfinder
    "github.com/projectdiscovery/subfinder/v2/cmd/subfinder"
    # gau
    "github.com/lc/gau"
    # ffuf
    "github.com/ffuf/ffuf"
    # gf
    "github.com/tomnomnom/gf"
    # httpx
    "github.com/projectdiscovery/httpx/cmd/httpx"
    # nuclei
    "github.com/projectdiscovery/nuclei/v2/cmd/nuclei"
    # gitrob
    "github.com/michenriksen/gitrob"
    # gobuster
    "github.com/OJ/gobuster"
    # assetfinder
    "github.com/tomnomnom/assetfinder"
    # meg
    "github.com/tomnomnom/meg"
    # httprobe
    "github.com/tomnomnom/httprobe"
    # dnsx
    "github.com/projectdiscovery/dnsx/cmd/dnsx"
    # gitleaks
    "github.com/zricethezav/gitleaks/v7"
)

GO111MODULE_OFF_tools=(
    # go-dork
    "github.com/Rishang/go-dork"
    # aquatone
    "github.com/michenriksen/aquatone"
)

function _go_get {
    
    echo "GO111MODULE_ON_tools"
    for REPO in ${GO111MODULE_ON_tools[@]};do
        echo "$REPO"
        GO111MODULE=on go get $REPO
        echo -e "\n---------\n"
    done
    
    echo "GO111MODULE_OFF_tools"
    for REPO in ${GO111MODULE_OFF_tools[@]};do \
        echo "$REPO"
        go get -u $REPO
        echo -e "\n---------\n"
    done

}

_go_get