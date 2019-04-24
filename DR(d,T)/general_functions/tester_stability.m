addpath('../../generally_applicable_code')
lam=0.46;
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
[gSX,GSXbar,FbarSgxinv,fgx_inv] = g_dists(Fbar_S, q, f_X, x_X, X_cont, w_range);

Fbar0=0.999;

Fbar_old=GSXbar;
while true
    Fbar_new=T_fun( Fbar0, T, lam, d, px, xx, w_range, fgx_inv, FbarSgxinv, Fbar_old );
    if max(abs(Fbar_old-Fbar_new))<0.1*abs(Fbar_new(end))
        break
    end
    Fbar_old=Fbar_new;
end