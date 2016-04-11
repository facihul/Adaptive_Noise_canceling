function ase = ASE(c,e)

t=length(c);
n=t/2;
 ase=(norm(c(t-n+1:t)-e(t-n+1:t)))/norm(c((t-n+1:t)));


end
