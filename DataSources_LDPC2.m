% clc;
% clear all;
% 
% NFFT = 512;         % FFT length
% G = 212;            % Guard interval length
% M_ary = 64;         % Multilevel of M_ary symbol
% t_a = 130.2e-9;    
% symbol_duration = NFFT*t_a;
% NofOFDMSymbols =10;
% NofMs = 1;
length_data = NFFT*NofOFDMSymbols;
        
Data_Frame1 = [];
Data_Frame2 = [];
symbol = [];

MsSource = [];
load mask_test2.mat;
load data_test2.mat;

for ms = 1:NofMs
    MsSource(ms).Symbols = [];
    MsSource(ms).Data = [];
end
for ms = 1:NofMs
    if Z_c(ms) ~=0
        l = length(tx_bits{ms});
        i = 0;
        while i<(l-6)
            bits = tx_bits{ms}((i+1):(i+log2(M_ary)));
            symbols = bi2de(bits');
            MsSource(ms).Data = [MsSource(ms).Data,  symbols];
            i = i + log2(M_ary);
        end
    end
end
count2 = zeros(1,NofMs);
for i = 1:NofOFDMSymbols
    for j = 1:NFFT
        if (mask(i,j) ~= 0)
            %data1 = randi([0,1],[1,log2(M_ary)]);
            data1 = data{mask(i,j)}((count2(mask(i,j))+1):count2(mask(i,j))+log2(M_ary));
            count2(mask(i,j)) = count2(mask(i,j)) + log2(M_ary);
            symbol(i,j) = bi2de(data1);
            ms = mask(i,j);
            MsSource(ms).Symbols = [MsSource(ms).Symbols,  symbol(i,j)];
            
            QAM_symbol = qammod(symbol(i,j),M_ary);
            if (mod(j,2) ~= 0)
                Data_Frame1(i,j) = QAM_symbol;
            else
                Data_Frame1(i,j) = -conj(QAM_symbol);
            end
        else
            Data_Frame1(i,j) = 0;
        end
    end
end

for i = 1:NofOFDMSymbols
    for j = 1:NFFT
        if (mod(j,2) ~= 0)
            Data_Frame2(i,j) = -conj(Data_Frame1(i,j+1));
        else
            Data_Frame2(i,j) = conj(Data_Frame1(i,j-1));
        end
    end
end

%save DataSources.mat Data_Frame1 Data_Frame2 MsSource
%save DataSources2.mat
save DataSources_test2.mat Data_Frame1 Data_Frame2 MsSource
