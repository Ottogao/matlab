clf
N = 80;
B8ZSpattern1 = [0 0 0 -1 1 0 1 -1];     
binary = rand(1,N)>0.8;       
mark = 0;      
for k=1:N      
    if(binary(k)==0) 
        ami(k)=0;
    else
        if(mark==0)
            ami(k) = 1;
            mark = 1;
        else
            ami(k) = -1; 
            mark = 0;
        end
    end
end
k = 1;
B8ZS = zeros(1,N);
prepole = -1;      
while(k<=N-8)
    if(ami(k)==0 & ami(k+1)==0 & ami(k+2)==0 & ami(k+3)==0 &ami(k+4)==0 &ami(k+5)==0 & ami(k+6)==0 & ami(k+7)==0)    
            if(prepole == -1)          
                B8ZS(k:k+7) = B8ZSpattern1;
                prepole = 1;
            else       
                B8ZS(k:k+7) = -B8ZSpattern1;
                prepole = -1;
            end    
        k=k+8;
    else
        if(ami(k)~=0) 
            B8ZS(k) = -prepole;
            prepole = B8ZS(k);
        else
            B8ZS(k)=ami(k);
        end
        k=k+1;
    end
end
tr = 100;
t = linspace(0,N,tr*N);        
bt = kron(binary, ones(1,tr)); 
amit = kron(ami, ones(1,tr));
hdb3t = kron(B8ZS, ones(1,tr));
figure(1)
plot(t,bt+1, t, 0.5*amit,'r',t,0.5*hdb3t-1.5,'m');
legend('binary','AMI','B8ZS','location','southeast');
set(gca,'XTick',[0:N])
set(gca,'XGrid','on');
axis([0 N -2.5 2.5]);
for k=1:N
    text(k-0.5,2.1,sprintf('%d',binary(k)));
end