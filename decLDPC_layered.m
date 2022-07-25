function [bit_output,LLR_D2,NumC,NumV] = decLDPC_layered(TxRx,Type,LDPC,LLR_A2, base_graph_check_node_list, Z_c, ms, H)
% -- initializations
%   numOfEntries = sum(sum(LDPC.H==1));
%   Rcv = spalloc(LDPC.par_bits,LDPC.tot_bits,numOfEntries); % msg matrix
LDPC.par_bits = LDPC.par_bits(ms);
LDPC.tot_bits = LDPC.tot_bits(ms);
LDPC.inf_bits = LDPC.inf_bits(ms);
Rcv = zeros(LDPC.par_bits, LDPC.tot_bits);
LLR_D2 = [zeros(1, 2*Z_c), LLR_A2];
% initialize with input bitslis
%   bit_output = zeros(1, LDPC.inf_bits);
NumC = 0; % number of computed check nodes
NumV = 0; % number of computed variable nodes

alpha = 0.8;
beta = -0.1;
alpha1 = 0.8;
beta1  = -0.1;
alpha2 = 1;
beta2  = -0.03;

% -- BEGIN loop over LDPC-internal iterations
for iter=1:TxRx.Decoder.LDPC.Iterations
    
    %%% % -- count the number of nonzero entries of H*x
    %     errors = 0;
    
    switch (Type)
        
        case 'mySPA' % -- max-log approximation (max-product algorithm)
            % == for all parity check node
            for j=1:LDPC.par_bits
                %idx = find(LDPC.H(j,:)==1); % slow
                %idx = base_graph_check_node_list{j};
                idx = find(H{ms}(j,:)==1);
                S = LLR_D2(idx)-full(Rcv(j,idx));
                for v=1:length(idx)
                    Stmp = S;
                    Stmp(v) = []; % clear row
                    Rcv(j,idx(v)) = log((1+prod(tanh(Stmp/2)))/(1-prod(tanh(Stmp/2))));
                    
                    if Rcv(j,idx(v)) > 20
                       Rcv(j,idx(v)) = 1;
                    end
                    if Rcv(j,idx(v)) < -20
                       Rcv(j,idx(v)) = -1;
                    end
                    
                    LLR_D2(idx(v)) = S(v) + Rcv(j,idx(v));
                    % --variable node & check node computed
