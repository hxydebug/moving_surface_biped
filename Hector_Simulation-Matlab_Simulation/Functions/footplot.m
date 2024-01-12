close all
%% set up
set(groot, 'defaulttextinterpreter','latex')
set(groot, 'defaultaxesticklabelinterpreter','latex')
set(groot, 'defaultlegendinterpreter','latex')

%% plot
figure
plot(x_z_tank(1,:))
hold on
plot(u_zmp_tank(1,:))
title('foot placement(ZMP) in x direction')
xlabel('timestep (0.008s one step)') 
ylabel('position (m)') 
legend({'actual zmp','desired zmp'})

figure
plot(x_z_tank(end,:))
hold on
plot(u_zmp_tank(end,:))
title('foot placement(ZMP) in y direction')
xlabel('timestep (0.008s one step)') 
ylabel('position (m)') 
legend({'actual zmp','desired zmp'})

figure
plot(x_z_tank(1,:),x_z_tank(end,:))
hold on
plot(u_zmp_tank(1,:),u_zmp_tank(end,:))
plot(out.xout(:,4),out.xout(:,5))
plot(ddxyz_com_tank(1,:),ddxyz_com_tank(2,:))
title('foot placement(ZMP) in x-y plane')
xlabel('x position (m)') 
ylabel('y position (m)') 
legend({'actual zmp','desired zmp','actual com','desired com'})
axis equal 

figure % velocity
plot(out.xout(:,10))
hold on
plot(out.xout(:,11))
plot(ddxyz_com_tank(3,:))
plot(ddxyz_com_tank(4,:))
title('com velocity')
xlabel('timestep (0.008s one step)') 
ylabel('velocity (m/s)') 
legend({'actual x-com','actual y-com','desired x-com','desired y-com'})

figure % position
plot(out.xout(:,4))
hold on
plot(out.xout(:,5))
plot(ddxyz_com_tank(1,:))
plot(ddxyz_com_tank(2,:))
title('com position')
xlabel('timestep (0.008s one step)') 
ylabel('position (m)') 
legend({'actual x-com','actual y-com','desired x-com','desired y-com'})