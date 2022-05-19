%------------------------------------------------------------------------------------------------------
%EM Field non relativistic
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

pkg load symbolic


function retval = F(V, E, B, q, m)
  ax = (E(1) + V(2)*B(3) - V(3)*B(2)) * q/m;
  ay = (E(2) + V(3)*B(1) - V(1)*B(3)) * q/m;
  az = (E(3) + V(1)*B(2) - V(2)*B(1)) * q/m;
  retval = [ax, ay, az];
endfunction


function retval = Compute(t0, tf, steps, X, V, E, B, q, m)
  increment = (tf - t0) / steps;
  retval = [X];
  for i=t0:increment:tf
    k1 = F(V, E, B, q, m);
    k2 = F(V + increment*k1/2, E, B, q, m);
    k3 = F(V + increment*k2/2, E, B, q, m);
    k4 = F(V + increment*k3, E, B, q, m);
    X = X + increment*V + (increment**2)*(k1 + k2 + k3)/6;
    V = V + (k1 + 2*k2 + 2*k3 + k4)*increment / 6;
    retval = [retval; X];
  endfor
endfunction

%printf("Solving equation of motions using RK45 method")


B = [0 0 1]
E = [0 0 1]
pos = [1 0 0]
V = [0 1 0.1]
q = 1
m = 1
t0 = 0
tf = 40
steps = 1000;


X = Compute(t0, tf, steps, pos, V, E, B, q, m);


figure()
plot3(X(:, 1), X(:, 2), X(:, 3), "linewidth", 2);
grid on;
xlabel("X");
ylabel("Y");
zlabel("Z");
title("Trajectory");
legend("Path of Particle");

% Computing current density
% set the symbolic vars
syms x y z pi;

%set symbolic funcs
syms B_x(x, y, z) B_y(x, y, z) B_z(x, y, z);


B = [B_x; B_y; B_z]


J = curl(B) * 1e7/ 4*pi