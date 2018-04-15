tic
digits(8);
size_net = 2;
div = 2;
mode = 1; % 1:vehicle; 0:cycling
flow_OD = 0.6; % OD flow
i_OD_number = 5; % initial size of OD
wid_cross = 0.1; % wid_cross/l_roads

%[point,boundary] = network_gen(size_net,div,mode,wid_cross);
%[OD,i_OD] = OD_gen(point,size_net,div,flow_OD,i_OD_number);
%[f,fval,sum_f] = road_solver(point,boundary,OD,i_OD,i_OD,mode);time_cal = toc; % road solver
map = map_plot_fun(div,size_net,wid_cross,point,boundary,sum_f);

figure(1)
xlim([-size_net-1 size_net+1]);
ylim([-size_net-1 size_net+1]);
for i = 1:size(boundary,1)
    line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'LineWidth',3*sum_f(i));
    hold on;
end
mark = plot(point(i_OD,1),point(i_OD,2),'rs');hold on;
hold off

figure(2)

map_x = (-size_net + size_net/div/2) : (size_net/div) : (size_net - size_net/div/2);
map_y = (-size_net + size_net/div/2) : (size_net/div) : (size_net - size_net/div/2);
[map_X,map_Y] = meshgrid(map_x,map_y);
[map_xx,map_yy] = meshgrid((-size_net + size_net/div/2):(size_net/div/20):(size_net - size_net/div/2),(-size_net + size_net/div/2):(size_net/div/20):(size_net - size_net/div/2));
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
fprintf('%d OD nodes:',size(i_OD,1));
disp(i_OD');

