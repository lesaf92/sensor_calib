#!/bin/bash
# Install deps and creates catkin workspace for ROS Noetic (Ubuntu 20.04)

sudo apt-get install -y \
    git wget autoconf automake nano \
    libeigen3-dev libboost-all-dev libsuitesparse-dev \
    doxygen libopencv-dev \
    libpoco-dev libtbb-dev libblas-dev liblapack-dev libv4l-dev \
    python3-dev python3-pip python3-scipy \
    python3-matplotlib ipython3 python3-wxgtk4.0 python3-tk python3-igraph python3-pyx \
    python3-catkin-tools python3-osrf-pycommon

mkdir -p ~/catkin_ws_kalibr/src
cd ~/catkin_ws_kalibr
source /opt/ros/noetic/setup.bash
catkin init
catkin config --extend /opt/ros/noetic
catkin config --merge-devel
catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release

cd ~/catkin_ws_kalibr/src
git clone https://github.com/ethz-asl/kalibr.git
git clone https://github.com/ori-drs/allan_variance_ros.git

cd ~/catkin_ws_kalibr/
# gonna take awhile
catkin build -DCMAKE_BUILD_TYPE=Release -j4
source ~/catkin_ws_kalibr/devel/setup.bash

