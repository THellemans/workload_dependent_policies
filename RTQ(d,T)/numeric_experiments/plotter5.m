%% Plot for ifo d
load num5.mat
close all
h=figure
marker_list=['d','x','o','+','s'];
line_list={'-','--','-.',':','-'};
%%%%%%%%%%%%% this changes
for i=1:4
    plot(T_iter(1:length(MRT(i,:)))*1.2, MRT(i,:), 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6, 'MarkerIndices', 1:6:length(MRT(i,:)))
    hold on
end

legend({'$d=2$','$d=3$','$d=4$','$d=5$'},'Interpreter','latex','Location','southeast')
xlabel('$T$','Interpreter','latex')
ylabel('$E[R]$','Interpreter','latex')
xlim([0,6])
%%%%%%%%%%%%%%%
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_MRT_ifoT_RTQdT.pdf')),'-dpdf','-r0')    