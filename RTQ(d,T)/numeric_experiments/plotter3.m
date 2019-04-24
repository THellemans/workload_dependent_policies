%% Plot for ifo d
load num3.mat
close all
h=figure
marker_list=['d','x','o','+','s'];
line_list={'-','--','-.',':','-'};
%%%%%%%%%%%%% this changes
for i=1:5
    plot(lam_iter(1:length(MRT(i,:)))*1.2, MRT(i,:), 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6, 'MarkerIndices', 1:6:length(MRT(i,:)))
    hold on
end
xlim([0,1])
ylim([0.5,10])
legend({'T=0','$T=1/2$','$T=1$','$T=2$','$T=3$'},'Interpreter','latex','Location','northwest')
xlabel('$\lambda \cdot E[\tilde X]$','Interpreter','latex')
ylabel('$E[R]$','Interpreter','latex')
%%%%%%%%%%%%%%%
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_MRT_RTQdT.pdf')),'-dpdf','-r0')    