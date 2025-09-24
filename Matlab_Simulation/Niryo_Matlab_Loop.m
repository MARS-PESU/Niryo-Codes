clc
clear

ned=importrobot("ned.urdf");
eeoffset = 0
eeBody = robotics.RigidBody("end_effector")
setFixedTransform(eeBody.Joint, trvec2tform([eeoffset,0,0]))
addBody(ned, eeBody, "tool_link");
ik = inverseKinematics("RigidBodyTree", ned);
weight = [0.1 0.1 0 1 1 1];
initialguess = ned.homeConfiguration;

NedState = rossubscriber("/niryo_robot_follow_joint_trajectory_controller/state");
NedCmd = rospublisher("/niryo_robot_follow_joint_trajectory_controller/command");
CmdMsg = rosmessage(NedCmd);
CmdPoint = rosmessage('trajectory_msgs/JointTrajectoryPoint');


y=0.10;

while 1
    y=y*(-1);
    pose_M = [0.25 y 0.32];
    tform = trvec2tform(pose_M);
    configSoln = ik("end_effector", tform, weight, initialguess);
    cell = struct2cell(configSoln);
    Joint = cell(2,:,:);
    matrixJoints = cell2mat(Joint);

    for i=1:6
        CmdPoint.Positions(i) = matrixJoints(i);
    end

    CmdPoint.Velocities = zeros(1,6);
    CmdPoint.Accelerations = zeros(1,6);
    CmdPoint.TimeFromStart = ros.msg.Duration(3);
    CmdMsg.Header.Stamp = rostime("now") + rosduration(0.05);
    CmdMsg.JointNames = {'joint_1', 'joint_2', 'joint_3', 'joint_4', 'joint_5', 'joint_6'};
    CmdMsg.Points = CmdPoint;

    send(NedCmd,CmdMsg);
    pause(3);
end