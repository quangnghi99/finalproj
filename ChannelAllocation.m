clc; 
clear all;

NofOFDMSymbols = 14;
NFFT = 256;
NofMs = 1;

load channel_coeff.mat;
N_data = ceil(NFFT/NofMs);
count = zeros(1,NofMs);
for i = 1:NofOFDMSymbols
    Ms_subUL = zeros(1,NofMs);
    for j = 1:NFFT
        V=[];
        for k=1:NofMs      
            mH=[H11_cell{k,i}(j), H12_cell{k,i}(j); H21_cell{k,i}(j), H22_cell{k,i}(j)];
            mH=(mH'*mH + eye(2));
            [s, v, d] = svd(mH);    
            V = [V v(2,2)];
        end
        [value, index]= max(V);
            
        for k = 1:NofMs
            if  Ms_subUL(index) < N_data && value ~= -10
                Ms_subUL(index) = Ms_subUL(index) + 1;
                mask(i,j) = index;
                count(index) = count(index) + 1;
                break;
            else
                H_MATRIX(index,j:NFFT)= -10;
                mask(i,j) = 0;
            end
                [value, index]= max(H_MATRIX(:,j));
        end
    end
end
save mask_test.mat mask count