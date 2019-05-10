%% Plot for ifo d
load num1.mat
%FRbar{1}(1:10)=1;
close all
h=figure;
marker_list=['d','x','o','+','s'];
line_list={'-','--','-.',':','-'};
for i=1:4
    semilogy(w_range, FRbar{i}, 'k', 'LineWidth', 1.1,...
    'Marker',marker_list(i),'LineStyle', line_list{i},'MarkerSize',6, 'MarkerIndices', 1:round(length(w_range)/100):length(w_range))
    hold on
end

xlim([0,20])
legend({'$T=0$','$T=5$','$T=10$','$T=\infty$'},'Interpreter','latex','Location','northeast')
xlabel('$w$','Interpreter','latex')
ylabel('$\bar F_R(w)$','Interpreter','latex')
set(gca,'fontsize',14)
box on
set(h,'Units','Inches');
pos = get(h,'Position');
set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(h,char(strcat('plot_FRbar_diffT.pdf')),'-dpdf','-r0')