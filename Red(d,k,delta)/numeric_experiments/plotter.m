%% Plot for ifo d
load num2.mat
close all
h=figure
marker_list=['d','x','o','+'];
line_list={'-','--','-.',':'};
%%%%%%%%%%%%% this changes
load plot_ifo_d.mat
for i=1:4
    plot(q_iter, lam_max(:,i).*EgSX, 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6)
    hold on
end
legend({'$d=2$','$d=3$','$d=4$','$d=5$'},'Interpreter','latex','Location','northeast')
xlabel('$q$','Interpreter','latex')
ylabel('$\lambda_{\max} \cdot \E[\tilde X]$','Interpreter','latex')
%%%%%%%%%%%%%%%
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_ifo_q_Reddk.pdf')),'-dpdf','-r0')    