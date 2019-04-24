function [ alpha, A ] = hyperexponential_init_alphaA( EX, SCV, f )
%

[ p, mu ] = hyperexponential_init( EX, SCV, f );
alpha=[p 1-p];
A=[-mu(1), 0; 0, -mu(2)];

end