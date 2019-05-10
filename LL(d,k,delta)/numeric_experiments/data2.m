% Here we analyze LL(d,k,\delta) in a model with job size X which is then
% split into (X/k,...,X/k).

addpath('../../generally_applicable_code')
addpath('../general_functions')

dists={'Erlang','Exp','HExp','HExp'};
SCV=[1/2, 1, 5, 10];
lam=0.799; k=1; delta=0.01; w_range=linspace(0,500,10^6);
addpath('../generally_applicable_code')

d_iter=2:24;
MRT_holder=zeros(length(dists), length(d_iter));
for j=1:length(dists)
    if strcmp(dists{j},'Erlang')
        Gbar=1-erlang_cdf(w_range, 2, 2);
        g=erlang_pdf(w_range, 2, 2);
        alpha=[1 0];
        A=[-2 2;0 -2];
    elseif strcmp(dists{j},'Exp')
        Gbar=exp(-w_range);
        g=exp(-w_range);
        alpha=1;
        A=-1;
    elseif strcmp(dists{j},'HExp')
        [ alpha, A ] = hyperexponential_init_alphaA( 1, SCV(j), 1/2 );
        Gbar=1-hyperexponential_cdf( alpha, A, w_range );
        [ g ] = hyperexponential_pdf( alpha, A, w_range );
    end
    for i=1:length(d_iter)
        d=d_iter(i);
        [ Fbar, w_range_loc, flag ] = fixed_point_PHD( lam, d, k, delta, alpha, A, Gbar, w_range );
        if flag
            d_iter=d_iter(1:i-1);
            MRT_holder=MRT_holder(:,1:i-1);
            break
        end
        [MRT_holder(j,i), ~] = MRT_split_jobs( d, k, delta, Gbar, g, w_range_loc, Fbar );
    end
end
save('plot_ifo_d.mat', 'MRT_holder', 'd_iter')