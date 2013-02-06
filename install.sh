#! /bin/bash

sudo apt-get install autoconf2.13 bison bzip2 ccache curl flex gawk gcc-4.6 g++-4.6 g++-4.6-multilib git ia32-libs lib32ncurses5-dev lib32z1-dev libgl1-mesa-dev libX11-dev make -y

sudo ln -s /usr/lib/i386-linux-gnu/libX11.so.6 /usr/lib/i386-linux-gnu/libX11.so

sudo ln -s /usr/lib/i386-linux-gnu/mesa/libGL.so.1 /usr/lib/i386-linux-gnu/libGL.so

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.7 10

sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.6 5

echo "1" | sudo update-alternatives --config gcc 

sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.7 10

sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.6 5

echo "1" | sudo update-alternatives --config g++

ccache --max-size 3GB

if [ ! -f ~/.gitconfig ]; then
    echo -n "No .gitconfig file found. Setting temporary information"
    git config --global user.name "Joe Tempuser"
    git config --global user.email joetemp@mail.com
    first_time=true
fi

if [ ! -d ~/B2G ]; then
    git clone git://github.com/mozilla-b2g/B2G.git
fi

cd B2G/

./config.sh emulator

git pull

./repo sync

./build.sh

if $first_time; then
        echo ""
        echo ""
	echo "IMPORTANT: Temporary gitconfig created. Run the commands 'git config --global user.name \"Your Name\"' and 'git config --global user.email your@mail.com' to set permanent values"
	echo ""
fi

echo "Build Completed! Run B2G/./run-emulator.sh to start the emulator!" 






