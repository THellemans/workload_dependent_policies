%% Plot for ifo d
load('num1.mat')
close all
h=figure;
marker_list=['d','x','o','+'];
line_list={'-','--','-.',':'};
for i=1:4
    plot(q_iter, lam_max(:,i).*(1+q_iter'), 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6,'MarkerIndices',1:5:length(q_iter))
    hold on
end
legend({'$SCV=1/2$','$SCV=1$','$SCV=2$','$SCV=3$'},'Interpreter','latex','Location','northwest')
xlabel('$q$','Interpreter','latex')
ylabel('$\lambda_{\max} \cdot E[\tilde{X}]$','Interpreter','latex')
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_ifo_q_Reddk_diffSCV.pdf')),'-dpdf','-r0')    