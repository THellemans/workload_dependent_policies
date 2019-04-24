addpath('../general_functions')
addpath('../../generally_applicable_code')
clear all

T_iter=linspace(0.01,30,600);
w_range=linspace(0,200,10^5);
d_iter=2:5;
q=0.2;
lam=0.4;
alpha=1;
A=-1;
nlam=100;
Fbar_S=@(x) exp(-x);
p=1/2;
for i=1:10
    px(i)=(1-p)^(i-1)*p;
    xx(i)=i;
end
px(10)=1-sum(px(1:9));
xx=xx./sum(px.*xx);
Fbar_S=@(x) exp(-x);
tol1=10^(-5); tol2=10^(-5);

[gSX,GSXbar,Fbargx_inv,fgx_inv] = g_dists(Fbar_S, q, px, xx, false, w_range);

FRbar=cell(length(d_iter), length(T_iter));
for i=4:4
    d=d_iter(i);
    for j=1:length(T_iter)
        T=T_iter(j);
        if j==1
            [ Fbar, ~, FRbar{i,j}, MRT(i,j) ] = get_MRT( T, lam, d, px, xx, w_range, fgx_inv, Fbargx_inv, gSX, GSXbar, tol1, tol2 );
        else
            [ Fbar, ~, FRbar{i,j}, MRT(i,j) ] = get_MRT( T, lam, d, px, xx, w_range, fgx_inv, Fbargx_inv, gSX, GSXbar, tol1, tol2, Fbar );
        end
        Fbar0_holder(i,j)=Fbar(1);
        if ((min(Fbar) >0.01) || (max(Fbar)>1))
            break
        end
        save('num3.mat','MRT','Fbar0_holder','FRbar','d_iter','q','xx','px','T_iter');
    end
end