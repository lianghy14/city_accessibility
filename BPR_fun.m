function [time_cost] = BPR_fun(wid_r,len_r,sum_f,mode)
% 0:cycling 1:vehicle;
alpha = 0.68;
beta = 2.48;
v_r0 = [20,40]; % maximum speed
time_cost = 1.39 .* len_r ./v_r0(mode+1) .* (1 + alpha .* (sum_f./wid_r) .^ (beta));
end