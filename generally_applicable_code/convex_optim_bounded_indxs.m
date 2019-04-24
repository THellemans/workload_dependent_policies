function [ optimal_x ] = convex_optim_bounded_indxs( f, lb, ub, s_range, tolX )
%

lb_indx=find(s_range<lb, 1, 'last' );
ub_indx=find(s_range<ub, 1, 'last' );
while (s_range(ub_indx)-s_range(lb_indx)) > tolX
	middle_indx=round((lb_indx+ub_indx)/2); right_indx=middle_indx+2;
	fx_middle=f(s_range(middle_indx)); fx_right=f(s_range(right_indx));
	if fx_middle<fx_right
		ub_indx=middle_indx;
	else
		lb_indx=middle_indx;
	end
end
optimal_x=s_range(middle_indx);
end