%Simon Mekonen
%12/10/2018
%MatLab 8

%Partial fraction expansion of:
% (2+3x+4x^2) / ((x-1)(x-2)(x-3))

% 
% The check gets further from zero as the number of x values (n) increases
% This is because there are 3 asymptotes in the function and sampling the
% asymptotes causes small error




clear

% ----- Compute numerators c1, c2, c3 -----

A = [1 1 1; -5 -4 -3; 6 3 2];           % coefficient matrix of equation system
b = [4; 3; 2];                  % constants of equation system

c = inv(A)*b;      % numerator solutions

% ----- Calculations -----

n = input('Enter value of n: ');    % number of points in x

x = linspace(-4, 4, n);

d1 = x-1;   % denominator values
d2 = x-2;
d3 = x-3;

R = (2 + 3*x + 4*x.^2) ./ (d1.*d2.*d3);     % original function

partialR = c(1)./d1 + c(2)./d2 + c(3)./d3; % partial fraction version

check = R - partialR;

checkSum = sum(abs(R - partialR))

plot(x, R, x, partialR)













