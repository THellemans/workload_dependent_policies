lam=0.9; d=4; k=3; delta=0.02; alpha=1; A=-1; w_range=linspace(0,100,10^5); Gbar=exp(-w_range); g=exp(-w_range);


[ Fbar1, w_range1 ] = fixed_point_PHD( lam, d, k, delta, alpha, A, Gbar, w_range );
[ Fbar2, w_range2 ] = fixed_point_IDE( lam, d, k, delta, g, Gbar, w_range );