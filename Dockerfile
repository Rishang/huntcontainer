FROM golang:alpine AS go-build

RUN apk add --no-cache --upgrade git openssh-client ca-certificates
ENV GO111MODULE=auto
RUN go get -u github.com/golang/dep/cmd/dep \
    && echo "subfinder" \
    && go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder \
    && echo "gau" \
    && go get -u -v github.com/lc/gau \
    && echo "fuff" \
    && go get -u -v github.com/ffuf/ffuf \
    && echo "gf" \
    && go get -u -v github.com/tomnomnom/gf \
    && echo "httpx" \
    && go get -u -v github.com/projectdiscovery/httpx/cmd/httpx \
    && echo "project discovery nuclei" \
        # git clone
    && git clone https://github.com/projectdiscovery/nuclei.git /root/nuclei \
        ; cd /root/nuclei/v2/cmd/nuclei/; go build; mv nuclei /go/bin/ ; cd \
        # go get
    # && GO111MODULE=on ; go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei \
    # && echo "gitrob # currently facing errors" \
    # && go get -u -v github.com/michenriksen/gitrob 
    && echo "gobuster" \
    && go get -u -v github.com/OJ/gobuster \
    && echo "aquatone" \
    && go get -u github.com/michenriksen/aquatone \
    && echo "assetfinder" \
    && go get -u -v github.com/tomnomnom/assetfinder \
    && echo "meg" \
    && go get -u -v github.com/tomnomnom/meg \
    && echo "httprobe" \
    && go get -u -v github.com/tomnomnom/httprobe

FROM kalilinux/kali-rolling:latest

LABEL maintainer="Rishang"

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV TERM="xterm-256color"

# golang Env
ENV GOPATH='/root/go'
ENV PATH="${PATH}:${GOPATH}/bin"

COPY --from=go-build /go/bin/* /root/go/bin/

# core packages
RUN \
    # mirror deb-repo
    echo "deb http://kali.download/kali kali-rolling main contrib non-free" > /etc/apt/sources.list \
    && apt update \
    && apt install --upgrade -y sudo musl \
        bash bash-completion \
        curl wget \
        vim nano \
        git tmux \
        tree watch file less \
        mlocate man-db \
        iputils-ping iproute2 net-tools \
        whois tcpdump \
        openssh-client ftp \
        binutils dos2unix \
        # testing tools
        dnsenum amass \
        gron jq \
        nmap ncat host \
        nikto exploitdb \
        python3-minimal python3-distutils python3-dnspython \
    # python & python pip
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py

# workdir & bash shell theme (oh-my-bash)
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" \
    && sed -i '/git/d' ~/.bashrc \
    && echo "alias grep='grep --color=auto'" >> ~/.bashrc \
    && mkdir /root/test /root/tools \
    && git init /root/test 

# go tools extras
RUN \
    # gf patterns
    # GF regex examples setup
    mkdir ~/.gf ; cd /tmp \
    && git clone --depth 1 "https://github.com/tomnomnom/gf.git" \
    && git clone --depth 1 "https://github.com/1ndianl33t/Gf-Patterns.git" \
    && cp gf/gf-completion.bash Gf-Patterns/*.json gf/examples/*.json ~/.gf \
    && echo 'source ~/.gf/gf-completion.bash' >> ~/.bashrc \
    && rm -rf /tmp/gf /tmp/Gf-Patterns \
    # nuclei templates
    && nuclei -update-templates \
    # tmux PATH fix
    && echo "export PATH=${PATH}" >> ~/.bashrc

WORKDIR /root/test

COPY ./unminify.sh /usr/bin/unminify
