%Simon Mekonen
%11/23/2018
%MatLab 6u

%Calculating results of multiple collisions of carts

%Source: https://www.real-world-physics-problems.com/elastic-collision.html


%----- Givens -----

clear

m = [240 120 360];  % masses of carts, in g
u = [30 15 -45];    % initial velocities of carts, in cm/s

m12 = m(1)+m(2);     % total mass of cart #1 and cart #2
m23 = m(2)+m(3);     % total mass of cart #2 and cart #3

kE0 = sum(m .* u.^2)/2;  % total initial kinetic energy, in 10^-7 J
p0  = sum(m .* u);       % total initial momentum, in g.cm/s


%----- Results of Collision A (cart 2 and 3) -----

va = [0 0 0];     % final velocity of carts after collision A, in cm/s
ua = u;           % initial velocity of carts before collion A, in cm/s

va(1) = ua(1);                                             % first cart does not collide so velocity is the same
va(2) = el_collision_vf(ua(2), ua(3), m(2), m(3));         % final velocity of cart #2 after collision A, in cm/s  
va(3) = el_collision_vf(ua(3), ua(2), m(3), m(2));         % final velocity of cart #3 after collision A, in cm/s 


va   % final velocities after collision A

kE_checkA = sum(m .* va.^2)/2 - kE0      % conservation of kinetic energy check, result should be 0
p_checkA = sum(m .* va) - p0             % conservation of momentum check, result should be 0



 %----- Results of Collision B (cart 1 and 2) -----
 
vb = [0 0 0];     % final velocity of carts after collision B, in cm/s
ub = va;           % initial velocity of carts before collion B, in cm/s

vb(1) = el_collision_vf(ub(1), ub(2), m(1), m(2));         % final velocity of cart #1 after collision B, in cm/s
vb(2) = el_collision_vf(ub(2), ub(1), m(2), m(1));         % final velocity of cart #2 after collision B, in cm/s
vb(3) = ub(3);                                             % third cart does not collide so velocity is the same

vb   % final velocities after collision B

kE_checkB = sum(m .* vb.^2)/2 - kE0      % conservation of kinetic energy check, result should be 0
p_checkB = sum(m .* vb) - p0             % conservation of momentum check, result should be 0
 
 


 %----- Results of Collision C (cart 2 and 3) -----

vc = [0 0 0];     % final velocity of carts after collision C, in cm/s
uc = vb;           % initial velocity of carts before collion C, in cm/s

vc(1) = uc(1);                                             % first cart does not collide so velocity is the same
vc(2) = el_collision_vf(uc(2), uc(3), m(2), m(3))          % final velocity of cart #2 after collision C, in cm/s
vc(3) = el_collision_vf(uc(3), uc(2), m(3), m(2));         % final velocity of cart #3 after collision C, in cm/s

vc   % final velocities after collision C

kE_checkC = sum(m .* vc.^2)/2 - kE0      % conservation of kinetic energy check, result should be 0
p_checkC = sum(m .* vc) - p0             % conservation of momentum check, result should be 0



 %----- Results of Collision D (cart 1 and 2) -----
 
vd = [0 0 0];     % final velocity of carts after collision D, in cm/s
ud = vc;           % initial velocity of carts before collion D, in cm/s

vd(1) = el_collision_vf(ud(1), ud(2), m(1), m(2));      % final velocity of cart #1 after collision D, in cm/s
vd(2) = el_collision_vf(ud(2), ud(1), m(2), m(1));      % final velocity of cart #2 after collision D, in cm/s
vd(3) = ud(3);                                             % third cart does not collide so velocity is the same

vd   % final velocities after collision D

kE_checkD = sum(m .* vd.^2)/2 - kE0      % conservation of kinetic energy check, result should be 0
p_checkD = sum(m .* vd) - p0             % conservation of momentum check, result should be 0


v_final = vd

% There are four collisions in all. Collision D is the last collision that
% can happen in the system. This can be seen from the final velocities -
% cart 2 and 3 are moving in opposite directions so they can't collide and
% cart 1 is moving much faster than cart 2 so cart 2 can't catch up with it and collide



%----- Function Definitions -----

function vf = el_collision_vf(u1, u2, m1, m2)
    mT = m1 + m2;
    vf = u1 * (m1-m2) / mT + u2 * 2*m2 / mT;
end
