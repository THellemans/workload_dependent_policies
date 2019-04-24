addpath('../general_functions')
addpath('../../generally_applicable_code')

clear all
addpath('../../generally_applicable_code')
addpath('../general_functions')

d_iter=2:5;
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
Fbar_S= @(x) exp(-x);
w_range=linspace(0,200,10^5);
alpha=1;

X_cont=false;
A=-1;
Fbar0=0.999;

for j=1:length(d_iter)
    d=d_iter(j);
    for i =1:length(q_iter)
        q=q_iter(i);
        EgSX(i,j)=(1+q);
        [~,~,Fbargx_inv,~] = g_dists(Fbar_S, q, px, xx, X_cont, w_range);
        
        [ lam_max(i,j) ] = find_lam_max_PHD( Fbar0, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-6) ,0, 1 );
        save('num2.mat','lam_max','q_iter','k','d','delta')
    end
end