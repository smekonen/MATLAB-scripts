%% ECE 202: Project 2 - part 4
% *Projectile motion model* - Hitting a baseball. 
% The calculated time of flight is 3.51 sec, which is a little lower the
% observed 4.4 sec. The maximum height is 50.76 ft and was expected to be 
% around 66 ft so it is a bit lower again. Using MATLAB(R). \n
%
% $$ x = x0 + \cos \phi $$
% 
% Simon Mekonen
% 12/16/18
% Collaborator: Bill Leonard (Lec 22)


clear

%% Define givens

x0 = 0; y0 = 0;     % initial position
v0mph = 116;        % exit velocity, in mph
phi0deg = 22;       % launch angle, in degrees

m = 1.43;       % mass of baseball, in kg
g = 10;         % gravitational constant, in N/kg


A = 0.04;      % cross-sectional area of ball, m^2
pAir = 1.225;   % density of air, in kg/m^3

dragC = 0.47;

%% Conversions and setup

mph2mps = 5280 * 12 * 2.54 / 100 / 3600;   % mph to m/s conversion
deg2rad = pi()/180;   % degrees to radians conversion

v0 = v0mph * mph2mps;   % initial speed in m/s
phi0 = phi0deg * deg2rad;   % initial angle in rad

v0x = v0 * cos(phi0);   % x-component of initial velocity
v0y = v0 * sin(phi0);   % y-component of initial velocity



%% Analytical calculation of x(t) and y(t) with NO DRAG


tmin = 0;
tmax = 4.4;

N = 2000;   % intervals
t = linspace(tmin, tmax, 1+N);

xt_a = x0 + v0x * t;   % x(t)
yt_a = y0 + v0y * t + 1/2 * -g * t.^2;   % y(t)


%% Numerical calculation of x(t) and y(t) WITH DRAG

dt = (tmax - tmin) / N;

yt_n = zeros(1, 1+N);    % initialize y(t)
vy = zeros(1, 1+N);   % initialize vy(t)

yt_n(1) = y0;
vy(1) = v0y;


xt_n = zeros(1, 1+N);    % initialize y(t)
vx = zeros(1, 1+N);   % initialize vy(t)

xt_n(1) = x0;
vx(1) = v0x;

dragConst = -1/2 * dragC * pAir * A;    % constant factors of drag

landingN = 1;   % index (n) at which the baseball lands

lostE = 0;  % energy lost to drag, in joules

for n = 1:N   
    
    v = sqrt(vx(n)^2 + vy(n)^2);
    
    dragF = [vx(n) vy(n)] .* dragConst*v;
    
    lostE = lostE + norm(dragF);
    
    fx = dragF(1);      
    fy = -m*g + dragF(2);

    
    
    ax = fx/m;      
    ay = fy/m;  

    xt_n(n+1) = xt_n(n) + vx(n) * dt + 1/2 * ax * dt^2;
    vx(n+1) = vx(n) + ax * dt;
    
    yt_n(n+1) = yt_n(n) + vy(n) * dt + 1/2 * ay * dt^2;
    vy(n+1) = vy(n) + ay * dt;
    
    if and(yt_n(n+1) < 0, yt_n(n) > 0)
        landingN = n;
    end
end


%% Result parameters

m2ft = 3.28;        % conversion factor meters to feet


range = xt_n(landingN) * m2ft       % maximum range, in ft

t_flight = t(landingN)              % time of flight, in sec

maxH = max(yt_n) * m2ft             % maximum height, in ft

v_final = sqrt(vx(N+1)^2 + vy(N+1)^2)   % velocity magnitude at landing

lost_energy_drag = lostE*dt

% ----- plot the trajectory, y vs. x -----

x_a = xt_a * m2ft;    % analytic solution x(t), in ft
y_a = yt_a * m2ft;    % analytic solution y(t), in ft

x_n = xt_n * m2ft;     % numeric solution x(t) with drag, in ft
y_n = yt_n * m2ft;     % numeric solution y(t) with drag, in ft



plot(x_n, y_n, x_a, y_a, 'LineWidth', 2)

ax = gca;
ax.FontSize = 16;

xlabel('x (ft)', 'FontSize', 18)
ylabel('y (ft)', 'FontSize', 18)

title({'ECE 202, Project 2 (Part 4): Trajectory of a baseball',...
    'Drag vs. no drag'}, 'FontSize', 18)

legend("with drag: C = " + dragC, "without drag")

axis([-inf 800 -inf 100])  

grid on



