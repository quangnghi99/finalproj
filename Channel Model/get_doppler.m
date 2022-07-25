function [f_doppler] = get_doppler(D_doppler,vr,vt,lambda)
%get_doppler 
%   Detailed explanation goes here
f_doppler=(sum(D_doppler'.*(vr-vt),'all'))/((norm(D_doppler,'fro')*lambda));

end

