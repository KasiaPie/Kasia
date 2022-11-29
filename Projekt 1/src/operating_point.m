clear;
close all;

% Sta³e
load("data/constants.mat");
% Punkt pracy
load("data/operating_point.mat");
% Równania stanu
load("data/dV_1.mat");
load("data/dh_2.mat");

% Rozwi¹zanie uk³adu równañ ró¿nicowych dla V_1 = 0 i h_2 z zadania
ode_options = odeset('RelTol',1e-10);
V_1 = 0;
h_2 = 9.9723;
df = @(t,y) [dV_1(y(1),F_1); dh_2(y(1),y(2))];
[t,y] = ode45(df,[0;1500],[V_1; h_2],ode_options);
% Wykresy 
figure;
plot(t,y(:,1));
writematrix([t, y(:,1)],'plots/op_V_1_1.txt', "Delimiter","tab");
figure;
plot(t,y(:,2));
writematrix([t, y(:,2)],'plots/op_h_2_1.txt', "Delimiter","tab");

% Rozwi¹zanie uk³adu równañ ró¿nicowych z obliczonego punktu pracy
V_1 = C_1*((F_1+F_D)/alpha_1)^6;
h_2 = ((F_1+F_D)/alpha_2)^2;
df = @(t,y) [dV_1(y(1),F_1); dh_2(y(1),y(2))];
[t,y] = ode45(df,[0;1500],[V_1; h_2],ode_options);
% Wykresy 
figure;
plot(t,y(:,1));
writematrix([t, y(:,1)],'plots/op_V_1_2.txt', "Delimiter","tab");
figure;
plot(t,y(:,2));
writematrix([t, y(:,2)],'plots/op_h_2_2.txt', "Delimiter","tab");

fprintf("V_1:\t%0.4f\nh_2:\t\t%0.4f\n",y(end,1),y(end,2));

% Zapisanie punktu pracy
V_1_op =  V_1;
h_2_op = h_2;
save("data/operating_point.mat",'V_1_op','h_2_op','F_1','F_D','tau');
