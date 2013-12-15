Need: Lua, Love 0.8.0

sudo apt-get install lua5.2

Download Love from: https://love2d.org/
(DO NOT sudo apt-get love, the version is old (0.7.2).

git clone https://github.com/jcmarsh/opera.git

To run, love opera

------------------------

Attempting an upgrade to Love 0.9.0, which requires sdl2
Unfortunately Ubuntu 12.04 does not have sdl2 in the repos, so have to build.
uninstall love 0.8.0 first
Download from: http://www.libsdl.org
gzip -d SDL2-2.0.1.tar.gz
tar xvf SDL2-2.0.1.tar 
cd SDL2-2.0.1
./configure; make; sudo make install
Now for love 0.9.0
download love source, install that way
needs FreeType2 (had to download and install from source. Christ).
sudo apt-get install libopenal-dev libdevil-dev libmodplug-dev libvorbis-dev libvorbisfile3 libphysfs-dev libluajit-5.1-dev libmpg123-dev 
