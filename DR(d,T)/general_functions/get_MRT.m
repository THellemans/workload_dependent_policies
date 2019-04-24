function [ Fbar, w_range, FRbar, MRT ] = get_MRT( T, lam, d, px, xx, w_range, fgx_inv, FbarSgxinv, tol1, tol2, Fbar_guess )
%Perform the fixed point iteration assuming that F0 is unknown.

if ~exist('Fbar_guess','var')
    Fbar_guess = "not_given";
end

if strcmp(Fbar_guess,"not_given")
    Fbar_guess=exp(-w_range);
end

if ~exist('tol1','var')
    tol1=10^(-8);
end
if ~exist('tol2','var')
    tol2=10^(-8);
end

[Fbar, FbarRx]=LTR_fun( T, lam, d, px, xx, w_range, fgx_inv, FbarSgxinv, tol1, tol2, Fbar_guess );
FbarRx=min(1,FbarRx(:,1:length(w_range)));
[FRbar, MRT] = Fbar_to_FRbar( T, d, px, xx, w_range, fgx_inv, FbarSgxinv, Fbar, FbarRx );

end