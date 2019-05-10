%% Plot for ifo d
close all
h=figure;
marker_list=['d','x','o','+'];
line_list={'-','--','-.',':'};
load num1.mat
for i=1:4
    plot(d_iter(1:end-1), MRT_holder(i,1:end-1), 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6)
    hold on
end
legend({'$SCV=1/2$','$SCV=1$','$SCV=5$','$SCV=10$'},'Interpreter','latex','Location','northeast')
xlabel('$d$','Interpreter','latex')
ylabel('$E[R]$','Interpreter','latex')
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_ifo_d_LLdk.pdf')),'-dpdf','-r0')