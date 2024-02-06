close all
%% set up
set(groot, 'defaulttextinterpreter','latex')
set(groot, 'defaultaxesticklabelinterpreter','latex')
set(groot, 'defaultlegendinterpreter','latex')
T=0:0.008:5;
%% plot
figure
plot(T,u_zmp_tank(1,:))
hold on
plot(T,x_z_tank(1,:)-0.06)
plot(T,x_z_tank(1,:)+0.06)

title('foot placement(ZMP) in x direction')
xlabel('time (s)') 
ylabel('position (m)') 
legend({'desired zmp','actual zmp low','actual zmp high'})

figure
plot(T,u_zmp_tank(end,:))
hold on
plot(T,x_z_tank(end,:)-0.01)
plot(T,x_z_tank(end,:)+0.01)

title('foot placement(ZMP) in y direction')
xlabel('time (s)') 
ylabel('position (m)') 
legend({'desired zmp','actual zmp low','actual zmp high'})

% figure
% plot(x_z_tank(1,:),x_z_tank(end,:))
% hold on
% plot(u_zmp_tank(1,:),u_zmp_tank(end,:))
% plot(out.xout(:,4),out.xout(:,5))
% plot(ddxyz_com_tank(1,:),ddxyz_com_tank(2,:))
% title('foot placement(ZMP) in x-y plane')
% xlabel('x position (m)') 
% ylabel('y position (m)') 
% legend({'actual zmp','desired zmp','actual com','desired com'})
% axis equal 

% footprint
figure

for i=1:length(x_z_tank(1,:))
    rectangle('Position',[x_z_tank(1,i)-0.06,x_z_tank(end,i)-0.01,0.12,0.02])
    hold on
end
plot(x_z_tank(1,:),x_z_tank(end,:))
% plot(u_zmp_tank(1,:),u_zmp_tank(end,:))
plot(out.xout(:,4)'-moving_tank(1,:),out.xout(:,5)'-moving_tank(4,:))
% plot(ddxyz_com_tank(1,:),ddxyz_com_tank(2,:))
title('foot placement(ZMP) in x-y plane')
xlabel('x position (m)') 
ylabel('y position (m)') 
legend({'actual zmp','desired zmp','actual com','desired com'})
axis equal 
%%
figure
for i=1:length(X_min)
    rectangle('Position',[X_min(i),Y_min(i),X_max(i)-X_min(i),Y_max(i)-Y_min(i)])
    hold on
end
plot(X_min,Y_min)
plot(up_u(1,:),up_u(2,:))
plot(low_u(1,:),low_u(2,:))

title('foot position trajectory')
xlabel('x (m)') 
ylabel('y (m)') 
legend({'0','up_COM','low_COM'},'Location','southwest')
axis equal 

%%
figure


plot(up_u(1,:))
hold on
plot(low_u(1,:))
plot(X_min)
plot(X_max)
title('Contingency MPC in x direction')
xlabel('horizon (dT=0.01s)') 
ylabel('position (m)') 
legend({'up_zmp','low_zmp','ZMP_lowConstraint','ZMP_upConstraint'})

figure
plot(up_u(2,:))
hold on
plot(low_u(2,:))
plot(Y_min)
plot(Y_max)
title('Contingency MPC in y direction')
xlabel('horizon (dT=0.01s)') 
ylabel('position (m)') 
legend({'up_zmp','low_zmp','ZMP_lowConstraint','ZMP_upConstraint'})
%%
figure % velocity
plot(T,out.xout(:,10))
hold on
plot(T,out.xout(:,11))
plot(T,ddxyz_com_tank(3,:))
plot(T,ddxyz_com_tank(4,:))
title('com velocity')
xlabel('time (s)') 
ylabel('velocity (m/s)') 
legend({'actual x-com','actual y-com','desired x-com','desired y-com'})

figure % position
plot(T,out.xout(:,4))
hold on
plot(T,out.xout(:,5))
plot(T,ddxyz_com_tank(1,:))
plot(T,ddxyz_com_tank(2,:))
title('com position')
xlabel('time (s)') 
ylabel('position (m)') 
legend({'actual x-com','actual y-com','desired x-com','desired y-com'})
(66+69+660+25.3+472+44.66+36.48+116+23.9+128+57.11+125+29+295)/2;

%%
% footprint
figure

for i=1:length(x_z_tank(1,:))
    rectangle('Position',[x_z_tank(1,i)-0.06,x_z_tank(end,i)-0.01,0.12,0.02])
    hold on
end
plot(x_z_tank(1,:),x_z_tank(end,:))
% plot(u_zmp_tank(1,:),u_zmp_tank(end,:))
plot(out.xout(:,4)'-moving_tank(1,:),out.xout(:,5)'-moving_tank(4,:))
% plot(ddxyz_com_tank(1,:),ddxyz_com_tank(2,:))
title('foot placement(ZMP) in x-y plane')
xlabel('x position (m)') 
ylabel('y position (m)') 
legend({'actual zmp','actual com'})
axis equal