% clc
% clear
% close all
%% set up
set(groot, 'defaulttextinterpreter','latex')
set(groot, 'defaultaxesticklabelinterpreter','latex')
set(groot, 'defaultlegendinterpreter','latex')

L=0.26;
g=9.8;
ddxy_s_max = [1.15;1.15];
ddxy_s_min = [-1.15;-1.15];

% choose a MPC controller
MPC_controller1 = intriMPC(g,L);
MPC_controller2 = contiMPC(g,L,ddxy_s_max,ddxy_s_min);

% time step
dT = 0.01;

% simulation time
T_s = 2;

% set rand
% a = -1.15;
% b = 1.15;
% random = a + (b-a)*rand(2,200);
%% simulation

x0 = [0;0;0;0];
T=0:dT:T_s;
x_tank = zeros(4,length(T));
x_tank(:,1) = x0; 
x_z = [0;0];
u_tank = [0;0];

% moving surface
% Ax = 0.005;
% T_periodx = 0.6;
% Ay = 0.02;
% T_periody = 0.6;
% 
% ddxy_s = [0;0];
% ddxy_s_tank = [0;0];
% dxy_s = [Ax*2*pi/T_periodx;Ay*2*pi/T_periody];
% dxy_s_tank = [Ax*2*pi/T_periodx;Ay*2*pi/T_periody];
% xy_s = [0;0];
% xy_s_tank = [0;0];

ddxy_s = [0;0];
ddxy_s_tank = [0;0];
dxy_s = [0;0];
dxy_s_tank = [0;0];
xy_s = [0;0];
xy_s_tank = [0;0];

last_acc = [0,0];


for i=2:length(T)
    fprintf("%d\n",i);
    current_T = T(i-1);
    

    x_z_dot = MPC_controller1.MPC(x_tank(:,i-1),x_z,ddxy_s,current_T);
    x_z = x_z + dT * x_z_dot;
    u_tank = [u_tank, x_z];
    x_tank(:,i) = lip_dynamics(x_tank(:,i-1),x_z,ddxy_s,dT,L,g);

    dxy_s = dxy_s + ddxy_s * dT;
    xy_s = xy_s + dxy_s * dT;

    ddxy_s_tank = [ddxy_s_tank,ddxy_s];
    dxy_s_tank = [dxy_s_tank,dxy_s];
    xy_s_tank = [xy_s_tank,xy_s];
end

%% plot result
[X_min_next,X_max_next] = MPC_controller1.get_ZMP_rangex(T_s+dT);
[Y_min_next,Y_max_next] = MPC_controller1.get_ZMP_rangey(T_s+dT);

% figure
% plot(T,x_tank(2,:))
% hold on
% plot(T,x_tank(4,:))
% title('com velocity')
% xlabel('t (s)') 
% ylabel('v (m/s)') 
% legend({'v_x','v_y'})

% figure
% plot(T(41:end),xy_s_tank(1,:))
% title('moving surface x direction position')
% xlabel('t (s)') 
% ylabel('p (m)') 

% figure
% plot(T(41:end),dxy_s_tank(1,:))
% title('moving surface x direction velocity')
% xlabel('t (s)') 
% ylabel('v (m/s)') 
% 
% figure
% plot(T(41:end),ddxy_s_tank(1,:))
% title('moving surface x direction acceleration')
% xlabel('t (s)') 
% ylabel('a (m/s^2)') 
% 
% figure
% plot(T(41:end),xy_s_tank(2,:))
% title('moving surface y direction position')
% xlabel('t (s)') 
% ylabel('p (m)')

% figure
% plot(T(41:end),dxy_s_tank(2,:))
% title('moving surface y direction velocity')
% xlabel('t (s)') 
% ylabel('v (m/s)') 
% 
% figure
% plot(T(41:end),ddxy_s_tank(2,:))
% title('moving surface y direction acceleration')
% xlabel('t (s)') 
% ylabel('a (m/s^2)') 

figure
plot(T,dxy_s_tank(1,:))
title('moving surface x direction velocity')
xlabel('t (s)') 
ylabel('v (m/s)') 

figure
plot(T,ddxy_s_tank(1,:))
title('moving surface x direction acceleration')
xlabel('t (s)') 
ylabel('a (m/s^2)') 

figure
plot(T,dxy_s_tank(2,:))
title('moving surface y direction velocity')
xlabel('t (s)') 
ylabel('v (m/s)') 

figure
plot(T,ddxy_s_tank(2,:))
title('moving surface y direction acceleration')
xlabel('t (s)') 
ylabel('a (m/s^2)') 

figure
plot(T,x_tank(1,:))
hold on
plot(T,u_tank(1,:))
plot(T+dT,X_min_next)
plot(T+dT,X_max_next)
title('com, zmp and zmp constraint postion in x direction')
xlabel('t (s)') 
ylabel('position (m)') 
legend({'COM','ZMP','ZMP_lowConstraint','ZMP_upConstraint'})

figure
plot(T,x_tank(3,:))
hold on
plot(T,u_tank(2,:))
plot(T+dT,Y_min_next)
plot(T+dT,Y_max_next)
title('com, zmp and zmp constraint postion in y direction')
xlabel('t (s)') 
ylabel('position (m)') 
legend({'COM','ZMP','ZMP_lowConstraint','ZMP_upConstraint'})
% 
% figure
% i = 200;
% plot(u_tank(1,1:i),u_tank(2,1:i))
% axis equal 
%%
figure
[X_min_next,X_max_next] = MPC_controller2.ZMP_rangex_plot(T_s);
[Y_min_next,Y_max_next] = MPC_controller2.ZMP_rangey_plot(T_s);

for i=1:length(X_min_next)
    rectangle('Position',[X_min_next(i),Y_min_next(i),X_max_next(i)-X_min_next(i),Y_max_next(i)-Y_min_next(i)])
    hold on
end

i = length(X_min_next);
plot(u_tank(1,1:i),u_tank(2,1:i))

plot(x_tank(1,1:i),x_tank(3,1:i))

% plot(X_min_next,Y_min_next)
% plot(X_max_next,Y_max_next)


title('COM trajectory and foot position trajectory')
xlabel('x (m)') 
ylabel('y (m)') 
legend({'foot position','COM'},'Location','southwest')
axis equal 

%% dynamic equation
function X_next = lip_dynamics(X,u,ddxy_s,dT,L,g)

A1 = [1 dT;
     g/L*dT 1];
 
B1 = [0;
     -dT*g/L];

C1 = [0;
     -ddxy_s(1)*dT];
C2 = [0;
     -ddxy_s(2)*dT];

A = blkdiag(A1,A1);
B = blkdiag(B1,B1);
C = [C1;
     C2];
X_next = A*X + B*u + C;

end