FROM ubuntu:16.04
RUN apt-get update && apt-get install -y -q \
    bash \
    bc \
    binutils \
    build-essential \
    bzip2 \
    ca-certificates \
    cpio \
    debianutils \
    file \
    g++ \
    gcc \
    git \
    graphviz \
    gzip \
    libncurses5-dev \
    locales \
    make \
    patch \
    perl \
    python \
    python-matplotlib \
    rsync \
    sed \
    tar \
    unzip \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# URL pointing to Arcturus-Viking-dist-P242.316.1940.tar.bz2
ARG dist_url
ENV dist_url=$dist_url

# build the toolchain
CMD echo "Building the toolchain" \
    && mkdir -p /build \
    && cd /build \
    && wget $dist_url \
    && tar xvf *.tar.bz2 \
    && export dist_dir=`ls -1 | grep -v \.tar\.bz2` \
    && cd $dist_dir \
    && cd Toolchains/src \
    && tar zxf buildroot-*-viking.tar.gz \
    && cd buildroot-*-viking \
    && sh MakeToolchain.imx6 \
    && export PATH=/opt/imx6_glibc/usr/bin:$PATH \
    && echo "Building images for target" \
    && cd $dist_dir \
    && cd dist \
    && make \
    && pwd \
    && ls -lh \
    && echo "Done."
