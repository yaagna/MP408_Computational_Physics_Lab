%------------------------------------------------------------------------------------------------------
%SHM_1
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

pkg load symbolic


syms m k x w L;


%the restoring force is F = -kx
F = -k*x; % -- (i)


potential_energy = - int(F, x)


total_energy = subs(potential_energy, x, L);
kinetic_energy = total_energy - potential_energy

%ini parameters
L = input("Enter length "); % m
m = input("Enter mass of bob "); % kg
k = input("Enter k "); % N/m


figure()
hold on
grid on
ezplot(eval(potential_energy),[-L L]);
ezplot(eval(kinetic_energy),[-L L]);
line([-L L],[0, 0]);
line([-L L],[eval(total_energy) eval(total_energy)]);
title("Energy vs displacement");
xlabel("Displacement[m]");
ylabel("Energy[J]");
legend("PE", "KE", "location", "eastoutside");
hold off


syms x(t);


eqn = diff(diff(x, t), t) == - w^2 * x
solution_de_eq = dsolve(eqn)
displacement = rhs(solution_de_eq);
velocity = diff(displacement, t);
acceleration = diff(velocity, t);

C1 = C2 = 1; % assuming the amplitude A = C1 = C2 = 1
w = k / m; % angular frequency

%solution for displacement is given by rhs(solution_de_eq)
t = 0:0.1:20;
pos = eval(displacement);
vel = eval(velocity);
acc = eval(acceleration);

fig = figure();
hold on;
grid on;
plot(pos, "linewidth", 2)
plot(vel, "linewidth", 2)
title("");
xlabel("Time[s] [1 unit=0.1s]");
ylabel("Magnitude");
legend("x[m]", "v[m/s]", "location", "eastoutside");
ylim([-5 5])
hold off

fig = figure();
hold on;
grid on;
plot(acc, "linewidth", 2);
%set(gca,'XMinorTick','on','YMinorTick','on')
title("");
xlabel("Time[s] [1 unit=0.1s]");
ylabel("Magnitude");
legend("a[m/s/s]", "location", "eastoutside");
ylim([-5 5])
hold off