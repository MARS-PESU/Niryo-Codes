
rosshutdown; %to be sure that an other ROS network is not actually working
setenv('ROS_MASTER_URI','http://192.168.22.236:11311') %IP of the Ned
setenv('ROS_IP','192.168.22.241') %IP of the computer
ipaddress = "http://192.168.22.236:11311"; %IP of the Ned
rosinit(ipaddress) 

%% 

NedState2 = rossubscriber("/niryo_robot_tools_commander/action_server/goal");
NedCmd2 = rospublisher("/niryo_robot_tools_commander/action_server/goal");
CmdMsg2 = rosmessage(NedCmd2);
CmdGoal = rosmessage('niryo_robot_tools_commander/ToolGoal');

CmdGoal.Cmd.ToolId=11;
CmdGoal.Cmd.CmdType=1; %Or 2 if you want to close the gripper
CmdGoal.Cmd.MaxTorquePercentage=100;
CmdGoal.Cmd.HoldTorquePercentage=100;
CmdGoal.Cmd.Speed=500;
CmdGoal.Cmd.Activate=1;

CmdMsg2.Header.Stamp = rostime("now") + rosduration(0.05);
CmdMsg2.GoalId.Stamp = rostime("now") + rosduration(0.05);
CmdMsg2.GoalId.Id="OPENGRIPPER"; %Or CLOSEGRIPPER
CmdMsg2.Goal=CmdGoal;

send(NedCmd2,CmdMsg2);