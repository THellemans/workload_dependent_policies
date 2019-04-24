function [ g ] = hyperexponential_pdf( alpha, A, s_range )
%

p=alpha(1);
mu=-diag(A);
g=(p*(exppdf(s_range, 1/mu(1))) + (1-p) * (exppdf(s_range, 1/mu(2))));


end

