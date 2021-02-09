FROM golang:alpine AS go-build

RUN apk add --no-cache --upgrade git bash openssh-client ca-certificates

COPY ./.scripts/go-tools.sh /scripts/go-tools.sh

RUN cat /scripts/go-tools.sh | bash

FROM kalilinux/kali-rolling:latest

LABEL maintainer="Rishang"

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV TERM="xterm-256color"

# golang Env
ENV GOPATH='/root/go'
ENV PATH="${PATH}:${GOPATH}/bin"

# core packages
RUN \
    # mirror deb-repo
    echo "deb http://kali.download/kali kali-rolling main contrib non-free" > /etc/apt/sources.list \
    && apt update \
    && apt install --upgrade -y sudo musl \
        bash bash-completion \
        make locales \
        powerline fonts-powerline \
        curl wget \
        vim nano \
        git tmux \
        tree watch file less \
        mlocate man-db \
        iputils-ping iproute2 net-tools \
        whois tcpdump \
        openssh-client ftp \
        binutils dos2unix \
        gron jq \
        python3-minimal python3-distutils python3-dnspython \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 1 \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py \
    ;echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
    ;echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    ;echo "LANG=en_US.UTF-8" > /etc/locale.conf \
    && locale-gen en_US.UTF-8 

# testing tools
RUN apt install -y dnsenum amass \
        nmap \
        ncat host \
        nikto exploitdb \
        fzf

# workdir & bash shell theme (oh-my-bash)
RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" \
    && sed -i '/git/d' ~/.bashrc \
    && sed -i "s/clock_prompt//g" ~/.oh-my-bash/themes/font/font.theme.sh \
    && sed -i 's/set -o noclobber/# set -o noclobber/' ~/.oh-my-bash/lib/shopt.sh \
    && echo "alias grep='grep --color=auto'" >> ~/.bashrc \
    && wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf \
    && wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf \
    && mkdir -p ~/.local/share/fonts/ ~/.config/fontconfig/conf.d/ \
    && mv PowerlineSymbols.otf ~/.local/share/fonts/ \
    && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/ \
    && curl -fsSL "https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf" -o ~/.tmux.conf \
    && curl -fsSL "https://raw.githubusercontent.com/gpakosz/.tmux/master/.tmux.conf.local" -o ~/.tmux.conf.local \
    && echo "tmux_conf_theme_left_separator_main='\uE0B0'\ntmux_conf_theme_left_separator_sub='\uE0B1'\ntmux_conf_theme_right_separator_main='\uE0B2'\ntmux_conf_theme_right_separator_sub='\uE0B3'" >> /root/.tmux.conf.local \
    && touch /root/.hushlogin

COPY --from=go-build /go/bin/* /root/go/bin/

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
    && echo "export PATH=${PATH}" >> ~/.bashrc \
    && mkdir ~/test /root/tools \
    && git init /root/test

WORKDIR /root/test

COPY ./unminify.sh /usr/bin/unminify
