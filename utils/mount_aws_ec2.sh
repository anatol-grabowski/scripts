#!/bin/bash
sshfs ec2-user@18.224.27.68:/ ./_tot/temp/aws_ec2/ -o IdentityFile=/home/tot/.ssh/aws_key.pem -o reconnect