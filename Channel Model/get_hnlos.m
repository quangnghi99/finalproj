function [h_NLos] = get_hnlos(d_pq_nm,vr,vt,lambda_i,P_nm,theta_VV,theta_VH,theta_HV,theta_HH,XPR,phi_AT_nm, phi_ET_nm, phi_AR_nm, phi_ER_nm)
% get_hnlos
%   Detailed explanation goes here

    % The distance vectors of the mth ray of the nth cluster
    dt_pq_nm = d_pq_nm*[cos(phi_ET_nm)*cos(phi_AT_nm) cos(phi_ET_nm)*sin(phi_AT_nm) sin(phi_ET_nm)];
    dr_pq_nm = d_pq_nm*[cos(phi_ER_nm)*cos(phi_AR_nm) cos(phi_ER_nm)*sin(phi_AR_nm) sin(phi_ER_nm)];
    % Doppler frequency of the NLos path
    f_p_Nlos=get_doppler(dt_pq_nm,vt,0,lambda_i);
    f_q_Nlos=get_doppler(dr_pq_nm,vr,0,lambda_i);
    % Transform LCS from GCS
    [Fqv, Fqh, Fpv, Fph]=getLcs(phi_AT_nm, phi_ET_nm, phi_AR_nm, phi_ER_nm);

    angle_matrix = zeros(2,2);
    angle_matrix(1,1) = exp(1j*theta_VV);
    angle_matrix(1,2) = sqrt(XPR^-1)*exp(1j*theta_VH);
    angle_matrix(2,1) = sqrt(XPR^-1)*exp(1j*theta_HV);
    angle_matrix(2,2) = exp(1j*theta_HH);
    
    Fq= [Fqv Fqh];
    Fp= [Fpv;Fph];

h_NLos = Fq*angle_matrix*Fp*sqrt(P_nm)*exp(2j*pi*f_p_Nlos)*exp(2j*pi*f_q_Nlos);

end

