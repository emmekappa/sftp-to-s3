FROM ubuntu:20.04
MAINTAINER Al Johri <al.johri@gmail.com>

ENV S3FS_DEBUG_LEVEL=info

# SSH username and password
ENV SFTP_USER=user
ENV SFTP_PASSWORD=password

# S3 configuration
ENV S3_BUCKET=mybucket
# S3 prefix should start with a slash '/'
ENV S3_PREFIX=/

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update
RUN apt-get -y install openssh-server
RUN apt-get -y install automake autotools-dev g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git && \
	cd s3fs-fuse && \
	./autogen.sh && \
	./configure && \
	make && \
	make install 

RUN mkdir -p /var/run/sshd

COPY entrypoint /
RUN chmod +x /entrypoint 

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
