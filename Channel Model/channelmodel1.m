clear; close; clc;
%% ------------------------------------------------------------------------
%
% A General 3D Non-Stationary Massive MIMO GBSM for 6G Communication Systems
%
%% ------------------------------------------------------------------------
%
% Channel Parameters
%

% Speed of light in m/s
% c = physconst('LightSpeed');
c=3e+8;
% Carrier frequency in GHz (0.3-10 THz)
f = 300; freq = num2str(f);
% Wave lenght
lambda= c/(f*1e9);
% Number of transmit antenna elements (2-256)
Mth = 2;
Mtv = 1;
Mt=Mth*Mtv;
% Number of receive antenna elements (2-256)
Mrh = 2;
Mrv = 1;
Mr=Mrv*Mth;
% Transmit antenna spacing in wavelengths (0.1-100)
dTx = c /((325*1e9)*2);
% Receive antenna spacing in wavelengths (0.1-100)
dRx = c /((325*1e9)*2);
% Velocity
vt0 = 0; %Tx
vr0 = 0.6; %Rx
% Delay scaling parameter
r_to=2.3;
% Random delay spread
mean_DS=-6.63;
std_DS=0.32;
DS= 10^(mean_DS + std_DS*randn); 
%The initial distance between the first element the Tx and Rx
D=3; Dvec=[D 0 0];
% the cluster generation rate and recombination rate.
lambda_G=80;
lambda_R=4;
% initial number of clusters
N=lambda_G/lambda_R;
% initial number of ray per cluster
M=50;

%
% Angle Parameter
%

% Azimuth and elevation angles of the Tx array
beta_AOD_TxH=3*pi/4;
beta_EOD_TxH=-3*pi/5;
beta_AOD_TxV=pi/10;
beta_EOD_TxV=-pi/10;
% Azimuth and elevation angles of the Rx array
beta_AOA_RxH=pi/3;
beta_EOA_RxH=pi/10;
beta_AOA_RxV=pi/4;
beta_EOA_RxV=-pi/3;
% Azimuth and elevation angles of the mobility of Tx (Rx) array,
alpha_AOD = 0;
alpha_AOA = pi/3;
alpha_EOD = 0; % can change
alpha_EOA = 0;
% Azimuth and elevation angles of departure (AAoD and EAoD) of the 
% LOS path transmitted from AT_1 at time instant t
phi_AAOD = pi/3;
phi_EAOD = pi/4;
% Azimuth and elevation angles of arrival (AAoA and EAoA) of the 
% LOS path impinging on AR_1 at time instant t
phi_AAOA = 3*pi/4;
phi_EAOA = pi/4;
% Azimuth and elevation angles of the Tx array
std_phi_AT=4*pi/9;std_phi_ET=4*pi/9;
psi_phi_AT=0;psi_phi_ET=0;
% Azimuth and elevation angles of the Rx array
std_phi_AR=4*pi/9;std_phi_ER=4*pi/9;
psi_phi_AR=pi/4;psi_phi_ER=0;
% The relative angle
std_AT_n=deg2rad(2.8);
std_ET_n=deg2rad(1.4);
std_AR_n=deg2rad(2.8);
std_ER_n=deg2rad(1.4);
% Angle in each cluster
for n=1:N
    [phi_AT_n(n),phi_ET_n(n)] = get_angle_cluster(std_phi_AT,std_phi_ET,psi_phi_AT,psi_phi_ET);
    [phi_AR_n(n),phi_ER_n(n)] = get_angle_cluster(std_phi_AR,std_phi_ER,psi_phi_AR,psi_phi_ER);
    for m=1:M
        % The relative angle
        delta_AT_n(m,n)=normrnd(0,std_AT_n);
        delta_ET_n(m,n)=normrnd(0,std_ET_n);
        delta_AR_n(m,n)=normrnd(0,std_AR_n);
        delta_ER_n(m,n)=normrnd(0,std_ER_n);
    end
end
for n=1:N
    for m=1:M
        phi_AT_nm(m,n)=mod(phi_AT_n(n)+delta_AT_n(m,n),2*pi); %AAOD
        phi_ET_nm(m,n)=phi_ET_n(n)+delta_ET_n(m,n); %EAOD
        phi_AR_nm(m,n)=mod(phi_AR_n(n)+delta_AR_n(m,n),2*pi); %AAOA
        phi_ER_nm(m,n)=phi_ER_n(n)+delta_ER_n(m,n); %EAOA
    end
