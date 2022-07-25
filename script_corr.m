% clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
NofMs = 10;
d_u = 3.0; 
d_s = 8.6;         %==========> corr = 0.1000

% d_u = 16.3; 
% d_s = 18.3;         %==========> corr = 0.1000

% ChannelCoeff_old;
% ChannelCoeff;
ChannelAllocation;
gen_bit_ldpc;
DataSources_LDPC;
main_LDPC;
save 14OFDM\corr_09_LAMS_I3_14.mat psnr SER SER1;
% save speed\corr_01_v15_LAMS.mat psnr SER SER1;
% save speed\corr_09_v60_LAMS.mat psnr SER SER1;
%==========================================================================
% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
% NofMs = 5;
% d_u = 0.6; 
% d_s = 3.7;         %==========> corr = 0.2004
% 
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% save corr2\corr_02.mat psnr  SER SER1;
%==========================================================================
% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
% NofMs = 5;
% d_u = 0.5; 
% d_s = 2.8;         %==========> corr = 0.3008
% 
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% save corr2\corr_03.mat psnr  SER SER1;
%==========================================================================
% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
% NofMs = 5;
% d_u = 1.8; 
% d_s = 0.6;          %==========> corr = 0.3996
% 
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% save corr2\corr_04.mat psnr  SER SER1;
% %==========================================================================
% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
% NofMs = 5;
% d_u = 1.6; 
% d_s = 1.1;          %==========> corr = 0.5015
% 
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% save corr2\corr_05.mat psnr  SER SER1;
% %==========================================================================
% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
% NofMs = 5;
% d_u = 0.5; 
% d_s = 0.8;          %==========> corr = 0.5961
% 
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% save corr2\corr_06.mat psnr  SER SER1;
%==========================================================================
% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
% NofMs = 5;
% d_u = 0.3; 
% d_s = 1.1;          %==========> corr = 0.7008
% 
% 
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% save corr2\corr_07.mat psnr  SER SER1;
%==========================================================================
% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
% NofMs = 5;
% d_u = 0.2; 
% d_s = 0.9;          %==========> corr = 0.7990
% 
% 
% ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% save corr2\corr_08.mat psnr  SER SER1;
%==========================================================================
% clc;
% clear all;
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9;     
% symbol_duration = NFFT * t_a/4;  %OFDM symbol duration
% NofMs = 5;
% % d_u = 0.2; 
% % d_s = 0.5;          %==========> corr = 0.9048
% d_u = 0.5; 
% d_s = 0.6;          %==========> corr = 0.9006
% 
% ChannelCoeff_old;
% % ChannelCoeff;
% ChannelAllocation;
% gen_bit_ldpc;
% DataSources_LDPC;
% main_LDPC;
% save corr2\corr_09_v6010_LAMS_old.mat psnr SER SER1;

