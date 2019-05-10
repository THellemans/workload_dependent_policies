function [ p, mu ] = hyperexponential_init( EX, SCV, f )
%

mu(1)=(SCV+(4*f-1)+((SCV-1)*(SCV-1+8*f*(1-f)))^(1/2))/(2*EX*f*(SCV+1));
mu(2)=(SCV+(4*(1-f)-1)-((SCV-1)*(SCV-1+8*f*(1-f)))^(1/2))/(2*EX*(1-f)*(SCV+1));
p=EX*mu(1)*f;

end

