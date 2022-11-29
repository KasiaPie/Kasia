clear;
close all;

% Sta³e
load("data/constants.mat");
% Punkt pracy
load("data/operating_point.mat");
% Równania stanu
load("data/dV_1.mat");
load("data/dh_2.mat");
load("data/dV_1_L.mat");
load("data/dh_2_L.mat");

x = (V_1_op-1000:2:V_1_op+1000)';
y = zeros(size(x));
y_L = y;
for n = 1:1:size(x,1)
    y(n) = dV_1(x(n),F_1);
    y_L(n) = dV_1_L(x(n),F_1);
end
figure;
hold on
title('Linearyzacja dV_1');
xlabel('V_1');
ylabel('dV_1');
plot(x,y);
plot(x,y_L,'-');
hold off
legend('V_1','V_1_L')
writematrix([x, y,y_L],'plots/ad1_dV_1__V_1.txt', "Delimiter","tab");

x = (V_1_op-1000:2:V_1_op+1000)';
y = zeros(size(x));
y_L = y;
for n = 1:1:size(x,1)
    y(n) = dh_2(x(n),h_2_op);
    y_L(n) = dh_2_L(x(n),h_2_op);
end
figure;
hold on
title('Linearyzacja dh_2');
xlabel('V_1');
ylabel('dh_2');
plot(x,y);
plot(x,y_L);
hold off
legend('dh_2','dh_{2L}')
writematrix([x, y,y_L],'plots/ad1_dh_2__V_1.txt', "Delimiter","tab");

x = (h_2_op-9:0.05:h_2_op+9)';
y = zeros(size(x));
y_L = y;
for n = 1:1:size(x,1)
    y(n) = dh_2(V_1_op,x(n));
    y_L(n) = dh_2_L(V_1_op,x(n));
end
figure;
hold on
title('Linearyzacja dh_2');
xlabel('h_2');
ylabel('dh_2');
plot(x,y);
plot(x,y_L);
hold off
legend('dh_2','dh_{2L}')
writematrix([x, y,y_L],'plots/ad1_dh_2__h_2.txt', "Delimiter","tab");

x_1 = (V_1_op-1000:100:V_1_op+1000)';
x_2 = (h_2_op-9:0.9:h_2_op+9)';
y = zeros(size(x_1,1),size(x_2,1),1);
y_L = y;
for n = 1:1:size(x_1,1)
    for m = 1:1:size(x_2,1)
        y(n,m) = dh_2(x_1(n),x_2(m));
        y_L(n,m) = dh_2_L(x_1(n),x_2(m));
    end
end
figure;
hold on
xlabel('h_2');
ylabel('V_1');
zlabel('dh_2');
title('Zlinearyzowany model');
surf(x_2,x_1,y,'FaceAlpha',0.6,'EdgeAlpha',0.6);
surf(x_2,x_1,y_L,'FaceAlpha',1,'EdgeColor','none');
hold off
legend('dh_2','dh_{2L}')
grid on
view(3);
print('images/ad1_surf.png','-dpng','-r400');
writematrix([repmat(x_1,size(x_2,1),1), repelem(x_2,size(x_1,1)),y_L(:)],'plots/ad1_surf.txt', "Delimiter","tab");