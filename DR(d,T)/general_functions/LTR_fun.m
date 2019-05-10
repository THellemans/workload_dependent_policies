function [ Fbar_new, FbarRx ] = LTR_fun( T, lam, d, px, xx, w_range, fgx_inv, FbarSgxinv, tol1, tol2, Fbar_guess )
%Perform the fixed point iteration assuming that F0 is unknown.

if ~exist('Fbar_guess','var')
    Fbar_guess = "not_given";
end

if strcmp(Fbar_guess,"not_given")
    Fbar=exp(-w_range);
else
    Fbar=Fbar_guess;
end

Fbar0max=1; Fbar0min=0;
Fbar_old=Fbar;
Fbar_new=zeros(size(Fbar_old));
Fbar0min=0;
Fbar0max=1;
found_something=false;
while (Fbar0max-Fbar0min > tol2)
    Fbar0=(Fbar0min+Fbar0max)/2;
    while true
        [Fbar_new, FbarRx]=T_fun( Fbar0, T, lam, d, px, xx, w_range, fgx_inv, FbarSgxinv, Fbar_old );
        %first_negative=find(Fbar_new<0, 1 );
        %most_negative=min(Fbar_new);
        %Fbar_new(first_negative:end)=0;
        if (max(abs(Fbar_old-Fbar_new))<abs(Fbar_new(end)/10)) || max(abs(Fbar_old-Fbar_new))<tol1 || (Fbar_new(end) < -1)
            if (max(abs(Fbar_old-Fbar_new))<abs(Fbar_new(end)/10))
                found_something=true;
            end
            break
        end
        Fbar_old=Fbar_new;
    end
    fprintf('Fbar(0)=%f\n Fbar(end)=%f\n--------------\n', Fbar0, Fbar_new(end))
    if (Fbar_new(end) < 0)
        Fbar0min=Fbar0;
    else
        Fbar0max=Fbar0;
    end
    if ~found_something
        Fbar_old=Fbar_guess;
    end
end
end