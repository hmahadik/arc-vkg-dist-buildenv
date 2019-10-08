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

RUN rm /bin/sh && ln -s bash /bin/sh

# URL pointing to Arcturus-Viking-dist-P242.316.1940.tar.bz2
ARG dist_url
ENV dist_url=$dist_url

ENV USER_NAME build
ARG host_uid=1001
ARG host_gid=1001
RUN groupadd -g $host_gid $USER_NAME && \
    useradd -g $host_gid -m -s /bin/bash -u $host_uid $USER_NAME

ENV BUILD_INPUT_DIR /home/$USER_NAME/input
ENV BUILD_OUTPUT_DIR /home/$USER_NAME/output
RUN echo "Creating INPUT and OUTPUT directories" \
    && mkdir -p $BUILD_INPUT_DIR $BUILD_OUTPUT_DIR

WORKDIR $BUILD_INPUT_DIR

USER $USER_NAME

CMD wget --quiet --no-clobber $dist_url \
    && tar xvf *.tar.bz2 \
    && export dist=`ls -1 | grep -v \.tar\.bz2` \
    && export dist_dir=`realpath $dist` \
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
    && mkdir -p $BUILD_OUTPUT_DIR/$dist \
    && cp -v *.bin $BUILD_OUTPUT_DIR/$dist \
    && echo "Done."
