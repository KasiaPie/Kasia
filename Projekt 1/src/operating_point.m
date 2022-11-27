clear;
close all;

% Sta³e
load("data/constants.mat");
% Punkt pracy
load("data/operating_point.mat");
% Równania stanu
load("data/dV_1.mat");
load("data/dh_2.mat");

% Rozwi¹zanie uk³adu równañ ró¿nicowych dla V_1 = 0
ode_options = odeset('RelTol',1e-10);
V_1 = 0;
h_2 = 9.9723;
df = @(t,y) [dV_1(y(1),F_1); dh_2(y(1),y(2))];
[t,y] = ode45(df,[0;2000],[V_1; h_2],odeset(ode_options,'RelTol',1e-10));
% Wykresy 
figure;
plot(t,y(:,1));
writematrix([t, y(:,1)],'plots/op_V_1_1.txt', "Delimiter","tab");
figure;
plot(t,y(:,2));
writematrix([t, y(:,2)],'plots/op_h_2_1.txt', "Delimiter","tab");

% Rozwi¹zanie uk³adu równañ ró¿nicowych z obliczonego punktu pracy
V_1 = 1165.9808;
h_2 = 9.9723;
df = @(t,y) [dV_1(y(1),F_1); dh_2(y(1),y(2))];
[t,y] = ode45(df,[0;2000],[V_1; h_2],odeset(ode_options,'RelTol',1e-10));
% Wykresy 
figure;
plot(t,y(:,1));
writematrix([t, y(:,1)],'plots/op_V_1_2.txt', "Delimiter","tab");
figure;
plot(t,y(:,2));
writematrix([t, y(:,2)],'plots/op_h_2_2.txt', "Delimiter","tab");

% Wyznaczenie dok³adnego punktu pracy
V_1 =  y(end,1);
h_2 = y(end,2);
fprintf("V_1:\t%0.4f\nh_2:\t\t%0.4f\n",V_1,h_2);

% Zapisanie punktu pracy
save("data/operating_point.mat",'V_1','h_2','F_1','F_D','tau');
