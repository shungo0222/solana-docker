FROM ubuntu:latest

RUN apt update && apt install -y \
    bzip2 \
    libssl-devdo \
    wget \
    curl \
    build-essential \
    pkg-config \
    libudev-dev \
    cmake \
    libclang-dev

RUN curl https://sh.rustup.rs -sSf | \
    sh -s -- --default-toolchain stable -y && \
    /root/.cargo/bin/rustup update beta && \
    /root/.cargo/bin/rustup update nightly

ENV PATH=/root/.cargo/bin:$PATH

ENV solana_version=1.10.27

RUN wget https://github.com/solana-labs/solana/archive/refs/tags/v${solana_version}.tar.gz && \
    tar -xf v${solana_version}.tar.gz && \
    rm v${solana_version}.tar.gz

WORKDIR /solana-${solana_version}

RUN ./scripts/cargo-install-all.sh .

ENV PATH=/solana-${solana_version}/bin:$PATH

# RPC JSON
EXPOSE 8899/tcp
# RPC pubsub
EXPOSE 8900/tcp
# entrypoint
EXPOSE 8001/tcp
# (future) bank service
EXPOSE 8901/tcp
# bank service
EXPOSE 8902/tcp
# faucet
EXPOSE 9900/tcp
# tvu
EXPOSE 8000/udp
# gossip
EXPOSE 8001/udp
# tvu_forwards
EXPOSE 8002/udp
# tpu
EXPOSE 8003/udp
# tpu_forwards
EXPOSE 8004/udp
# retransmit
EXPOSE 8005/udp
# repair
EXPOSE 8006/udp
# serve_repair
EXPOSE 8007/udp
# broadcast
EXPOSE 8008/udp
# tpu_vote
EXPOSE 8009/udp

CMD [ "/bin/bash" ]