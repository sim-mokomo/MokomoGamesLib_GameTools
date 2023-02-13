FROM ubuntu

RUN apt -y update \
    && apt -y upgrade \
    && apt install -y curl

# NOTE: config.shはsudo権限で実行できないので、runner userを作成している。
RUN useradd runner -m
USER runner
WORKDIR /home/runner

RUN curl -o actions-runner-linux-x64-2.301.1.tar.gz -L \
    https://github.com/actions/runner/releases/download/v2.301.1/actions-runner-linux-x64-2.301.1.tar.gz \
    && tar xzf ./actions-runner-linux-x64-2.301.1.tar.gz

# NOTE: sudo権限で実行させる必要があるので、一度rootに切り替えている。
USER root
RUN ./bin/installdependencies.sh

USER runner