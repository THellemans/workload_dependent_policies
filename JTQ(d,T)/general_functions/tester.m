addpath('../../generally_applicable_code')
%Gbar and g are the ccdf and the pdf for g(S,X)
%Better use the g_function thing

lam=0.9;
Fbar0=lam;
T=2;
d=2;
w_range=linspace(0,100,10^6);
Gbar=exp(-w_range); %This is actually GSXbar in T_tester
g=exp(-w_range); %This is actually gSX in T_tester
Fbar=Gbar;

[Fbar, FRbar, w_range, MRT] = get_MRT( Fbar0, T, lam, d, Gbar, g, w_range );