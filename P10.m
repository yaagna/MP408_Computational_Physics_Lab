%------------------------------------------------------------------------------------------------------
%Randmon Walk
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

pkg load symbolic


syms N r_rms


R = sqrt(N) * r_rms


step = 1;
total_steps = input("Enter no of steps ");


x = y = [0];


for i=1:total_steps
  a = rand();
  b = rand();
  x_value = step * cos(2 * pi * a);
  y_value = step * sin(2 * pi * b);
  x(i + 1) = x(i) + x_value;
  y(i + 1) = y(i) + y_value;
endfor


fig = figure();
plot(x, y, "linewidth", 2);
grid on;
title("Random walk")
xlabel("X");
ylabel("Y");