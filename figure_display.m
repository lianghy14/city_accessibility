function [figure1,figure2] = figure_display(size_net,div,boundary,point,i_OD,sum_f,map)

figure1 = figure();
xlim([-size_net-1 size_net+1]);
ylim([-size_net-1 size_net+1]);
for i = 1:size(boundary,1)
    line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'LineWidth',3*sum_f(i));
    hold on;
end
mark = plot(point(i_OD,1),point(i_OD,2),'rs');hold on;
hold off

figure2 = figure();
map_x = (-size_net - size_net/div/2) : (size_net/div) : (size_net + size_net/div/2);
map_y = (-size_net - size_net/div/2) : (size_net/div) : (size_net + size_net/div/2);
[map_X,map_Y] = meshgrid(map_x,map_y);
[map_xx,map_yy] = meshgrid((-size_net):(size_net/div/20):(size_net),(-size_net):(size_net/div/20):(size_net));
map_int = interp2(map_X,map_Y,map,map_xx,map_yy,'cubic');
h = pcolor(map_xx,map_yy,map_int);hold on;
set(h,'edgecolor','none','facecolor','interp');
mark = plot(point(i_OD,1),point(i_OD,2),'rs');hold on;
for i = 1:size(boundary,1)
    line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'LineWidth',0.2);
    hold on;
end
xlim([-size_net-1 size_net+1]);
ylim([-size_net-1 size_net+1]);
hold off

end