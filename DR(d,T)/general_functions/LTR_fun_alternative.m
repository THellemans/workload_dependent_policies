function [ Fbar ] = LTR_fun_alternative( T, lam, d, px, xx, w_range, fgx_inv, FbarSgxinv, tol1, tol2, Fbar_guess )
%Perform the fixed point iteration assuming that F0 is unknown.

if ~exist('Fbar_guess','var')
    Fbar_guess = "not_given";
end

if strcmp(Fbar_guess,"not_given")
    Fbar=exp(-w_range);
else
    Fbar=Fbar_guess;
end

diff_Fbar_Fbarold=100;
too_big_counter=0;

while diff_Fbar_Fbarold > tol1
    Fbarold=Fbar;
    fprintf('Fbar(0)=%f\n diff=%f\n--------------\n', Fbar(1), diff_Fbar_Fbarold)    
    Fbar0min=0;
    Fbar0max=1;
    while (Fbar0max-Fbar0min > tol2)
        Fbar0=(Fbar0min+Fbar0max)/2;
        [temp_Fbar] = T_fun( Fbar0, T, lam, d, px, xx, w_range, fgx_inv, FbarSgxinv, Fbar );
        if (temp_Fbar(end) < 0)
            Fbar0min=Fbar0;
        else
            Fbar0max=Fbar0;
        end
    end
    if abs(temp_Fbar(end)) > 10^(-3)
        too_big_counter=too_big_counter+1;
        if too_big_counter > 300 && (diff_Fbar_Fbarold > 10^(-2))
            Fbar="onstabiel";
            return
        end
    end
    Fbar= 1/2*Fbar + 1/2 * (temp_Fbar(1) * (temp_Fbar-temp_Fbar(end))/(temp_Fbar(1)-temp_Fbar(end)));
    diff_Fbar_Fbarold=max(abs(Fbar-Fbarold));
end

end