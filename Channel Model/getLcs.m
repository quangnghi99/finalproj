function [Fqv, Fqh, Fpv, Fph]=getLcs(phi_AziTx, phi_EleTx, phi_AziRx, phi_EleRx)
% rotation angle
x_Tx=pi/15;y_Tx=pi/15;z_Tx=pi/15;
x_Rx=pi/15;y_Rx=pi/15;z_Rx=pi/15;

% AAOD
phi_AziTx_lcs=acos(cos(y_Tx)*cos(z_Tx)*cos(phi_AziTx)+...
    (sin(y_Tx)*cos(z_Tx)*cos(phi_EleTx-x_Tx)-sin(z_Tx)*sin(phi_EleTx-x_Tx))*sin(phi_AziTx));
% EAOD
phi_EleTx_lcs=angle(cos(y_Tx)*sin(phi_AziTx)*cos(phi_EleTx-x_Tx)+...
    1j*(cos(y_Tx)*sin(z_Tx)*cos(phi_AziTx)+...
    (sin(y_Tx)*sin(z_Tx)*cos(phi_EleTx-x_Tx)-cos(z_Tx)*sin(phi_EleTx-x_Tx))*sin(phi_AziTx)));
% AAOA
phi_AziRx_lcs=acos(cos(y_Rx)*cos(z_Rx)*cos(phi_AziRx)+...
    (sin(y_Rx)*cos(z_Rx)*cos(phi_EleRx-x_Rx)-sin(z_Rx)*sin(phi_EleRx-x_Rx))*sin(phi_AziRx));
% EAOA
phi_EleRx_lcs=angle(cos(y_Rx)*sin(phi_AziRx)*cos(phi_EleRx-x_Rx)+...
    1j*(cos(y_Rx)*sin(z_Rx)*cos(phi_AziRx)+...
    (sin(y_Rx)*sin(z_Rx)*cos(phi_EleRx-x_Rx)-cos(z_Rx)*sin(phi_EleRx-x_Rx))*sin(phi_AziRx)));

% antenna patterns
Fqv=sin(phi_EleRx_lcs)*sqrt(1.64)*cos(pi*cos(phi_AziRx_lcs)/2)/sin(phi_AziRx_lcs);
Fqh=cos(phi_EleRx_lcs)*sqrt(1.64)*cos(pi*cos(phi_AziRx_lcs)/2)/sin(phi_AziRx_lcs);
Fpv=sin(phi_EleTx_lcs)*sqrt(1.64)*cos(pi*cos(phi_AziTx_lcs)/2)/sin(phi_AziTx_lcs);
Fph=cos(phi_EleTx_lcs)*sqrt(1.64)*cos(pi*cos(phi_AziTx_lcs)/2)/sin(phi_AziTx_lcs);