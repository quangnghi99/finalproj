function [P_remain,mean_Nnew] = get_power_remain_f(delta_f,lambda_R,lambda_G)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Coefficient related to the reflection surface
rho_s=1;
% Scenario-dependent correlation factors in the frequency domain.
B_fc=0.3;

P_remain=exp(-lambda_R*rho_s*delta_f/B_fc);
mean_Nnew=(lambda_G/lambda_R)*(1-P_remain);
end

