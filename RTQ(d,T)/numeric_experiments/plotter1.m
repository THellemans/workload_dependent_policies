%% Plot for ifo d
load num1_backup.mat
Fbar0_holder(Fbar0_holder==0)=1;
close all
h=figure
marker_list=['d','x','o','+'];
line_list={'-','--','-.',':'};
%%%%%%%%%%%%% this changes
for i=1:4
    plot(lam_iter(1:length(Fbar0_holder(i,:)))*1.2, Fbar0_holder(i,:), 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6, 'MarkerIndices', 1:10:length(Fbar0_holder(i,:)))
    hold on
end
xlim([0,1])
legend({'$d=2$','$d=3$','$d=4$','$d=5$'},'Interpreter','latex','Location','northwest')
xlabel('$\lambda \cdot E[\tilde X]$','Interpreter','latex')
ylabel('$\bar F(0)$','Interpreter','latex')
%%%%%%%%%%%%%%%
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_Fbar0_RTQdT.pdf')),'-dpdf','-r0')    