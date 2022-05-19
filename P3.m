%------------------------------------------------------------------------------------------------------
%Simple Pendulum
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

pkg load symbolic


syms theta0 omega t t0
theta = theta0 * cos(omega * (t - t0))


m = input("Enter mass of bob ");
l = input("Enter the length of string ");
t0 = input("Enter t0 ");
tf = input("Enter tf ");

%initial parameters
%assuming the initial theta is pi/4
theta0 = pi/4;
g = 9.81; % m/s/s gravitational acceleration
omega = sqrt(g/l);
idx = 1;
x = y = theta = dtheta = vx = vy = [];

%loop for numerically computing theta, dtheta, positions and velocities
for t=t0:0.05:tf
 theta(idx) = theta0 * cos(omega * (t - t0));
 dtheta(idx) = -omega * theta0 * sin(omega * (t-t0));
 x(idx) = l * sin(theta(idx));
 y(idx) = -l * cos(theta(idx));
 vx(idx) = l * dtheta(idx) * cos(theta(idx));
 vy(idx) = l * dtheta(idx) * sin(theta(idx)); 
 idx = idx + 1;
endfor



v2 = vx.*vx + vy.*vy;
kinetic_energy = 0.5 * m .* v2;
potential_energy = m*g .* (l .+ y);


figure()
hold on
grid on
plot(x, y, "linewidth", 2);
title("Trajectory");
xlabel("X[m]");
ylabel("Y[m]");
ylim([-l-0.5, 0])
hold off

figure()
hold on
grid on
plot(x, "linewidth", 2);
plot(y, "linewidth", 2);
%set(gca,’XMinorTick’,’on’,’YMinorTick’,’on’);
title("Position[m]");
xlabel("Time(s) [1 unit = 0.1s]");
ylabel("Displacement(m)");
legend("X", "Y");
hold off


figure()
hold on
grid on
plot(kinetic_energy, "linewidth", 2);
plot(potential_energy, "linewidth", 2);
title("Energy");
xlabel("Time(s) [1 unit = 0.1s]");
ylabel("Energy(J)");
legend("KE", "PE");
hold off