function [H_nr,h_nr,mask] = moas_elim_redundancies(A,b,H,h)
%MOAS_ELIM_REDUNDANCIES Removes the redundant constraints in [A;H]x <= [b;h]
%by removing rows of H and h.
%  [H_nr, h_nr, mask] = MOAS_ELIM_REDUNDANCIES(A,b,H,h) returns the matrix
%                 H and h with the redundant rows removed and a mask describing
%                 which rows were removed. The mask is a vector the same length
%                 as h with 1 if the row is not redundant, and 0 otherwise.
%
%   Copyright (c) 2024, University of Colorado Boulder


% Nonredundant Constraints
H_nr = [];
h_nr = [];
mask = zeros(length(h),1);

for i = 1:length(h)
    if(~moas_is_redundant(H(i,:)',h(i),A,b))
        H_nr = [H_nr;H(i,:)];
        h_nr = [h_nr;h(i)];
        A = [A;H(i,:)];
        b = [b;h(i)];
        mask(i) = 1;
    end
end