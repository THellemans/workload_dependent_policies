function [ lam_max ] = find_lam_max( T, Fbar0, d, px, xx, w_range, fgx_inv, FbarSgxinv, tol1, tol2, Fbar_guess )
%Perform the fixed point iteration assuming that F0 is unknown.

if ~exist('Fbar_guess','var')
    Fbar_guess = "not_given";
end

if strcmp(Fbar_guess,"not_given")
    Fbar=exp(-w_range);
else
    Fbar=Fbar_guess;
end

Fbar_old=Fbar;
Fbar_new=zeros(size(Fbar_old));
lam_min=0;
lam_max=1;
while (lam_max-lam_min > tol2)
    lam=(lam_min+lam_max)/2;
    while true
        Fbar_new=T_fun( Fbar0, T, lam, d, px, xx, w_range, fgx_inv, FbarSgxinv, Fbar_old );
        if (max(abs(Fbar_old-Fbar_new))<abs(Fbar_new(end)/10)) || (Fbar_new(end) < -1)
            break
        end
        Fbar_old=Fbar_new;
    end
    fprintf('lam=%f\n Fbar(end)=%f\n--------------\n', lam, Fbar_new(end))
    if (Fbar_new(end) < 0)
        lam_max=lam;
    else
        lam_min=lam;
    end
end
end