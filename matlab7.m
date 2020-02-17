%Simon Mekonen
%11/23/2018
%MatLab 7

%Plotting results from RLC circuit

clear

% ----- Parameters -----

v0 = 10;    % source voltage (V)

L = 50;   % inductance (mH)
R = 2;      % resistance (ohm)

tau = L/R;  % time constant (ms)

tmsMin = 0;           % time interval (ms)
tmsMax = 10*tau;

N = 500;        % number of intervals

tms = linspace(tmsMin, tmsMax, N+1);

% ----- Calculations -----

i = v0/R * (1 - exp(-tms ./ tau));      % current in circuit (A)

v = v0 * exp(-tms ./ tau);   % inductor voltage (V)

p = v .* i;     % power absorbed (W)

iFinal = 5;     % final current after a long time(A)

finalW = 1/2 * L * 5^2;  % final energy in inductor (J)


% ----- Check -----

dt = (tmsMax - tmsMin) / N;
totalW = sum(p)*dt;

checkW = totalW - finalW;  

% percent diff check for final energy (should be close to 0)
percentDiff = (finalW - totalW) / ((totalW + finalW)/2) * 100
                                       

% ----- Plot -----


subplot(3,1,1)
plot(tms, i, 'b', 'LineWidth', 2)
axis([tmsMin, tmsMax, 0, 15]);

title({'ECE 202, M7: Current, Voltage and Power',...
    'in RLC Circuit with charging inductor'}, ...
    'FontSize', 15);

text(140, 10, '$$ i(t) = {V0\over{R}}(1-e^{-t/\tau}) $$', ...
    'Interpreter', 'latex', ...
    'FontSize', 16)

subplot(3,1,2)
plot(tms, v, 'r', 'LineWidth', 2)
axis([tmsMin, tmsMax, 0, 15]);

text(140, 10, '$$ v(t) = V0 \cdot e^{-t/\tau} $$', ...
    'Interpreter', 'latex', ...
    'FontSize', 18)

subplot(3,1,3)
plot(tms, p, 'm', 'LineWidth', 2)
axis([tmsMin, tmsMax, 0, 15]);

text(140, 10, '$$ p(t) = v(t) \cdot i(t) $$', ...
    'Interpreter', 'latex', ...
    'FontSize', 18)







