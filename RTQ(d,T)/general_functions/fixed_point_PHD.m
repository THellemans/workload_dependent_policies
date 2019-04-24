function [ Fbar, w_range, FbarRx, BxwT ] = fixed_point_PHD( Fbar0, lam, d, T, q, alpha, A, Fbargx_inv,  px, xx, w_range )
% g(S,X)=(S+1)X, S PHD kans q en 0 met kans 1-q.
N_S=length(alpha);
mu=-A*ones(N_S,1);
N_x=length(px);
xpos=xx;
for i=1:length(xpos)
    xpos(i)=find(w_range<xx(i), 1, 'last' );
end
Tpos=find(w_range<T, 1, 'last' );
dw=w_range(2)-w_range(1);
N=length(w_range);
Fbar=zeros(1,N);
Fbar(1)=Fbar0;
FbarRx=zeros(N,N_x);
lamddw=lam*d*dw;
lamdw=lam*dw;
xi=zeros(N_S, N_x, N);
phi=zeros(N_S, N_x, N);
BxwT=zeros(N_x, N);
first_time_cross_T=true;
for n=1:(N-1)
    if n ==Tpos+10
        a=1;
    end
    Fbar(n+1)=Fbar(n);
    %Update FbarRx
    for i=1:N_x
        if n<=xpos(i)
            FbarRx(n,i)=1;
        else
            FbarRx(n,i)=(1-q)*Fbar(n-xpos(i))+q*(Fbargx_inv(i,n)+alpha*xi(:,i,n)/xx(i));
            xi(:,i,n+1)=xi(:,i,n)+dw*(Fbar(n-xpos(i))*mu+A*xi(:,i,n)/xx(i));
        end
    end
    %Update phi
    if Tpos <n
        if first_time_cross_T
            first_time_cross_T=false;
            for i=1:N_x
                for m=1:n
                    if xpos(i)< m
                        phi(:,i,m+1)=phi(:,i,m)+dw*((Fbar(m-xpos(i))-Fbar(Tpos))*mu+A*phi(:,i,m)./xx(i));
                    end
                end
            end
            for i=1:N_x
                for m=1:n
                    BxwT(i,m)=(1-Fbar(Tpos))*(q*Fbargx_inv(i,m))+q*alpha*phi(:,i,m)/xx(i);
                    if m<= xpos(i)
                        BxwT(i,m)=BxwT(i,m)+(1-q)*(1-Fbar(Tpos));
                    elseif m<= xpos(i)+Tpos
                        BxwT(i,m)=BxwT(i,m)+(1-q)*(Fbar(m-xpos(i))-Fbar(Tpos));
                    end
                end
            end
        else
            for i=1:N_x
                if xpos(i)< n && n <= xpos(i) + Tpos
                    phi(:,i,n+1)=phi(:,i,n)+dw*((Fbar(n-xpos(i))-Fbar(Tpos))*mu+A*phi(:,i,n)./xx(i));
                elseif xpos(i) + Tpos < n
                    phi(:,i,n+1)=phi(:,i,n)+dw*(A*phi(:,i,n))/xx(i);
                end
            end
        end
    end
    %Update B_x(w,T)
    if n > Tpos
        for i=1:N_x
            BxwT(i,n)=(1-Fbar(Tpos))*(q*Fbargx_inv(i,n))+q*alpha*phi(:,i,n)/xx(i);
            if n<= xpos(i)
                BxwT(i,n)=BxwT(i,n)+(1-q)*(1-Fbar(Tpos));
            elseif n<= xpos(i)+Tpos
                BxwT(i,n)=BxwT(i,n)+(1-q)*(Fbar(n-xpos(i))-Fbar(Tpos));
            end
        end
    end
    % Update Fbar
    if n <= Tpos
        for i=1:N_x
            Fbar(n+1)=Fbar(n+1)-lamddw*px(i)*FbarRx(n,i)^(d-1)*(FbarRx(n,i)-Fbar(n));
        end
    else
        for i=1:N_x
            Fbar(n+1)=Fbar(n+1)-lamddw*px(i)*(BxwT(i,n)*(Fbar(Tpos)+BxwT(i,n))^(d-1))-...
                lamdw*px(i)*(FbarRx(n,i)-Fbar(n)-BxwT(i,n))*Fbar(Tpos)^(d-1);
        end
    end
    if n>1001 && abs(Fbar(n+1)-Fbar(n-1000)) < 10^(-8)
        w_range=w_range(1:(n+1));
        Fbar=Fbar(1:(n+1));
        FbarRx=FbarRx(1:(n+1),:);
        BxwT=BxwT(:,1:(n+1));
        return
    end
    if Fbar(n+1)<-0.01
        w_range=w_range(1:(n+1));
        Fbar=Fbar(1:(n+1));
        FbarRx=FbarRx(1:(n+1),:);
        BxwT=BxwT(:,1:(n+1));
        return
    end
end

end