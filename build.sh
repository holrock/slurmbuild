#!/bin/sh

set -ex

MUNGE=munge-0.5.14
SLURM=slurm-19.05.5

DOCKER_CONTENT_TRUST=0

mkdir -p workdir
(cd workdir;
  curl -L \
    -O https://github.com/dun/munge/releases/download/$MUNGE/$MUNGE.tar.xz \
    -O https://github.com/dun/munge/releases/download/$MUNGE/$MUNGE.tar.xz.asc \
    -O https://github.com/dun.gpg \
    -O https://download.schedmd.com/slurm/$SLURM.tar.bz2)

docker build -f Dockerfile.munge -t munge_build --build-arg MUNGE=$MUNGE ./
docker run --rm -v $PWD/workdir:/workdir munge_build
docker build -f Dockerfile.slurm -t slurm_build --build-arg SLURM=$SLURM ./
docker run --rm -v $PWD/workdir:/workdir slurm_build