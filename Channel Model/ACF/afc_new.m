clc
clear all
close all

delta_t = 0.001;

% 300Ghz
load 300Ghz.mat
time=linspace(0,delta_t*NofS,NofS-1);
plot(time,corr_nlos,'b-.');
grid on
hold on

% 350 Ghz
load 350Ghz.mat
plot(time,corr_nlos,'r-.');

title('ACF');
xlabel('time diffirent \Delta_{t}(s)');
ylabel('Value of ACF');
legend('Simulation at 300Ghz','Simulation at 350Ghz');