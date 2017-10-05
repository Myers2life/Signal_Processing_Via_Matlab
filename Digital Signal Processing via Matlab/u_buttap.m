function [b,a]=u_buttap(N,OmegaC);

[z,p,k]=buttap(N);
p=p*OmegaC;
k=k*OmegaC^N;
B=real(poly(z));
b0=k;
b=k*B;
a=real(poly(p));