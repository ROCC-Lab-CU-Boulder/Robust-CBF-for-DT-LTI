function rdcbf = rdcbfqp_yalmip(data,r,options)
%RDCBFQP_YALMIP compiles a YALMIP optimizer object for the RDCBF-QP.
%  rdcbf = RDCBFQP_YALMIP(data,r) Returns
%        a YALMIP optimizer to solve the RDCBF-QP problem. 
%  rdcbf = RDCBFQP_YALMIP(data,r,options) if options.soft=1, 
%      the RDCBF-condition is made soft.
%
%   Copyright (c) 2024, University of Colorado Boulder

arguments
  data
  r
  options.soft (1,1) logical = 0
end

% Setup optimization variables and parameters
x = sdpvar(size(data.A,1),1);
u = sdpvar(size(data.B,2),1);
w = sdpvar(size(data.B,2),1);
v = sdpvar(size(data.G_x,2),1);

% Objective
obj = norm(u - data.kappa(x,r))^2 + data.eta*norm(w - r)^2;

if options.soft
  wt = 1000; % wt on epsilon (sufficiently large)
  epsilon = sdpvar(1,1);
  obj = obj + wt*epsilon;
end

% Constraints
cst = [];
cst = [cst, data.M*u <= data.b];
if options.soft
  cst = [cst, data.M_K*[u;w] <= data.b_K(x) + epsilon];
  cst = [cst, epsilon >= 0];
else
  cst = [cst, data.M_K*[u;w] <= data.b_K(x)]; 
end

% Options
opt = sdpsettings('verbose',0,'solver','mosek,*','debug',0);

% Compile optimizer
prob = optimizer(cst,obj,opt,{x,v},{u,w});
rdcbf = @(x,v) rdcbf_sortout(x,v,prob);
end

% Add solvetime wrapper
function [uw,errorcode,solvetime] = rdcbf_sortout(x,v,prob)
    [uw, errorcode,~,~,~,sol] = prob(x,v);
    uw = cell2mat(uw)';
    solvetime = sol.solvertime;
end
