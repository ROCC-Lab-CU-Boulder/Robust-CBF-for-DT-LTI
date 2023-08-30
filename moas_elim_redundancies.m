function [H_nr,h_nr] = moas_elim_redundancies(A,b,H,h)
%MOAS_ELIM_REDUNDANCIES Removes the redundant constraints in [A;H]x <= [b;h]
%by removing rows of H and h.
%  [H_nr, h_nr] = MOAS_ELIM_REDUNDANCIES(A,b,H,h) returns the matrix
%                 H and h with the redundant rows removed.
%
%   Copyright (c) 2023, University of Colorado Boulder


% Nonredundant Constraints
H_nr = [];
h_nr = [];

for i = 1:length(h)
    if(~moas_is_redundant(H(i,:)',h(i),A,b))
        H_nr = [H_nr;H(i,:)];
        h_nr = [h_nr;h(i)];
        A = [A;H(i,:)];
        b = [b;h(i)];
    end
end