function [figure1] = figure_display(size_net,div,boundary,point,i_OD,sum_f,map)

figure1 = figure();
set(figure1,'units','normalized','position', [0.1 0.2 0.8 0.53]);
subplot(1,2,1);
xlim([-size_net-1 size_net+1]);
ylim([-size_net-1 size_net+1]);
for i = 1:size(boundary,1)
    line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'LineWidth',3*sum_f(i));
%     x = point(boundary(i,1),1)-point(boundary(i,2),1);
%     y = point(boundary(i,1),2)-point(boundary(i,2),2);
%     l = (x^2 + y^2)^0.5;
%     if l >= 0.5
%         text((point(boundary(i,1),1)+point(boundary(i,2),1))./2,(point(boundary(i,1),2)+point(boundary(i,2),2))./2,num2str(sum_f(i),'%.2f'));
%     end;
    hold on;
end

mark = plot(point(i_OD,1),point(i_OD,2),'rs','Markerfacecolor','r');hold on;
for i = 1:size(i_OD)
    text(point(i_OD(i),1),point(i_OD(i),2),num2str(i),'fontsize',20);hold on;
end;
hold off

subplot(1,2,2);
map_x = (-size_net - size_net/div/2) : (size_net/div) : (size_net + size_net/div/2);
map_y = (-size_net - size_net/div/2) : (size_net/div) : (size_net + size_net/div/2);
[map_X,map_Y] = meshgrid(map_x,map_y);
[map_xx,map_yy] = meshgrid((-size_net):(size_net/div/20):(size_net),(-size_net):(size_net/div/20):(size_net));
map_int = interp2(map_X,map_Y,map,map_xx,map_yy,'cubic');
h = pcolor(map_xx,map_yy,map_int);hold on;
set(h,'edgecolor','none','facecolor','interp');
for i = 1:size(boundary,1)
    line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'LineWidth',0.2);
    hold on;
end
mark = plot(point(i_OD,1),point(i_OD,2),'rs','Markerfacecolor','r');hold on;
xlim([-size_net-1 size_net+1]);
ylim([-size_net-1 size_net+1]);
hold off

end