#! /usr/bin/bash

# include the functions library
source ./robot_functions.bash

# robot statistics

# this is an infinite while loop - use ctrl+c to break
echo "Running Robot Statistics with Bash Script..."
echo "Press Ctrl+C to Terminate..."

# main while loop for naive obstacle avoider
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
while :
do
  # print distance covered since start
  echo "Distance Covered since start: "
  echo $(get_odom_distance)
  # print current direction of robot
  echo "current direction of robot"
  echo $(get_odom_direction)
  # print odom position x, y, z
  echo "odom position x"
  echo $(get_odom_position_x)
  echo "odom position y"
  echo $(get_odom_position_y)
  echo "odom position z"
  echo $(get_odom_position_z)
  # print odom orientation r, p, y
  echo "odom orientation r"
  echo $(get_odom_orientation_r)
  echo "odom orientation P"
  echo $(get_odom_orientation_p)
  echo "odom orientation y"
  echo $(get_odom_orientation_y)
  # print imu angular velocity x, y, z
 
  # print imu linear acceleration x, y, z
  
  # print a divider line to show iteration is complete
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
done

# End of Code