function [H_roinf, c_roinf] = rmoas_oinf(data, K)
%RMOAS_OINF Computes the robust maximal output admissible under K: 
%  O_inf^epsilon.
%  [H_roinf,c_roinf] = RMOAS_OINF(data, K) Returns [H_oinf, c_oinf]
%          such that O_inf^epsilon = {(x,v) | H_roinf[x;v] <= c_roinf}
%
%   Copyright (c) 2023, University of Colorado Boulder


% Get dimensions
m = size(data.B,2);
l = size(data.G_x,2);
n = size(data.A,1);
n_c = length(data.a);

% Closed Loop System
A_cl = data.A - data.B*K;
B_cl = data.B*(data.G_u + K*data.G_x);
C_cl = data.C_c - data.D_c*K;
D_cl = data.D_c*(data.G_u + K*data.G_x);

% Initialize H_oinf, c_oinf with V^epsilon cst
H_roinf = [zeros(n_c,n),...
          data.L*(C_cl*data.G_x + D_cl)];
c_roinf = (1 - data.epsilon)*data.a;

% 0-step O_0 set
L_0 = data.L*[C_cl, D_cl];
a_0 = data.a;
[L_0,a_0] = moas_elim_redundancies(H_roinf,c_roinf,L_0,a_0);
H_roinf = [H_roinf;L_0];
c_roinf = [c_roinf;a_0];

% Find L_1, a_1 and iterate by adding rows to H_oinf, c_oinf until h_1 is empty
while ~isempty(a_0)
    % Compute the next step constraints
    L_1 = L_0*[A_cl, B_cl; zeros(l,n), eye(l)];
    a_1 = a_0 - rmoas_dastar(L_0,data);
    [L_1,a_1] = moas_elim_redundancies(H_roinf,c_roinf,L_1,a_1);
    H_roinf = [H_roinf;L_1];
    c_roinf = [c_roinf;a_1];
    L_0 = L_1;
    a_0 = a_1;
end