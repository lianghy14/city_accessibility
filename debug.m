sum_f = 0.1;
wid_r = 1;
len_r = 2;

m0 = [0.2,1.36]; % money cost
vot_m = [15,15]; % work time cost
T_max = 15; 
yita_m = [179,59]; % parameters, if larger rest time cost will be smaller
tao_m = [2.7,0.3]; % parameters, if larger rest time cost will be larger
v_r0 = [20,60]; % maximum speed
gama_m = [0.7,0.5]; % parameters, if larger rest time cost will be larger


time_cost = 2 .* len_r ./v_r0 .* (((1 - sum_f./wid_r) .^ (-0.5)));
rest_time = gama_m .* T_max ./ (1+yita_m.*exp(-tao_m.*time_cost));
obj2 = vot_m(mode+1) .* time_cost; % cost part 2
obj3 = vot_m(mode+1) .* rest_time; % cost part 3
obj2
obj3
