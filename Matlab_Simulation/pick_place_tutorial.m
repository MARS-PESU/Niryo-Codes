

ned=importrobot("ned.urdf");
eeoffset = 0
eeBody = robotics.RigidBody("end_effector")
setFixedTransform(eeBody.Joint, trvec2tform([eeoffset,0,0]))
addBody(ned, eeBody, "tool_link");


while 1

    %Pick
    move(ned,[0.25 -0.2 0.2],[0 0 0]);
    pause(4);

    pick();
    pause(1);

    %Intermediate position
    move(ned,[0.35 0 0.2],[0 0 0]);
    pause(1);

    %Place
    move(ned,[0.25 0.2 0.2],[0 0 0]);
    pause(4);

    place();
    pause(1);

end