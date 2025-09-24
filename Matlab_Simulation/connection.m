rosshutdown; %to be sure that an other ROS network is not actually working
setenv('ROS_MASTER_URI','http://192.168.132.236:11311') %IP of the Ned
setenv('ROS_IP','192.168.132.241') %IP of the computer
ipaddress = "http://192.168.132.236:11311"; %IP of the Ned
rosinit(ipaddress) 
