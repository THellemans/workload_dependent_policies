%addpath('../general_functions')
%addpath('../../generally_applicable_code')
%clear all

T_iter=[0.01 5 10 199];
w_range=linspace(0,150,10^5);
d=2;
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
tol1=10^(-14); tol2=10^(-14);

[~,~,Fbargx_inv,fgx_inv] = g_dists(Fbar_S, q, px, xx, false, w_range);

FRbar=cell(length(xx),length(T_iter));
for j=1:length(T_iter)
    T=T_iter(j);
    [ Fbar, ~, FRbar{j}, MRT(j) ] = get_MRT( T, lam, d, px, xx, w_range, fgx_inv, Fbargx_inv, tol1, tol2 ); 
    Fbar0_holder(i,j)=Fbar(1);
    save('num4.mat','MRT','Fbar0_holder','FRbar','q','xx','px','T_iter');
end