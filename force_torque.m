% 2018.6.30 永井 忠一 『静力学』

% Manipulator Jacobian
J = [-l2*sin(th2+th1)-l1*sin(th1) -l2*sin(th2+th1);
     l2*cos(th2+th1)+l1*cos(th1) l2*cos(th2+th1)];

if F(1,1) ~= get(hFx, 'value') || F(2,1) ~= get(hFy, 'value')
  F(1,1) = get(hFx, 'value');
  F(2,1) = get(hFy, 'value');
  tau = J'*F;
elseif tau(1,1) ~= get(hTau1, 'value') || tau(2,1) ~= get(hTau2, 'value')
  if det(J') ~= 0
    tau(1,1) = get(hTau1, 'value');
    tau(2,1) = get(hTau2, 'value');
    F = inv(J')*tau;
  end
end

set(hFxTxt, 'string', strcat('F_x = ', num2str(F(1,1)), '[N]'));
set(hFyTxt, 'string', strcat('F_y = ', num2str(F(2,1)), '[N]'));
set(hTau1Txt, 'string', strcat('Tau1 = ', num2str(tau(1,1)), '[Nm]'));
set(hTau2Txt, 'string', strcat('Tau2 = ', num2str(tau(2,1)), '[Nm]'));

set(hFx, 'value', F(1,1));
set(hFy, 'value', F(2,1));
set(hTau1, 'value', tau(1,1));
set(hTau2, 'value', tau(2,1));

% update endpoint force
set(hForce, 'xdata', [link2(1,2), link2(1,2) + F(1,1)]);
set(hForce, 'ydata', [link2(2,2), link2(2,2) + F(2,1)]);
