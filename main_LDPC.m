clc;
clear all;
%==========================================================================
% Main program
NFFT = 512;         % FFT length
G = 212;            % Guard interval length
M_ary = 64;         % Multilevel of M_ary symbol
t_a = 130.2e-9;     
NofOFDMSymbols = 10;            %Number of data and pilot OFDM symbol
itr = 9;
fD = 70;

% N_P  = length(rho);            %Length of the CIR
symbol_duration = NFFT * t_a;  %OFDM symbol duration
N = 80;
teta=2*pi*rand(1,N);
length_data =  NofOFDMSymbols * NFFT;  % the total data length


snr_min = 0.0;
snr_max = 20.0;
step = 2.0;
SER=[];
SER1 = [];
NT = 5;
NofMs = 1;


%==========================================================================
% Source Data
%
load DataSources_test2.mat

%==========================================================================
% Channel Coefficients
%
load channel_coeff_test2.mat

%==========================================================================
% Channel Allocation
%
load mask_test2.mat
%==========================================================================
% LDPC
load data_test2.mat
load base_graph_1_check_node_list
base_graph_check_node_list = base_graph_1_check_node_list;
TxRx.Decoder.LDPC.Iterations = 3;
%==========================================================================
% Main loop
%==========================================================================
for snr = snr_min:step:snr_max

     SER_t=0;
     SER1_t=0;
     snr = snr - 10*log10((NFFT-G)/NFFT); %Miss matching effect

     for t_i=1:NT %(1000*1920)
        rs11_frame = [];
        rs12_frame = [];
        rs21_frame = [];
        rs22_frame = [];

       
        for i=1:NofOFDMSymbols
            OFDM_signal_tem1 = OFDM_Modulator(Data_Frame1(i,:),NFFT,G); % assuming that two adjacent symbols experience the same fading
            OFDM_signal_tem2 = OFDM_Modulator(Data_Frame2(i,:),NFFT,G);
            
            for k = 1:NofMs
                %Singal pass channel
                rs11_tmp = conv(OFDM_signal_tem1, h11_cell{k,i});
                rs12_tmp = conv(OFDM_signal_tem2, h12_cell{k,i});
                rs21_tmp = conv(OFDM_signal_tem1, h21_cell{k,i});
                rs22_tmp = conv(OFDM_signal_tem2, h22_cell{k,i});
                
                rs11{k,i} = rs11_tmp;
                rs12{k,i} = rs12_tmp;
                rs21{k,i} = rs21_tmp;
                rs22{k,i} = rs22_tmp;
                
%                 snr = snr - 10*log10(nnz(mask(i,:))/NFFT);
                % The received signal over multhipath channel is created
                rs11{k,i} = awgn(rs11{k,i},snr,'measured','dB');
                rs12{k,i} = awgn(rs12{k,i},snr,'measured','dB');
                rs21{k,i} = awgn(rs21{k,i},snr,'measured','dB');
                rs22{k,i} = awgn(rs22{k,i},snr,'measured','dB');
            end
           
            
            clear OFDM_signal_tem11 OFDM_signal_tem12;
        end

        %------------------------------------------------------------------------
        % Transmitted signal of antenna 2 to receive antenna 1 (channel: h21)
        % and transmitted signal of antenna 2 to receive antenna 2 (channel: h22)
        %-----------------------------------------------------------------------

        %data_symbol = [];
        s_est_matrix1 = [];
        s_est_matrix2 = [];
        s1_est = [];
        s2_est = [];
        
        for i=1:NofOFDMSymbols
            for k = 1:NofMs
                % received data in RX
                rs1i = rs11{k,i} + rs12{k,i};
                rs2i = rs21{k,i} + rs22{k,i};

                %-----------------------------------------------------------
                % OFDM demodulator
                %-----------------------------------------------------------
                Demodulated_signal_1i = OFDM_Demodulator(rs1i,NFFT,NFFT,G);                              
                Demodulated_signal_2i = OFDM_Demodulator(rs2i,NFFT,NFFT,G);
                
                % --------------------------------
                % Zero Forcing Equalizer
                %---------------------------------
                s_est1 = [];
                s_est2 = [];
                W = [];

                r1=Demodulated_signal_1i;
                r2=Demodulated_signal_2i;

                for kkk = 1: NFFT/2
                    kk = 2*kkk -1;
                    H_tmp_first = [H11_cell{k,i}(kk), H12_cell{k,i}(kk);...
                            H21_cell{k,i}(kk), H22_cell{k,i}(kk)];
                    H_tmp_next = [H11_cell{k,i}(kk+1), H12_cell{k,i}(kk+1); ...
                            H21_cell{k,i}(kk+1), H22_cell{k,i}(kk+1)];
                 
                    
                    H_tmp = [H_tmp_first(1,1), H_tmp_first(1,2);...
                            H_tmp_first(2,1), H_tmp_first(2,2);...
                            conj(H_tmp_next(1,2)), -conj(H_tmp_next(1,1)); ...
                            conj(H_tmp_next(2,2)), -conj(H_tmp_next(2,1))];
      
                    W = (transpose(conj(H_tmp))*H_tmp)\transpose(conj(H_tmp));
                    r = [r1(kk); r2(kk); conj(r1(kk+1)); conj(r2(kk+1))];
                    s_est_tmp = W*r;
                    %------------------------------
                    % VBLAST detector
