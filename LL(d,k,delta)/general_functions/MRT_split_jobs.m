function [MRT, FbarR] = MRT_split_jobs( d, k, delta, Gbar, g, w_range, Fbar )
% Here we obtain the mean response time for LL(d,k,delta) 

Gbar=Gbar(1:length(w_range));
g=g(1:length(w_range));
dw=(w_range(2)-w_range(1));
indx_delta=find(w_range<delta, 1, 'last' );
FbarR=ones(size(Fbar));
Fbark=zeros(size(Fbar));
for i=0:(k-1)
    Fbark=Fbark+nchoosek(d,i)*(1-Fbar).^i.*Fbar.^(d-i);
end
FbarR(indx_delta+1:end)=Gbar(1:(end-indx_delta))+convolution(g(1:(end-indx_delta)), Fbark(1:(end-indx_delta))',dw);
MRT=trapz(FbarR)*dw;


end