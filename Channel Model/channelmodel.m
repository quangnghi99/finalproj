clc; clear; close; 
%% ------------------------------------------------------------------------
%
% A General 3D Non-Stationary Massive MIMO GBSM for 6G Communication Systems
%
%% ------------------------------------------------------------------------
%
% Channel Parameters
%

load Parameter_test.mat

% Carrier frequency in GHz (0.3-10 THz)
f = 350; freq = num2str(f);
% Wave lenght
lambda= c/(f*1e9);
% Transmit antenna spacing in wavelengths (0.1-100)
dTx = 0.5 * c /(325*1e9);
% Receive antenna spacing in wavelengths (0.1-100)
dRx = 0.5 * c /(325*1e9);

%% ------------------------------------------------------------------------
%
% Channel Modeling
%

% Position vector of antenna
% Tx
for pH=1:Mth
    for pV=1:Mtv
        p=pV+(pH-1)*Mtv;
        Atp(p,:) = pH*dTx*[cos(beta_EOD_TxH)*cos(beta_AOD_TxH) cos(beta_EOD_TxH)*sin(beta_AOD_TxH) sin(beta_EOD_TxH)]...
            + pV*dTx*[cos(beta_EOD_TxV)*cos(beta_AOD_TxV) cos(beta_EOD_TxV)*sin(beta_AOD_TxV) sin(beta_EOD_TxV)];
    end
end

% Rx
for qH=1:Mrh
    for qV=1:Mrv
        q=qV+(qH-1)*Mrv;
        Arq(q,:) = qH*dRx*[cos(beta_EOA_RxH)*cos(beta_AOA_RxH) cos(beta_EOA_RxH)*sin(beta_AOA_RxH) sin(beta_EOA_RxH)]...
            + qV*dRx*[cos(beta_EOA_RxV)*cos(beta_AOA_RxV) cos(beta_EOA_RxV)*sin(beta_AOA_RxV) sin(beta_EOA_RxV)];
    end
end

% Bandwith
BW=0.1;
% Bandwith of sub-band
BWSB=0.1;
% Number of sub-band
Nf=BW/BWSB;
for nf = 1:Nf
    if Nf==1
        f_i = f;
    else
        f_i(1)=f - BW/2;
    end
    f_i(nf) = f_i(1) + (nf-1)*BWSB; 
    lambda_i(nf)=f_i(nf)*1e9/c;
end


%% Initial time
t = 0; p = 1; q = 1;i = 1; Ctp = p;Crq = q;a = 0;
delta_t = 0.001;delta_f = 0; delta_p=0; delta_q=0;
% number of snapshot
NofS=200;
% number of cluster
number_cluster = zeros(Mt,Mr,40);
number_cluster(p,q,i) = N;
% number of ray
for n = 1:number_cluster(p,q,i)
    for nf = 1:Nf
        number_ray{p,q,i}(n,nf) = M;
    end
end

% los
% Distance form Atp to Arq
d_Los = Dvec + Arq(q,:) - Atp(p,:)+ (vr-vt)*t;
% Delay Los
to_Los(p,q,i) = norm(d_Los)/c;
% h_los
for nf=1:Nf
    h_los{p,q}(nf,i) = get_hlos(d_Los,vr,vt,t,theta_los,phi_AAOD, phi_EAOD, phi_AAOA, phi_EAOA,lambda_i(nf));
end
% nlos
for n = 1:number_cluster(p,q,i)
    for nf = 1:Nf
        for m = 1:number_ray{p,q,i}(n,nf)
            % the total distance of different scattering paths
            d_nm{p,q,i}(m,n) = get_totaldistance_ray(d_pq_n(p,q,n),phi_AR_n(n), phi_AT_n(n),...
                delta_AT_n(m,n), delta_AR_n(m,n), delta_ET_n(m,n), delta_ER_n(m,n));
            % Delay of ray in cluster
            to_nm{p,q,i}(m,n) = d_nm{p,q,i}(m,n)/c;  
        end
    end
end
% Power of rays
for n=1:number_cluster(p,q,i)
    for nf = 1:Nf
        for m = 1:number_ray{p,q,i}(n,nf)
            P_nm(m,n,nf) = exp(-to_nm{p,q,i}(m,n)*(r_to-1)/(r_to*DS))*10^((-Zn(n)/10))*(f_i(nf)/f)^2;
        end
    end
end
for nf =1:Nf
    P_nm(:,:,nf) = P_nm(:,:,nf)/sum(P_nm(:,:,nf),'all');
end
% h_nlos
for n = 1:number_cluster(p,q,i)
    sum_h=0;
    for nf = 1:Nf
        for m = 1:number_ray{p,q,i}(n,nf)            
            h_nlos{p,q,i}(m,n,nf) = get_hnlos(d_nm{p,q,i}(m,n),vr,vt,lambda_i(nf),P_nm(m,n,nf),theta_VV(m,n),theta_VH(m,n),...
                theta_HV(m,n),theta_HH(m,n),XPR(m,n),phi_AT_nm(m,n), phi_ET_nm(m,n), phi_AR_nm(m,n), phi_ER_nm(m,n));
            sum_h = sum_h + h_nlos{p,q,i}(m,n,nf);
        end
    end
    h{p,q,i}(n)= sum_h;
