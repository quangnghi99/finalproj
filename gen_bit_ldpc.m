clear;
load mask_test.mat
base_graph_index = 1;

NofMs = 1;
l = count*6;

for k=1:NofMs
    table_zc = [2 4 8 16 32 64 128 256; 3 6 12 24 48 96  192 384; 5 10 20 40 80 160 320 0; 7 14 28 56 112 224 0 0; 9 18 36 72 144 288 0 0; 11 22 44 88 176 352 0 0; 13 26 52 104 208 0 0 0; 15 30 60 120 240 0 0 0];
    z = floor(l(k)/66);
    min = z;
    for i=1:8
        for j=1:8
            if table_zc(i,j) <= z
                if (z-table_zc(i,j))<=min
                    min = abs(table_zc(i,j)-z);
                    Z_c(k) = table_zc(i,j);
                end
            end
        end
    end
end
for ms = 1:NofMs
    tx_bits{ms} = [];
    encoded_bits{ms} = [];
    H{ms} = [];
end

for i=1:NofMs
    if Z_c(i) ~= 0
    LDPC.inf_bits(i) =  Z_c(i)*22;
    tx_bits{i} = randi([0, 1], LDPC.inf_bits(i), 1);
    [encoded_bits{i}, H2, Z, test] = ldpc_encode_optimized(tx_bits{i}, base_graph_index);
    H{i} = H2;
    [LDPC.par_bits(i), LDPC.tot_bits(i)] = size(H2);
    data{i} = [(encoded_bits{i})' randi([0,1],[1,l(i)-Z_c(i)*66])];
    else
    data{i} = randi([0,1],[1,l(i)]);
    end
%     n = nnz(mod(H2*test,2))
%     if n == 0
%         disp('pass');
%     else
%         disp('fail');
%     end
end
if (nnz(Z_c==0))
    save data_test.mat data l Z_c count
else
    save data_test.mat tx_bits LDPC H encoded_bits data l Z_c count
end
