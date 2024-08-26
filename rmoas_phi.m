function phi = rmoas_phi(L,data)
%RMOAS_PHI finds the worst-case disturbances for the constraint L and
%  find the safety margin required on a.
%  rmoas_phi = RMOAS_PHI(L,data) Returns phi_k.
%
%   Copyright (c) 2024, University of Colorado Boulder

% Get dims
q = size(data.E,2);   % Disturbance d dimension
m = size(data.B,2); % Reference v, r dim
ell = size(L,1);    % Number of constraints in L

% Initialize
phi = zeros(ell,1);
A = [eye(q); -eye(q)];
b = ones(2*q,1)*data.d_max;
e = @(i) [zeros(i-1,1);1;zeros(ell-i,1)]; % Canonical basis
LE = L*[data.E; zeros(m,q)];
opt = optimoptions('linprog','Display','off');
for i = 1:ell
  f = (-e(i)'*LE)';
  [~,phi(i)] = linprog(f,A,b,[],[],[],[],opt);
  phi(i) = -phi(i);
end