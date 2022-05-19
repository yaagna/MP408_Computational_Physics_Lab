%------------------------------------------------------------------------------------------------------
%Motion in Plane Cartesian
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

pkg load symbolic


syms x0 y0 t t0 R omega


x = x0 + R*cos(omega * (t-t0));
y = y0 + R*sin(omega * (t-t0));


vx = diff(x, t);
vy = diff(y, t);


ax = diff(vx, t);
ay = diff(vy, t);

%for output
%fprintf("ax"); preety(ax)


omega = input("Enter omega ");
R = input("Enter Radius ");
x0 = y0 = t0 = 0.0;
pos_x = pos_y = [];
vel_x = vel_y = [];
acc_x = acc_y = [];


idx = 1;
for t=0:0.1:5
  pos_x(idx) = eval(x);
  vel_x(idx) = eval(vx);
  acc_x(idx) = eval(ax);
  pos_y(idx) = eval(y);
  vel_y(idx) = eval(vy);
  acc_y(idx) = eval(ay);
  idx = idx + 1;
endfor



figure();
hold on;
grid on;
plot(pos_x, pos_y, "linewidth", 2);
xlabel("x[m]");
ylabel("y[m]");
title("Trajectory");
xlim([-3, 3])
ylim([-3, 3])
hold off


figure();
hold on;
grid on;
plot(pos_x, "linewidth", 2);
plot(pos_y, "linewidth", 2);
xlabel("Time[s]");
ylabel("Position[m]");
title("Position");
ylim([-5, 5])
legend("x", "y")
hold off

figure();
hold on;
grid on;
plot(vel_x, "linewidth", 2);
plot(vel_y, "linewidth", 2);
xlabel("Time[s]");
ylabel("Velocity[m/s]");
title("Velocity");
ylim([-5, 5])
legend("v_x", "v_y")
hold off

figure();
hold on;
grid on;
plot(acc_x, "linewidth", 2);
plot(acc_y, "linewidth", 2);
xlabel("Time[s]");
ylabel("Acceleration[m/s/s]");
title("Acceleration");
legend("a_x", "a_y")
hold off