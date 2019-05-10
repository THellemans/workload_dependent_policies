function [Fbar, FRbar, w_range, MRT] = get_MRT( T, lam, d, Gbar, g, w_range, Fbar, tol )
%
if ~exist('tol','var')
    tol=10^(-8);
end

if ~exist('Fbar','var')
    Fbar=Gbar;
end

%indx_last=@(x) x(length(x));
%fun=@(Fbar0) indx_last(LTR_fun( Fbar0, T, lam, d, Gbar, g, w_range, Fbar, tol ));
%Fbar0=bisection_method(fun,Fbar0min,Fbar0max,10^(-10));
Fbar0=lam*trapz(Gbar)*w_range(2);
[Fbar, AwT, FRXbar] = LTR_fun( Fbar0, T, lam, d, Gbar, g, w_range, Fbar, tol );
indx_T=find(w_range<T,1,'last');
FRbar=(1-Fbar(indx_T).^d)/(1-Fbar(indx_T)).*AwT+Fbar(indx_T)^(d-1).*(FRXbar-AwT);
MRT=trapz(FRbar)*w_range(2);

end