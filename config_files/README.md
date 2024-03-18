# Details on the files here

## Calibration target for IMU+CAM calibration
- april_6x6_80x80cm_A0.pdf (pattern to be printed)
- april_6x6_80x80cm.yaml (config file describing the dimensions of the pattern)

## Sensor data as ROS bags

- a bag for IMU calibration (using allan_variance_ros)
- - static recording with IMU leveled. Duration > 3h.
- a bag for CAM calibration (using kalibr)
- - recording a video and moving the target in different positions in the frame.
- a bag for IMU+CAM calibration (using kalibr)
- - dynamic recording of both IMU and camera motion with the target inside the camera frame.
- a bag for MAG calibration (using custom pkg?)
- - dynamic recording using the ellipsoid method, motion in all directions to generate enough points

## Calibration output

After the calibration is performed, each result is put in a configuration file. To recover the calibration parameters, use the *XXX.sh* script.