%                     NumC = NumC + 1;
%                     NumV = NumV + 1;
                end
            end    
        
         case 'myNMS' % -- max-log approximation (max-product algorithm)
            % == for all parity check node
            for j=1:LDPC.par_bits
                %idx = find(LDPC.H(j,:)==1); % slow
                idx = base_graph_check_node_list{j};
                S = LLR_D2(idx)-full(Rcv(j,idx));
                Ssgn = prod(sign(S));
                for v=1:length(idx)
                    Stmp = S;
                    Stmp(v) = []; % clear row
                    Rcv(j,idx(v)) = alpha*min(abs(Stmp))*prod(sign(Stmp));
                    LLR_D2(idx(v)) = S(v) + Rcv(j,idx(v));
                    % --variable node & check node computed
    %                     NumC = NumC + 1;
    %                     NumV = NumV + 1;
                end
            end
            
         case 'myOMS' % -- max-log approximation (max-product algorithm)
            % == for all parity check node
            for j=1:LDPC.par_bits
                %idx = find(LDPC.H(j,:)==1); % slow
                idx = base_graph_check_node_list{j};
                S = LLR_D2(idx)-full(Rcv(j,idx));
                Ssgn = prod(sign(S));
                for v=1:length(idx)
                    Stmp = S;
                    Stmp(v) = []; % clear row
                    Rcv(j,idx(v)) = max(min(abs(Stmp))+beta,0)*prod(sign(Stmp));
                    LLR_D2(idx(v)) = S(v) + Rcv(j,idx(v));
                    % --variable node & check node computed
    %                     NumC = NumC + 1;
    %                     NumV = NumV + 1;
                end
            end     
        
         case 'myLAMS' % -- max-log approximation (max-product algorithm)
            % == for all parity check node
            for j=1:LDPC.par_bits
                %idx = find(LDPC.H(j,:)==1); % slow
                %idx = base_graph_check_node_list{j};
                idx = find(H{ms}(j,:)==1);
                S = LLR_D2(idx)-full(Rcv(j,idx));
                %S = sign(LLR_D2(idx)).*max(alpha2*abs(LLR_D2(idx))+beta2,0)-full(Rcv(j,idx));
                Ssgn = prod(sign(S));
                for v=1:length(idx)
                    Stmp = S;
                    Stmp(v) = []; % clear row
                    Rcv(j,idx(v)) = max(alpha1*min(abs(Stmp))+beta1,0)*prod(sign(Stmp));
                    %LLR_D2(idx(v)) = S(v) + Rcv(j,idx(v));
                    LLR_D2(idx(v)) = sign(S(v))*max(alpha2*abs(S(v))+beta2,0) + Rcv(j,idx(v));
                end
            end
        
        case 'SPA' % -- sum-product algorithm
            % == for all parity check node
            for j=1:LDPC.par_bits
                % idx = find(LDPC.H(j,:)==1); % slow
                %idx = base_graph_check_node_list{j};
                idx = find(H{ms}(j,:)==1);
                S = LLR_D2(idx)-full(Rcv(j,idx));
                Spsi = sum(-log(1e-300+tanh(abs(S)*0.5)));
                Ssgn = prod(sign(S));
                for v=1:length(idx)
                    Qtemp = LLR_D2(idx(v)) - Rcv(j,idx(v));
                    Qtemppsi = -log(1e-300+tanh(abs(Qtemp)*0.5));
                    Qtempsgn = Ssgn*sign(Qtemp);
                    Rcv(j,idx(v)) = Qtempsgn*(-log(1e-300+tanh(abs(Spsi-Qtemppsi)*0.5)));
                    LLR_D2(idx(v)) = Qtemp + Rcv(j,idx(v));
                    % -- count number variable & check nodes computed
                    NumC = NumC + 1;
                    NumV = NumV + 1;
                end
                
            end
        case 'MPA' % -- max-log approximation (max-product algorithm)
            % == for all parity check node
            for j=1:LDPC.par_bits
                %idx = find(LDPC.H(j,:)==1); % slow
                idx = base_graph_check_node_list{j};
                S = LLR_D2(idx)-full(Rcv(j,idx));
                for v=1:length(idx)
                    Stmp = S;
                    Stmp(v) = []; % clear row
                    Rcv(j,idx(v)) = min(abs(Stmp))*prod(sign(Stmp));
                    LLR_D2(idx(v)) = S(v) + Rcv(j,idx(v));
                    % --variable node & check node computed
                    NumC = NumC + 1;
                    NumV = NumV + 1;
                end
            end
        case 'OMS' % -- offset min-sum [Chen05]
            % == for all parity check node
            for j=1:LDPC.par_bits
                idx = find(LDPC.H(j,:)==1); % slow
%                 idx = base_graph_check_node_list{j};
                S = LLR_D2(idx)-Rcv(j,idx);
                Stmp_abs = abs(S);

                [Stmp_abs_min, min_position] = min(Stmp_abs);
                Stmp_abs_without_min = Stmp_abs;
                Stmp_abs_without_min(min_position) = [];
                Stmp_abs_second_min = min(Stmp_abs_without_min);
                               
                Stmp_sign_1 = sign(S);
                Stmp_sign_1(Stmp_sign_1==0) = 1;       
                Stmp_sign_prod = prod(Stmp_sign_1);
                for v=1:length(idx)
                    if v == min_position
                        Magnitude = Stmp_abs_second_min;
                    else    
                        Magnitude = Stmp_abs_min;
                    end

                    Signum = Stmp_sign_prod * Stmp_sign_1(v);
                    
                    Rcv(j,idx(v)) = Signum*Magnitude;
                    LLR_D2(idx(v)) = S(v) + Rcv(j,idx(v));
                    % --variable node & check node computed
                    NumC = NumC + 1;
                    NumV = NumV + 1;
                end
            end
%         otherwise
%             error('Unknown TxRx.Decoder.LDPC.Type.')
    end
    
end

% -- compute binary-valued estimates
bit_output = 0.5*(1-mysign(LLR_D2(1:LDPC.inf_bits)));

clear Rcv

return

function s = mysign(inp)
s = 2*double(inp>0)-1;
return