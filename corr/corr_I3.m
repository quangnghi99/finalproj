clear all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BP
load corr_01_BP_I3.mat
semilogy(psnr, SER1,'b+-','LineWidth',1.5);
hold on; 

load corr_04_BP_I3.mat
semilogy(psnr, SER1,'bo-','LineWidth',1.5);
hold on; 

load corr_06_BP_I3.mat
semilogy(psnr, SER1,'b*-','LineWidth',1.5);
hold on; 

load corr_09_BP_I3.mat
semilogy(psnr, SER1,'b<-','LineWidth',1.5);
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LAMS
load corr_01_LAMS_I3.mat
semilogy(psnr, SER1,'r+-','LineWidth',1.5);
hold on; 

load corr_04_LAMS_I3.mat
semilogy(psnr, SER1,'ro-','LineWidth',1.5);
hold on; 

load corr_06_LAMS_I3.mat
semilogy(psnr, SER1,'r*-','LineWidth',1.5);
hold on; 

load corr_09_LAMS_I3.mat
semilogy(psnr, SER1,'r<-','LineWidth',1.5);
hold on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlabel('SNR in dB');
ylabel('SER');
legend('p=0.1 BP I=3','p=0.4 BP I=3','p=0.6 BP I=3','p=0.9 BP I=3',...
    'p=0.1 LAMS I=3','p=0.4 LAMS I=3','p=0.6 LAMS I=3','p=0.9 LAMS I=3',...
    'Location','southwest');
 title('SER performance using LDPC code, with different number of corr');
grid on;

axis([0 12 10^(-3.5) 1]);