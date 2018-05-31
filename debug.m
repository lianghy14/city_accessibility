xlim([-size_net-1 size_net+1]);
ylim([-size_net-1 size_net+1]);
for i = 1:size(boundary_0,1)
    line(point_0(boundary_0(i,1:2),1),point_0(boundary_0(i,1:2),2),'LineWidth',0.5);
    hold on;
end
mark = plot(point_0(i_OD_0,1),point_0(i_OD_0,2),'rs','Markerfacecolor','r');hold on;
for i = 1:size(i_OD_0)
    text(point_0(i_OD_0(i),1),point_0(i_OD_0(i),2),num2str(i),'fontsize',20);hold on;
end;
hold off