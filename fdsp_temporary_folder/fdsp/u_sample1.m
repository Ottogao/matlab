function y = u_sample1 (t)

%U_SAMPLE1: Example user file for GUI module G_SAMPLE
%
% Usage: y = u_sample (t);
%
% Inputs: 
%         t  = vector of input times
% Outputs: 
%          y = vector of samples of analog signal evaluated at t

y = 0.1 ./ (.1 + (t-1).^2);
