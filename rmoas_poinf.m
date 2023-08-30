function [H_rpoinf, c_rpoinf] = rmoas_poinf(data, K)
%RMOAS_POINF Computes the projection of the robust maximal output 
%  admissible set under K Proj(O_inf^epsilon).
%  [H_rpoinf, c_rpoinf] = RMOAS_POINF(data,K) Returns the H,h such that
%        O_poinf = {x| H*x<=h}
%
%   Required packages: MPT3
%
%   Copyright (c) 2023, University of Colorado Boulder


% Compute Roinf
[H_roinf,c_roinf] = rmoas_oinf(data, K);

% Project
RProjOinf = Polyhedron(H_roinf,c_roinf).projection(1:size(data.A,1));
H_rpoinf = RProjOinf.A;
c_rpoinf = RProjOinf.b;