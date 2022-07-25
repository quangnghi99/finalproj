function [phi_AOD,phi_EOD,phi_AOA,phi_EOA] = update_angle(vr,phi_AOD,phi_EOD,phi_AOA,phi_EOA,d,env, delta_t)
%update_angle_los Summary of this function goes here
%   Detailed explanation goes here

S_AOD = (vr(:,2)*cos(phi_AOD)-vr(:,1)*sin(phi_AOD))/(d*sin(phi_EOD));
S_EOD = (vr(:,1)*cos(phi_AOD)*cos(phi_EOD)+vr(:,2)*cos(phi_EOD)*sin(phi_AOD)-vr(:,3)*sin(phi_EOD))/d;
% if env == "LOS"
    S_AOA =(vr(:,2)*cos(phi_AOA)-vr(:,1)*sin(phi_AOA))/(d*sin(phi_EOA));
% else
%     B=rand;
%     if B < 0.5
%         B = -1;
%     else
%         B= 1;
%     end
%     S_AOA =B*(vr(:,2)*cos(phi_AOA)-vr(:,1)*sin(phi_AOA))/(d*sin(phi_EOA));
% end
S_EOA = (vr(:,1)*cos(phi_AOA)*cos(phi_EOA)+vr(:,2)*cos(phi_EOA)*sin(phi_AOA)-vr(:,3)*sin(phi_EOA))/d;

    phi_AOD = phi_AOD + S_AOD*delta_t;
    phi_EOD = phi_EOD + S_EOD*delta_t;
    phi_AOA = phi_AOA + S_AOA*delta_t;
    phi_EOA = phi_EOA + S_EOA*delta_t;
end

