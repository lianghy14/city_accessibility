


wid_r = 1;
len_r = 5;
mode = [0,1];  %1:vehicle; 0:cycling
sum_f = 0:0.02:0.98; %total flow ratio on a single road

[obj_cycling,obj_tot_cycling] = cost_flow_fun(wid_r,len_r,sum_f,mode(1));
figure(1)
subplot(2,2,1);
a1 = area(sum_f',obj_cycling');
le1 = legend('usage cost \itg_m','time cost \itg_T','comfort cost \itg_X','Location','NorthWest');
xlabel('\itf_r');
ylabel('\itg_r');
hold off

[obj_vehicle,obj_tot_vehicle] = cost_flow_fun(wid_r,len_r,sum_f,mode(2));
subplot(2,2,2)
a2 = area(sum_f',obj_vehicle');
le2 = legend('usage cost \itg_m','time cost \itg_T','comfort cost \itg_X','Location','NorthWest');
xlabel('\itf_r');
ylabel('\itg_r');
hold off

subplot(2,2,3:4)
len_r = 0.1:0.1:10;
sum_f = 0.1;
[obj_cycling,obj_tot_cycling] = cost_flow_fun(wid_r,len_r,sum_f,mode(1));
[obj_vehicle,obj_tot_vehicle] = cost_flow_fun(wid_r,len_r,sum_f,mode(2));
a3 = plot(len_r,obj_tot_cycling,'g-',len_r,obj_tot_vehicle,'r-');
le3 = legend('cycling','vehicle','Location','NorthWest');
xlabel('\itl_r');
ylabel('\itg_r');
ylim([0,Inf])
hold off
