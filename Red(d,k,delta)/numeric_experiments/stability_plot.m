clear all
addpath('../../generally_applicable_code')
addpath('../general_functions')

d=5;

k_iter=1:5;
delta=0.01;
q=0.2;
stype=0;
sp1=0;sp2=0;sp3=0;
jtype=0;
p=1/2;
for i=1:10
    px(i)=(1-p)^(i-1)*p;
    xx(i)=i;
end
px(10)=1-sum(px(1:9));
xx=xx./sum(px.*xx);
N=300;
nruns=40;
runlen=round(10^7/N);
w_range=linspace(0,200,10^5);
alpha=1;

X_cont=false;

nlam=100;
for i=1:length(k_iter)
    k=k_iter(i)
    A=-k;
    [~,~,Fbargx_inv,~] = g_dists(Fbar_S, q, px, xx, X_cont, w_range);
    lam_max(i)=find_lam_max_PHD( 0.9999, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-6) ,0, 1 );
    lam_iter=linspace(0,lam_max-0.001,nlam);
    Fbar_S= @(x) exp(-k*x);
    for j=1:length(lam_iter)
        lam=lam_iter(j);
        [~,~,Fbargx_inv,~] = g_dists(Fbar_S, q, px, xx, X_cont, w_range);
        
        if j==1
            [ MRT(i,j), ~, Fbar ] = get_MRT( lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, tolX, 0,1 );
        else
            [ MRT(i,j), ~, Fbar ] = get_MRT( lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, tolX, Fbar(1),1 );
        end
        save('num1.mat','MRT','k_iter','d','lam_max','nlam')
    end
end