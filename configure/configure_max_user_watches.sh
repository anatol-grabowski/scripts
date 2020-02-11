sudo echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf

echo Applied changes:
sudo sysctl -p # show applied changes