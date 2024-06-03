function [G_x, G_u] = moas_ss_basis(A,B,C,D)
%MOAS_SS_BASIS computes a basis G for the null space of [A-eye(n), B]
%  given the tracking outputs y = Cx + Du. The basis is G = [G_x;G_u].
%  [G_x, G_u] = MOAS_SS_BASIS(A,B,C,D) Returns the ss manifold basis.
%
%   Copyright (c) 2024, University of Colorado Boulder

G_bar = null([A-eye(size(A)) B]);
G_x_bar = G_bar(1:size(A,2),:);
G_u_bar = G_bar(size(A,2)+1:end,:);
G_x = G_x_bar/(C*G_x_bar + D*G_u_bar);
G_u = G_u_bar/(C*G_x_bar + D*G_u_bar);
