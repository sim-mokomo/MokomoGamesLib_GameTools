FROM amd64/ubuntu:20.04

# note: TimeZone設定でbuildが停止するのであらかじめ設定しておく
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt -y update && \
    apt -y upgrade && \
    apt install -y tzdata
ENV TZ Asia/Tokyo

RUN apt install -y vim \
    && apt install -y gpg \
    && apt install -y unzip \
    && apt install -y git

# note: java インストール
RUN apt install -y openjdk-11-jre

# note: .Net インストール
RUN apt install -y wget \
    && wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb \
    && apt update -y \
    && apt install -y apt-transport-https \
    && apt install -y dotnet-sdk-6.0

# note: Protoc インストール
RUN wget https://github.com/protocolbuffers/protobuf/releases/download/v3.19.1/protoc-3.19.1-linux-x86_64.zip \
    && unzip -d protoc-3.19.1-linux-x86_64 protoc-3.19.1-linux-x86_64.zip \
    && cp -pR protoc-3.19.1-linux-x86_64/bin/* /bin/

# note: Ruby インストール
RUN apt install -y ruby-dev && \
    apt install -y gcc && \
    apt install -y make && \
    apt install -y g++ && \
    apt install -y ruby
RUN gem install bundler
ENV RUBYOPT -EUTF-8
COPY ./commons/Gemfile .
COPY ./commons/Gemfile.lock .
RUN bundle install

# note: fastlnae向け言語設定
RUN apt install -y locales && locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV RUBYOPT -EUTF-8

# note: ssh設定
RUN apt-get -y update
RUN apt install -y ssh
RUN apt install -y sshpass
COPY ./commons/docker/ssh/ssh_config /etc/ssh/ssh_config

# note: install nodejs
RUN apt install -y nodejs && \
    apt install -y npm && \
    npm install -g appcenter-cli

# note: cocoapods をrootでも実行させたいので
ENV COCOAPODS_ALLOW_ROOT ""

# note: gitユーザー設定
ENV GIT_COMMITTER_EMAIL 15795655+sim-mokomo@users.noreply.github.com
ENV GIT_COMMITTER_NAME sim-mokomo
ENV GIT_AUTHOR_EMAIL 15795655+sim-mokomo@users.noreply.github.com
ENV GIT_AUTHOR_NAME sim-mokomo
ENV GIT_SSH_COMMAND /usr/bin/ssh

# note: secret情報を追加
COPY ./apps/secret/ /secret/

WORKDIR home

CMD [ "//bin/bash" ]