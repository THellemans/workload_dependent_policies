function [ cdf ] = erlang_cdf(x, k, lam)
%

if x==Inf
    cdf=1;
	return
end

ccdf=zeros(1,length(x));
for kk=0:(k-1)
    ccdf=ccdf+((lam*x).^kk .* exp(-lam .* x))/(factorial(kk));
end
cdf=1-ccdf;
end