
size_in = 2;
size_out = 3;
div = [2,3];
gate_switch = ones((div(1)*2+1)^2,1);

OD = [1,1,1;1,1,1;1,1,1];
i_in = [10,20,30];
i_out = [20,40,60];

[point,boundary,b_gate,ip_out,ip_in,i_bd_out,ib_in,ib_out,i_bd_trans_in,i_bd_trans_out] = network_gen(size_in,size_out,div,gate_switch);
%[f,fval,sum_f] = road_solver(point,boundary,OD,i_in,i_out); % road solver
