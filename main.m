
digits(8);
size_net = 2;
div = 2;
i_OD_number = 6; % initial size of OD
flow_OD = [0.95,0.95]/(i_OD_number-1); % OD flow
wid_cross = 0.1; % wid_cross/l_roads

tic
mode = 0; %  0:cycling; 1:vehicle;

[point_0,boundary_0] = network_gen(size_net,div,mode,wid_cross);
%[OD_0,i_OD_0] = OD_gen(point_0,size_net,div,flow_OD(mode+1),i_OD_number);
f_0 = zeros(size(boundary_0,1)*size(OD_0,1)*size(OD_0,2),1)+0.01;
sum_f_0 = zeros(size(boundary_0,1),1)+0.6;
%f0 = f_0;
%[f_0,fval_0,sum_f_0] = road_solver(point_0,boundary_0,OD_0,i_OD_0,i_OD_0,mode,f0);time_cal_0 = toc; % road solver
map_0 = map_plot_fun(div,size_net,wid_cross,point_0,boundary_0,sum_f_0);


tic
mode = 1; %  0:cycling; 1:vehicle;
% [point_1,boundary_1] = network_gen(size_net,div,mode,wid_cross);
% [OD_1,i_OD_1] = OD_gen(point_1,size_net,div,flow_OD(mode+1),i_OD_number);
% f_1 = zeros(size(boundary_1,1)*size(OD_1,1)*size(OD_1,2),1)+0.01;
% sum_f_1 = zeros(size(boundary_1,1),1)+0.6;
%f1 = f_1;
%[f_1,fval_1,sum_f_1] = road_solver(point_1,boundary_1,OD_1,i_OD_1,i_OD_1,mode,f1);time_cal_1 = toc; % road solver
map_1 = map_plot_fun(div,size_net,wid_cross,point_1,boundary_1,sum_f_1);

[figure_0] = figure_display(size_net,div,boundary_0,point_0,i_OD_0,sum_f_0,map_0);
[figure_1] = figure_display(size_net,div,boundary_1,point_1,i_OD_1,sum_f_1,map_1);
[figure_2] = figure_display(size_net,div,boundary_0,point_0,i_OD_0,sum_f_0,map_0+map_1);
saveas(figure_0,'0417figure\figure_size_2_mode_0.png');
saveas(figure_1,'0417figure\figure_size_2_mode_1.png');
saveas(figure_2,'0417figure\figure_size_2_mode_all.png');
fprintf('%d OD nodes cycling:',size(i_OD_0,1));
disp(i_OD_0');
fprintf('%d OD nodes vehicle:',size(i_OD_1,1));
disp(i_OD_1');

