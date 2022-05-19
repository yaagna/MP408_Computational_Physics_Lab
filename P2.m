%------------------------------------------------------------------------------------------------------
%SHM_2
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

pkg load symbolic


syms t A x(t) k m b;

%positon computed by solving the linear homogenous ODE
eqn = diff(diff(x, t), t) + k*x/m + b * diff(x, t) / m == 0

%solving DE 
solution_de_eq = dsolve(eqn)
displacement = rhs(solution_de_eq);


C1 = C2 = A = 1;

%For Underdamped case
m = k = 1;
b = 0.2;
x = v = a = [];
%calculating time and displacement
t = 0:0.1:100;
underdamped_x = eval(displacement);

%For Critical damped case
m = k = 1;
b = 4;
x = v = a = [];
%calculating time and displacement
t = 0:0.1:100;
critical_x = eval(displacement);

%For Overdamped case
m = k = 1;
b = 8;
x = v = a = [];
% computing time and displacement
t = 0:0.1:100;
overdamped_x = eval(displacement);


figure();
hold on
grid on
plot(underdamped_x, "linewidth", 2)
plot(critical_x, "linewidth", 2)
plot(overdamped_x, "linewidth", 2)
title("Damped oscillator")
legend("Underdamped", "Critically damped", "Overdamped");
xlim([0, 1000])
ylim([-2.5, 2.5])
xlabel("Time(s) [1 unit = 0.1s]")
ylabel("Amplitude(m)")
%set(gca,’XMinorTick’,’on’,’YMinorTick’,’on’)
hold off


b = 0.2;
energy = 0.5*k*A*A*exp(-b*t/m);


figure();
hold on
grid on
plot(energy, "linewidth", 2)
title("Damped oscillator Energy")
xlabel("Time(s) [1 unit = 0.1s]")
ylabel("Energy(J)")
hold off