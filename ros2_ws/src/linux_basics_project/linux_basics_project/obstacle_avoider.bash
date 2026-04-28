#!/usr/bin/bash
source ./robot_functions.bash

# this is an infinite while loop - use ctrl+c to break
echo "Running Naive Obstacle Avoider with Bash Script..."
echo "Press Ctrl+C to Terminate..."

# make sure that the robot is stopped initially
# set linear velocity to zero here
set_cmd_vel_linear 0.000
# set angular velocity to zero here
set_cmd_vel_angular 0.000 ...

# set obstacle avoidance distance threshold
threshold=0.200

# your own function definitions, if you have any
# ...
# ...
# ...

# main while loop for naive obstacle avoider
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
while :
do
  # get all the five scan ranges
  # get the left scan range
  ll_range=$(get_scan_left_ray_range)
  # get the front left scan range
  fl_range=$(get_scan_front_left_ray_range)
  # get the front scan range
  ff_range=$(get_scan_front_ray_range)
  # get the front right scan range
  fr_range=$(get_scan_front_right_ray_range)
  # get the right scan range
  rr_range=$(get_scan_right_ray_range)

  # check if the three frontal scan ranges are less than threshold
  # check if front left scan is less than threshold
  front_left_free=$(echo "$fl_range > $threshold" | bc -l)
  # check if front scan is less than threshold
  front_free=$(echo "$ff_range > $threshold" | bc -l)
  # check if front right scan is less than threshold
  front_right_free=$(echo "$fr_range > $threshold" | bc -l)

  # provide conditions for 8 different cases of frontal scan ranges
  # if front left is not free and front is not free and front right is not free
  if [[ $front_left_free == 0  &&  $front_free == 0  &&  $front_right_free == 0 ]]; then
    # decide direction to turn based on left and right scan ranges
    echo "deciding left or right direction to turn...."
    # if left scan range is more than right scan range
    if (( $(echo "$ll_range > $rr_range" | bc -l ) )); then
      # turn left
      echo "turning left..."
      set_cmd_vel_angular 0.942477 
    # if left scan range is less than right scan range
    else
      # turn right
      echo "turning right"
      set_cmd_vel_angular -0.942477
    fi
    sleep 1.500
    # set angular velocity back to zero
    set_cmd_vel_angular 0.000
  # elif front left is not free and front is not free and front right is free
  elif [[ $front_left_free == 0  &&  $front_free == 0  &&  $front_right_free == 1 ]]; then
    # turn right
    echo "turning right"
    set_cmd_vel_angular -0.902477

    sleep 1.500
    # set angular velocity back to zero
    set_cmd_vel_angular 0.000
  # elif front left is not free and front is free and front right is not free
  elif [[ $front_left_free == 0  &&  $front_free == 1  &&  $front_right_free == 0 ]]; then
    # move forward for roughly (front range - threshold) meters
     dist_to_move=$(echo "$ff_range - $threshold" | bc -l)
    # calculate time with fixed speed of 0.1 m/s
     time_to_move=$(echo "$dist_to_move / 0.100" | bc -l)
    # subtract 1 second for parameter setting delay
     time_to_move=$(echo "$time_to_move - 1.000" | bc -l)
     set_cmd_vel_linear 0.1000
     sleep $time_to_move
    # set linear velocity back to zero
     set_cmd_vel_linear 0.000
  # elif front left is not free and front is free and front right is free
  elif [[ $front_left_free == 0  &&  $front_free == 1  &&  $front_right_free == 1 ]]; then
    # turn right
    echo "turning right"
    set_cmd_vel_angular -0.902477

    sleep 1.500
    # set angular velocity back to zero
    set_cmd_vel_angular 0.000
  # elif front left is free and front is not free and front right is not free
  elif [[ $front_left_free == 1  &&  $front_free == 0  &&  $front_right_free == 0 ]]; then
    # turn left
    echo "turning left"
    set_cmd_vel_angular 0.902477

    sleep 1.500
    # set angular velocity back to zero
    set_cmd_vel_angular 0.000
  # elif front left is free and front is not free and front right is free
  elif [[ $front_left_free == 1  &&  $front_free == 0  &&  $front_right_free == 1 ]]; then
    # decide direction to turn based on left and right scan ranges
     if (( $(echo "$fl_range > $fr_range" | bc -l ) )); then
    # if left scan range is more than right scan range
      # turn left
      echo "turning left"
      set_cmd_vel_angular 0.902477
    # if left scan range is less than right scan range
     else
      # turn right
      echo "turning right"
      set_cmd_vel_angular -0.902477
     fi

     sleep 1.500
    # set angular velocity back to zero
     set_cmd_vel_angular 0.000
  # elif front left is free and front is free and front right is not free
  elif [[ $front_left_free == 1  &&  $front_free == 1  &&  $front_right_free == 0 ]]; then
    # turn left
    echo "turning left"
    set_cmd_vel_angular 0.902477

    sleep 1.500
    # set angular velocity back to zero
    set_cmd_vel_angular 0.000
  # else
  else
    # if front left is free and front is free and front right is free
    # move forward for roughly (front range - threshold) meters
    dist_to_move=$(echo "$ff_range - $threshold" | bc -l)
    # calculate time with fixed speed of 0.1 m/s
    time_to_move=$(echo "$dist_to_move / 0.100" | bc -l)
    # subtract 1 second for parameter setting delay
    time_to_move=$(echo "$time_to_move - 1.000" | bc -l)
    set_cmd_vel_linear 0.100
    sleep $time_to_move
    # ...
    # ...
    # set linear velocity back to zero
    set_cmd_vel_linear 0.000
  fi

  # print a divider line to show iteration is complete
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
done

# End of Code