addpath('../../generally_applicable_code')
lam=0.4;
d=2;
px=[1/2 1/2];
xx=[1/2 3/2];
T=4;

tol1=10^(-4);
tol2=10^(-4);

w_range=linspace(0,100,10^5);

Fbar_S=@(x) exp(-x);
q=1;
f_X=[1/2 1/2];
x_X=[0.5, 1.5];
X_cont=false;
% You want to use these things when doing JTQ(d) and replicate after time
% T or whichever model that does not "really" depend on the slowdown
%gSX is the pdf of g(S,X)
%GSXbar is the ccdf of g(S,X)
[gSX,GSXbar,FbarSgxinv,fgx_inv] = g_dists(Fbar_S, q, f_X, x_X, X_cont, w_range);

[ Fbar, w_range, FRbar, MRT ] = get_MRT( T, lam, d, px, xx, w_range, fgx_inv, FbarSgxinv, gSX, GSXbar );