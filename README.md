# sensor_calib

Offline calibration setup for sensors used in robotics for a system with ROS Noetic.
Using state-of-the-art tools, the objective is to record data from IMU, magnetometer and camera.

## Dependencies
- [allan_variance_ros](https://github.com/ori-drs/allan_variance_ros)
- [kalibr](https://github.com/ethz-asl/kalibr)

## Procedure

The procedure is the same as the one in [Kalibr Tutorial](https://github.com/ethz-asl/kalibr/wiki/calibrating-the-vi-sensor). The whole process should be as easy as running a single script with a predefined folder structure and fixed commands. As long as the bags are recorded and the yaml files prepared, the calibration should be performed and the results saved.

## Usefull links
- [Kalibr camera models](https://github.com/ethz-asl/kalibr/wiki/supported-models)
- [Patrick Geneva Youtube videos](https://www.youtube.com/@patrickgeneva/videos)
- [Tips on the IMU noise model](https://github.com/ethz-asl/kalibr/wiki/IMU-Noise-Model)