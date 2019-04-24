function [ G ] = hyperexponential_cdf( alpha, A, s_range )
%

p=alpha(1);
mu=-diag(A);
G=1-(p*(1-expcdf(s_range, 1/mu(1))) + (1-p) * (1-expcdf(s_range, 1/mu(2))));


end