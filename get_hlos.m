function [h_los] = get_hlos(d_nlos,vr,vt,t,theta_los,phi_AAOD, phi_EAOD, phi_AAOA, phi_EAOA,lambda_i)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%     theta_los=2*pi*rand;

    %Doppler frequency of Los path
    f_pq_Los = get_doppler(d_nlos,vr,vt,lambda_i);
    % Transform LCS from GCS
    [Fqv, Fqh, Fpv, Fph]=getLcs(phi_AAOD, phi_EAOD, phi_AAOA, phi_EAOA);
    
    angle_matrix = zeros(2,2);
    angle_matrix(1,1)=exp(1j*theta_los);
    angle_matrix(1,2) = 0;
    angle_matrix(2,1) = 0;
    angle_matrix(2,2) = -exp(1j*theta_los);
    Fq= [Fqv Fqh];
    Fp= [Fpv;Fph];
    
    %hLos
    h_los=Fq*angle_matrix*Fp*exp(2j*pi*f_pq_Los*t);
end

