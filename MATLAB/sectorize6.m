function sir6 = sectorize6(N)

% calculate SIR of 6-sectorized system using worst case formula

q=sqrt(3*N);
sir6 = 1/(q+0.7)^-4;