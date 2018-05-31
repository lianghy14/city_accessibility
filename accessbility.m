function Access_eval = accessbility(mode,OD,boundary,sum_f,f)
N1 = size(OD,1);
N2 = size(boundary,1);
Access = zeros(N1,N1);
for i = 1:N1
    for k = 1:N1
        for j = 1:N2
            wid_r = boundary(j,4);
            len_r = boundary(j,3);
            [obj,obj_tot,time_cost] = cost_flow_fun(wid_r,len_r,sum_f(j),mode);
            Access(i,k) = Access(i,k)+sum(obj,1)*f((N1*(i-1)+k-1)*N2+j);
        end;
    end;
end;
Access_eval = zeros(N1,1);
beta = 1;
for i = 1:N1
    for j = 1:N1
        Access_eval(i) = Access_eval(i) + sum(OD(i,:)) / exp(beta*Access(i,j));
    end;
end;
end
    