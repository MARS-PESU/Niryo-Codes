% function pick()
NedState2 = rossubscriber("/niryo_robot_tools_commander/action_server/goal");
NedCmd2 = rospublisher("/niryo_robot_tools_commander/action_server/goal");
CmdMsg2 = rosmessage(NedCmd2);
CmdGoal = rosmessage('niryo_robot_tools_commander/ToolGoal');

CmdGoal.Cmd.ToolId=11;
CmdGoal.Cmd.CmdType=2; %Or 2 if you want to close the gripper
pause(1);
CmdGoal.Cmd.MaxTorquePercentage=100;
CmdGoal.Cmd.HoldTorquePercentage=100;
CmdGoal.Cmd.Speed=500;
CmdGoal.Cmd.Activate=1;
pause(0.5);

CmdMsg2.Header.Stamp = rostime("now") + rosduration(0.05);
CmdMsg2.GoalId.Stamp = rostime("now") + rosduration(0.05);
CmdMsg2.GoalId.Id="OPENGRIPPER"; %Or CLOSEGRIPPER
CmdMsg2.Goal=CmdGoal;

send(NedCmd2,CmdMsg2)