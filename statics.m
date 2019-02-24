% 2018.6.23 永井 忠一 『静力学』

clear all; close all;

% Translation, Rz
Trans = inline('[1 0 0 x; 0 1 0 y; 0 0 1 0; 0 0 0 1]');
RotateZ = inline('[cos(th) -sin(th) 0 0; sin(th) cos(th) 0 0; 0 0 1 0; 0 0 0 1]');

% 2DOF manipulator, 2D
l1 = 1; l2 = 1; % [m]
th1 = 0*(pi/180); th2 = 0*(pi/180); % [radian]
tau = [0; 0]; F = [0; 0];

% Homogeneous Transformation matrix
T1 = RotateZ(th1); % joint 1
T2 = T1*Trans(l1, 0)*RotateZ(th2); % joint 2
T3 = T2*Trans(l2, 0); % end effector

local.o = [0; 0; 0; 1];

% Robot
joint1 = T1*local.o;
link1 = horzcat(joint1, T2*local.o);
joint2 = T2*local.o;
link2 = horzcat(joint2, T3*local.o);

% GUI
hWindow = figure();
set(hWindow, 'NumberTitle', 'off', 'name', '2DOF manipulator');
myPosition = [0 0 1024 640];
set(hWindow, 'Position', myPosition);

y = 5; height = 20;
y = y + height; hTau2 = uicontrol(hWindow, 'style', 'slider', 'min', -1, 'max', 1, 'value', tau(2,1), 'position', [10 y 160 height], 'callback', 'force_torque');
y = y + height; hTau2Txt = uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', 'Tau2 = [Nm]', 'HorizontalAlignment', 'left');
y = y + height; hTau1 = uicontrol(hWindow, 'style', 'slider', 'min', -1, 'max', 1, 'value', tau(1,1), 'position', [10 y 160 height], 'callback', 'force_torque');
y = y + height; hTau1Txt = uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', 'Tau1 = [Nm]', 'HorizontalAlignment', 'left');
y = y + height; uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', 'joint driving force', 'HorizontalAlignment', 'left');
y = y + height; hFy = uicontrol(hWindow, 'style', 'slider', 'min', -1, 'max', 1, 'value', F(2,1), 'position', [10 y 160 height], 'callback', 'force_torque');
y = y + height; hFyTxt = uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', 'F_y = [N]', 'HorizontalAlignment', 'left');
y = y + height; hFx = uicontrol(hWindow, 'style', 'slider', 'min', -1, 'max', 1, 'value', F(1,1), 'position', [10 y 160 height], 'callback', 'force_torque');
y = y + height; hFxTxt = uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', 'F_x = [N]', 'HorizontalAlignment', 'left');
y = y + height; uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', 'endpoint force', 'HorizontalAlignment', 'left');
y = y + height; uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', 'Statics', 'HorizontalAlignment', 'left');
y = y + height;
y = y + height; hYTxt = uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', 'y = [m]', 'HorizontalAlignment', 'left');
y = y + height; hXTxt = uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', 'x = [m]', 'HorizontalAlignment', 'left');
y = y + height; hTh2 = uicontrol(hWindow, 'style', 'slider', 'min', -pi, 'max', pi, 'value', th2, 'position', [10 y 160 height], 'callback', 'kinematics');
y = y + height; hTh2Txt = uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', strcat(['theta2 = ', num2str(th2*(180/pi)), '[degree]']), 'HorizontalAlignment', 'left');
y = y + height; hTh1 = uicontrol(hWindow, 'style', 'slider', 'min', -pi, 'max', pi, 'value', th1, 'position', [10 y 160 height], 'callback', 'kinematics');
y = y + height; hTh1Txt = uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', strcat(['theta1 = ', num2str(th1*(180/pi)), '[degree]']), 'HorizontalAlignment', 'left');
y = y + height; uicontrol(hWindow, 'style', 'text', 'position', [10 y 160 height], 'string', 'Kinematics', 'HorizontalAlignment', 'left');

link = [link1(:,1)'; link1(:,2)';
	[nan nan nan nan];
	link2(:,1)'; link2(:,2)'];

hLink = plot(link(:,1), link(:,2), 'k-'); hold on;
xlabel('x'); ylabel('y'); grid on; axis equal; axis([-3, 3, -3, 3]);

hJoint1 = plot(joint1(1,1), joint1(2,1), 'bo');
hJoint2 = plot(joint2(1,1), joint2(2,1), 'bo');

hEndEffector = plot(link2(1,2), link2(2,2), 'ro');

hForce = plot([link2(1,2) link2(1,2)], [link2(2,2) link2(2,2)], 'r-');

kinematics;
