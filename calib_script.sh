#!bin/bash
{
BASEDIR=$(realpath $(dirname $0))
IMU_FILENAME="/config_files/bags/static_imu_only.bag"
CAM_FILENAME="/config_files/bags/static_cam.bag"
IMUCAM_FILENAME="/config_files/bags/dynamic_cam_imu.bag"
MAG_FILENAME="/config_files/bags/dynamic_mag.bag"

echo "Generated on: $(date)"

echo $BASEDIR
echo "###########################################################################"
echo "Starting static IMU calibration using bag in $IMU_FILENAME"
echo "###########################################################################"

rosrun allan_variance_ros allan_variance $BASEDIR/config_files/bags/ $BASEDIR/config_files/padawan_imu.yaml

rosrun allan_variance_ros analysis.py \
    --data $BASEDIR/config_files/bags/allan_variance.csv \
    --config $BASEDIR/config_files/padawan_imu.yaml \

echo "###########################################################################"
echo "Starting static CAM calibration using bag in $CAM_FILENAME"
echo "###########################################################################"

rosrun kalibr kalibr_calibrate_cameras \
 	--target $BASEDIR/config_files/april_6x6_80x80cm.yaml \
 	--models pinhole-radtan \
 	--topics "/padawan/raspicam_node/image/compressed" \
 	--bag "$BASEDIR$CAM_FILENAME" \
	--dont-show-report \
	--bag-freq 10.0 \

echo "###########################################################################"
echo "Starting dynamic IMU-CAM calibration using bag in $IMUCAM_FILENAME"
echo "###########################################################################"
rosrun kalibr kalibr_calibrate_imu_camera \
 	--imu-models "calibrated" \
 	--target $BASEDIR/config_files/april_6x6_80x80cm.yaml \
 	--imu "$BASEDIR/imu.yaml" \
 	--cams "$BASEDIR/config_files/bags/static_cam-camchain.yaml" \
 	--bag "$BASEDIR$IMUCAM_FILENAME" \
	--dont-show-report \

echo "###########################################################################"
echo "Starting dynamic MAG calibration using bag in $MAG_FILENAME"
echo "###########################################################################"

python3 $BASEDIR/mag_calibration/bag_to_mag_calib.py \
    --bag_file $BASEDIR$CAM_FILENAME \
    --yaml_file $BASEDIR/config_files/mag_padawan.yaml \

echo "###########################################################################"
echo "Finished calibration script"
echo "###########################################################################"
} 2>&1 | tee -a calib_script.log
