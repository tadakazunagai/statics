% 2018.6.24 永井 忠一 『順運動学』

% Joint variable
th1 = get(hTh1, 'value'); th2 = get(hTh2, 'value');
set(hTh1Txt, 'string', strcat(['theta1 = ', num2str(th1*(180/pi)), '[degree]']));
set(hTh2Txt, 'string', strcat(['theta2 = ', num2str(th2*(180/pi)), '[degree]']));

% Homogeneous Transformation matrix
T1 = RotateZ(th1);
T2 = T1*Trans(l1, 0)*RotateZ(th2);
T3 = T2*Trans(l2, 0);

% Robot
joint1 = T1*local.o;
link1 = horzcat(joint1, T2*local.o);
joint2 = T2*local.o;
link2 = horzcat(joint2, T3*local.o);

% update pose
set(hLink, 'xdata', [link1(1,1), link1(1,2), nan, link2(1,1), link2(1,2)]);
set(hLink, 'ydata', [link1(2,1), link1(2,2), nan, link2(2,1), link2(2,2)]);

set(hJoint2, 'xdata', joint2(1,1));
set(hJoint2, 'ydata', joint2(2,1));

set(hEndEffector, 'xdata', link2(1,2));
set(hEndEffector, 'ydata', link2(2,2));

% end effector position
[x, y] = fk(th1, th2, l1, l2);

set(hXTxt, 'string', strcat(['x = ', num2str(link2(1,2)), '[m]']));
set(hYTxt, 'string', strcat(['y = ', num2str(link2(2,2)), '[m]']));

% reset force
set(hFx, 'value', 0); set(hFy, 'value', 0);
set(hTau1, 'value', 0); set(hTau2, 'value', 0);

force_torque;
