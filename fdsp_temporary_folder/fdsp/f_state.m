function theta = f_state (x,y,k,m,n)

% F_STATE: Construct state vector from inputs and outputs
%
% Usage: theta = f_state (x,y,k,m,n)
%
% Inputs: 
%         x  = N by 1 input vector
%         y  = N by 1 output vector
%         k  = current time (1 to N)  
%         m  = number of past inputs (m >= 0)
%         n  = number of past outputs (n >= 0)
% Outputs: 
%          theta = p by 1 state vector at time k. Here
%                  theta = [x(k),...,x(k-m),y(k-1),...y(k-n)]'

p = m+n+1;
theta = zeros(p,1);
if k < m+1
    theta(1:k) = x(k:-1:1);
else
    theta(1:m+1) = x(k:-1:k-m);
end
if k > 1
    if k <= n
        theta(m+2:m+k) = y(k-1:-1:1);
    else
        theta(m+2:p) = y(k-1:-1:k-n);
    end
end 
