% clc;
% clear all;

load channel_test_06.mat %0.1
% load Cofficient_test1.mat %20
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% NofOFDMSymbols =10;
% t_a = 130.2e-9; 
% symbol_duration = NFFT*t_a;
% NofMs = 1;
t = 2;


for k = 1:NofMs
        for i = 1:NofOFDMSymbols            
            h11_cell{k,i} = h{1,1,t};
            h12_cell{k,i} = h{1,2,t};
            h21_cell{k,i} = h{2,1,t};
            h22_cell{k,i} = h{2,2,t};
            
            H11 = fft([h{1,1,t},zeros(1,NFFT-length(h{1,1,t}))]);
            H12 = fft([h{1,2,t},zeros(1,NFFT-length(h{1,2,t}))]);
            H21 = fft([h{2,1,t},zeros(1,NFFT-length(h{2,1,t}))]);
            H22 = fft([h{2,2,t},zeros(1,NFFT-length(h{2,2,t}))]);
            
            H11_cell{k,i} = H11;
            H12_cell{k,i} = H12;
            H21_cell{k,i} = H21;
            H22_cell{k,i} = H22;
            t = t + 1;
        end
end
save channel_coeff_test2.mat h11_cell h12_cell h21_cell h22_cell ...
     H11_cell H12_cell H21_cell H22_cell

                