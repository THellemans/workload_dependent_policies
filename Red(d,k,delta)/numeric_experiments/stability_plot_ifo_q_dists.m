clear all
addpath('../general_functions')
addpath('../../generally_applicable_code')

d=2;
k=1;
delta=0.01;
q_iter=0.01:0.01:1;
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
nruns=40;
X_cont=false;

Fbar0=0.999;


for j=1:4
    if j==1
        w_range=linspace(0,200,10^5);
        Fbar_S= @(x) 1-erlang_cdf(x, 2, 2);
        alpha=[1 0];
        A=[-2 2; 0 -2];
    elseif j==2
        w_range=linspace(0,200,10^5);
        Fbar_S= @(x) exp(-x);
        alpha=1;
        A=-1;
    elseif j==3
        w_range=linspace(0,400,10^5);
        [ alpha, A ] = hyperexponential_init_alphaA( 1, 2, 1/2 );
        Fbar_S= @(x) 1-hyperexponential_init_cdf( 1, 2, 1/2, x );
    elseif j==4
        w_range=linspace(0,600,10^5);
        [ alpha, A ] = hyperexponential_init_alphaA( 1, 3, 1/2 );
        Fbar_S= @(x) 1-hyperexponential_init_cdf( 1, 3, 1/2, x );
    end
    for i =1:length(q_iter)
        q=q_iter(i);
        EgSX(i,j)=(1+q);
        [~,~,Fbargx_inv,~] = g_dists(Fbar_S, q, px, xx, X_cont, w_range);
        
        [ lam_max(i,j) ] = find_lam_max_PHD( Fbar0, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-6) ,0, 1 );
        save('num3.mat','lam_max','q_iter','k','d','delta')
    end
end