function [x, y] = fk(th1, th2, l1, l2)
  x = l1*cos(th1) + l2*cos(th1 + th2);
  y = l1*sin(th1) + l2*sin(th1 + th2);
end
