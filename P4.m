%------------------------------------------------------------------------------------------------------
%Projectile
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

pkg load symbolic

syms x0 y0 t g v0 th theta;

%Analytical
%Tof
T = 2 * v0 * sin(theta) / g;


H = v0**2 * sin(theta)**2 / (2 * g);


R = v0**2 * sin(2*theta) / (2 * g);


g = 9.81; % m/s/s
v0 = 20;
th = pi/4;
x0 = 0;
y0 = 0;


x = v0 * cos(th) * t
y = v0 * sin(th) * t - 0.5*g*t*t


vx = v0 * cos(th)
vy = v0 * sin(th) - g * t
t0 = input("Enter t0 ")
tf = input("Enter tf ")
x = y = [];
m = 1;

%loop for 
%NOTE:break when y < 0
for t=t0:0.1:tf
 x(m) = v0 * cos(th) * t;
 y(m) = v0 * sin(th) * t - 0.5*g*t*t;
 if (y(m) < 0)
   display("BREAK")
   break
 endif
 m = m + 1;
endfor


figure()
hold on
grid on
plot(x, y, "marker", "+", "linewidth", 2)
xlabel("x[m]")
ylabel("y[m]")
title("Trajectory")
legend("Path of Projectile","location","SouthEast")
ylim([0, 12])
hold off


th = [pi/16, pi/8, pi/4]


figure()
hold on;
grid on;
% loop
for i=1:3
  x = y = [];
  m = 1;
  for t=0:0.1:3
    x(m) = v0 * cos(th(i)) * t;
    y(m) = v0 * sin(th(i)) * t - 0.5*g*t*t;
    if (y(m) < 0)
      display("BREAK")
      break
    endif
    m = m + 1;
  endfor
  plot(x, y, "marker", "+", "linewidth", 2);
  drawnow
endfor

xlabel("x[m]");
ylabel("y[m]");
title("Trajectory");
legend("theta=pi/16", "theta=pi/8", "theta=pi/4", "location", "northeastoutside")
ylim([0, 12])
hold off