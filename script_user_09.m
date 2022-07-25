clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT*t_a/4;  %OFDM symbol duration
NofMs = 1;
d_u = 0.2; 
d_s = 0.5;          %==========> corr = 0.9006

ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user2\VBLAST_1user.mat psnr  SER;
save user2\1user2.mat psnr  SER SER1;
%==========================================================================

% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
% NofMs = 2;
% d_u = 0.2; 
% d_s = 0.5;          %==========> corr = 0.9006
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% % save user2\VBLAST_2user.mat psnr  SER;
% save user2\2user2.mat psnr  SER SER1;
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
d_u = 0.2; 
d_s = 0.5;          %==========> corr = 0.9006

ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user2\VBLAST_5user.mat psnr  SER;
save user2\5user2.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 10;
d_u = 0.2; 
d_s = 0.5;          %==========> corr = 0.9006

ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user2\VBLAST_10user.mat psnr  SER;
save user2\10user2.mat psnr  SER SER1;
%==========================================================================
% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
% NofMs = 20;
% d_u = 0.2; 
% d_s = 0.5;          %==========> corr = 0.9006
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% % save user2\VBLAST_20user.mat psnr  SER;
% save user2\20user2.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 50;
d_u = 0.2; 
d_s = 0.5;          %==========> corr = 0.9006

ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user2\VBLAST_50user.mat psnr  SER;
save user2\50user2.mat psnr  SER SER1;
