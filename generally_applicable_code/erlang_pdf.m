function [ pdf ] = erlang_pdf(x, k, lam)
%

pdf=(lam^k .* x.^(k-1) .* exp(-lam.*x)) / (factorial(k-1));

end