addpath('../general_functions')
clear all

T_iter=[0.01 0.5 1 2 3];
w_range=linspace(0,200,10^5);
d=2;
q=0.2;
lam=0.75;
alpha=1;
A=-1;
nlam=100;
lam_iter=[linspace(0.01,1/(1+q)-0.01, nlam) linspace(1/(1+q),1,50)];
Fbar_S=@(x) exp(-x);
p=1/2;
for i=1:10
    px(i)=(1-p)^(i-1)*p;
    xx(i)=i;
end
px(10)=1-sum(px(1:9));
xx=xx./sum(px.*xx);

w_range=linspace(0,200,10^5);
Fbar_S= @(x) exp(-x);
alpha=1;
A=-1;
[~,~,Fbargx_inv,~] = g_dists(Fbar_S, q, px, xx, false, w_range);

for i=1:5
    T=T_iter(i);
    for j=1:length(lam_iter)
        lam=lam_iter(j);
        if j==1 
            [ MRT(i,j), ~, Fbar, ~ ] = get_MRT( lam, d, T, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-8), 0,1 );
        else
            [ MRT(i,j), ~, Fbar, ~ ] = get_MRT( lam, d, T, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-8), Fbar(1),1 );
        end
        Fbar0_holder(i,j)=Fbar(1);
        if min(Fbar) >0.01 || max(Fbar)>1
            break
        end
        save('num3.mat','lam_iter','MRT','Fbar0_holder','lam_iter','xx','px','T_iter');
    end
end