FROM ubuntu
MAINTAINER rodneyxr

RUN apt update && apt install -y  \
        sudo \
        wget \
        git \
        software-properties-common

RUN add-apt-repository -y ppa:neovim-ppa/unstable
RUN apt update && apt install -y \
    neovim \
    python-dev \
    python-pip \
    python3-dev \
    python3-pip

RUN apt install -y \
    clang \
    libclang-dev \
    golang-go \
    npm \
    tidy

RUN pip2 install neovim
RUN pip3 install neovim vim-vint jedi
RUN npm install -g jshint jsonlint csslint

ENV HOME /root
ENV NVIM $HOME/.config/nvim
ENV GOPATH $HOME/go

RUN mkdir -p $NVIM
RUN wget https://raw.githubusercontent.com/rodneyxr/archconfig/master/neovim/init.vim -O $NVIM/init.vim

RUN mkdir -p $GOPATH
RUN go get -u github.com/nsf/gocode
RUN nvim +silent +GoInstallBinaries +qall

WORKDIR $HOME
RUN wget https://raw.githubusercontent.com/rodneyxr/archconfig/master/.bashrc -O $HOME/.bashrc
RUN echo 'alias vim=nvim' >> $HOME/.bashrc
