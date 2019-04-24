function [Fbar, w_range] = fixed_point_IDE( lam, d, k, delta, g, Gbar, w_range )
%
dw=w_range(2)-w_range(1);
N=length(w_range);

Fbar=zeros(N, 1);
H=zeros(size(Fbar));
Fbar(1)=lam*k*dw*trapz(Gbar)+lam*d*delta;
delta_indx=find(w_range<delta, 1, 'last' );
if isempty(delta_indx)
    delta_indx=0;
end
lamddw=lam*d*dw;
lamdw2=lam*dw^2;
lamdw=lam*dw;
grev=fliplr(g);
for i=1:delta_indx
    Fbar(i+1)=Fbar(i)-lamddw*(1-Fbar(i));
end
for j=1:d
    H(1:delta_indx+1)=H(1:delta_indx+1)+min(j,k)*nchoosek(d,j)*Fbar(1:delta_indx+1).^(d-j).*(1-Fbar(1:delta_indx+1)).^j;
end
H(1:delta_indx+1)=H(1:delta_indx+1)-1;
for i=delta_indx+1:N-1
    imin=i-delta_indx;
    Fbar(i+1)=Fbar(i)-lamddw*(Fbar(imin)-Fbar(i))-lamdw*(Gbar(imin)+H(imin)-dw*dot(H(1:imin),grev(N-imin+1:N))); %trapezoidal rule
    Fbar(i+1)=Fbar(i+1)-lamdw2*(H(1)*g(imin)+H(imin)*g(1))/2;
    for j=1:d
        H(i+1)=H(i+1)+min(j,k)*nchoosek(d,j)*Fbar(i+1)^(d-j)*(1-Fbar(i+1))^j;
    end
    H(i+1)=H(i+1)-1;
    %if Fbar(i)<10^(-8)
    %    Fbar=Fbar(1:i);
    %    w_range=w_range(1:i); %trapezoidal rule
    %    return
    %end
end
end