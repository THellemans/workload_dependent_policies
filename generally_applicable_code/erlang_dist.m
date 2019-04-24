function [ ccdf, pdf ] = erlang_dist(x, k, lam)
%

pdf=(lam^k .* x.^(k-1) .* exp(-lam.*x)) / (factorial(k-1));
ccdf=zeros(1,length(x));
for kk=0:(k-1)
    ccdf=ccdf+((lam*x).^kk .* exp(-lam .* x))/(factorial(kk));
end

end