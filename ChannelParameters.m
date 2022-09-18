clc; clear; close;
%% ------------------------------------------------------------------------
%
% Channel Parameters
%

% Speed of light in m/s
% c = physconst('LightSpeed');
c=3e+8;
% Number of transmit antenna elements (2-256)
Mth = 2;
Mtv = 1;
Mt=Mth*Mtv;
% Number of receive antenna elements (2-256)
Mrh = 2;
Mrv = 1;
Mr=Mrv*Mth;
%The initial distance between the first element the Tx and Rx
D=3; Dvec=[D 0 0];
% Velocity
vt0 = 0; %Tx
vr0 = 0.6; %Rx
% Delay scaling parameter
r_to=2.3;
% Random delay spread
mean_DS=-6.63;
std_DS=0.32;
DS= 10^(mean_DS + std_DS*randn);
% the cluster generation rate and recombination rate.
lambda_G=80;
lambda_R=4;
% initial number of clusters
N=lambda_G/lambda_R;
% initial number of ray per cluster
M=50;

%% ------------------------------------------------------------------------
%
% Angle Parameters
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

% XPR
XPR=zeros(M,N);
for n=1:N
    for m=1:M    
%         XPR(m,n)=10^-0.8;
        XPR(m,n)=10^((7+3*randn)/10);
    end
end

% per cluster shadowing term in dB
for n = 1:N
    Zn(n)=3*randn;
end

% theta_los
theta_los=2*pi*rand;

%% ------------------------------------------------------------------------
%
% Channel Modeling
%

% velocity vector
vt= vt0 * [cos(alpha_EOD)*cos(alpha_AOD) cos(alpha_EOD)*sin(alpha_AOD) sin(alpha_EOD)];
vr= vr0 * [cos(alpha_EOA)*cos(alpha_AOA) cos(alpha_EOA)*sin(alpha_AOA) sin(alpha_EOA)];

for p = 1:Mt
    for q = 1:Mr
        for n = 1:N
            if n==1
                d_pq_n(p,q,n) = D + 1.5*exp(-rand/1.5);
            else
                delta_dn = 1.5*exp(-rand/1.5);
                d_pq_n(p,q,n) = d_pq_n(p,q,n-1) + delta_dn;
            end
        end
    end
end

save Parameter_test.mat