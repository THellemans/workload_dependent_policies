addpath('../general_functions')
addpath('../../generally_applicable_code')
clear all

T_iter=linspace(0.01,40,200);
w_range=linspace(0,200,10^5);
d_iter=2:5;
lam=0.9;
[alpha, A] = hyperexponential_init_alphaA( 1, 9, 1/2 );
%Gbar=exp(-w_range); g=exp(-w_range);
Gbar = 1-hyperexponential_cdf( alpha, A, w_range );
g=hyperexponential_pdf(alpha, A, w_range);
A=-1;
tol1=10^(-4); tol2=10^(-4);

FRbar=cell(length(d_iter), length(T_iter));
for i=1:4
    d=d_iter(i);
    for j=1:length(T_iter)
        
        T=T_iter(j);
        if j==1
            [Fbar, ~, ~, MRT(i,j)] = get_MRT( lam, T, lam, d, Gbar, g, w_range );
        else
            [Fbar, ~, ~, MRT(i,j)] = get_MRT( lam, T, lam, d, Gbar, g, w_range, Fbar );
        end
        save('num1.mat','MRT','d_iter','T_iter');
    end
end