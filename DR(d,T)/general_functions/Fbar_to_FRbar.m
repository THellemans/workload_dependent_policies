function [FRbar, ER] = Fbar_to_FRbar( T, d, px, xx, w_range, fgx_inv, FbarSgxinv, Fbar, FbarRx )
%

dw=w_range(2)-w_range(1);
FRbar=zeros(size(Fbar));
for i=1:length(px)
    if xx(i) < T
        FRbar(w_range < T)=FRbar(w_range < T)+px(i)*FbarRx(i,(w_range < T));
    end
end
indx_T=find(w_range<T, 1, 'last' );
for i=1:length(px)
    temp=FbarSgxinv(i,:)+convolution(fgx_inv(i,:), Fbar, dw);
    FRbar(indx_T+1:end)=FRbar(indx_T+1:end)+px(i)*temp(indx_T+1:end).*temp(1:end-indx_T).^(d-1);
end
ER=trapz(FRbar)*dw;
end