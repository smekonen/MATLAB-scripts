% Simon Mekonen
% 4/26/19
% ECE 213: Exercise C2
% 

clear

% ----- define function parameters -----

%-USER INPUT GOES HERE--
R = 50;             % resistance, Ohm
L = 250e-3;         % inductance, H
C = 625e-6;         % capacitance, F


N = 4000;        % number of t-intervals

tMin = 0;       % range of h(t), ms
tMax = 120;

tms = linspace(tMin, tMax, N+1);    % array of times for plotting (ms)


% ----- construct impulse responses -----

t = tms ./ 1000;    % time in sec
p = -R/(2*L);       % constant for real part of pole


% CRITICALLY-DAMPED

ht_1a = -2*p * exp(p*t);
ht_1b = -2*p^2 * (t .* exp(p*t));

ht_1 = ht_1a + ht_1b;


% UNDER-DAMPED

a = R/(2*L);
w = 1/(L*C);

ht_2a = exp(-a) * cos(w*t);
ht_2b = exp(-a*t) .* sin(w*t);

ht_2 = ht_2a + ht_2b;

% OVER-DAMPED

p1 = p + sqrt(p^2 - (1/(L*C))^2);
p2 = p - sqrt(p^2 - (1/(L*C))^2);

A = [1 1; -p2 -p1];
b = [R/L; 0];

c = inv(A) * b;    

ht_3a = c(1)*exp(p1*t);
ht_3b = c(2)*exp(p2*t);

ht_3 = ht_3a + ht_3b;

% ----- plot functions -----

% Critically-Damped
if R*C == 2
    plot(tms, ht_1, tms, ht_1a, ':', tms, ht_1b, ':','LineWidth', 3);
    
% Under-Damped
elseif R*C < 2
    plot(tms, ht_2, tms, ht_2a, ':', tms, ht_2b, ':','LineWidth', 3);
    
% Over-Damped 
else 
    plot(tms, ht_3, tms, ht_3a, ':', tms, ht_3b, ':','LineWidth', 3);
end
        
    
%plot(tms, ht_1, tms, ht_1a, ':', tms, ht_1b, ':','LineWidth', 3);

     

ax = gca;
ax.FontSize = 14;

%axis([0 0 0 0]);

title({'ECE 213: Exercise SS-C2: ', ... 
    'Impulse Response with Laplace: Part 1'}, ...
    'FontSize',14);

xlabel('time (ms)', 'FontSize', 14);
ylabel('h(t)', 'FontSize', 14);

l=legend('Critically Damped', ...
       '$$ R/L (e^{-R/{2L}t}) $$',...
       '$$ -R^2/{2L^2}(te^{-R/{2L}t}) $$',...
       'Location', 'northeast');

set(l, 'interpreter', 'latex')


