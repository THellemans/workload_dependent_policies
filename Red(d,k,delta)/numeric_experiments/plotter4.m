%% Plot for ifo d
load('num4.mat')
MRT(1,1)=1;
close all
h=figure;
marker_list=['d','x','o','+','s'];
line_list={'-','--','-.',':','-'};
%%%%%%%%%%%%% this changes
for i=1:4
    plot(linspace(0,lam_max(i),nlam), MRT(i,:), 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6,'MarkerIndices',1:5:nlam)
    hold on
end
legend({'$k=1$','$k=2$','$k=3$','$k=4$'},'Interpreter','latex','Location','northwest')
xlabel('$\lambda$','Interpreter','latex')
ylabel('$E[R]$','Interpreter','latex')
ylim([0,3])
%%%%%%%%%%%%%%%
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_ifo_lam_Reddk_diffk.pdf')),'-dpdf','-r0')    