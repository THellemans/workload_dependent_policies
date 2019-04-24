function [ Fbar, w_range, flag ] = fixed_point_PHD( lam, d, k, delta, alpha, A, Gbar, w_range )
%

flag=false;
mu=-A*ones(length(A),1);
Fbar=zeros(length(w_range), 1);
H=zeros(size(Fbar));
Fbar(1)=-lam*k*alpha*pinv(A)*ones(length(alpha),1)+lam*d*delta;
if Fbar(1)>=1
    flag=true;
    return
end
xi=zeros(length(alpha), length(w_range));
delta_indx=find(w_range<delta, 1, 'last' );
if isempty(delta_indx)
    delta_indx=0;
end
dw=w_range(2)-w_range(1);
lamddw=lam*d*dw;
lamdw=lam*dw; 
for i=1:delta_indx
    Fbar(i+1)=Fbar(i)-lamddw*(1-Fbar(i));
end
for j=1:d
    H(1:delta_indx+1)=H(1:delta_indx+1)+min(j,k)*nchoosek(d,j)*Fbar(1:delta_indx+1).^(d-j).*(1-Fbar(1:delta_indx+1)).^j;
end
H(1:delta_indx+1)=H(1:delta_indx+1)-1;
for i=delta_indx+1:length(w_range)-1
    ixi=i-delta_indx;
    Fbar(i+1)=Fbar(i)-lamddw*(Fbar(i-delta_indx)-Fbar(i))-lamdw*(Gbar(ixi)+H(ixi)-alpha*xi(:,ixi));
    for j=1:d
        H(i+1)=H(i+1)+min(j,k)*nchoosek(d,j)*Fbar(i+1)^(d-j)*(1-Fbar(i+1))^j;
    end
    H(i+1)=H(i+1)-1;
    xi(:,ixi+1)=xi(:,ixi)+dw*(mu*H(ixi)+A*xi(:,ixi));
    if Fbar(i)<10^(-8)
        Fbar=Fbar(1:i);
        w_range=w_range(1:i);
        return
    end
end

end