function [OD,i_OD] = OD_gen(point,size_net,div,flow_OD,i_OD_number)
% boundary:size_net*(div-1)/div
sor = find(and(( abs(point(:,1))<=size_net*(div-1)/div ),( abs(point(:,2))<=size_net*(div-1)/div )));
point_OD = point(sor,1:2);
% rand point ids
i_OD_rand = sor(randperm(size(point_OD,1),i_OD_number));
i_OD_rand(:,2) = ones(size(i_OD_rand,1),1); 
% leave close point ids
for i = 1:(size(i_OD_rand)-1)
    for j = (i+1):size(i_OD_rand)
        if distance(point(i_OD_rand(i,1),:),point(i_OD_rand(j,1),:))<=(size_net/div/2)
            i_OD_rand(i,2) = 0;
        end;
    end;
end;
sor = find(i_OD_rand(:,2) == 1);
i_OD = i_OD_rand(sor,1);
% OD flow is equal to given flow_OD
OD = zeros(size(i_OD,1),size(i_OD,1));
for i = 1:size(i_OD,1)
    for j = 1:size(i_OD,1)
        if (i==j)
            OD(i,j) = 0;
        else
            OD(i,j) = flow_OD;
        end;
    end;
end;
end