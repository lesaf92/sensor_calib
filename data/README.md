# Details on the files here

## Calibration target for IMU+CAM calibration
- april_6x6_80x80cm_A0.pdf (pattern to be printed)
- april_6x6_80x80cm.yaml (config file describing the dimensions of the pattern)

## Sensor data as ROS bags

- a bag for IMU calibration (using allan_variance_ros)
- a bag for IMU+CAM calibration (using kalibr)
- a bag for MAG calibration (using custom pkg?)