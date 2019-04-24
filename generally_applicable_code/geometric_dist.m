function [ f, x ] = geometric_dist( p, tol)
%
clear f
n=1;
f(1)=(1-p);
while true
    n=n+1;
    f(n)=f(n-1)*p;
    if f(n) < tol
        break
    end
end
f=f/sum(f);
x=1:length(f);
x=x/sum(f.*x);


end

