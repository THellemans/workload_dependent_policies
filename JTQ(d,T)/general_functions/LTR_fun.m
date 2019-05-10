function [Fbar_new, AwT, FRXbar] = LTR_fun( Fbar0, T, lam, d, Gbar, g, w_range, Fbar, tol )
%
if ~exist('tol','var')
    tol=10^(-8);
end

if ~exist('Fbar','var')
    Fbar=Gbar;
end

old_error=0;
Fbar_old=Fbar;
while true
    Fbar_old=Fbar0-(Fbar0/Fbar_old(1))*(Fbar_old(1)-Fbar_old);
    Fbar_old=Fbar0*(Fbar_old-Fbar_old(end))/(Fbar0-Fbar_old(end));
    [Fbar_new, AwT, FRXbar] = T_fun( T, lam, d, Gbar, g, w_range, Fbar_old );
    if max(abs(Fbar_new-Fbar_old))<tol
        break
    elseif abs(old_error-max(abs(Fbar_new-Fbar_old)))<10^(-14)
        break
    end
    old_error=max(abs(Fbar_new-Fbar_old));
    Fbar_old=Fbar_new;
end
end