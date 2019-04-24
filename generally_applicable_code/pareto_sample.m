function [ x ] = pareto_sample(n, lb, ub, alpha)
%

U=rand(n,1);
%x=(-(U.*ub.^alpha-U.*lb.^alpha-ub.^alpha)./(ub.^alpha*lb.^alpha)).^(-1./alpha);
x= (-(U .*(1-(lb/ub).^alpha)-1)./(lb.^alpha)).^(-1/alpha);

end

