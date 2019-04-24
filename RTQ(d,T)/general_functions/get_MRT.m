function [ MRT, FRbar, Fbar, w_range ] = get_MRT( lam, d, T, q, alpha, A, Fbargx_inv,  px, xx, w_range, tolX, lb,ub )

if ~exist('tolX','var')
    tolX=10^(-8);
end
if ~exist('lb','var')
    lb=0; ub=1;
end
[ Fbar, w_range, FbarRx, BxwT ] = find_Fbar_PHD( lam, d, T, q, alpha, A, Fbargx_inv,  px, xx, w_range, tolX ,lb, ub );
FRbar=zeros(size(Fbar))';
Tpos=find( w_range < T, 1, 'last');
%part 1
FRbar(1:Tpos)=FRbar(1:Tpos)+Fbar(Tpos).^d;
for i=1:length(px)
    for k=1:d
        FRbar(1:Tpos)=FRbar(1:Tpos)+px(i)*nchoosek(d,k)*Fbar(Tpos)^(d-k)*squeeze(BxwT(i,1:Tpos))'.^k;        
    end
end
for i=1:length(px)
    FRbar(Tpos+1:end)=FRbar(Tpos+1:end)+px(i)*Fbar(Tpos)^(d-1)*...
        (squeeze(FbarRx(Tpos+1:end,i))-squeeze(BxwT(i,Tpos+1:end))');
    for k=1:d
        FRbar(Tpos+1:end)=FRbar(Tpos+1:end)+ px(i)*nchoosek(d,k)*Fbar(Tpos)^(d-k)*squeeze(BxwT(i,Tpos+1:end))'.^k;
    end
end
MRT=trapz(FRbar)*w_range(2);
end