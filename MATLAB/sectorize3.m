function sir3=sectorize3(N)

% calculate the SIR of 3-sectorized system using worst case formula

q=sqrt(3*N);
sir3=1/(q^-4 + (q+0.7)^-4);