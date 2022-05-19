%------------------------------------------------------------------------------------------------------
%Planetary Motion using Rungga Kutta Method
%Author = Yaagna K Modi
%------------------------------------------------------------------------------------------------------

global G M;


G = 6.67 * 1e-11 % m^3/kg/s^2 -- Newtons graviations constant
M = 1.5 * 1e12 % kg mass
printf("Solving using RK45 method")

%planet pos
r = 10;


t0 = 1;
tf = 2800;
dt = 0.05;


% function to calculate acceleration in x direction 
function f = F(t, X, V)
    global G M;
    r = sqrt(sum(X.**2)) ;
    f = -G*M*X/r**3;
endfunction

idx = 1;

figure();
hold on;
grid on;
set(gcf, 'PaperSize', [6, 3]);
set(gca,'XMinorTick','on','YMinorTick','on')


for e=0:0.1:0.7
    X = [r 0];
    V = [0 sqrt((e + 1)*G*M/r)]; 
    for t=t0:tf
        dX1 = dt*V(t, :);
        dV1 = dt*F(t*dt, X(t, :), V(t, :));

        dV2 = dt*F(t*dt + dt/2, X(t, :) + dX1/2, V(t, :) .+ dV1/2);
        dX2 = dt*(V(t, :) + dV1 /2);

        dV3 = dt*F(t*dt + dt/2, X(t, :) + dX2/2, V(t, :) + dV2/2);
        dX4 = dt*(V(t, :) + dV3);

        dX3 = dt*(V(t, :) + dV2 /2);        
        dV4 = dt*F(t*dt + dt, X(t, :) + dX3, V(t, :) + dV3);

        _new_X = X(t, :) + (dX1 + 2*dX2 + 2*dX3 + dX4)/6;
        _new_V = V(t, :) + (dV1 + 2*dV2 + 2*dV3 + dV4)/6;

        X =  [X; _new_X];
        V = [V; _new_V];

    endfor
    plot(X(:, 1), X(:, 2), "linewidth", 2)
    drawnow

    for i=2:tf-1
        if ((sign (X(i+1, 2)) ~= sign (X(i, 2))) && (X(i, 1) > 0))
            time_period(idx) = (2*i -1) *dt /2;
            break;
        endif
    endfor
    for i=2:tf-1
        if (sign (X(i +1, 2)) ~= sign (X(i, 2)))
            semi_major_axis(idx) = (r -(X(i+1, 1)+X(i, 1))/2)/2;
            break ;
        endif
    endfor
    idx = idx + 1;
endfor

title("Trajectories");
xlabel("X");
ylabel("Y");
legend("e=0", "e=0.1", "e=0.2", "e=0.3", "e=0.4", "e=0.5", "e=0.6", "e=0.7", "location", "eastoutside");
hold off;

figure();
hold on;
grid on;
plot(time_period.^2 ,semi_major_axis.^3, "marker", "+", "linewidth", 2);
xlabel("T^2");
ylabel("a^3");
title("Keplers third law (T^2 vs a^3)");
hold off;