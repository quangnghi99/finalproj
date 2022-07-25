function [P_remain_T,P_remain_R,P_remain,mean_Nnew] = get_power_remain_T(p,q,Nth,Ntv,Nrh,Nrv,delta_t,lambda_R,lambda_G,dTx,dRx,vt0,vr0,alpha_AOD,alpha_AOA)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    D_a_c=10;D_s_c=30;
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
    %lambda_R=0.04; lambda_G=0.8;

if p==1
    beta_EOD_Tx = 0;
    beta_AOD_Tx = 0;
    dT=dTx;
elseif mod(p,Nth)==1 && mod(p,Ntv) ~= 1
    beta_EOD_Tx = beta_EOD_TxH;
    beta_AOD_Tx = beta_AOD_TxH;
    dT=dTx;
elseif p < Nth
    beta_EOD_Tx = beta_EOD_TxV;
    beta_AOD_Tx = beta_AOD_TxV;
    dT=dTx;
else
    beta_EOD_Tx= (beta_EOD_TxV+beta_EOD_TxH)/2;
    beta_AOD_Tx=(beta_AOD_TxV+beta_AOD_TxH)/2;
    dT=dTx*sqrt(2);
end
eps_t_1=dT*cos(beta_EOD_Tx)/D_a_c;
eps_t_2=vt0*delta_t/D_s_c;
P_remain_T=exp(-lambda_R*(eps_t_1^2+eps_t_2^2-2*eps_t_1*eps_t_2*cos(alpha_AOD-beta_AOD_Tx))^(1/2));

if q==1
    beta_EOA_Rx = 0;
    beta_AOA_Rx = 0;
    dR=dRx;
elseif mod(q,Nrh) == 1 && mod(q,Nrv) ~= 1
    beta_EOA_Rx = beta_EOA_RxH;
    beta_AOA_Rx = beta_AOA_RxH;
    dR=dRx;
elseif q < Ntv
    beta_EOA_Rx = beta_EOA_RxV;
    beta_AOA_Rx = beta_AOA_RxV;
    dR=dRx;
else
    beta_EOA_Rx= (beta_AOA_RxH + beta_EOA_RxH)/2;
    beta_AOA_Rx= (beta_AOA_RxV + beta_EOA_RxV)/2;
    dR=dRx*sqrt(2);
end
eps_r_1=dR*cos(beta_EOA_Rx)/D_a_c;
eps_r_2=vr0*delta_t/D_s_c;
P_remain_R=exp(-lambda_R*(eps_r_1^2+eps_r_2^2-2*eps_r_1*eps_r_2*cos(alpha_AOA-beta_AOA_Rx))^(1/2));
P_remain=P_remain_T*P_remain_R;
mean_Nnew=(lambda_G/lambda_R)*(1-P_remain);
end

