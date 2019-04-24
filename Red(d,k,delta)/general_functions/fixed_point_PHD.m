function [ Fbar, w_range, FbarRx ] = fixed_point_PHD( Fbar0, lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range )
% g(S,X)=(S+1)X, S PHD kans q en 0 met kans 1-q.
N_S=length(alpha);
mu=-A*ones(N_S,1);
N_x=length(px);
xpos=xx;
for i=1:length(xpos)
    xpos(i)=find(w_range<xx(i), 1, 'last' );
end
indx_delta=find(w_range<delta, 1, 'last' );
dw=w_range(2)-w_range(1);
N=length(w_range);
Fbar=zeros(1,N);
Fbar(1)=Fbar0;
FbarRx=zeros(N,N_S);
lamddw=lam*d*dw;
xi=zeros(N_S, N_x, N);
for n=1:(N-1)
    Fbar(n+1)=Fbar(n);
    for i=1:N_x
        if n<=xpos(i)
            FbarRx(n,i)=1;
        else
            FbarRx(n,i)=(1-q)*Fbar(n-xpos(i))+q*(Fbargx_inv(i,n)+alpha*xi(:,i,n)/xx(i));
            xi(:,i,n+1)=xi(:,i,n)+dw*(Fbar(n-xpos(i))*mu+A*xi(:,i,n)/xx(i));
        end
    end
    if n <= indx_delta    
        Fbar(n+1)=Fbar(n+1)-lamddw*(dot(px,FbarRx(n,:))-Fbar(n));
    else
        for i=1:N_x
            sumterm=0;
            for j=0:(k-1)
                sumterm=sumterm+nchoosek(d-1,j)*(1-FbarRx(n-indx_delta,i))^j*FbarRx(n-indx_delta,i)^(d-j-1);
            end
            Fbar(n+1)=Fbar(n+1)-lamddw*px(i)*(FbarRx(n,i)-Fbar(n))*sumterm;
        end
    end
    if n>1001 && abs(Fbar(n+1)-Fbar(n-1000)) < 10^(-8)
        w_range=w_range(1:(n+1));
        Fbar=Fbar(1:(n+1));
        FbarRx=FbarRx(1:(n+1),:);
        return
    end
    if Fbar(n+1) >= 1
        Fbar(end)=-1;
        return
    end
    if Fbar(n+1)<-0.01
        w_range=w_range(1:(n+1));
        Fbar=Fbar(1:(n+1));
        FbarRx=FbarRx(1:(n+1),:);
        return
    end
end

end