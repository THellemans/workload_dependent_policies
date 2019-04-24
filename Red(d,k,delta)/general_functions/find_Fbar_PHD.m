function [ Fbar, w_range, FbarRx ] = find_Fbar_PHD( lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range, tolX ,lb, ub )
%

indx_last=@(x) x(length(x));
fun=@(Fbar0) indx_last(fixed_point_PHD( Fbar0, lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range ));
Fbar0=bisection_method(fun,lb,ub,tolX);
[ Fbar, w_range, FbarRx ] = fixed_point_PHD( Fbar0, lam, d, k, delta, q, alpha, A, Fbargx_inv,  px, xx, w_range );

end

