function [ x ] = convex_optim_bounded( f, lb, ub, tolX )
%
if ub-lb<=tolX
    x=(lb+ub)/2;
end
while (ub-lb) > tolX
	x=(lb+ub)/2; xright=(lb+ub)/2+tolX;
	fx=f(x); fxright=f(xright);
	if fx<fxright
		ub=x;
	else
		lb=x;
	end
end
end