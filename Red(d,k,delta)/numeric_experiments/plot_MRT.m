clear all
addpath('../../generally_applicable_code')
addpath('../general_functions')

d=5;

k_iter=1:3;
d_iter=2:2:6;
delta=0.01;
q=0.2;
stype=0;
sp1=0;sp2=0;sp3=0;
jtype=0;
p=1/2;
for i=1:10
    px2(i)=(1-p)^(i-1)*p;
    xx2(i)=i;
end
px2(10)=1-sum(px2(1:9));
xx2=xx2./sum(px2.*xx2);
N=300;
nruns=40;
runlen=round(10^7/N);
w_range=linspace(0,200,10^5);
alpha=1;
A=-1;
Fbar_S= @(x) exp(-x);

X_cont=false;

nlam=100;
for i=1:length(k_iter)
    k=k_iter(i);
    d=d_iter(i);
    xx=xx2./k; px = px2;
    
    [~,~,Fbargx_inv,~] = g_dists(Fbar_S, q, px, xx, X_cont, w_range);
    lam_max(i)=find_lam_max_PHD( 0.99, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-6) ,0, 1 );
    lam_iter=linspace(0,lam_max(i)-0.001,nlam);
    
    for j=1:length(lam_iter)
        lam=lam_iter(j);
        if j==1
            [ MRT(i,j), ~, Fbar ] = get_MRT( lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-8), 0,1 );
        else
            [ MRT(i,j), ~, Fbar ] = get_MRT( lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-8), Fbar(1),1 );
        end
        save('num5.mat','MRT','k_iter','d','lam_max','nlam')
    end
end