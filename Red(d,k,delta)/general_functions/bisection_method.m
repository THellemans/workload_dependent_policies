function [ x ] = bisection_method(f,lb,ub,tol)
%

while (ub-lb > tol)
    x=(lb+ub)/2
    fx=f(x);
    if (fx < 0 || isnan(fx))
        lb=x;
    else
        ub=x;
    end
end
end