end

theta_VV=zeros(M,N);theta_VH=zeros(M,N);
theta_HV=zeros(M,N);theta_HH=zeros(M,N);
for n=1:N
    for m=1:M
        theta_VV(m,n) = rand*2*pi;
        theta_VH(m,n) = rand*2*pi;
        theta_HV(m,n) = rand*2*pi;
        theta_HH(m,n) = rand*2*pi;
    end
end

%XPR
XPR=zeros(M,N);
for n=1:N
    for m=1:M    
%         XPR(m,n)=10^-0.8;
        XPR(m,n)=10^((7+3*randn)/10);
    end
end

% theta_los
theta_los=2*pi*rand;

save Parameter2
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

% velocity vector
vt= vt0 * [cos(alpha_EOD)*cos(alpha_AOD) cos(alpha_EOD)*sin(alpha_AOD) sin(alpha_EOD)];
vr= vr0 * [cos(alpha_EOA)*cos(alpha_AOA) cos(alpha_EOA)*sin(alpha_AOA) sin(alpha_EOA)];

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
delta_t=0.001;delta_f = 0; delta_p=0; delta_q=0;
% number of snapshot
NofS=20;

% los
% Distance form Atp to Arq
d_Los = Dvec + Arq(q,:) - Atp(p,:)+ (vr-vt)*t;
% Delay Los
to_Los(p,q,i) = norm(d_Los)/c;
% h_Los
for nf=1:Nf
    h_Los(nf,i) = get_hlos(d_Los,vr,vt,t,theta_los,phi_AAOD, phi_EAOD, phi_AAOA, phi_EAOA,lambda_i(nf));
end
h_los{p,q}=h_Los;
% nlos
number_cluster = zeros(Mt,Mr,40);
number_cluster(p,q,i) = N;
for n = 1:number_cluster(p,q,i)
    if n==1
       d_pq_n(n) = 5;
    else
       delta_dn = 1 - exp(-rand/1.5);
       d_pq_n(n) = d_pq_n(n-1) + delta_dn;
    end
    for nf = 1:Nf
        number_ray{p,q,i}(n,nf) = M;
        for m = 1:number_ray{p,q,i}(n,nf)
            % the total distance of different scattering paths
            d_pq_nm(m,n) = get_totaldistance_ray(d_pq_n(n),phi_AR_n(n), phi_AT_n(n),...
                delta_AT_n(m,n), delta_AR_n(m,n), delta_ET_n(m,n), delta_ER_n(m,n));
            % Delay of ray in cluster
            to_pq_nm(m,n) = d_pq_nm(m,n)/c;  
        end
    end
end
d_nm{p,q,i}=d_pq_nm;
to_nm{p,q,i}=to_pq_nm;
% Power of rays
for n=1:number_cluster(p,q,i)
    Zn(n)=3*randn;
    for nf = 1:Nf
        for m = 1:number_ray{p,q,i}(n,nf)
            P_nm(m,n,nf) = exp(-to_nm{i}(m,n)*(r_to-1)/(r_to*DS))*10^((-Zn(n)/10))*(f_i(nf)/f)^2;
        end
    end
end
for nf =1:Nf
    P_nm(:,:,nf) = P_nm(:,:,nf)/sum(P_nm(:,:,nf),'all');
end
% h_NLos
for n = 1:number_cluster(p,q,i)
    for nf = 1:Nf
        for m = 1:number_ray{p,q,i}(n,nf)            
            h_NLos(m,n,nf) =  get_hnlos(d_pq_nm(m,n),vr,vt,lambda_i(nf),P_nm(m,n,nf),theta_VV(m,n),theta_VH(m,n),...
                theta_HV(m,n),theta_HH(m,n),XPR(m,n),phi_AT_nm(m,n), phi_ET_nm(m,n), phi_AR_nm(m,n), phi_ER_nm(m,n));
        end
    end
end

h_nlos{p,q,i} = h_NLos;

