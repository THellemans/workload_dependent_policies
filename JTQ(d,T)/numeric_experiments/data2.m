addpath('../general_functions')
addpath('../../generally_applicable_code')

T_iter=linspace(0.01,40,300);
w_range=linspace(0,200,10^5);
d=2;
lam=0.9;
A=-1;
tol1=10^(-4); tol2=10^(-4);
MRT=zeros(4,length(T_iter));
for i=1:4
    if i==1
        w_range=linspace(0,200,10^5);
        Gbar=1-erlang_cdf(w_range, 2, 2);
        g = erlang_pdf(w_range, 2, 2);
    elseif i==2
        w_range=linspace(0,200,10^5);
        Gbar=exp(-w_range);
        g=exp(-w_range);
    elseif i==3
        w_range=linspace(0,400,10^5);
        [ alpha, A ] = hyperexponential_init_alphaA( 1, 5, 1/2 );
        Gbar = 1- hyperexponential_cdf( alpha, A, w_range );
        g=hyperexponential_pdf( alpha, A, w_range );
    elseif i==4
        w_range=linspace(0,400,10^5);
        [ alpha, A ] = hyperexponential_init_alphaA( 1, 10, 1/2 );
        Gbar = 1- hyperexponential_cdf( alpha, A, w_range );
        g=hyperexponential_pdf( alpha, A, w_range );
    end
    for j=1:length(T_iter)
        T=T_iter(j);
        if j==1
            [Fbar, ~, ~, MRT(i,j)] = get_MRT( T, lam, d, Gbar, g, w_range );
        else
            [Fbar, ~, ~, MRT(i,j)] = get_MRT( T, lam, d, Gbar, g, w_range, Fbar );
        end
    end
    save('num2_test.mat','MRT','T_iter');
end