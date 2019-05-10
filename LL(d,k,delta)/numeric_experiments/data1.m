% Here we analyze LL(d,k,\delta) in a model with job size X which is then
% split into (X/k,...,X/k).

addpath('../../generally_applicable_code')
addpath('../general_functions')

dists={'Erlang','Exp','HExp','HExp'};
SCV=[1/2, 1, 5, 10];
lam=0.8; d=20; delta=0.01; w_range=linspace(0,500,10^6);
addpath('../generally_applicable_code')

k_iter=1:20;
MRT_holder=zeros(length(dists), length(k_iter));
for j=1:length(dists)
    for i=1:length(k_iter)
        k=k_iter(i);
        if strcmp(dists{j},'Erlang')
            Gbar=1-erlang_cdf(k*w_range, 2, 2);
            g=erlang_pdf(k*w_range, 2, 2)*k;
            alpha=[1 0];
            A=[-2 2;0 -2]*k;
        elseif strcmp(dists{j},'Exp')
            Gbar=exp(-k*w_range);
            g=exp(-k*w_range)*k;
            alpha=1;
            A=-k;
        elseif strcmp(dists{j},'HExp')
            [ alpha, A ] = hyperexponential_init_alphaA( 1, SCV(j), 1/2 );
            A=A*k;
            Gbar=1-hyperexponential_cdf( alpha, A, w_range );
            [ g ] = hyperexponential_pdf( alpha, A, w_range );
        end
        [ Fbar, w_range_loc, flag ] = fixed_point_PHD( lam, d, k, delta, alpha, A, Gbar, w_range );
        [MRT_holder(j,i), ~] = MRT_split_jobs( d, k, delta, Gbar, g, w_range_loc, Fbar );
    end
end
save('plot_ifo_k.mat', 'MRT_holder', 'k_iter')