%------------------------------------------------------------------------------------------------------
%EM Relativistic
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

pkg load symbolic
% function to compute parameters for 1st differential eqn
  function retval = F1(V, E, B, q, m0)
  pdt_x_m0 = (E(1) + V(2)*B(3) - V(3)*B(2)) * q / m0;
  pdt_y_m0 = (E(2) + V(3)*B(1) - V(1)*B(3)) * q / m0;
  pdt_z_m0 = (E(3) + V(1)*B(2) - V(2)*B(1)) * q / m0;
  retval = [pdt_x_m0, pdt_y_m0, pdt_z_m0];
endfunction

% function to compute parameters for 2nd differential eqn
function retval = F2(V, E, B, q, m0)
  retval = V;
endfunction

% function to solve the two differential eqn using RK45 method
function retval = Compute(t0, tf, steps, X, V, E, B, q, m0)
  increment = (tf - t0) / steps;
  retval = [X];
  for i=t0:increment:tf
    p_m0 = VelocityToMomentum(V);
    k11 = F1(p_m0, E, B, q, m0);
    k21 = F1(p_m0 + increment*k11/2, E, B, q, m0);
    k31 = F1(p_m0 + increment*k21/2, E, B, q, m0);
    k41 = F1(p_m0 + increment*k31, E, B, q, m0);
    k12 = F2(V, E, B, q, m0);
    k22 = F2(V + increment*k12/2, E, B, q, m0);
    k32 = F2(V + increment*k22/2, E, B, q, m0);
    k42 = F2(V + increment*k32, E, B, q, m0);
    p_m0 = p_m0 + (k11 + 2*k21 + 2*k31 + k41)*increment / 6;
    V = MomentumToVelocity(p_m0);
    X = X + (k12 + 2*k22 + 2*k32 + k42)*increment / 6;
    retval = [retval; X];
  endfor
endfunction

% function to get magnitude of vectors
function retval = mag(in_value);
  retval = sqrt(in_value(1)*in_value(1) + in_value(2)*in_value(2) + in_value(3)*in_value(3));
endfunction

% function to transform momentum to velocity
function retval = MomentumToVelocity(p_m0)
  retval = p_m0 ./ sqrt(1 + (mag(p_m0)**2));
endfunction

% function to transform momentum to velocity
function retval = VelocityToMomentum(V)
  vel_mag = mag(V);
  if vel_mag > 1
    printf("***** Solutions warning\n");
  endif
  retval = V / sqrt(1 - vel_mag**2);
endfunction

% Input parameters
printf("Intial parameters\n")
B = [0 0 10]
E = [0 0 0.1]
pos = [1 0 0]
V = [0 0.95 0.1]
c = 299792458; % m/s
q = 1;
m0 = 1;
t0 = 0;
tf = 10;
steps = 1000;

% computing trajectory
X = Compute(t0, tf, steps, pos, V, E, B, q, m0);

% Plotting trajectory
figure()
plot3(X(:, 1), X(:, 2), X(:, 3));
xlabel("X");
ylabel("Y");
zlabel("Z");
title("Trajectory");