end

% Calculate the K-factor in dB
K=-10*log10(max(max(P_nm(:,:,1)))/(sum(P_nm(:,:,1),'all')-max(max(P_nm(:,:,1)))));

%% STF evolution

for i = 2:NofS
    % Space time evolution
    % Update time
    t = t + delta_t;
    
    if Ctp < Mt
        Ctp = Ctp + 1;
    end
    if Crq < Mr
        Crq = Crq + 1;
    end
    
    for p=1:Ctp
        for q=1:Crq
            d_p=(p-1)*dTx;
            d_q=(q-1)*dRx;
            % Probability of a cluster remains
            [P_remain_T,P_remain_R,P_remain,mean_Nnew] = ...
                get_power_remain_T(p,q,Mth,Mtv,Mrh,Mrv,delta_t,lambda_R,lambda_G,...
                d_p,d_q,vt0,vr0,alpha_AOD,alpha_AOA);
            % The number of newly generated cluster
            Nnew = floor(poissrnd(mean_Nnew));
            % Number of cluster
            if number_cluster(p,q,i-1)==0
                if p > q 
                    number_cluster(p,q,i) = number_cluster(p-1,q,i-1);
                    number_ray{p,q,i} = number_ray{p-1,q,i-1};
                elseif p < q
                    number_cluster(p,q,i) = number_cluster(p,q-1,i-1);
                    number_ray{p,q,i} = number_ray{p,q-1,i-1};
                elseif p==q
                    number_cluster(p,q,i) = number_cluster(p-1,q-1,i-1);
                    number_ray{p,q,i} = number_ray{p-1,q-1,i-1};
                end
                for n = 1:number_cluster(p,q,i)
                    for nf = 1:Nf
                        for m = 1:number_ray{p,q,i}(n,nf)
                            d_nm{p,q,i}(m,n) = get_totaldistance_ray(d_pq_n(p,q,n),phi_AR_n(n),...
                                phi_AT_n(n), delta_AT_n(m,n), delta_AR_n(m,n), delta_ET_n(m,n), delta_ER_n(m,n));
                            to_nm{p,q,i}(m,n) = d_nm{p,q,i}(m,n)/c;
                            P_nm(m,n,nf) = exp(-to_nm{p,q,i}(m,n)*(r_to-1)/(r_to*DS))*10^((-Zn(n)/10))*(f_i(nf)/f)^2;
                        end
                    end
                end
            else
                number_cluster(p,q,i) = number_cluster(p,q,i-1);
                number_ray{p,q,i} = number_ray{p,q,i-1};
                % Update cluster
                % Cluster remain
                P_sur=rand(1,number_cluster(p,q,i));
                for n = 1:number_cluster(p,q,i)
                    if P_sur(1,n) > P_remain
                        d_nm{p,q,i}(:,n)=0;
                        to_nm{p,q,i}(:,n)=0;
                        P_nm(:,n,:)=0;
                    else
                        for nf = 1:Nf
                            for m = 1:number_ray{p,q,i}(n,nf)
                                d_pq_nm_temp= norm(d_nm{p,q,i-1}(m,n)*...
                                    [cos(phi_ER_nm(m,n))*cos(phi_AR_nm(m,n)) cos(phi_ER_nm(m,n))*sin(phi_AR_nm(m,n)) sin(phi_ER_nm(m,n))]...
                                    + Arq(q,:) + vr*delta_t);
                                d_nm{p,q,i}(m,n)=norm(d_pq_nm_temp*...
                                    [cos(phi_ET_nm(m,n))*cos(phi_AT_nm(m,n)) cos(phi_ET_nm(m,n))*sin(phi_AT_nm(m,n)) sin(phi_ET_nm(m,n))]...
                                    - Atp(p,:) - vt*delta_t);
                                to_nm{p,q,i}(m,n) = d_nm{p,q,i}(m,n)/c;
                                P_nm(m,n,nf) = exp(-to_nm{p,q,i}(m,n)*(r_to-1)/(r_to*DS))*10^((-Zn(n)/10))*(f_i(nf)/f)^2;
                            end
                        end
                    end
                end
            end            
            
            % Add new cluster
            if Nnew ~= 0
                for n = number_cluster(p,q,i):number_cluster(p,q,i)+Nnew
                    [phi_AT_n(n),phi_ET_n(n)] = get_angle_cluster(std_phi_AT,std_phi_ET,psi_phi_AT,psi_phi_ET);
                    [phi_AR_n(n),phi_ER_n(n)] = get_angle_cluster(std_phi_AR,std_phi_ER,psi_phi_AR,psi_phi_ER);
                    Zn(n) = 3*randn;
                    delta_dn = 1 - exp(-rand/1.5);
                    d_pq_n(p,q,n) = d_pq_n(n-1) + delta_dn;
                    for nf = 1:Nf
                        number_ray{p,q,i}(n,nf)= M;
                        for m = 1:number_ray{p,q,i}(n,nf)
                            %XPR(m,n)=10^-0.8;
                            XPR(m,n)=10^((7+3*randn)/10);
                            theta_VV(m,n)= 2*pi*rand; theta_VH(m,n)= 2*pi*rand;
                            theta_HV(m,n)= 2*pi*rand; theta_HH(m,n)= 2*pi*rand;
                            delta_AT_n(m,n)=normrnd(0,std_AT_n);
                            delta_ET_n(m,n)=normrnd(0,std_ET_n);
                            delta_AR_n(m,n)=normrnd(0,std_AR_n);
                            delta_ER_n(m,n)=normrnd(0,std_ER_n);
                            phi_AT_nm(m,n)=phi_AT_n(n)+delta_AT_n(m,n); 
                            phi_ET_nm(m,n)=phi_ET_n(n)+delta_ET_n(m,n); 
                            phi_AR_nm(m,n)=phi_AR_n(n)+delta_AR_n(m,n); 
                            phi_ER_nm(m,n)=phi_ER_n(n)+delta_ER_n(m,n); 
                            % The total distance of different scattering paths
                            d_nm{p,q,i}(m,n) = get_totaldistance_ray(d_pq_n(p,q,n),phi_AR_n(n),...
                                phi_AT_n(n), delta_AT_n(m,n), delta_AR_n(m,n), delta_ET_n(m,n), delta_ER_n(m,n));
                            to_nm{p,q,i}(m,n) = d_nm{p,q,i}(m,n)/c;
                            P_nm(m,n,nf) = exp(-to_nm{p,q,i}(m,n)*(r_to-1)/(r_to*DS))*10^((-Zn(n)/10))*(f_i(nf)/f)^2;
                        end
                    end
                end
                number_cluster(p,q,i) = number_cluster(p,q,i) + Nnew;
            end
            
            for n = 1:number_cluster(p,q,i)
                for nf = 1:Nf
                    [P_remain_f,mean_Mnew] = get_power_remain_f(delta_f,lambda_R,lambda_G);
                    % The number of newly generated cluster
                    Mnew = floor(poissrnd(mean_Mnew));
                    % Number of rays
                    number_ray{p,q,i}(n,nf) = number_ray{p,q,i}(n,nf) + Mnew;
                    P_sur_ray = rand(1,number_ray{p,q,i}(n,nf));
                    for m = 1:number_ray{p,q,i}(n,nf)
                        if P_sur_ray > P_remain_f
                            P_nm(m,n,nf) = 0;
                        end
                    end
                end
            end
            for nf =1:Nf
                P_nm(:,:,nf) = P_nm(:,:,nf)/sum(P_nm(:,:,nf),'all');
            end
            %% CIR
            % los
            % Distance from Atp to Arq
            d_Los = Dvec + Arq(q,:) - Atp(p,:)+ (vr-vt)*t;
            % Delay Los
            to_Los(p,q,i) = norm(d_Los)/c;
            % h_Los
            for nf=1:Nf
                h_los{p,q}(nf,i) = get_hlos(d_Los,vr,vt,t,theta_los,phi_AAOD, phi_EAOD, phi_AAOA, phi_EAOA,lambda_i(nf));
            end
            % h_nlos
            sum_h=0;
            for n=1:number_cluster(p,q,i)
                for nf = 1:Nf
                    for m = 1:number_ray{p,q,i}(n,nf)            
                        h_nlos{p,q,i}(m,n,nf) = get_hnlos(d_nm{p,q,i}(m,n),vr,vt,lambda_i(nf),P_nm(m,n,nf),theta_VV(m,n),theta_VH(m,n),...
                            theta_HV(m,n),theta_HH(m,n),XPR(m,n),phi_AT_nm(m,n), phi_ET_nm(m,n), phi_AR_nm(m,n), phi_ER_nm(m,n));
                        sum_h = sum_h + h_nlos{p,q,i}(m,n,nf)*exp(-2j*pi*f*1e9*to_nm{p,q,i}(m,n));
                    end
                end
            end
            h{p,q,i}= sum_h;
        end
    end
end
p=1;q=1;nf=1;
time=linspace(0,delta_t*NofS,NofS-1);
for i=1:NofS-1
    sum_corr=0;
    n=1;nn=1;
    for m = 1:number_ray{p,q,i}(n,nf)
        for mm=1:number_ray{p,q,i+1}(nn,nf)
            sigma2=f*1e9*(to_nm{p,q,i}(m,n)-to_nm{p,q,i+1}(mm,nn));
            sum_corr= sum_corr + P_remain_f*h_nlos{p,q,i}(m,n,nf)*conj(h_nlos{p,q,i+1}(mm,nn,nf))*exp(2j*pi*sigma2);
        end
    end
    corr_nlos(i)=abs(real(sum_corr));
end
% plot(time,corr_nlos,'b-.');
cd('ACF')
save 350ghz.mat corr_nlos NofS