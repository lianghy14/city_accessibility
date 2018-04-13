size_net = 2;
div = 2;
mode = 1;% 1:vehicle; 0:cycling

OD = [1,1,1;1,1,1;1,1,1];
i_in = [10,20,30];
i_out = [25,40,60];

[point,boundary] = network_gen(size_net,div,mode);
%[f,fval,sum_f] = road_solver(point,boundary,OD,i_in,i_out); % road solver

for i = 1:size(boundary,1)
    line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'LineWidth',5*sum_f(i));
    hold on;
    %line(p(b(i,1:2),1),p(b(i,1:2),2),'LineWidth',f(6*N2+i));
end

mark_in = plot(point(i_in,1),point(i_in,2),'r^');hold on;
mark_out = plot(point(i_out,1),point(i_out,2),'rs');hold on;
legend([mark_in,mark_out],'Origin','Destination')
xlim([-size_net-1 size_net+1]);
ylim([-size_net-1 size_net+1]);
hold off