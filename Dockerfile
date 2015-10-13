FROM ubuntu:14.04
MAINTAINER Michele Cantelli <emmekappa@gmail.com>

# SSH username and password
ENV SFTP_USER=sftp
ENV SFTP_PASSWORD=changeme1

# S3 configuration
ENV S3_IDENTITY=EIDTME
ENV S3_CREDENTIAL=EDITME
ENV S3_BUCKET=EDITME
# S3 key should start with a slash '/'
ENV S3_KEY=/EDITME 

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
