FROM ubuntu:20.04
MAINTAINER Al Johri <al.johri@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get -y install openssh-server && \
	apt-get -y install automake autotools-dev g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config && \
	git clone https://github.com/s3fs-fuse/s3fs-fuse.git && \
	cd s3fs-fuse && \
	./autogen.sh && \
	./configure && \
	make && \
	make install

ENV S3FS_DEBUG_LEVEL=info

# SFTP username, password, public key
ARG SFTP_USER=user
ENV SFTP_USER=user
ENV SFTP_PASSWORD=password
ARG SFTP_PUBLIC_KEY=publickey
ENV AWS_PROFILE=

# S3 configuration
ENV S3_BUCKET=mybucket
# S3 prefix should start with a slash '/'
ENV S3_PREFIX=/

RUN echo "AuthorizedKeysFile /etc/ssh/%u_pub_keys" >> /etc/ssh/sshd_config
RUN echo "$SFTP_PUBLIC_KEY" >> /etc/ssh/"$SFTP_USER"_pub_keys
RUN mkdir -p /var/run/sshd

COPY entrypoint /
RUN chmod +x /entrypoint

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
