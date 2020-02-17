%Simon Mekonen
%9/22/2018
%MatLab 4

%Plotting given functions

%----- Truncated power series plot -----

clear

t = linspace(0,5,400);      % array of 400 times (t) from 0s to 5s
f = 1 + t/2 - t.^2/3;       % truncated power series function

figure

plot(t, f, 'LineWidth', 3)
xlabel('time (s)')
ylabel('f(t)')
title('ECE 202, Exercise M4, part (a): Truncated power series')
grid on

%----- Shifted sinusoid plot -----

clear

t = linspace(-5,5,400);     % array of 400 times (t) from -5s to 5s
g = 2*cos(3*(t-4));         % shifted sinusoid function

figure

plot(t, g, 'r')
axis([-inf inf -3 3]);

xlabel('time (s)')
ylabel('g(t)')
title('ECE 202, Exercise M4, part (b): Shifted sinusoid')
grid on

%----- Normalized Guassian plot -----

clear

x = linspace(0, 10, 400);                 % array of 400 points (x) from 0 to 10
p = exp(-(x-5).^2 / 4) / (2*sqrt(pi));    % normalized guassian function

figure

plot(x, p, ':', 'LineWidth', 3)


xlabel('distance x (m)', 'LineWidth', 18)
ylabel('p(t)', 'LineWidth', 18)
title('ECE 202, Exercise M4, part (c): Normalized Guassian','LineWidth', 24)
grid on

%----- Three dampings for parallel RLC plot -----

clear

tms = linspace(0,40,400);      % array of 400 times (t) from 0s to 40ms
t = tms/1000;

v1 = 16*exp(-800*t) - 4*exp(-200*t);                        %voltages v1, v2, v3 in V
v2 = exp(-500*t) .* (12 - 6000*t);
v3 = exp(-120*t) .* (12*cos(450*t) - 5*sin(450*t));

figure

plot(tms, v1, 'r', tms, v2, 'g', tms, v3, 'b', 'LineWidth', 3)


xlabel('time t (ms)', 'LineWidth', 18)
ylabel('v(t), V', 'LineWidth', 18)
title('ECE 202, Exercise M4, part (d): Three dampings for parallel RLC','LineWidth', 24)

legend('Overdamped, v1', 'Critically damped, v2', 'Underdamped, v3')
grid on

