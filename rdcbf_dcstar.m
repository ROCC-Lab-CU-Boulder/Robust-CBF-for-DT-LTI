function dc_star = rdcbf_dcstar(data)
%RDCBF_DCSTAR uses the worst-case disturbances for the RDCBF-condition to
%  find the safety margin required on c.
%  dc_star = RDCBF_DCSTAR(data) Returns dc_star.
%
%   Copyright (c) 2023, University of Colorado Boulder

% Get dims
n_o = size(data.H_rpoinf,1);  % dc_star dimension
q = size(data.E,2);   % Disturbance d dimension

% Initialize
dc_star = zeros(n_o,1);
A = [eye(q); -eye(q)];
b = ones(2*q,1)*data.d_max;
e = @(i) [zeros(i-1,1);1;zeros(n_o-i,1)]; % Canonical basis
HE = data.H_rpoinf*data.E;
opt = optimoptions('linprog','Display','off');
for i = 1:n_o
  f = (-e(i)'*HE)';
  [~,dc_star(i)] = linprog(f,A,b,[],[],[],[],opt);
  dc_star(i) = -dc_star(i);
end