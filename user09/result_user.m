clear all;
clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%LDPC
% load 1user2_LAMS.mat
% semilogy(psnr, SER1,'b+-','LineWidth',1.5);
% hold on; 
% 
% load 2user2_LAMS.mat
% semilogy(psnr, SER1,'ko-','LineWidth',1.5);
% hold on;
% 
% load 5user2_LAMS.mat
% semilogy(psnr, SER1,'ro-','LineWidth',1.5);
% hold on; 
% 
% load 10user2_LAMS.mat
% semilogy(psnr, SER1,'g*-','LineWidth',1.5);
% hold on; 
% 
% load 20user2_LAMS.mat
% semilogy(psnr, SER1,'m<-','LineWidth',1.5);
% hold on;
% 
% load 50user2_LAMS.mat
% semilogy(psnr, SER1,'yd-','LineWidth',1.5);
% hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load 1user2_LAMS.mat
semilogy(psnr, SER,'b+-','LineWidth',1.5);
hold on; 

load 2user2_LAMS.mat
semilogy(psnr, SER,'ko-','LineWidth',1.5);
hold on;

load 5user2_LAMS.mat
semilogy(psnr, SER,'ro-','LineWidth',1.5);
hold on; 

load 10user2_LAMS.mat
semilogy(psnr, SER,'g*-','LineWidth',1.5);
hold on; 

load 20user2_LAMS.mat
semilogy(psnr, SER,'m<-','LineWidth',1.5);
hold on;

load 50user2_LAMS.mat
semilogy(psnr, SER,'yd-','LineWidth',1.5);
hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlabel('SNR in dB');
ylabel('SER');
legend('1 user','2 users','5 users','10 users','20 users','50 users');
% legend('1 user ZF','5 users ZF','10 users ZF','50 users ZF','1 user ZF-LDPC','5 users ZF-LDPC','10 users ZF-LDPC','50 users ZF-LDPC');
% legend('1 user BP I=10','5 users BP I=10','10 users BP I=10','20 users BP I=10','50 users BP I=10','1 user LAMS I=10','5 users LAMS I=10','10 users LAMS I=10','20 users BP I=10','50 users LAMS I=10');
% legend('1 user BP I=10','5 users BP I=10','10 users BP I=10','50 users BP I=10','1 user LAMS I=10','5 users LAMS I=10','10 users LAMS I=10','50 users LAMS I=10');
% title('SER performance using linear ZF receiver, with different number of users');
 title('SER performance using LDPC code, with different number of users');
grid on;

axis([0 12 10^(-3.5) 1]);