function [point,boundary]=network_gen(size_net,div,mode)

p_cross = []; % Coordinates of central point of crosses
x_center = [0;0]; % Coordinates of central point of the network
l_roads = size_net / div; % length of roads

for i = 0 : floor(size_net/l_roads)
    for j = 0 : floor(size_net/l_roads)
        x = x_center + [i*l_roads;j*l_roads];
        p_cross = [p_cross;x'];
        x = x_center + [-i*l_roads;j*l_roads];        
        p_cross = [p_cross;x'];
        x = x_center + [-i*l_roads;-j*l_roads];
        p_cross = [p_cross;x'];
        x = x_center + [i*l_roads;-j*l_roads];
        p_cross = [p_cross;x'];
    end;
end

p_cross = unique(p_cross,'rows'); % generate coordinates of all crosses

wid_cross = 0.1; % width of crosses
point = []; % coordinates of points
boundary = []; % point boundaries' ip for each road

for i = 1 : size(p_cross,1)
    x = p_cross(i,:);
    dir = wid_cross * [0.5,0.5; -0.5,0.5; -0.5,-0.5; 0.5,-0.5];
    for j = 1:4
        point = [point;x+dir(j,:)];
    end
    boundary = [boundary; (i-1)*4+1,(i-1)*4+2; (i-1)*4+2,(i-1)*4+3; (i-1)*4+3,(i-1)*4+4; (i-1)*4+4,(i-1)*4+1]; %four roads around the cross by anti-clock
    dir2 = l_roads * [1,0; 0,1; -1,0; 0,-1];
    for j = 1:4 % four points in a cross
        x1 = x + dir2(j,:);
        for k = 1 : size(p_cross,1)
            if ( p_cross(k,:) == x1 )
                switch j
                    case 1
                        boundary = [boundary; (i-1)*4+4,(k-1)*4+3; (k-1)*4+2,(i-1)*4+1];
                    case 2
                        boundary = [boundary; (i-1)*4+1,(k-1)*4+4; (k-1)*4+3,(i-1)*4+2];
                    case 3
                        boundary = [boundary; (i-1)*4+2,(k-1)*4+1; (k-1)*4+4,(i-1)*4+3];
                    case 4
                        boundary = [boundary; (i-1)*4+3,(k-1)*4+2; (k-1)*4+1,(i-1)*4+4];
                end
            end
        end
    end
end
boundary = unique(boundary,'rows');

for i = 1:size(boundary,1)
    len = norm(point(boundary(i,1),:) - point(boundary(i,2),:));
    boundary(i,3) = len;
    judge1 = (abs(point(boundary(i,1),1)) < (size_net - wid_cross) / 2) || (abs(point(boundary(i,2),1)) < (size_net - wid_cross) / 2);
    judge2 = (abs(point(boundary(i,1),2)) <= wid_cross / 2) && (abs(point(boundary(i,2),2)) <= wid_cross / 2);
    judge3 = (round(boundary(i,3)*10000) == round(wid_cross*10000)) && (point(boundary(i,1),2) == point(boundary(i,2),2));
    judge4 = (abs(point(boundary(i,1),2)) < (size_net - wid_cross) / 2) || (abs(point(boundary(i,2),2)) < (size_net - wid_cross) / 2);
    judge5 = (abs(point(boundary(i,1),1)) <= wid_cross / 2) && (abs(point(boundary(i,2),1)) <= wid_cross / 2);
    judge6 = (round(boundary(i,3)*10000) == round(wid_cross*10000)) && (point(boundary(i,1),1) == point(boundary(i,2),1));
    if (((judge1&&judge2)) && (judge3 == 0)) || (((judge4&&judge5)) && (judge6 == 0))
        %boundary(i,4) = 1; % 1:vehicle; 0:cycling
        %boundary(i,3) = 99;
        boundary(i,4) = 1 - mode;
    else
        boundary(i,4) = 1;
    end;
end;
% fprintf('\n');
% disp(size(boundary,1));
sor = find(boundary(:,4) == 1);
boundary = boundary(sor,1:4);
i = 1;
while i<=size(point,1)
    if (any(boundary(:,1)==i)==0)&&(any(boundary(:,2)==i)==0)
%        disp(point(i,:));
%        fprintf('\n');
        point(i,:) = [];
        for j = 1:size(boundary,1)
            if (boundary(j,1)>i)
                boundary(j,1) = boundary(j,1) - 1;
            end;
            if (boundary(j,2)>i)
                boundary(j,2) = boundary(j,2) - 1;
            end;
        end;
    else
        i = i+1;
    end;
end;
    
for i = 1:size(boundary,1)
    hold on;
    if (mode<=boundary(i,4))
        line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'Color','blue');
        %text((point(boundary(i,1),1)+point(boundary(i,2),1))/2,(point(boundary(i,1),2)+point(boundary(i,2),2))/2,num2str(i));
    else
        %line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'Color','red');
        %text((point(boundary(i,1),1)+point(boundary(i,2),1))/2,(point(boundary(i,1),2)+point(boundary(i,2),2))/2,num2str(i));
    end;
end
end