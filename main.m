tic
size_net = 2;
div = 2;
mode = 1; % 1:vehicle; 0:cycling
flow_OD = 0.6; % OD flow
i_OD_number = 5; % initial size of OD

[point,boundary] = network_gen(size_net,div,mode);
[OD,i_OD] = OD_gen(point,size_net,div,flow_OD,i_OD_number);

%[f,fval,sum_f] = road_solver(point,boundary,OD,i_OD,i_OD,mode); % road solver

mark = plot(point(i_OD,1),point(i_OD,2),'rs');hold on;
xlim([-size_net-1 size_net+1]);
ylim([-size_net-1 size_net+1]);


for i = 1:size(boundary,1)
    line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'LineWidth',2*sum_f(i));
    hold on;
end
hold off
toc
fprintf('%d OD nodes:',size(i_OD,1));
disp(i_OD');