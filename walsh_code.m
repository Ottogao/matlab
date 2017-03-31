function c = walsh_code(N, n)
% walsh's rule to generate orthogonal code
% parameters: 
% N: the dimension of the code space
% n: the order of the code wanted
% return: the code

order = log2(N);
N = 2^(floor(order));

W1 = [1];
WN = W1;
for k=1:order
    WN = [WN WN; WN -WN];
end
if(n>=1 && n <=N)
    c = WN(n,:);
else
    c = WN(N/2,:);
end