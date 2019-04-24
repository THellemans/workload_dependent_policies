addpath('../../generally_applicable_code')

Fbar0=0.99999;
d=2;
k=1;
delta=0.01;
q=0.2;
alpha=1;
A=-1;
w_range=linspace(0,200,10^6);
Fbar_S=@(x) exp(-x);
X_cont=false;
p=1/2;
for i=1:10
    px(i)=(1-p)^(i-1)*p;
    xx(i)=i;
end
px(10)=1-sum(px(1:9));
xx=xx./sum(px.*xx);

[~,~,Fbargx_inv,~] = g_dists(Fbar_S, q, px, xx, X_cont, w_range);

[ lam_max ] = find_lam_max_PHD( Fbar0, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-8) ,0, 1 );
lam_max=0.715;
save('lam_max_reddk.mat','lam_max')
%[ Fbar, w_range ] = find_Fbar_PHD( lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-8) ,0, 1 );
