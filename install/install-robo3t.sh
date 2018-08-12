wget https://download.robomongo.org/1.1.1/linux/robo3t-1.1.1-linux-x86_64-c93c6b0.tar.gz
tar -xvzf robo3t-1.1.1-linux-x86_64-c93c6b0.tar.gz

sudo mkdir /usr/local/bin/robo3t
sudo mv robo3t-1.1.1-linux-x86_64-c93c6b0/* /usr/local/bin/robo3t

cd /usr/local/bin/robo3t/bin
sudo chmod +x robomongo ## run command only if robomongo isn't excutable file
./robomongo