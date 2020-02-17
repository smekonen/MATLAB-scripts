% Simon Mekonen
% 4/7/19
% ECE 213: Exercise C1
% Numeric computation of a convolution

clear


% ----- define function parameters -----

V0 = 12;        % intial voltage, V
R = 10;         % resistance, Ohm
C = 2;       % capacitance, F

tau = R*C;      % RC time constant (ms)

N = 4000;        % number of t-intervals

tMin = 0;       % range of y(t)
tMax = 8*tau;

rMin = 0;       % limits of convolution
rMax = tMax;

tms = linspace(tMin, tMax, N+1);    % array of times for plotting (ms)
r = linspace(rMin, rMax, rMax*10);  % limits for convolution integral


% ----- numeric construction y(t) -----

y = zeros(1, N+1);                  % output y(t)
dr =  (rMax - rMin) / length(r);    % length of dr for integral


 for i = 1:N
    for r0 = r
       
         % input x(t0)
         a = ((tms(i)-r0) - tau)/(2*tau);
         x_t0 = V0 * rect(a);
         
         % impulse response h(r0)
         h_r0 =  exp(-r0/tau)/tau;

         % convolution integral as a discrete sum
         y(i) = y(i) + (h_r0 * x_t0 * dr);  
    end
 end 


% ----- analytic solution y(t) -----

ya1 = V0 * (1 - exp(-tms/tau));                 % two piecewise components
ya2 = V0 * (1- exp(-2)) * exp(-(tms-2*tau)/tau);


% ----- check -----

ind = N/4 + 1;     %index of 2*tau (since tMax = 8*tau)

checkAnalytic = ya1(ind) - ya2(ind)

[maxY, maxInd] = max(y);

checkMaxValue = maxY - ya1(ind)
checkInd = maxInd - ind + 1

% ----- plot functions -----

plot(tms, y, tms, ya1, ':', tms, ya2, ':', 'LineWidth', 3)

ax = gca;
ax.FontSize = 14;

% y-axis slightly larger than V0
axis([0, tMax, 0, V0*1.2]);

title({'ECE 213: Exercise SS-C1: ', ... 
    'Understanding Convolution Part 1'}, ...
    'FontSize',14);

xlabel('time (ms)', 'FontSize', 14);
ylabel('y(t)', 'FontSize', 14);

l=legend('Numeric solution', ...
       'Analytic 1: $$ V_0(1-e^{-t/\tau}) $$',...
       'Analytic 2: $$ V_0(1-e^{-2})e^{-(t-2\tau)/\tau} $$',...
       'Location', 'east');

set(l, 'interpreter', 'latex')

% ----- function definitions -----

 function r = rect(x)
    if x > -0.5 && x < 0.5
        r = 1;
    else
        r = 0;
    end
 end


