%Simon Mekonen
%10/8/2018
%MatLab 5

%Description: Testing trigonometric product identies and plotting
%Source: https://www2.clarku.edu/faculty/djoyce/trig/identities.html

clear 

% ----- Givens -----

tms = linspace(0,200,500);  %time tms, in ms
t = tms / 1000;             %time t, in s

a = 50*t - 1.2;
b = 120*t + 1.6;

% function of t with the product of two sinuoids
f = 10*cos(a).*cos(b);    

% functions of sinusoid 1 and sinusoid which sum to f (derived using
% the product identity)
f1 = 5*cos(a+b);
f2 = 5*cos(a-b);

% ----- Check -----

% check the equivalence of f with f1 + f2, result should be array of zeros
checkDiff = f - (f1+f2);  

% check the correctness of f1 and f2, result should be zeor
checkF1F2 = sum(abs(checkDiff))

% The absolute function is important before finding the sum because if 
% negative values exist in checkSum, they could cancel out with the
% positive values and result in a sum of zero signifying a passed check
% even though the actual array may be wrong and just cancelling out.
                                            
% ----- Graph -----

plot(tms, f, 'r', tms, f1, 'g', tms, f2, 'b', tms, checkDiff, '--', 'LineWidth', 2)
title('ECE 202 M5: Trigonometric Product identity', 'FontSize', 18)
xlabel('time t (ms)', 'FontSize', 15)
ylabel('functions of t', 'FontSize', 15)

axis([-inf, inf, -15, 20])
grid on

legend('Original function, f', 'Sinusoid 1, f1', 'Sinusoid 2, f2','Difference of functions, f-(f1+f2)')



