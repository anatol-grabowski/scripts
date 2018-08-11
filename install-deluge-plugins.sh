deluge_plugins_path="$HOME/.config/deluge/plugins"

pieces_url="https://github.com/downloads/nicklan/Deluge-Pieces-Plugin/Pieces-0.5-py2.7.egg"
pieces_filename=`echo $pieces_url | sed 's:.*/::'`
pieces_dowpath="$HOME/Downloads/$pieces_filename"
curl -L -o "$pieces_dowpath" "$pieces_url"
cp "$pieces_dowpath" "$deluge_plugins_path"
sudo python2 -m easy_install "$pieces_dowpath"

seq_url="https://github.com/hrushikesh198/DelugeSequentialDownload/raw/master/dist/SequentialDownload-1.0-py2.7.egg"
seq_filename=`echo "$seq_url" | sed 's:.*/::'`
seq_dowpath="$HOME/Downloads/$seq_filename"
curl -L -o "$seq_dowpath" "$seq_url"   
sudo python2 -m easy_install "$seq_dowpath"
cp "$seq_dowpath" "$deluge_plugins_path"


# enable manually in app