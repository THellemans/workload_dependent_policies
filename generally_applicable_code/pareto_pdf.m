function [ y ] = pareto_pdf(x, lb, ub, alpha)
%

if length(x)==1
	if x <= lb || x >= ub
		y=0;
	else
		y=(alpha.*lb.^alpha.*x.^(-alpha-1))./(1-(lb./ub).^alpha);
	end
	return
end

y=x;
y(y>=ub)=0;
y(y<=lb)=0;
between=(x > lb) & (x < ub);
y(between)=(alpha.*lb.^alpha.*x(between).^(-alpha-1))./(1-(lb./ub).^alpha);
dx=x(2)-x(1);
if abs(trapz(y)*dx-1) > 0.05
    y=y/(trapz(y)*dx);
end

end