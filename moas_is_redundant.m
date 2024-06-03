function redundant = moas_is_redundant(f,g,A,b)
%MOAS_IS_REDUNDANT checks if f'*z <= g is redundant with respect to A*z <= b.
%  redundant = MOAS_IS_REDUNDANT(f,g,A,b) Returns true if the constraint is
%              redundant, false otherwise.
%
%   Copyright (c) 2024, University of Colorado Boulder

redundant = true;
[~,fval,flag] = linprog(-f,A,b,[],[],[],[],optimoptions('linprog','Display','none'));
if(flag==-2)
  error("Oinf is emptyset");
end
if(flag == -3 || -fval>g)
  redundant = false;
end