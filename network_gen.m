function [point,boundary,b_gate,ip_out,ip_in,i_bd_out,ib_in,ib_out,i_bd_trans_in,i_bd_trans_out]=network_gen(size_in,size_out,div,gate_switch)

p_cross = []; % Coordinates of central point of crosses
x_center = [0;0]; % Coordinates of central point of the network
l_roads(1) = size_in / div(1); % length of roads inside 
l_roads(2) = size_out / div(2); % lenth of roads outside

for i = 0 : floor(size_in/l_roads(1))
    for j = 0 : floor(size_in/l_roads(1))
        x = x_center + [i*l_roads(1);j*l_roads(1)];
        if ( judge(x,size_in,size_out) == 1 )
            p_cross = [p_cross;x'];
        end
        x = x_center + [-i*l_roads(1);j*l_roads(1)];        
        if ( judge(x,size_in,size_out) == 1 )
            p_cross = [p_cross;x'];
        end
        x = x_center + [-i*l_roads(1);-j*l_roads(1)];
        if ( judge(x,size_in,size_out) == 1 )
            p_cross = [p_cross;x'];
        end
        x = x_center + [i*l_roads(1);-j*l_roads(1)];
        if ( judge(x,size_in,size_out) == 1 )
            p_cross = [p_cross;x'];
        end
    end
end

for i = 0 : floor(size_out/l_roads(2))
    for j = 0:floor(size_out/l_roads(2))
        x = x_center + [i*l_roads(2);j*l_roads(2)];
        if ( judge(x,size_in,size_out) == 2 )
            p_cross = [p_cross;x'];
        end
        x = x_center + [-i*l_roads(2);j*l_roads(2)];
        if ( judge(x,size_in,size_out) == 2 )
            p_cross = [p_cross;x'];
        end
        x = x_center + [-i*l_roads(2);-j*l_roads(2)];
        if ( judge(x,size_in,size_out) == 2 )
            p_cross = [p_cross;x'];
        end
        x = x_center + [i*l_roads(2);-j*l_roads(2)];
        if ( judge(x,size_in,size_out) == 2 )
            p_cross = [p_cross;x'];
        end
    end
end
p_cross = unique(p_cross,'rows'); % generate coordinates of all crosses

wid_cross = 0.1; % width of crosses
point = []; % coordinates of points
boundary = []; % point boundaries' ip for each road
ib_in = []; 
ib_out = [];
ip_in = []; % crosses' ip for inside roads
ip_out = [];% crosses' ip for outside roads
i_bd_out = [];
i_bd_trans_in = [];
i_bd_trans_out = [];
b_gate = [];

for i = 1 : size(p_cross,1)
    x = p_cross(i,:);
    dir = wid_cross * [0.5,0.5; -0.5,0.5; -0.5,-0.5; 0.5,-0.5];
    for j = 1:4
        point = [point;x+dir(j,:)];
    end
    boundary = [boundary; (i-1)*4+1,(i-1)*4+2; (i-1)*4+2,(i-1)*4+3; (i-1)*4+3,(i-1)*4+4; (i-1)*4+4,(i-1)*4+1]; %four roads around the cross
    tol = judge(x,size_in,size_out);
    if (tol == 1)
        ip_in = [ip_in ; i];
    else
        ip_out = [ip_out ; i];
    end
    dir2 = l_roads(tol) * [1,0; 0,1; -1,0; 0,-1];
    for j = 1:4 % four points in a cross
        x1 = x + dir2(j,:);
        if (judge(x,size_in,size_out) + judge(x1,size_in,size_out) == 3)
            if (tol == 1)
                i_bd_trans_in = [i_bd_trans_in ; i];
            else
                i_bd_trans_out = [i_bd_trans_out ; i];
            end
            continue;
        end
        if (judge(x1,size_in,size_out) == 3)
            switch j
                case 1
                    i_bd_out = [i_bd_out; (i-1)*4+1; (i-1)*4+4];
                case 2
                    i_bd_out = [i_bd_out; (i-1)*4+1; (i-1)*4+2];
                case 3
                    i_bd_out = [i_bd_out; (i-1)*4+2; (i-1)*4+3];
                case 4
                    i_bd_out = [i_bd_out; (i-1)*4+3; (i-1)*4+4];
            end
        end
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
i_bd_out = unique(i_bd_out,'rows');
i_bd_trans_in = unique(i_bd_trans_in,'rows');
i_bd_trans_out = unique(i_bd_trans_out,'rows');
[bp_number,inout] = max( [size(i_bd_trans_in,1),size(i_bd_trans_out,1)] );
index = randperm(bp_number);
if (inout == 1)
    for i = 1:bp_number
        index_in = i_bd_trans_in(index(i));
        A = zeros(size(i_bd_trans_out,1),2);
        for j = 1:size(i_bd_trans_out,1)
            A(j,:) = p_cross(i_bd_trans_in(index(i)),:);
        end
        c = (p_cross(i_bd_trans_out,:) - A);
        c = c(:,1).^2 + c(:,2).^2;
        [~,in_out] = min(c);
        index_out = i_bd_trans_out(in_out);
        in_out_vect = -p_cross(index_in,:) + p_cross(index_out,:);
        dir = [1,0; 0,1; -1,0; 0,-1];
        for j = 1:4
            ang = dot(in_out_vect,dir(j,:)) / norm(in_out_vect) / norm(dir(j,:));
            if (ang >= cos(pi/4))
                switch j
                    case 1
                        boundary = [boundary; (index_in-1)*4+4,(index_out-1)*4+3; (index_out-1)*4+2,(index_in-1)*4+1];
                        b_gate = [b_gate;(index_in-1)*4+4,(index_out-1)*4+3; (index_out-1)*4+2,(index_in-1)*4+1];
                    case 2
                        boundary = [boundary; (index_in-1)*4+1,(index_out-1)*4+4; (index_out-1)*4+3,(index_in-1)*4+2];
                        b_gate = [b_gate;(index_in-1)*4+1,(index_out-1)*4+4; (index_out-1)*4+3,(index_in-1)*4+2];
                    case 3
                        boundary = [boundary; (index_in-1)*4+2,(index_out-1)*4+1; (index_out-1)*4+4,(index_in-1)*4+3];
                        b_gate = [b_gate;(index_in-1)*4+2,(index_out-1)*4+1; (index_out-1)*4+4,(index_in-1)*4+3];
                    case 4
                        boundary = [boundary; (index_in-1)*4+3,(index_out-1)*4+2; (index_out-1)*4+1,(index_in-1)*4+4];
                        b_gate = [b_gate; (index_in-1)*4+3,(index_out-1)*4+2; (index_out-1)*4+1,(index_in-1)*4+4];
                end
            end
        end
    end
else
    for i = 1:bp_number
        index_out = i_bd_trans_out(index(i));
        A = zeros(size(i_bd_trans_in,1),2);
        for j = 1:size(i_bd_trans_in,1)
            A(j,:) = p_cross(i_bd_trans_out(index(i)),:);
        end
        c = (p_cross(i_bd_trans_in,:) - A);
        c = c(:,1).^2+c(:,2).^2;
        [~,in_out] = min(c);
        index_in = i_bd_trans_in(in_out);
        in_out_vect = -p_cross(index_in,:) + p_cross(index_out,:);
        dir = [1,0; 0,1; -1,0; 0,-1];
        for j = 1:4
            ang = dot(in_out_vect,dir(j,:)) / norm(in_out_vect) / norm(dir(j,:));
            if (ang >= cos(pi/4))
                switch j
                    case 1
                        boundary = [boundary; (index_in-1)*4+4,(index_out-1)*4+3; (index_out-1)*4+2,(index_in-1)*4+1];
                        b_gate = [b_gate; (index_in-1)*4+4,(index_out-1)*4+3; (index_out-1)*4+2,(index_in-1)*4+1];
                    case 2
                        boundary = [boundary; (index_in-1)*4+1,(index_out-1)*4+4; (index_out-1)*4+3,(index_in-1)*4+2];
                        b_gate = [b_gate; (index_in-1)*4+1,(index_out-1)*4+4; (index_out-1)*4+3,(index_in-1)*4+2];
                    case 3
                        boundary = [boundary; (index_in-1)*4+2,(index_out-1)*4+1; (index_out-1)*4+4,(index_in-1)*4+3];
                        b_gate = [b_gate; (index_in-1)*4+2,(index_out-1)*4+1; (index_out-1)*4+4,(index_in-1)*4+3];
                    case 4
                        boundary = [boundary; (index_in-1)*4+3,(index_out-1)*4+2; (index_out-1)*4+1,(index_in-1)*4+4];
                        b_gate = [b_gate; (index_in-1)*4+3,(index_out-1)*4+2; (index_out-1)*4+1,(index_in-1)*4+4];
                end
            end
        end
    end 
end
b_gate = unique(b_gate,'rows');
boundary = unique(boundary,'rows');
b_gate = [b_gate,zeros(size(b_gate,1),1)];
boundary = [boundary,zeros(size(boundary,1),2)];
for i = 1:size(b_gate,1)
    for j = 1:size(boundary,1)
        if ( b_gate(i,1)==boundary(j,1) && b_gate(i,2)==boundary(j,2) )
            b_gate(i,3) = j;
        end
    end
end
% here: change the switch of the gates
% gate_switch=ones(size(b_gate,1),1);
boundary = unique(boundary,'rows');

for i = 1:size(point,1)
    hold on;
    if ( judge(point(i,:),size_in,size_out)==1 )
        scatter(point(i,1),point(i,2),'filled','MarkerEdgeColor',[0 .5 .5]', 'MarkerFaceColor',[0 .7 .7]);
        text(point(i,1),point(i,2),num2str(i));
    else
        scatter(point(i,1),point(i,2),'^', 'MarkerEdgeColor','red');
        text(point(i,1),point(i,2),num2str(i));
    end
end
for i = 1:size(boundary,1)
    hold on;
    if ( judge(point(boundary(i,1),:),size_in,size_out)==1 )
        line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'Color','blue');
        len = norm(point(boundary(i,1),:) - point(boundary(i,2),:));
        boundary(i,3) = len;
        boundary(i,4) = 1;
    else
        line(point(boundary(i,1:2),1),point(boundary(i,1:2),2),'Color','red');
        len = norm(point(boundary(i,1),:) - point(boundary(i,2),:));
        boundary(i,3) = len;
        boundary(i,4) = 1;
    end
    text((point(boundary(i,1),1)+point(boundary(i,2),1))/2,(point(boundary(i,1),2)+point(boundary(i,2),2))/2,num2str(i));
end

for i = 1:size(b_gate,1)
    if ( gate_switch(i)==0 )
        boundary(b_gate(i,3),3) = 10000;
    end
end
% figure(2);
% hold on;
% scatter(p(i_bd_out,1),p(i_bd_out,2),'^');
% % scatter(p(i_bd_trans_in,1),p(i_bd_trans_in,2),'MarkerEdgeColor',[0 .5 .5]', 'MarkerFaceColor',[0 .7 .7]);
% scatter(p(i_bd_trans_out,1),p(i_bd_trans_out,2),'MarkerEdgeColor','red', 'MarkerFaceColor','red');






end