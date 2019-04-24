function [ MRT, FRbar, Fbar, w_range ] = get_MRT( lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, tolX, lb,ub )
%
if ~exist('tolX','var')
    tolX=10^(-8);
end
if ~exist('lb','var')
    lb=0; ub=1;
end
[ Fbar, w_range, FbarRx ] = find_Fbar_PHD( lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, tolX ,lb, ub );
FRbar=zeros(size(Fbar))';
for i=1:length(px)
    for j=0:k-1
        FRbar=FRbar+px(i)*nchoosek(d-1,j)*(1-FbarRx(:,i)).^j.*FbarRx(:,i).^(d-j-1);
    end
end
MRT=trapz(FRbar)*w_range(2);
end