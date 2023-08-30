function [H, f, A, b] = rdcbf_quadprog(data)
%RDCBF_QUADPROG returns the matrices and vector functions required to 
% solve the RDCBF-QP (linear systems) for the system described in data.
%  [H, f, A, b] = RDCBF_QUADPROG(data) Returns the parameters to pass to
%  u = quadprog(H, f(x,r), A, b(x)) to solve the RDCBF-QP. See quadprog.m.
%  Note that f is an anonymous function of the state x and reference r 
%  and that b is an anonymous function of the state x.
%  
%   Copyright (c) 2023, University of Colorado Boulder

arguments
  data
end

H = 2*eye(size(data.B,2));
f = @(x,r) -2*data.kappa(x,r);
A = [data.H_rpoinf*data.B; data.M];
b = @(x) [data.c_rpoinf - data.H_rpoinf*data.A*x - data.dc_star; data.b];