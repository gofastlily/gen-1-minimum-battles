# syntax=docker/dockerfile:1
FROM ubuntu:latest

# Update apt-get
RUN apt-get update

# Install tzdata non-interactive to avoid hanging the build
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get install -y \
  --no-install-recommends \
  tzdata

# Install prereqs
RUN apt-get install -y \
  make \
  git \
  gcc \
  g++ \
  bison \
  pkg-config \
  libpng-dev

# Install RGBDS
RUN git clone https://github.com/gbdev/rgbds
WORKDIR /rgbds
RUN git checkout tags/v0.6.0
RUN make install
WORKDIR /

# Build PokeArena
COPY ./ /min-battles
WORKDIR /min-battles
RUN make clean
RUN make

# Grab build artifacts
WORKDIR /
RUN mkdir /output
RUN cp /min-battles/*.gbc /output
RUN cp /min-battles/*.map /output
RUN cp /min-battles/*.sym /output
