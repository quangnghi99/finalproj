clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a;  %OFDM symbol duration
NofMs = 5;
d_p = 0.1; 
d_q = 2.3;         %==========> corr = 0.4000


ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;

save corr\corr_06_LAMS_I3.mat psnr  SER SER1;
%==========================================================================


