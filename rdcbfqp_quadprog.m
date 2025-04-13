function [H, f, A, b] = rdcbfqp_quadprog(data,r)
%RDCBFQP_QUADPROG returns the matrices and vector functions required to 
% solve the RDCBF-QP (linear systems) for the system described in data.
%  [H, f, A, b] = RDCBFQP_QUADPROG(data,r) Returns the parameters to pass to
%  u = quadprog(H, f(x), A, b(x)) to solve the RDCBF-QP. See quadprog.m.
%  Note that f is an anonymous function of the state x 
%  and that b is an anonymous function of the state x.
%  
%   Copyright (c) 2024, University of Colorado Boulder

arguments
  data
  r
end

% Check norm weight
if isfield(data,'P')
  P = data.P;
else 
  P = eye(data.m);
end

H = 2*blkdiag(P,data.eta*eye(data.m));
f = @(x) -2*[P*data.kappa(x,r); data.eta*r];
A = [[data.M, zeros(size(data.M,1),data.m)]; data.M_K];
b = @(x) [data.b; data.b_K(x)];