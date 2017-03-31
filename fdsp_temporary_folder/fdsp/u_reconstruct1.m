function x_a = u_reconstruct1 (t)

%U_RECONSTRUCT1: Example user file for GUI module G_RECONSTRUCT
%
% Usage: x_a = u_reconstruct1 (t);
%
% Inputs: 
%         t  = vector of input times
% Outputs: 
%          u_a = vector of samples of analog signal evaluated at t

x_a = -exp(-2*t) + t .* exp(-t) ./ (.1 + (1.5 - t).^2);
