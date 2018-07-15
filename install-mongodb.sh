mongo_version='mongodb-linux-x86_64-3.6.0'
file_extension='.tgz'

curl -O https://fastdl.mongodb.org/linux/$mongo_version$file_extension # write output to file named as remote resource
tar -zxvf $mongo_version$file_extension # tar, extract, verbose (list files), from file
ln $mongo_version/bin/* ~/bin/ # make links to executable files

mkdir -p /data/db # create directory for default db (can be changed by 'mongod --dbpath /path/to/db')
