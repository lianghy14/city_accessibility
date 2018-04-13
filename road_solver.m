function [f,fval,sum_f] = road_solver(point,boundary,OD,i_in,i_out)
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
for i = 1:N2
    if(boundary(i,3)>=100)
        c = zeros(N3,N2*N3);
        j = 1:N3;
        c(:,(j-1).*N2+i) = eye(N3);
        A2 = [A2;c];
        b2 = [b2;zeros(N3,1)];
    end
end
f0 = zeros(N2*N3,1);
lb = f0;
options = optimoptions('fmincon','Diagnostics','on','Display','iter','MaxFunEvals',1000000,'TolFun',1e-4);
[f,fval] = fmincon(@obj_fun,f0,[],[],A2,b2,lb,[],[],options,boundary,OD);

for i = 1:N2
    j = 1:N3;
    sum_f(i) = sum(f((j-1)*N2+i));
end

end

function obj = obj_fun(f,boundary,OD)
[m,n] = size(OD);
N3 = m * n;
N2 = size(boundary,1);
obj = 0;
for i = 1:N2
    j = 1:N3;
    sum_f = sum(f((j-1)*N2+i));
    obj = obj + sum_f^3 * boundary(i,3) / boundary(i,4);
end
end
