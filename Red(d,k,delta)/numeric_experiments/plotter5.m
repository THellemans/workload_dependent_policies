%% Plot for ifo d
load('num5.mat')
close all
MRT(1,1)=MRT(1,2);
h=figure;
marker_list=['d','x','o','+','s'];
line_list={'-','--','-.',':','-'};
%%%%%%%%%%%%% this changes
for i=1:3
    plot([linspace(0,lam_max(i),nlam), lam_max(i)+0.01], [MRT(i,:) 6], 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6,'MarkerIndices',1:5:nlam)
    hold on
end
legend({'$d=2, k=1$','$d=4, k=2$','$d=6, k=3$'},'Interpreter','latex','Location','northwest')
xlabel('$\lambda\cdot k \cdot E[\tilde{X}]$','Interpreter','latex')
ylabel('$E[R]$','Interpreter','latex')
ylim([0,5])
%%%%%%%%%%%%%%%
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_ifo_lam_Reddk_diffdandk.pdf')),'-dpdf','-r0')    