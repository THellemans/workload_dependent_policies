function [Fbar_new, AwT, FRXbar] = T_fun( T, lam, d, Gbar, g, w_range, Fbar )
%

Fbar0=Fbar(1);
N=length(w_range);
indx_T=find(w_range<T, 1, 'last' );
dw=w_range(2)-w_range(1);
Fbar_new=Fbar0*ones(1,N);

FRXbar=Gbar+convolution(g, Fbar, dw);
H=zeros(size(Fbar));
H(1:indx_T)=Fbar(1:indx_T) - Fbar(indx_T);
AwT=(1-Fbar(indx_T)).*Gbar+convolution(g, H, dw);

Fbar_new(1:indx_T)=Fbar_new(1:indx_T)-lam*dw*cumtrapz((1-Fbar(indx_T).^d)/(1-Fbar(indx_T))*...
    (FRXbar(1:indx_T)-Fbar(1:indx_T)));
Fbar_new(indx_T+1:end)=Fbar_new(indx_T)-lam*dw*cumtrapz((1-Fbar(indx_T).^d)/(1-Fbar(indx_T)).*...
    AwT(indx_T+1:end)+Fbar(indx_T)^(d-1).*(FRXbar(indx_T+1:end)-Fbar(indx_T+1:end)-AwT(indx_T+1:end)));

Fbar_new=max(0,Fbar_new);

end