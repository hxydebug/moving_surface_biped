close all

%% set up
set(groot, 'defaulttextinterpreter','latex')
set(groot, 'defaultaxesticklabelinterpreter','latex')
set(groot, 'defaultlegendinterpreter','latex')
T=0:0.008:5;

%% data process
% cut double support
x_z = x_z_tank(:,26:end);
xout = out.xout(26:end,:);
moving = moving_tank(:,26:end);
stance = stance_leg(26:end);

% x_z = x_z_tank;
% xout = out.xout;
% moving = moving_tank;
% stance = stance_leg;

% sample
num = 2;
x_z = x_z(:,1:num:end);
xout = xout(1:num:end,:);
moving = moving(:,1:num:end);
stance = stance(:,1:num:end);
%% 3D plot
figure

for i=1:length(x_z(1,:))
    rectangle('Position',[x_z(1,i)-0.06,x_z(end,i)-0.01,0.12,0.02],'EdgeColor',"r")
    hold on
end

plot3(xout(:,4)'-moving(1,:),xout(:,5)'-moving(4,:),xout(:,6)','.',"Color","r")
for i=1:length(x_z(1,:))
    if(stance(i)==1)
        line([x_z(1,i) xout(i,4)'-moving(1,i)],[x_z(2,i) xout(i,5)'-moving(4,i)],[0 xout(i,6)'],"Color","b")
    else
        line([x_z(1,i) xout(i,4)'-moving(1,i)],[x_z(2,i) xout(i,5)'-moving(4,i)],[0 xout(i,6)'],"Color","y")
    end
end

[X,Y] = meshgrid(-0.5:0.1:3.5,-0.8:0.1:0.8);
Z = 0*X;
surf(X,Y,Z)

xlim([-0.5 3.5])
ylim([-0.8 0.8])
zlim([0 0.8])
axis equal

title('foot placement(ZMP)')
xlabel('x position (m)') 
ylabel('y position (m)') 
zlabel('z position (m)') 
legend({'actual zmp','actual com'})

%% 
