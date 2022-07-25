clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 5;
d_u = 16.3; 
d_s = 18.3;         %==========> corr = 0.1000


ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_2user.mat psnr  SER;
save corr_zf\corr_01_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 5;
d_u = 14.5; 
d_s = 8.1;         %==========> corr = 0.2000


ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_5user.mat psnr  SER;
save corr_zf\corr_02_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 5;
d_u = 4.0; 
d_s = 12.5;         %==========> corr = 0.3000


ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_10user.mat psnr  SER;
save corr_zf\corr_03_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 5;
d_u = 4.1; 
d_s = 4.3;          %==========> corr = 0.3999


ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_20user.mat psnr  SER;
save corr_zf\corr_04_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 5;
d_u = 3.8; 
d_s = 4.4;          %==========> corr = 0.5000

ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_50user.mat psnr  SER;
save corr_zf\corr_05_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 5;
d_u = 3.3; 
d_s = 3.5;          %==========> corr = 0.6002


ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_50user.mat psnr  SER;
save corr_zf\corr_06_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 5;
d_u = 0.4; 
d_s = 3.7;          %==========> corr = 0.6998


ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_50user.mat psnr  SER;
save corr_zf\corr_07_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 5;
d_u = 0.5; 
d_s = 2.8;          %==========> corr = 0.7999


ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_50user.mat psnr  SER;
save corr_zf\corr_08_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 5;
d_u = 0.5; 
d_s = 0.6;          %==========> corr = 0.9006

ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_50user.mat psnr  SER;
save corr_zf\corr_09_I10.mat psnr  SER SER1;

