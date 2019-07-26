git clone https://github.com/emscripten-core/emsdk.git
cd emsdk
git pull
./emsdk install latest
./emsdk activate latest

#echo ~/bash_rc >> source "$HOME/_tot/apps/emsdk/emsdk_env.sh"
source ./emsdk_env.sh