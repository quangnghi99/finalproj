%clc;
clear all;
load ChannelModel2.mat
NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
NofOFDMSymbols =14;
% t_a = 130.2e-9; 
% symbol_duration = NFFT*t_a*4;
t=2;
nf=1;
NofMs = 5;

for i = 1:NofOFDMSymbols
    h11_cell{i} = h{1,1,t}(nf);
    h12_cell{i} = h{1,2,t}(nf);
    h21_cell{i} = h{2,1,t}(nf);
    h22_cell{i} = h{2,2,t}(nf);

    H11 = fft([h{1,1,t}(nf),zeros(1,NFFT-length(h{1,1,t}(nf)))]);
    H12 = fft([h{1,2,t}(nf),zeros(1,NFFT-length(h{1,2,t}(nf)))]);
    H21 = fft([h{2,1,t}(nf),zeros(1,NFFT-length(h{2,1,t}(nf)))]);
    H22 = fft([h{2,2,t}(nf),zeros(1,NFFT-length(h{2,2,t}(nf)))]);

    H11_cell{i} = H11;
    H12_cell{i} = H12;
    H21_cell{i} = H21;
    H22_cell{i} = H22;

    t = t + 1;
end

save channel_coeff1.mat h11_cell h12_cell h21_cell h22_cell ...
     H11_cell H12_cell H21_cell H22_cell