clear;
close all;

% Sta³e
load("data/constants.mat");
% Punkt pracy
load("data/operating_point.mat");
C_A_op = C_A;
T_op = T;
C_Ain_op = C_Ain;
F_C_op = F_C;
% Równania stanu
load("data/dC_A.mat");
load("data/dT.mat");
load("data/dC_A_L.mat");
load("data/dT_L.mat");

x = (C_A_op-0.1:0.0002:C_A_op+0.1)';
y = zeros(size(x));
y_L = y;
for n = 1:1:size(x,1)
    y(n) = dC_A(x(n),C_Ain,F,F_in,T_op,V);
    y_L(n) = dC_A_L(x(n),C_Ain,F,F_in,T_op,V);
end
figure;
hold on
title('Linearyzacja dC_A');
xlabel('C_A');
ylabel('dC_A');
plot(x,y);
plot(x,y_L,'--');
hold off
legend('y','y_L')
writematrix([x, y,y_L],'plots/ad1_dC_A_C_A.txt', "Delimiter","tab");
print('Linearyzacja_dC_A1.png','-dpng','-r400');

x = (T_op-50:0.1:T_op+50)';
y = zeros(size(x));
y_L = y;
for n = 1:1:size(x,1)
    y(n) = dC_A(C_A_op,C_Ain,F,F_in,x(n),V);
    y_L(n) = dC_A_L(C_A_op,C_Ain,F,F_in,x(n),V);
end
figure;
hold on
title('Linearyzacja dC_A ');
xlabel('T');
ylabel('dC_A');
plot(x,y);
plot(x,y_L);
hold off
legend('y','y_L')
writematrix([x, y,y_L],'plots/ad1_dC_A_T.txt', "Delimiter","tab");
print('Linearyzacja_dC_A2.png','-dpng','-r400');

x = (C_A_op-0.1:0.0002:C_A_op+0.1)';
y = zeros(size(x));
y_L = y;
for n = 1:1:size(x,1)
    y(n) = dT(x(n),F,F_C,F_in,T_op,T_in,T_Cin,V);
    y_L(n) = dT_L(x(n),F,F_C,F_in,T_op,T_in,T_Cin,V);
end
figure;
hold on
title('Linearyzacja dT');
xlabel('C_A');
ylabel('dT');
plot(x,y);
plot(x,y_L);
hold off
legend('y','y_L')
writematrix([x, y,y_L],'plots/ad1_dT_C_A.txt', "Delimiter","tab");
print('Linearyzacja_dCT1.png','-dpng','-r400');

x = (T_op-50:0.1:T_op+50)';
y = zeros(size(x));
y_L = y;
for n = 1:1:size(x,1)
    y(n) = dT(C_A_op,F,F_C,F_in,x(n),T_in,T_Cin,V);
    y_L(n) = dT_L(C_A_op,F,F_C,F_in,x(n),T_in,T_Cin,V);
end
figure;
hold on
title('Linearyzacja dT');
xlabel('T');
ylabel('dT');
plot(x,y);
plot(x,y_L);
hold off
legend('y','y_L')
writematrix([x, y,y_L],'plots/ad1_dT_T.txt', "Delimiter","tab");
print('Linearyzacja_dCT2.png','-dpng','-r400');

x_1 = (C_A_op-1:0.2:C_A_op+1)';
x_2 = (T_op-30:3:T_op+30)';
y = zeros(size(x_1,1),size(x_2,1),1);
y_L = y;
for n = 1:1:size(x_1,1)
    for m = 1:1:size(x_2,1)
        y(n,m) = dT(x_1(n),F,F_C,F_in,x_2(m),T_in,T_Cin,V);
        y_L(n,m) = dT_L(x_1(n),F,F_C,F_in,x_2(m),T_in,T_Cin,V);
    end
end
figure;
hold on
xlabel('T');
ylabel('C_A');
zlabel('y');
title('Zlinearyzowany model');
surf(x_2,x_1,y,'FaceAlpha',0.6,'EdgeAlpha',0.6);
surf(x_2,x_1,y_L,'FaceAlpha',1,'EdgeColor','none');
hold off
legend('y','y_L')
grid on
view(3);
print('Linearyzacja_Model.png','-dpng','-r400');
writematrix([repmat(x_1,size(x_2,1),1), repelem(x_2,size(x_1,1)),y_L(:)],'plots/ad1_surf.txt', "Delimiter","tab");


x = (C_Ain-1:0.01:C_Ain+1)';
y = zeros(size(x));
y_L = y;
for n = 1:1:size(x,1)
    y(n) = dC_A(C_A_op,x(n),F,F_in,T_op,V);
    y_L(n) = dC_A_L(C_A_op,x(n),F,F_in,T_op,V);
end
figure;
hold on
title('');
xlabel('C_{Ain}');
ylabel('dT');
plot(x,y);
plot(x,y_L);
hold off
print('Linearyzacja_C_ain.png','-dpng','-r400');

x = (F_C-10:0.1:F_C+10)';
y = zeros(size(x));
y_L = y;
for n = 1:1:size(x,1)
    y(n) = dT(C_A_op,F,x(n),F_in,T_op,T_in,T_Cin,V);
    y_L(n) = dT_L(C_A_op,F,x(n),F_in,T_op,T_in,T_Cin,V);
end
figure;
hold on
title('');
xlabel('F_C');
ylabel('dT');
plot(x,y);
plot(x,y_L);
hold off
print('Linearyzacja_F_C.png','-dpng','-r400');
%print('Rys_1.png','-dpng','-r400')