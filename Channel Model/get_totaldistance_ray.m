function [d_pq_nm] = get_totaldistance_ray(d_pq_n,phi_AR_n, phi_AT_n, delta_AT_n, delta_AR_n, delta_ET_n, delta_ER_n)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    r_c_Rx=0.2;
    r_c_Tx=0.4;
    
    % the vertical distances
    d_V_pq_nm=(d_pq_n*sin(phi_AR_n)*r_c_Rx/cos(delta_ER_n))+...
            (d_pq_n*sin(phi_AT_n)*r_c_Tx/cos(delta_ET_n));
        
    % the horizontal distances
    d_H_pq_nm=(d_pq_n*cos(phi_AR_n)*r_c_Rx/cos(delta_AR_n))+...
            (d_pq_n*cos(phi_AT_n)*r_c_Tx/cos(delta_AT_n));
        
    % the total distance of different scattering paths     
    d_pq_nm=sqrt(d_V_pq_nm^2+d_H_pq_nm^2);
end

