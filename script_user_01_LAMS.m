clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT*t_a/4;  %OFDM symbol duration
NofMs = 1;
d_p = 1; 
d_q = 0.3;        %==========> corr = 0.1002 ~ 0.1

% d_p = 0.5;
% d_q = 1.9;        %==========> corr = 0.8980 ~ 0.9

ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;
% save user\VBLAST_1user_LAMS_I10.mat psnr  SER;
save user01\1user14_LAMS_I10.mat psnr  SER SER1;
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
% d_u = 1; 
% d_s = 0.3;        %==========> corr = 0.1000
% 
% ChannelCoeff2;
% ChannelAllocation2;
% gen_bit_ldpc2;
% DataSources_LDPC2;
% main_LDPC2;
% % save user\VBLAST_2user_LAMS_I10.mat psnr  SER;
% save user01\2user14_BP.mat psnr  SER SER1;
% %==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a;  %OFDM symbol duration
NofMs = 5;
d_u = 1; 
d_s = 0.3;        %==========> corr = 0.1000

ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;
% save user\VBLAST_5user_LAMS_I10.mat psnr  SER;
save user01\5user14_LAMS_I10.mat psnr  SER SER1;
% %==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a;  %OFDM symbol duration
NofMs = 10;
d_u = 3.0; 
d_s = 8.6;        %==========> corr = 0.1000

ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;
% save user\VBLAST_10user_LAMS_I10.mat psnr  SER;
save user01\10user14_LAMS_I10.mat psnr  SER SER1;
% %==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a;  %OFDM symbol duration
NofMs = 20;
d_u = 1; 
d_s = 0.3;        %==========> corr = 0.1000

ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;
% save user\VBLAST_20user_LAMS_I10.mat psnr  SER;
save user01\20user14_LAMS_I10.mat psnr  SER SER1;
% %==========================================================================
clc;
clear all;
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
t_a = 130.2e-9;     
symbol_duration = NFFT * t_a;  %OFDM symbol duration
NofMs = 50;
d_u = 1; 
d_s = 0.3;        %==========> corr = 0.1000

ChannelCoeff2;
ChannelAllocation2;
gen_bit_ldpc2;
DataSources_LDPC2;
main_LDPC2;
% save user\VBLAST_50user_LAMS_I10.mat psnr  SER;
save user01\50user14_LAMS_I10.mat psnr  SER SER1;
