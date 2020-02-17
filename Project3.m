%Simon Mekonen
%12/14/2018
%ECE 202: Project 3

%Model of elastic collision in a system of three carts arranged linearly
%(in the same level)

%Source: https://www.real-world-physics-problems.com/elastic-collision.html

clear

%----- Setup -----

% m = [240 120 360];  % masses of carts, in g
% u = [30 15 -45];    % initial velocities of carts, in cm/s


% input prompts
promptM = strcat('\n Enter an array for the mass(g) ', ...
    ' of the 3 carts \n(left, middle, right cart respectively): \n');

promptU = strcat('\n Enter an array for the velocity(cm/s)', ...
    ' of the 3 carts \n(with negative being moving to the left): \n');
 
promptD = strcat('\n Enter an array for the distance(cm) between the 3 carts \n', ...
    ' (between cart 1 and 2, and cart 2 and 3 respectively): \n');
 
%----- Calculation of Collisions -----

try
    m = input(promptM);    % masses of carts, in g 
    u = input(promptU);    % initial velocities of carts, in cm/s
    d = input(promptD);    % the two distances between the carts, in cm
    
    computeCollisions(m, u, d)
catch
    input('Invalid input. Goodbye');
    
end



%----- Function Definitions -----


% Main function which calculates final velocities, runs checks, and
% prints the results

function computeCollisions(m, u, d)

    m12 = m(1)+m(2);     % total mass of cart #1 and cart #2
    m23 = m(2)+m(3);     % total mass of cart #2 and cart #3

    kE0 = sum(m .* u.^2)/2;  % total initial kinetic energy, in 10^-7 J
    p0  = sum(m .* u);       % total initial momentum, in g.cm/s

    
   
    % relative velocities of cart 1 and 3 with respect to cart 2
    relV = [u(1)-u(2) u(2)-u(3)];    
    coll_times = d ./ relV;
    
    % determine first collision
    if or(relV(1) < 0, relV(2) < 0)
        if relV(1) > 0
            coll_carts = [1 2];
        elseif relV(2) > 0
            coll_carts = [2 3];
        else
            coll_carts = [];
        end
               
    else
        if coll_times(1) <= coll_times(2)
            coll_carts = [1 2];
        else
            coll_carts = [2 3];
        end
    end
    

    coll_possible = size(coll_carts) > 0;   % collision possibility (boolean)

    vf = u;   % final velocity of carts after each collision, in cm/s 
              %(initialized with initial velocities

    collisionCount = 0;

    while coll_possible

        a = coll_carts(1);      % indicies of the colliding carts
        b = coll_carts(2);

        v = vf;     % current velocity of carts after previous collision

        vf(a) = el_collision_vf(v(a), v(b), m(a), m(b));
        vf(b) = el_collision_vf(v(b), v(a), m(b), m(a));

        vf

        kE_check = sum(m .* vf.^2)/2 - kE0;      % conservation of kinetic energy check, result should be 0
        p_check = sum(m .* vf) - p0;             % conservation of momentum check, result should be 0

        if kE_check == 0 && p_check == 0

            collisionCount = collisionCount+1

            coll_carts = next_collision(vf);
            coll_possible = size(coll_carts) > 0;

        else
            input('An error has occured in the check');
            coll_possible = false;
        end

    end

end






% Parameters: initial velocities, masses
% Return: final velocity of cart with mass 1 and velocity u1
function vf = el_collision_vf(u1, u2, m1, m2)
    mT = m1 + m2;
    vf = u1 * (m1-m2) / mT + u2 * 2*m2 / mT;
end




% Parameters: array of current velocities of the carts in order
% Return: number ids of the two carts which collide next
% if there is no next collision, returns empty array
function carts = next_collision(v)
    relV = [v(1)-v(2) v(2)-v(3)];
    
    if relV(1) > 0
        carts = [1 2];
    elseif relV(2) > 0
        carts = [2 3];
    else
        carts = [];
    end
end

    