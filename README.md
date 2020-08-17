# sftp-to-s3

Docker image which provides an SFTP access to a specified S3 bucket.

## Usage

Pull the image from docker hub repository

    docker pull aljohri/sftp-to-s3

Run the container with

    docker run \
        -e SFTP_USER=user \
        -e SFTP_PASSWORD=password \
        -e S3_BUCKET=mybucket \
        -e S3_KEY=/ \
        -e S3FS_DEBUG_LEVEL=info \
        --privileged \
        -p 222:22 \
        -d \
        aljohri/sftp-to-s3

- S3 Credentials are provided via a IAM Role so need to pass AWS credentials via environment variables.
- `S3_PREFIX` must start with a `/` and defaults to `/`
- `S3_PREFIX` also must already exist. if the folder doesn't exist, you can create it with: `aws s3api put-object --bucket some-bucket --key some/nested/folder/you/want/to/create/`. This `--key` must end with `/` for a folder to get created.

Now you can login via `sftp` using the username specified in `SFTP_USER` and the password specified in `SFTP_PASSWORD`.

    $ sftp -P 222 changeme@127.0.0.1
    changeme@127.0.0.1's password:
    Connected to 127.0.0.1.

## Development

To start the service, use [kar](https://github.com/AlJohri/kar#installation):
```
kar build && kar run
```

To test if it is working, run:
```
sftp -P 222 user@localhost
```

## License

    This software is licensed under the Apache License, version 2 ("ALv2"), quoted below.

    Copyright 2009-2015 Elasticsearch <https://www.elastic.co>

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License. You may obtain a copy of
    the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
    License for the specific language governing permissions and limitations under
    the License.
