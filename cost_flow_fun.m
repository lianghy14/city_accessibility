function [obj,obj_tot,time_cost] = cost_flow_fun(wid_r,len_r,sum_f,mode)
% 0:cycling 1:vehicle;

m0 = [0.2,1.36]; % money cost
vot_m = [15,15]; % work time cost
T_max = 15; 
yita_m = [179,59]; % parameters, if larger rest time cost will be smaller
tao_m = [5.5,0.3]; % parameters, if larger rest time cost will be smaller
v_r0 = [20,40]; % maximum speed
gama_m = [0.7,0.5]; % parameters, if larger rest time cost will be larger

obj1 = (m0(mode+1) .* len_r) .* ones(1,size(sum_f,2)); % cost part 1
time_cost = 2.78 .* len_r ./v_r0(mode+1) .* (((1+(1 - sum_f./wid_r) .^ (0.5)).^(-1)) .* (sum_f<=0.999) + (sum_f>0.999) .* (((1 - 0.999./wid_r) .^ (-0.5)) + 100.*(sum_f - 0.999)));
obj2 = vot_m(mode+1) .* time_cost; % cost part 2
obj3 = vot_m(mode+1) .* gama_m(mode+1) .* T_max ./ (1+yita_m(mode+1).*exp(-tao_m(mode+1).*time_cost)); % cost part 3
obj = [obj1; obj2; obj3];  %cost function
obj_tot = sum_f .* (sum(obj,1));

end