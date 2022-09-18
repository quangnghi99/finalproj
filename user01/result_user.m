clear all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BP
load 1user14_BP.mat
semilogy(psnr, SER1,'b+-','LineWidth',1.5);
hold on; 

load 5user14_BP.mat
semilogy(psnr, SER1,'bo-','LineWidth',1.5);
hold on; 

load 10user14_BP.mat
semilogy(psnr, SER1,'b*-','LineWidth',1.5);
hold on; 

load 20user14_BP.mat
semilogy(psnr, SER1,'b<-','LineWidth',1.5);
hold on;

load 50user14_BP.mat
semilogy(psnr, SER1,'b.-','LineWidth',1.5);
hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAMS
load 1user14_LAMS.mat
semilogy(psnr, SER1,'r+-','LineWidth',1.5);
hold on; 

load 5user14_LAMS.mat
semilogy(psnr, SER1,'ro-','LineWidth',1.5);
hold on; 

load 10user14_LAMS.mat
semilogy(psnr, SER1,'r*-','LineWidth',1.5);
hold on; 

load 20user14_LAMS.mat
semilogy(psnr, SER1,'r<-','LineWidth',1.5);
hold on;

load 50user14_LAMS.mat
semilogy(psnr, SER1,'r.-','LineWidth',1.5);
hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlabel('SNR in dB');
ylabel('SER');
legend('1 user BP I=3','5 users BP I=3','10 users BP I=3','20 users BP I=3','50 users BP I=3',...
    '1 user LAMS I=3','5 users LAMS I=3','10 users LAMS I=3','20 users LAMS I=3','50 users LAMS I=3',...
    'Location','southwest');
 title('SER performance using LDPC code, with different number of users');
grid on;

axis([0 12 10^(-3.5) 1]);