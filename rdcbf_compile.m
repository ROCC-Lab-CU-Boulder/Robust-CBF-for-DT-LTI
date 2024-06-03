function rdcbf = rdcbf_compile(data,options)
%RDCBF_COMPILE compiles a YALMIP optimizer object for the RDCBF-QP.
%  rdcbf = RDCBF_COMPILE(data) Returns
%        a YALMIP optimizer to solve the RDCBF-QP problem. 
%  rdcbf = RDCBF_COMPILE(x,r,data,options) if options.soft=1, 
%      the RDCBF-condition is made soft.
%
%   Copyright (c) 2024, University of Colorado Boulder

arguments
  data
  options.soft (1,1) logical = 0
end

% Setup optimization variables and parameters
x = sdpvar(size(data.A,1),1);
u = sdpvar(size(data.B,2),1);
rho = sdpvar(size(data.B,2),1);
r = sdpvar(size(data.G_x,2),1);

% Objective
obj = norm(u - data.kappa(x,r))^2 + data.eta*norm(rho - r)^2;

if options.soft
  wt = 1000; % wt on epsilon (sufficiently large)
  epsilon = sdpvar(1,1);
  obj = obj + wt*epsilon;
end

% Constraints
cst = [];
cst = [cst, data.M*u <= data.b];
if options.soft
  cst = [cst, data.M_K*[u;rho] <= data.b_K(x) + epsilon];
  cst = [cst, epsilon >= 0];
else
  cst = [cst, data.M_K*[u;rho] <= data.b_K(x)]; 
end

% Options
opt = sdpsettings('verbose',0,'solver','mosek','debug',0);

% Compile optimizer
prob = optimizer(cst,obj,opt,{x,r},{u});
rdcbf = @(x,r) rdcbf_sortout(x,r,prob);
end

% Add solvetime wrapper
function [u,errorcode,solvetime] = rdcbf_sortout(x,r,prob)
    [u, errorcode,~,~,~,sol] = prob(x,r);
    solvetime = sol.solvertime;
end
