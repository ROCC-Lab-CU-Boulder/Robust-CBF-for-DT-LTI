function da_star = rmoas_dastar(L_k,data)
%RMOAS_DASTAR finds the worst-case disturbances for the constraint L and
%  find the safety margin required on a.
%  da_star = RMOAS_DASTAR(L_k,data) Returns delta a^star_k.
%
%   Copyright (c) 2023, University of Colorado Boulder

% Get dims
q = size(data.E,2);   % Disturbance d dimension
m = size(data.G_x,2); % Reference v, r dim
n_c = size(L_k,1);    % Number of constraints in L

% Initialize
da_star = zeros(n_c,1);
A = [eye(q); -eye(q)];
b = ones(2*q,1)*data.d_max;
e = @(i) [zeros(i-1,1);1;zeros(n_c-i,1)]; % Canonical basis
LE = L_k*[data.E; zeros(m,q)];
opt = optimoptions('linprog','Display','off');
for i = 1:n_c
  f = (-e(i)'*LE)';
  [~,da_star(i)] = linprog(f,A,b,[],[],[],[],opt);
  da_star(i) = -da_star(i);
end