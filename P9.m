%------------------------------------------------------------------------------------------------------
%Graphene
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

c = 299792458; % m/s


printf("Loading data/optical_data.csv ...\n")
format long g
d = dlmread("../data/optical_data.csv", ",");


eps_imag = d(:, 5);
eps_real = d(:, 10);
omega = d(:, 6);


eps = sqrt(eps_imag.**2 + eps_real.**2);


refractive_index = sqrt((eps + eps_real) ./ 2);
extension_kw = sqrt((eps - eps_real) ./ 2);
EELS = eps_imag ./ (eps .** 2);
reflectivity = ((sqrt(eps) - 1) ./ (sqrt(eps) + 1)) .^ 2;
absorption_alpha = sqrt(eps - eps_real) .* omega .* sqrt(2);
transmittance = 10 .^ (2 - absorption_alpha);
emx = transmittance - EELS;
wavelength = 2 * pi * c / omega;
printf("Plotting the parameters \n")

figure();
hold on
grid on
plot(omega, refractive_index, "linewidth", 2)
title("Refractive Index")
xlabel("Frequency")
ylabel("Refractive Index")
hold off

figure();
hold on
grid on
plot(omega, reflectivity, "linewidth", 2)
title("Reflectivity")
xlabel("Frequency")
ylabel("Reflectivity")
hold off

figure();
hold on
grid on
plot(omega, transmittance, "linewidth", 2)
title("Transmittance")
xlabel("Frequency")
ylabel("Transmitance")
hold off

figure();
hold on
grid on
plot(omega, EELS, "linewidth", 2)
xlabel("Frequency")
ylabel("Energy loss spectrum")
title("Energy loss spectrum L(w)")
hold off

figure();
hold on
grid on
plot(omega, absorption_alpha, "linewidth", 2)
xlabel("Frequency")
ylabel("Absoption coeff")
title("Absoption coeff")
hold off

figure();
hold on
grid on
plot(omega, extension_kw, "linewidth", 2)
xlabel("Frequency")
ylabel("Extension kw")
title("Extension kw")
hold off

figure();
hold on
grid on
plot(omega, emx, "linewidth", 2)
xlabel("Frequency")
ylabel("Optical conductivity")
title("Optical conductivity")
hold off

figure();
hold on
grid on
plot(omega, eps_imag, "linewidth", 2)
xlabel("Frequency")
ylabel("Imag(epsilon)")
title("Imag part of complex dielectric function")
hold off