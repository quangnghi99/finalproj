function [phi_A,phi_E] = get_angle_cluster(std_phi_A,std_phi_E,psi_phi_A,psi_phi_E)
% get_angle_cluster
%   Detailed explanation goes here
Y_A = randn;
Y_E = randn;
phi_A = std_phi_A*Y_A + psi_phi_A;
phi_E = std_phi_E*Y_E + psi_phi_E;
end