% Calculate the K-factor in dB
K=-10*log10(max(max(P_nm(:,:,1)))/(sum(P_nm(:,:,1),'all')-max(max(P_nm(:,:,1)))));

%h_final
for nf=1:Nf
    sum_h=0;
    for n = 1:number_cluster(p,q,i)
        for m = 1:number_ray{p,q,i}(n,nf) 
            sum_h = sum_h + h_nlos{p,q,i}(m,n,nf);                
        end
    end
    h{p,q,i}(nf)=sqrt(K/(K+1))*h_Los(nf,i)+sqrt(1/(K+1))*sum_h;
end

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
                    d_nm{p,q,i} = d_nm{p-1,q,i-1};
                    number_ray{p,q,i} = number_ray{p-1,q,i-1};
                elseif p < q
                    number_cluster(p,q,i) = number_cluster(p,q-1,i-1);
                    d_nm{p,q,i} = d_nm{p,q-1,i-1};
                    number_ray{p,q,i} = number_ray{p,q-1,i-1};
                elseif p==q
                    number_cluster(p,q,i) = number_cluster(p-1,q-1,i-1);
                    d_nm{p,q,i} = d_nm{p-1,q-1,i-1};
                    number_ray{p,q,i} = number_ray{p-1,q-1,i-1};
                end
            else
                number_cluster(p,q,i) = number_cluster(p,q,i-1);
                d_nm{p,q,i} = d_nm{p,q,i-1};
                number_ray{p,q,i} = number_ray{p,q,i-1};
            end            
            
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
                            d_pq_nm_temp= norm(d_nm{p,q,i}(m,n)*...
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
            
            % Add new cluster
            if Nnew ~= 0
                for n = number_cluster(p,q,i):number_cluster(p,q,i)+Nnew
                    [phi_AT_n(n),phi_ET_n(n)] = get_angle_cluster(std_phi_AT,std_phi_ET,psi_phi_AT,psi_phi_ET);
                    [phi_AR_n(n),phi_ER_n(n)] = get_angle_cluster(std_phi_AR,std_phi_ER,psi_phi_AR,psi_phi_ER);
                    Zn(n) = 3*randn;
                    delta_dn = 1 - exp(-rand/1.5);
                    d_pq_n(n) = d_pq_n(n-1) + delta_dn;
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
                            d_nm{p,q,i}(m,n) = get_totaldistance_ray(d_pq_n(n),phi_AR_n(n),...
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
            % Distance form Atp to Arq
            d_Los = Dvec + Arq(q,:) - Atp(p,:)+ (vr-vt)*t;
            % Delay Los
            to_Los(p,q,i) = norm(d_Los)/c;
            % h_Los
            for nf=1:Nf
                h_Los(nf,i) = get_hlos(d_Los,vr,vt,t,theta_los,phi_AAOD, phi_EAOD, phi_AAOA, phi_EAOA,lambda_i(nf));
            end
            h_los{p,q}=h_Los;
            % h_nlos
            for n=1:number_cluster(p,q,i)
                for nf = 1:Nf
                    for m = 1:number_ray{p,q,i}(n,nf)            
                        h_NLos(m,n,nf) =  get_hnlos(d_nm{p,q,i}(m,n),vr,vt,lambda_i(nf),P_nm(m,n,nf),theta_VV(m,n),theta_VH(m,n),...
                            theta_HV(m,n),theta_HH(m,n),XPR(m,n),phi_AT_nm(m,n), phi_ET_nm(m,n), phi_AR_nm(m,n), phi_ER_nm(m,n));
                        if h_NLos(m,n,nf)==0
                            a=a+1;
                        end
                    end
                end
            end
            h_nlos{p,q,i}=h_NLos;
            %h_final
            for nf=1:Nf
                sum_h=0;
                for n = 1:number_cluster(p,q,i)
                    for m = 1:number_ray{p,q,i}(n,nf) 
                        sum_h = sum_h + h_nlos{p,q,i}(m,n,nf);                
                    end
                end
                h{p,q,i}(nf)=sqrt(K/(K+1))*h_Los(nf,i) + sqrt(1/(K+1))*sum_h;
            end
        end
    end
end

save ChannelModel2 h_nlos h_los h to_nm to_Los

