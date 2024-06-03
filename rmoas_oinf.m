function [H, c, phi] = rmoas_oinf(data, K)
%RMOAS_OINF Computes the robust maximal output admissible under K: 
%  O_inf^c.
%  [H, c, phi] = RMOAS_OINF(data, K) Returns [H, c]
%          such that O_inf^c = {(x,v) | H[x;v] <= c} and
%          the vector of worst-case perturbations phi.
%
%   Copyright (c) 2024, University of Colorado Boulder

% Get dimensions
n = size(data.A,1);
m = size(data.B,2);
dimz = length(data.z);
dimb = length(data.b);

% Closed Loop System
A_pi = data.A - data.B*K;
B_pi = data.B*(data.G_u + K*data.G_x);

% Initialize
k = 0;
L_k = [zeros(dimz,n), data.W*data.G_x;
       zeros(dimb,n), data.M*data.G_u;
       data.W, zeros(dimz,m);
       -data.M*K, data.M*(data.G_u + K*data.G_x)];
a_k = [(1-data.epsilon)*data.z;
       (1-data.epsilon)*data.b;
       data.z;
       data.b];
H = L_k;
c = a_k;
phi = rmoas_phi(H,data);

while true
  if k == 0
    L_kk = L_k*[A_pi, B_pi;
                zeros(m,n), eye(m)];
    a_kk = a_k - phi;
  else
    L_kk = L_plus*[A_pi, B_pi;
                zeros(m,n), eye(m)];
    phi_kk = rmoas_phi(L_plus,data);
    phi = [phi; phi_kk];
    a_kk = a_plus - phi_kk;
  end
  [L_plus,a_plus] = moas_elim_redundancies(H,c,L_kk,a_kk);
  if ~isempty(a_plus)
    k = k + 1;
    H = [H; L_plus];
    c = [c; a_plus];
  else
    break;
  end
end
