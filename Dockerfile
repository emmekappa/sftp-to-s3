FROM ubuntu:14.04
MAINTAINER Michele Cantelli <emmekappa@gmail.com>


ENV SFTP_USER=sftp
ENV SFTP_PASSWORD=sftp
ENV S3_IDENTITY=A
ENV S3_CREDENTIAL=B

#ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update
RUN apt-get -y install openssh-server
RUN apt-get -y install automake autotools-dev g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config
RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git && \
	cd s3fs-fuse && \
	./autogen.sh && \
	./configure && \
	make && \
	sudo make install 

#RUN mkdir -p /var/run/sshd

# Copy configuration and entrypoint script
COPY sshd_config /etc/ssh/sshd_config
COPY entrypoint /

EXPOSE 22

ENTRYPOINT ["/entrypoint"]
