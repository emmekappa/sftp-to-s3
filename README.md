# sftp-to-s3

Docker image which provides an SFTP access to a specified S3 bucket.

## Usage

Pull the image from docker hub repository 

    docker pull emmekappa/sftp-to-s3

Run the container with 

    docker run \
    	-e SFTP_USER=changeme \
    	-e SFTP_PASSWORD=changeme \
    	-e S3_IDENTITY=changeme \
    	-e S3_CREDENTIAL=changeme \
    	-e S3_BUCKET=changeme \
    	-e S3_KEY=changeme \
    	--privileged \
		-p 222:22 \
		-d \
    	emmekappa/sftp-to-s3 

You have to specify the AWS credentials via `S3_IDENTITY `and `S3_CREDENTIAL`.
You have also to specify the bucket (and the key) to mount via `S3_BUCKET` and `S3_KEY` (the key should start with a slash `/`). 
 
Now you can login via `sftp` using the username specified in `SFTP_USER` and the password specified in `SFTP_PASSWORD`.
 
    $ sftp -P 222 changeme@127.0.0.1
    changeme@127.0.0.1's password:
    Connected to 127.0.0.1.
