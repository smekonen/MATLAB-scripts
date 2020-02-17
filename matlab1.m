%Simon Mekonen
%9/13/2018
%MatLab 1
%Calculating velocity after an elastic collision

%Source: https://www.real-world-physics-problems.com/elastic-collision.html


%----- Givens -----

clear

m1 = 270;   % mass of cart #1, in g
m2 = 120;   % mass of cart #2, in g

u1 = 30;   % initial velocity of cart #1, in cm/s
u2 = -20;  % initial velocity of cart #2, in cm/s


%----- Solution with formula -----

mT = m1 + m2;   % total mass of the carts, in g

v1 = u1 * (m1-m2)/mT + u2 * 2*m2/mT  %final velocity of cart #1, in cm/s
v2 = u2 * (m2-m1)/mT + u1 * 2*m1/mT  %final velocity of cart #2, in cm/s


%----- Checks -----

KE0 = m1*u1^2/2 + m2*u2^2/2;    %total initial kinetic energy, in 10^-7 J
KEf = m1*v1^2/2 + m2*v2^2/2;    %total final kinetic energy, in 10^-7 J

KE_check = KEf - KE0    %check for conservation of kinetic energy, result should be 0

p0 = m1*u1 + m2*u2;    %total initial momentum, in g.cm/s
pf = m1*v1 + m2*v2;    %total final momentum, in g.cm/s

p_check = pf-p0     %check for conservation of momentum, result should be 0