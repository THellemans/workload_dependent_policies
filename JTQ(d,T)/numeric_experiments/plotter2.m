%% Plot for ifo d
load num2.mat
close all
h=figure
marker_list=['d','x','o','+','s'];
line_list={'-','--','-.',':','-'};
%%%%%%%%%%%%% this changes
for i=1:4
    plot(T_iter, MRT(i,:), 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6, 'MarkerIndices', 1:6:length(MRT(i,:)))
    hold on
end

xlim([0,30])
legend({'$SCV=1/2$','$SCV=1$','$SCV=5$','$SCV=10$'},'Interpreter','latex','Location','north')
xlabel('$T$','Interpreter','latex')
ylabel('$E[R]$','Interpreter','latex')
%%%%%%%%%%%%%%%
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_MRT_ifoT_JTQ_diffdists.pdf')),'-dpdf','-r0')