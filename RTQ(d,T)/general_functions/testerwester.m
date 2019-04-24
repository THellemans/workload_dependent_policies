addpath('../../generally_applicable_code')

lam=0.2;
d=2;
q=1;
alpha=1;
A=-1;
T=2;
w_range=linspace(0,100,10^5);
Fbar_S=@(x) q*exp(-x);
X_cont=false;
px=[1/2 1/2];
xx=[0.01 1.99];
tolX=10^(-6);

[~,~,Fbargx_inv,~] = g_dists(Fbar_S, q, px, xx, X_cont, w_range);[ MRT, FRbar, Fbar, w_range ] = get_MRT( lam, d, T, q, alpha, A, Fbargx_inv,  px, xx, w_range );
close all
semilogy(w_range, FRbar)