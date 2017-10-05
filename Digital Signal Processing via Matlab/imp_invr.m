function [b,a]=imp_invr(c,d,T)
[R,p,k]=residue(c,d);
p=exp(p*T);
[b,a]=residuez(R,p,k);
b=real(b);a=real(a);