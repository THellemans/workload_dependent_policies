%% Plot ifo k
close all
h=figure;
marker_list=['d','x','o','+'];
line_list={'-','--','-.',':'};
load num2.mat
for i=1:4
    plot(k_iter, MRT_holder(i,:), 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6)
    hold on
end
legend({'$SCV=1/2$','$SCV=1$','$SCV=5$','$SCV=10$'},'Interpreter','latex','Location','northwest')
xlabel('$k$','Interpreter','latex')
ylabel('$E[R]$','Interpreter','latex')
ylim([0,3])
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_ifo_k_LLdk.pdf')),'-dpdf','-r0')