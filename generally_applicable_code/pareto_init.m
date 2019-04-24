function [ lb, ub ] = pareto_init(EX, SCV, alpha)
%

fun= @(lbub) abs(pareto_moment(1,lbub(1),lbub(2),alpha)-EX) + abs(pareto_scv(lbub(1),lbub(2),alpha)-SCV);
A=[1 -1; -1 0];
b=[0; 0];
lbub = fmincon(fun, [1 12*SCV], A, b);
lb = lbub(1);
ub = lbub(2);
if fun(lbub) < 10^(-4)
    filename=strcat('BPSCV',int2str(SCV),'alpha',string(alpha),'.mat');
    save(filename,'alpha','lb','ub','SCV','EX')
end