%test orthogonality of cosine function
t=linspace(0,1,2000);
s1 = cos(2*pi*10*t);
s2 = cos(2*pi*11*t);
r1 = s1.*s2;
r2 = s1.*s1;
plot(t, r1, t, r2, 'r');
