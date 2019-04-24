function [gSX,GSXbar,Fbargx_inv,fgx_inv] = g_dists(Fbar_S, q, f_X, x_X, X_cont, w_range)
%

dw=w_range(2)-w_range(1);
Fbargx_inv=zeros(length(w_range), length(x_X));
for i=1:length(x_X)
    w_range_loc=max(0, (w_range-x_X(i))./(x_X(i)));
    %Fbargx_inv(w_range_loc==0,i)=(1-q);
    %Fbargx_inv(:,i)=Fbargx_inv(:,i)+q*Fbar_S(w_range_loc).';
    Fbargx_inv(:,i)=Fbargx_inv(:,i)+Fbar_S(w_range_loc).';
end
GSXbar=zeros(size(w_range));
to_definegSX=zeros(size(w_range));
if X_cont
    dx=x_X(2)-x_X(1);
    Fbarx_onx=1-dx*cumtrapz(f_X);
    Fbarx_onw=zeros(size(GSXbar));
    Fbarx_onw(w_range<=x_X(1))=1;
    Fbarx_onw(w_range>x_X(end))=0;
    for i=1:length(x_X)-1
        Fbarx_onw(x_X(i)<w_range & x_X(i+1)>= w_range)=Fbarx_onx(i);
    end
    for i=1:length(w_range)
        GSXbar(i)=q*dx*trapz(f_X.*Fbargx_inv(i,:));
    end
    GSXbar=GSXbar+(1-q)*Fbarx_onw;
else
    for i =1:length(f_X)
        temp=ones(size(GSXbar));
        temp(x_X(i)<w_range)=0;
        GSXbar=GSXbar+q*f_X(i)*Fbargx_inv(:,i)'+(1-q)*f_X(i)*temp;
        to_definegSX=to_definegSX+f_X(i)*min(q,Fbargx_inv(:,i)');
    end
end
gSX=[(to_definegSX(1:end-1)-to_definegSX(2:end)) 0]/dw;
fgx_inv=[(Fbargx_inv(1:end-1,:)-Fbargx_inv(2:end,:))/dw; zeros(1,size(Fbargx_inv,2))];
Fbargx_inv=Fbargx_inv';
fgx_inv=fgx_inv';
end