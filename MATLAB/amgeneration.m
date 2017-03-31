#generating AM signal from envolepe function

t=0:0.001:(1-0.001);
Vc=2;
Vct = Vc*ones(1,1000);
Vm=1;
fm=2;
fc=30;
env = Vc+Vm*sin(2*pi*fm*t);
am = env.*sin(2*pi*fc*t);
figure(1)
plot(t, am, t, env, 'r', t, -env, 'm', t, Vct, 'k--');

Vmt=sin(2*fm*pi*t);
Vct=2*sin(2*fc*pi*t);
s1=Vmt+Vct;
figure(2);
plot(t, s1)