function [ lam_max ] = find_lam_max_PHD( Fbar0, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, tolX ,lb, ub )
%

indx_last=@(x) x(length(x));
fun=@(lam) -indx_last(fixed_point_PHD( Fbar0, lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range ));
lam_max=bisection_method(fun,lb,ub,tolX);

end

