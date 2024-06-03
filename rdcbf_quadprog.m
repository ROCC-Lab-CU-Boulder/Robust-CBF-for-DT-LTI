function [H, f, A, b] = rdcbf_quadprog(data)
%RDCBF_QUADPROG returns the matrices and vector functions required to 
% solve the RDCBF-QP (linear systems) for the system described in data.
%  [H, f, A, b] = RDCBF_QUADPROG(data) Returns the parameters to pass to
%  u = quadprog(H, f(x,r), A, b(x)) to solve the RDCBF-QP. See quadprog.m.
%  Note that f is an anonymous function of the state x and reference r 
%  and that b is an anonymous function of the state x.
%  
%   Copyright (c) 2024, University of Colorado Boulder

arguments
  data
end

H = 2*eye(2*size(data.B,2));
f = @(x,r) -2*[data.kappa(x,r); data.eta*r];
A = [[data.M, zeros(size(data.M,1),data.m)]; data.M_K];
b = @(x) [data.b; data.b_K(x)];