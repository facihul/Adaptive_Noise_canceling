function [err] = rls(lamda,u,d,M)

Ns = length(d);
if (Ns ~= length(u))  
    return; 
end
 del=100*var(u)+10;
%del = 1;
I=eye(M);
u = [zeros(M-1, 1); u];

p=del*I;
w=zeros(M,1);
err = zeros(Ns,1);
count=1;% counter for reset p;

for n=1:Ns
    
    uu = u(n+M-1:-1:n);
    pi= uu'*p;
    gamma=lamda+pi*uu;
    k=pi'./gamma;
    y=w'*uu;
    err(n)=d(n)-y;
    pb=k*pi;
     if n==count*4000 
       p=del*I; count=count+1;
       else p=(p-pb)/lamda; 
     end
    
    w=w+(k*err(n));
end

end