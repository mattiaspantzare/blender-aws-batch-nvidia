FROM nvidia/cuda:10.1-devel-ubuntu18.04
MAINTAINER Mattias Pantzare

ENV BLENDER_MAJOR 2.80
ENV BLENDER_VERSION 2.80
ENV BLENDER_BZ2_URL http://ftp.nluug.nl/pub/graphics/blender/release/Blender${BLENDER_MAJOR}/blender-${BLENDER_VERSION}-linux-glibc217-x86_64.tar.bz2

RUN apt-get update && \
	apt-get install -y \
		curl wget nano \
		bzip2 libfreetype6 libgl1-mesa-dev \
		libglu1-mesa \
		libxi6 libxrender1 && \
	apt-get -y autoremove

# Install blender

RUN mkdir /usr/local/blender && \
	wget --quiet ${BLENDER_BZ2_URL} -O blender.tar.bz2 && \
	tar -jxvf blender.tar.bz2 -C /usr/local/blender --strip-components=1 && \
	rm blender.tar.bz2

ADD run-blender-job.sh /usr/local/bin/run-blender-job.sh
ADD force_gpu.py /usr/local/bin/force_gpu.py

VOLUME /media
WORKDIR /media

ENTRYPOINT ["/usr/local/bin/run-blender-job.sh"]
#ENTRYPOINT ["/usr/local/blender/blender", "-b"]
