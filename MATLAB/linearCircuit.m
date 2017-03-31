% solve linear circuits as a voltage source connected by 5 resistors
% R1,R2 in one branch, R4, R5 in another branch, and R3 bridges in the
% middle points of R1-R2, and R4-R5
% the solution is based on kirchoff's law and assuming I1 as current for
% circuit on the left (with voltage source), I2 the upper circuit current,
% and I3 the lower circuit current

V = 5;
R1 = 4;
R2 = 2;
R3 = 3;
R4 = 4;
R5 = 6;
A=[R1+R2 -R1 -R2; -R1 R1+R3+R4 -R3; -R2 -R3 R2+R3+R5];
Y=[V; 0; 0];
X=linsolve(A,Y);    % solve for X as A*X=Y;
x = (A')\Y;         % equivalent formula