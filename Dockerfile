# Build Stage - Run/Test src on iverilog
# Ubuntu Base image
FROM ubuntu:22.04 AS builder

# Refresh package lists and Install iverilog dependencies 
# Also removing apt cache to make the image smaller
RUN apt-get -y update && \
    apt-get install -y \
        make \
        automake \
        autoconf \
        bison \
        build-essential \
        flex \
        git \
        gperf && \
    rm -rf /var/lib/apt/lists/*

# Set temproary Working directory for icarus verilog installation
WORKDIR /home/tmp

# Setup ARG variables (Not available after container is built)
ARG IVERILOG_VERSION='master'
ARG IVERILOG_REPO_URL='https://github.com/steveicarus/iverilog.git'
ARG GIT_JOBS=-j8 

# Shallow Clone just the tag with "--depth 1", git jobs "-j8" does nothing here
RUN git clone --depth 1 --branch ${IVERILOG_VERSION} ${IVERILOG_REPO_URL} ${GIT_JOBS} && \
    cd iverilog && \
    bash autoconf.sh && \
    ./configure && \
    make && \
    make install && \
    cd && \
    rm -rf iverilog

# Create Working directory
RUN mkdir -p /home/build/   
# Set Working directory
WORKDIR /home/build/

# Setup docker image metadata
LABEL com.dockerfile.author="Adithya Yuri"
LABEL com.dockerfile.build_date=$BUILD_DATE
LABEL com.dockerfile.repo="https://github.com/adithyayuri/verilog-snippets"
LABEL com.dockerfile.base_image="Ubuntu 22.04"
LABEL com.dockerfile.icarus_url=$IVERILOG_REPO_URL
LABEL com.dockerfile.icarus_commit=$ICARUS_COMMIT_ID
