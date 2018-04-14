function [f,fval,sum_f] = road_solver(point,boundary,OD,i_in,i_out,mode)
[m,n] = size(OD);
N3 = m*n; % number of flow kinds
N2 = size(boundary,1); % number of roads
N1 = size(point,1); % number of points
A2 = zeros(N1*N3,N2*N3); 
b2 = zeros(N1*N3,1);
Map = zeros(N1,N2);
for i = 1:N2;
    Map(boundary(i,1),boundary(i,2)) = i;
end
for i = 1:N1
    for j = 1:N1
        if (Map(i,j)~=0)
            bond = Map(i,j);
            m = 1:N3;
            A2((m-1)*N1+i,(m-1)*N2+bond) = eye(N3);
        end
        if (Map(j,i)~=0)
            bond = Map(j,i);
            m = 1:N3;
            A2((m-1)*N1+i,(m-1)*N2+bond) = -eye(N3);
        end
    end
end
[m,n] = size(OD);
k=1;
for i = 1:m
    for j = 1:n
        b2((k-1)*N1+i_in(i),1) = OD(i,j);
        b2((k-1)*N1+i_out(j),1) = -OD(i,j);
        k=k+1;
    end
end
m = 1:N3;
A2((m-1)*N1+1,:) = [];
b2((m-1)*N1+1) = [];
% for i = 1:N2
%     if(boundary(i,3)>=100)
%         c = zeros(N3,N2*N3);
%         j = 1:N3;
%         c(:,(j-1).*N2+i) = eye(N3);
%         A2 = [A2;c];
%         b2 = [b2;zeros(N3,1)];
%     end
% end
f0 = zeros(N2*N3,1);
lb = f0;
options = optimoptions('fmincon','Diagnostics','on','Display','iter','MaxFunEvals',500000,'TolFun',1e-4);
[f,fval] = fmincon(@obj_fun,f0,[],[],A2,b2,lb,[],[],options,boundary,OD,mode);

for i = 1:N2
    j = 1:N3;
    sum_f(i) = sum(f((j-1)*N2+i));
end

end
% 
% function obj = obj_fun(f,boundary,OD,mode)
% [m,n] = size(OD);
% N3 = m * n;
% N2 = size(boundary,1);
% obj = 0;
% for i = 1:N2
%     j = 1:N3;
%     sum_f = sum(f((j-1)*N2+i));
%     obj = obj + sum_f^3 * boundary(i,3) / boundary(i,4);
% end
% end

function obj = obj_fun(f,boundary,OD,mode)

m0 = [0.2,1.36]; % money cost
vot_m = [10,15];
T_max = 15;
yita_m = 55;
tao_m = 0.3;
gama_m = [0.7,0.5];

[m,n] = size(OD);
N3 = m * n;
N2 = size(boundary,1);
obj = 0;
for i = 1:N2
    j = 1:N3;
    sum_f = sum( f( (j-1)*N2+i ) ); %total flow on a single road
    obj1 = m0(mode+1) * boundary(i,3); % cost part 1
    time_cost = 2 * boundary(i,3) * (((1 - sum_f/boundary(i,4)) ^ (-0.5)) * (sum_f<=0.999) + (sum_f>0.999) * (((1 - 0.999/boundary(i,4)) ^ (-0.5)) + 1000*(sum_f - 0.999)));
    obj2 = vot_m(mode+1) * time_cost; % cost part 2
    obj3 = vot_m(mode+1) * gama_m(mode+1) * T_max / (1+yita_m*exp(-tao_m*time_cost)); % cost part 3
    obj = obj + obj1 + obj2 + obj3; %cost function
end
end
