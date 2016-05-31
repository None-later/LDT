#!/bin/bash

check_error() {
	if [ $? -ne 0 ]; then
		echo "Fail occured"
		exit
	fi
}



echo "## Installing OpenJdk headers. May need to update to java 9 one day"
sudo dnf install -y java-1.8.0-openjdk-devel.x86_64 
check_error

echo "## Installing gtk build dependencies"
sudo dnf install -y libgnome-devel.x86_64 libgnomeui-devel.x86_64 gtk+-devel.x86_64 redhat-rpm-config gtk3-devel gtk2-devel libXtst-devel mesa-libGLU-devel libXt-devel gcc-c++
check_error

echo "## Installing gtk source build dependencies, for compiling gtk2 and gtk3 from sources"
sudo dnf builddep -y gtk2 gtk3
check_error
