clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT*t_a/4;  %OFDM symbol duration
NofMs = 1;
d_u = 3.0; 
d_s = 8.6;         %==========> corr = 0.1000

ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_1user.mat psnr  SER;
save user2\1user.mat psnr  SER SER1;
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
% d_u = 3.0; 
% d_s = 8.6;         %==========> corr = 0.1000
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% % save user\VBLAST_2user.mat psnr  SER;
% save user2\2user.mat psnr  SER SER1;
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
d_u = 3.0; 
d_s = 8.6;         %==========> corr = 0.1000

ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_5user.mat psnr  SER;
save user2\5user.mat psnr  SER SER1;
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
d_u = 3.0; 
d_s = 8.6;         %==========> corr = 0.1000

ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_10user.mat psnr  SER;
save user2\10user.mat psnr  SER SER1;
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
% d_u = 3.0; 
% d_s = 8.6;         %==========> corr = 0.1000
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% % save user\VBLAST_20user.mat psnr  SER;
% save user2\20user.mat psnr  SER SER1;
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
d_u = 3.0; 
d_s = 8.6;         %==========> corr = 0.1000

ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
% save user\VBLAST_50user.mat psnr  SER;
save user2\50user.mat psnr  SER SER1;