%                     [gk k0]=min(sum(abs(W),2));                  
%                     Tx_n = 2;
%                     Rx_n = 2;
%                     for ii=1:Tx_n 
% 
%                         k1(ii)=k0;
%                         w(ii)=W(k1(ii),:)*r;
% 
%                         %tmp1=ddemodce([1 w(ii)],1,1,'qask',64);
%                         tmp1=qamdemod([1 w(ii)],64);
%                         x_vblast(k1(ii),1) = tmp1(2);
%                         %tmp2=dmodce([1 x_vblast(k1(ii),1)],1,1,'qask',64);
%                         tmp2=qammod([1 x_vblast(k1(ii),1)],64);
%                         X_vblast(k1(ii),1) = tmp2(2); 
% %                         X_vblast(k1(ii),1) = round(w(ii));
%                         
%                         r=r-(H_tmp(:,k1(ii)))*(X_vblast(k1(ii),1));  
%                         H_tmp(:,k1(ii)) = zeros(2*Rx_n,1);
% 
%                         W=pinv(H_tmp);
%                         for tt=1:ii
%                             W(k1(tt),:)=inf;
%                         end
%                         [gk k0]=min(sum(abs(W),2));
%                         s_est_tmp(k1(ii),1)=w(ii);   
%                     end      
%                     %------------------------------
                    s_est1 = [s_est1 s_est_tmp(1)];
                    s_est2 = [s_est2 s_est_tmp(2)];
                end
                s_est_matrix1{k,i} = s_est1;
                s_est_matrix2{k,i} = s_est2;
            end
        end  % end of the OFDM index

        %-----------------------------------------------
        % SFBC decoder
        %-----------------------------------------------
        QAM_tmp = [];
        c = [];
        for i = 1:NofOFDMSymbols
            for k = 1:NofMs
                a = s_est_matrix1{k,i};
                b = s_est_matrix2{k,i};
                c(1:2:NFFT) = a;
                c(2:2:NFFT) = b;
                QAM_tmp{k,i} = c;
%                 QAM_tmp{k,i}(2:2:end) = ;
            end
        end        
        %-----------------------------------------------
        % QAM demodulation
        %-----------------------------------------------
        for i = 1:NofOFDMSymbols
            for k = 1:NofMs
                tmp = qamdemod(QAM_tmp{k,i},M_ary);
                tmp_llr = qamdemod(QAM_tmp{k,i},M_ary,'OutputType','llr');
                data_symbol{k,i} = tmp;
                data_llr{k,i} = tmp_llr;
            end
        end
        
        %-----------------------------------------------
        % Extract data to each Ms
        for k = 1:NofMs
            Ms_data1(k).Symbols = [];
            Ms_data1(k).Data = [];
            Ms_data1(k).LLR = [];
            
            Ms_data2(k).Data = [];
            received_bits{k} = [];
            decoded_bits{k} = [];
        end
        
        for i = 1:NofOFDMSymbols
            for j = 1:NFFT        
                k = mask(i,j);
                if ( k~=0 )
                    Ms_data1(k).Symbols = [Ms_data1(k).Symbols,  data_symbol{k,i}(j)];
                    Ms_data1(k).Data = [Ms_data1(k).Data,  de2bi(data_symbol{k,i}(j),log2(M_ary))];
                    Ms_data1(k).LLR = [Ms_data1(k).LLR,  rot90(data_llr{k,i}(:,j),3)];
                end
            end
        end
        %-----------------------------------------------
        % Channel Coding LDPC
        for k = 1:NofMs
            if Z_c(k) ~=0
                ms = k;
                received_bits{k} = Ms_data1(k).Data(1:Z_c(k)*66);
                decoded_bits{k} = decLDPC_layered(TxRx, 'myLAMS', LDPC, (1-2*received_bits{k}), base_graph_check_node_list, Z_c(k), ms, H);
%                 received_llr = Ms_data1(k).LLR(1:Z_c(k)*66);
%                 decoded_bits{k} = decLDPC_layered(TxRx, 'myLAMS', LDPC, received_llr, base_graph_check_node_list, Z_c(k), ms, H);
    
            end
        end
        
        for ms = 1:NofMs
            if Z_c(ms) ~=0
                l = length(decoded_bits{ms});
                i = 0;
                while i<(l-6)
                    bits = decoded_bits{ms}((i+1):(i+log2(M_ary)));
                    symbols = bi2de(bits);
                    Ms_data2(ms).Data = [Ms_data2(ms).Data,  symbols];
                    i = i + log2(M_ary);
                end
            end
        end
        
        %-----------------------------------------------
        % Calulate SER
        ratio = [];
        ratio1= [];
        for k = 1:NofMs
            if count(k) ~= 0
            [num, rate] = symerr(MsSource(k).Symbols,Ms_data1(k).Symbols);
            ratio = [ratio, rate];
            end
            if Z_c(k) ~= 0    
            [num1, rate1] = symerr(MsSource(k).Data,Ms_data2(k).Data);
            ratio1 = [ratio1, rate1];
            end
        end
        SER_t = SER_t + sum(ratio)/nnz(count);
        SER1_t = SER1_t + sum(ratio1)/nnz(Z_c);
    end 
     tE=SER_t/t_i;
     tE1=SER1_t/t_i;
     SER = [SER, tE];
     SER1 = [SER1, tE1];
end  
psnr = snr_min:step:snr_max;
% save user\SFBC_20user.mat psnr  SER;
% semilogy(psnr, SER,'bo-','Color','blue');
% hold on;
% semilogy(psnr, SER1,'*-','Color','red');
% xlabel('SNR in dB');
% ylabel('SER');
% grid on;
% hold on;