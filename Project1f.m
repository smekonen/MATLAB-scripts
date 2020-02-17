% Simon Mekonend
% 12/9/18
% ECE 202: Project 1 - part 6
% Power Series Expansion of cosine function
% f(t) = A * cos(wt)

clear

format shortG


% ----- ANSWERS TO QUESTIONS ------

% a) Number of terms = 10
%
% b) The function seems to rapidly decrease. I think this happens because
%   the polynomial from the power series is even with a negative leading 
%   coefficient so it's right limit is negative infinity.
%
% c) Number of terms = 20

% ----- define function parameters -----

A = 10;     % amplitude 
w = 50;     % angle (rad)

maxTerms = input('Input the maximum number of non-zero terms: ');   % max number of terms in truncated power series

N = 500;        % number of intervals

tMin = 0;       % time interval (sec)
tMax = input('Input the maximum time value to plot (sec): ');

t = linspace(tMin, tMax, N+1);  % array of times for calculating (sec)
tms = t*1000;                   % array of times for plotting (msec)

n = 0:2:(maxTerms*2-2);     % n values corresponding to first 6 non-zero coefficients

a = A * (-1).^(n/2) .* w.^n ./ factorial(n);        % non-zero coefficients

aTable = [n; a] .';                 % matrix with coefficients and respective n values




% ----- construct functions -----

f1 = a(1) * t .^ (n(1));          % first six partial sums of the power series 
f2 = f1 + a(2) * t .^ (n(2));     % (for non-zero coefficients)
f3 = f2 + a(3) * t .^ (n(3));
f4 = f3 + a(4) * t .^ (n(4));
f5 = f4 + a(5) * t .^ (n(5));
f6 = f5 + a(6) * t .^ (n(6));


% ----- construct functions and plot (efficient) -----

subtotal = 0;

for m = 1:maxTerms
    subtotal = subtotal + a(m) * t .^ (n(m));
    
    if m == maxTerms
        plot(tms, subtotal, 'LineWidth', 3)
    else
        plot(tms, subtotal, 'LineWidth', 2)
    end
    
    hold on
end



% ----- check final function (does method 1 agree with method 2) -----

% checkF = sum(abs(subtotal - f6))     % checks if the final function from the 2 methods above are equal



% ----- plot setup -----

hold off

grid on

ax = gca;
ax.FontSize = 16;

axis([tMin*1000, tMax*1000, -(A+A/10), A+A/10])

funcStr = join([num2str(A),'*cos(',num2str(w),'*t)']);

% Constructing strings for dynamic part of the title

postTitle1 = join(['Truncated Power Series of ', funcStr]);
postTitle2 = join([' (max ', num2str(maxTerms), ' terms)']);

title({'ECE 202 - Project 1 (Part 6): ', ... 
    postTitle1, ...
    postTitle2}, ...
    'FontSize',14);

xlabel('time (ms)');
ylabel('f(t)');

legend("up to n = " + (n), 'Location','southeastoutside', 'FontSize',12);









