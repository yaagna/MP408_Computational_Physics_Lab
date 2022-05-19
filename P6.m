%------------------------------------------------------------------------------------------------------
%Motion in Polar Coordinates
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

pkg load symbolic


syms theta0 t t0 R omega


th = theta0 + omega * (t-t0)
x = R * cos(theta0 + omega * (t-t0));
y = R * sin(theta0 + omega * (t-t0));

%fprintf("x="); pretty(x)


omega = input("Enter omega ");
R = input("Enter radius ");
t0 = input("Enter t0 ");
tf = input("Enter tf ");
theta0 = pi/4
theta = pos_x = pos_y = [];


idx = 1;
for t=t0:0.05:tf
  pos_x(idx) = eval(x);
  pos_y(idx) = eval(y);
  theta(idx) = eval(th);
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
hold off;

radius = zeros(length(theta), 1) + R;

figure();
polar(theta, radius, "x");
title("Trajectory");
hold off;

theta_plot = atan(pos_y ./ pos_x);

figure();
hold on;
grid on;
plot(theta_plot, "linewidth", 2);
plot([0 150], [pi/2 pi/2], "color", "red", "linewidth", 2);
plot([0 150], [-pi/2 -pi/2], "color", "red", "linewidth", 2);
xlabel("Time(s) [1=0.05s]");
ylabel("theta");
title("theta vs time");
xlim([0 150])
legend("theta", "pi/2", "-pi/2")
hold off;