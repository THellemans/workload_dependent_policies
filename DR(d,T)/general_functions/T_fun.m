function [Fbar_new, FbarRx] = T_fun( Fbar0, T, lam, d, px, xx, w_range, fScgxinv, FbarSgxinv, Fbar )
%

N=length(w_range);
indx_T=find(w_range<T, 1, 'last' );
dw=w_range(2)-w_range(1);
FbarRx=zeros(length(px), N+indx_T);
Fbar=Fbar0-(Fbar0/Fbar(1))*(Fbar(1)-Fbar);
Fbar_new=Fbar0*ones(1,N);
for i=1:length(xx)
    FbarRx(i,1:N)=FbarSgxinv(i,:)+convolution(Fbar, fScgxinv(i,:), dw);
    Fbar_new(1:indx_T)=Fbar_new(1:indx_T)-px(i)*(lam*dw*cumtrapz((FbarRx(i,1:indx_T)-Fbar(1:indx_T)).*...
        ((d-1).*FbarRx(i,1:indx_T).^(d-2).*FbarRx(i,indx_T+1:2*indx_T)+1)));
end
Fbar_new(indx_T+1:end)=Fbar_new(indx_T);
for i=1:length(xx)
    Fbar_new(indx_T+1:end)=Fbar_new(indx_T+1:end)-px(i)*(lam*dw*cumtrapz(...
        (FbarRx(i,indx_T+1:N)-Fbar(indx_T+1:end)).*((d-1).*FbarRx(i,indx_T+1:N).^(d-2).*...
        FbarRx(i,2*indx_T+1:end)+FbarRx(i,1:N-indx_T).^(d-1))));
end

end