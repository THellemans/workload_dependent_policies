addpath('../../generally_applicable_code')

lam=0.3;
d=2;
k=1;
delta=0.05;
%px=[1/4 1/4 1/4 1/4];
%xx=[0.1 0.2 0.3 1.8];
px=[10/11 1/11];
xx=[0.1 10];
w_range=linspace(0,200,10^5);
q=0.5;
[ alpha, A ] = hyperexponential_init_alphaA( 1, 2, 1/2 );
Fbar_S=@(x) 1-hyperexponential_cdf( alpha, A, x );
[~,~,Fbargx_inv,~] = g_dists(Fbar_S, q, px, xx, false, w_range);
tolX=10^(-8);

tic
[ MRT, FRbar, Fbar, w_range ] = get_MRT( lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range );
toc