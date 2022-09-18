clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT*t_a;  %OFDM symbol duration
NofMs = 1;
d_u = 0.5; 
d_s = 1.9;          %==========> corr = 0.8980

ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;
% save user\VBLAST_1user.mat psnr  SER;
save user09\1user14_LAMS_I10.mat psnr  SER SER1;
%==========================================================================

% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =14;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a;  %OFDM symbol duration
% NofMs = 2;
% d_u = 0.2; 
% d_s = 0.5;          %==========> corr = 0.9006
% 
% ChannelCoeff2;
% ChannelAllocation2;
% gen_bit_ldpc2;
% DataSources_LDPC2;
% main_LDPC2;
% % save user\VBLAST_2user.mat psnr  SER;
% save user09\2user14_LAMS.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =10;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a;  %OFDM symbol duration
NofMs = 5;
d_u = 0.2; 
d_s = 0.5;          %==========> corr = 0.9006

ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;
% save user\VBLAST_5user.mat psnr  SER;
save user09\5user14_LAMS_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a;  %OFDM symbol duration
NofMs = 10;
d_u = 0.2; 
d_s = 0.5;          %==========> corr = 0.9006

ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;
% save user\VBLAST_10user.mat psnr  SER;
save user09\10user14_LAMS_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a;  %OFDM symbol duration
NofMs = 20;
d_u = 0.2; 
d_s = 0.5;          %==========> corr = 0.9006

ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;
% save user\VBLAST_20user.mat psnr  SER;
save user09\20user14_LAMS_I10.mat psnr  SER SER1;
%==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a;  %OFDM symbol duration
NofMs = 50;
d_u = 0.2; 
d_s = 0.5;          %==========> corr = 0.9006

ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;
% save user\VBLAST_50user.mat psnr  SER;
save user09\50user14_LAMS_I10.mat psnr  SER SER1;
