addpath('../general_functions')

T_iter=linspace(0.01,10,100);
w_range=linspace(0,200,10^5);
d_iter=2:5;
q=0.2;
lam=0.4;
alpha=1;
A=-1;
nlam=100;
Fbar_S=@(x) exp(-x);
p=1/2;
px(10)=1-sum(px(1:9));
xx=xx./sum(px.*xx);

[~,~,Fbargx_inv,~] = g_dists(Fbar_S, q, px, xx, false, w_range);

for i=1:4
    d=d_iter(i);
    for j=1:length(T_iter)
        T=T_iter(j);
        if j==1 
            [ MRT(i,j), ~, Fbar, ~ ] = get_MRT( lam, d, T, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-8), 0,1 );
        else
            [ MRT(i,j), ~, Fbar, ~ ] = get_MRT( lam, d, T, q, alpha, A, Fbargx_inv,  px, xx, w_range, 10^(-8), Fbar(1),1 );
        end
        Fbar0_holder(i,j)=Fbar(1);
        if min(Fbar) >0.01 || max(Fbar)>1
            break
        end
        save('num1.mat','MRT','Fbar0_holder','d_iter','xx','px','T_iter');
    end
end