function [y] = pareto_cdf(x, lb, ub, alpha)
%

if length(x)==1
	if x <= lb
		y=0;
	elseif x >= ub
		y=1;
	else
		y=(1-lb.^alpha.*x.^(-alpha))/(1-(lb/ub).^alpha);
	end
	return
end

y=x;
y(y>=ub)=1;
y(y<=lb)=0;
between=(x > lb) & (x < ub);
y(between)=(1-lb.^alpha.*x(between).^(-alpha))/(1-(lb/ub).^alpha);

end

