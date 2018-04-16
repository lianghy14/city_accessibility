
digits(8);
size_net = 2;
div = 2;
flow_OD = 0.6; % OD flow
i_OD_number = 5; % initial size of OD
wid_cross = 0.1; % wid_cross/l_roads

tic
mode = 0; %  0:cycling; 1:vehicle;
f0 = f_0;
%[point_0,boundary_0] = network_gen(size_net,div,mode,wid_cross);
%[OD_0,i_OD_0] = OD_gen(point_0,size_net,div,flow_OD,i_OD_number);
%[f_0,fval_0,sum_f_0] = road_solver(point_0,boundary_0,OD_0,i_OD_0,i_OD_0,mode,f0);time_cal_0 = toc; % road solver
map_0 = map_plot_fun(div,size_net,wid_cross,point_0,boundary_0,sum_f_0);
[figure_0_1,figure_0_2] = figure_display(size_net,div,boundary_0,point_0,i_OD_0,sum_f_0,map_0);
fprintf('%d OD nodes cycling:',size(i_OD_0,1));
disp(i_OD_0');

tic
mode = 1; %  0:cycling; 1:vehicle;
f1 = f_1;
%[point_1,boundary_1] = network_gen(size_net,div,mode,wid_cross);
%[OD_1,i_OD_1] = OD_gen(point_1,size_net,div,flow_OD,i_OD_number);
%[f_1,fval_1,sum_f_1] = road_solver(point_1,boundary_1,OD_1,i_OD_1,i_OD_1,mode,f1);time_cal_1 = toc; % road solver
map_1 = map_plot_fun(div,size_net,wid_cross,point_1,boundary_1,sum_f_1);
[figure_1_1,figure_1_2] = figure_display(size_net,div,boundary_1,point_1,i_OD_1,sum_f_1,map_1);
fprintf('%d OD nodes vehicle:',size(i_OD_1,1));
disp(i_OD_1');

