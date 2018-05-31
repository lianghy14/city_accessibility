


wid_r = 1;
len_r = 2;
mode = [0,1];  %1:vehicle; 0:cycling
ylim_p = 10;
sum_f = 0:0.02:0.9; %total flow ratio on a single road
[obj_0,obj_tot_0,time_cost_0] = cost_flow_fun(wid_r,len_r,sum_f,mode(1));
figure1 = figure(1);
area(sum_f',obj_0');
legend('usage cost \itg_m','time cost \itg_T','comfort cost \itg_S','Location','NorthWest');
xlabel('\itf_r');ylabel('\itg_r');
ylim([0 ylim_p]);
hold off
[obj_1,obj_tot_1,time_cost_1] = cost_flow_fun(wid_r,len_r,sum_f,mode(2));
figure2 = figure(2);
area(sum_f',obj_1');
legend('usage cost \itg_m','time cost \itg_T','comfort cost \itg_S','Location','NorthWest');
xlabel('\itf_r');ylabel('\itg_r');
ylim([0 ylim_p]);
hold off

figure3 = figure(3);
len_r = 2;
sum_f = 0:0.02:0.98;
[obj_0,obj_tot_0,time_cost_0] = cost_flow_fun(wid_r,len_r,sum_f,mode(1));
[obj_1,obj_tot_1,time_cost_1] = cost_flow_fun(wid_r,len_r,sum_f,mode(2));
[time_cost_BPR_0] = BPR_fun(wid_r,len_r,sum_f,mode(1));
[time_cost_BPR_1] = BPR_fun(wid_r,len_r,sum_f,mode(2));
plot(sum_f,time_cost_0,'g-',sum_f,time_cost_1,'r-');hold on;
plot(sum_f,time_cost_BPR_0,'g:',sum_f,time_cost_BPR_1,'r:');hold on;
legend('cycling-Greenshields','vehicle-Greenshields','cycling-BPR','vehicle-BPR','Location','NorthWest');
xlabel('\itf_r');
ylabel('\itt_r (h)');
ylim([0,Inf])
hold off

figure4 = figure(4);
len_r = 0.1:0.1:10;
sum_f = 0.1;
[obj_0,obj_tot_0,time_cost_0] = cost_flow_fun(wid_r,len_r,sum_f,mode(1));
[obj_1,obj_tot_1,time_cost_1] = cost_flow_fun(wid_r,len_r,sum_f,mode(2));
plot(len_r,obj_tot_0,'g-',len_r,obj_tot_1,'r-');
legend('cycling','vehicle','Location','NorthWest');
xlabel('\itd_r (km)');
ylabel('\itg_r');
ylim([0,Inf])
hold off

saveas(figure1,'0528figure\figure_model_1.png');
saveas(figure2,'0528figure\figure_model_2.png');
saveas(figure3,'0528figure\figure_model_3.png');
saveas(figure4,'0528figure\figure_model_4.png');


