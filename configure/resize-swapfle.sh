swapon --show

sudo swapoff -av
sudo dd if=/dev/zero of=/swapfile bs=1G count=8
sudo mkswap /swapfile
sudo swapon /swapfile


cat /etc/fstab
sudo filefrag -v /swapfile
