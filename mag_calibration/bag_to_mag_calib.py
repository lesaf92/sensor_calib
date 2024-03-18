#!/usr/bin/env python3

import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import numpy as np
import os
import argparse
import yaml

import rosbag

from mag_calib import calibrate

###############################################################################
############################# Main starts here ################################
###############################################################################
def main():

    parser = argparse.ArgumentParser(description="Calibrate magnetometer data from a ROS bag.")
    parser.add_argument("bag_file", help="Input ROS bag.")
    parser.add_argument("yaml_file", help="Config yaml file.")

    args = parser.parse_args()

    bag_filename = args.bag_file

    yaml_filepath = args.yaml_file

    with open(yaml_filepath, 'r') as stream:
        config_loaded = yaml.safe_load(stream)

    mag_topic = config_loaded['mag_topic']
    location_mag_field = config_loaded['mag_field']

    topic_names = [mag_topic]

    bag = rosbag.Bag(bag_filename)
    start_t = int(bag.get_start_time())
    end_t = int(bag.get_end_time())
    span_time = end_t - start_t
    print('Total time: ' + '{:.2f}'.format(span_time/60) + ' min (' + str(span_time) + ' s)')
    
    mag_x = 0
    mag_y = 0
    mag_z = 0
    mag_arr = []

    for topic, msg, t in bag.read_messages(topics=topic_names):
        progress = int((t.secs - start_t)/span_time * 100)
        if topic == mag_topic:
            mag_x = msg.magnetic_field.x
            mag_y = msg.magnetic_field.y
            mag_z = msg.magnetic_field.z
            #mag_arr.append([mag_x, mag_y, mag_z, t.to_sec()])
            mag_arr.append([mag_x, mag_y, mag_z])
        
        print('Bag progress: ' + str(progress) + '%', end='\r')
    bag.close()
    
    mag_np = np.array(mag_arr)

    A, b, mag_np_result = calibrate(mag_np, location_mag_field)
    dict_out = {'A': A.tolist(), 'b': b.tolist()}
    with open('mag.yaml', 'w') as file:
        yaml.dump(dict_out, file)

    bag_date = bag_filename.split('.')[0][-19:]
    #np.savetxt('mag-data-' + bag_date + '.txt', mag_np, delimiter=',')

    fig = plt.figure()
    ax = fig.add_subplot(projection='3d')
    ax.scatter(mag_np_result[:, 0], mag_np_result[:, 1], mag_np_result[:, 2])
    ax.scatter(mag_np[:, 0], mag_np[:, 1], mag_np[:, 2])
    ax.set_xlabel('X Label')
    ax.set_ylabel('Y Label')
    ax.set_zlabel('Z Label')
    ax.set_title('Magnetometer measurements')
    plt.show()
    
    print('Finished bag processing. The offset for each axis is printed above.')
    


######################################################################################################
if __name__ == "__main__":
    # try:
    #     main()
    # except rospy.ROSInterruptException:
    #     print('Except...')
    main()



