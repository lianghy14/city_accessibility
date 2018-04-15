function [map] = map_plot_fun(div,size_net,wid_cross,point,boundary,sum_f)
size_map = div*2;
l_r = size_net / div - wid_cross;
map = zeros(size_map,size_map);
for i = 1:size_map
    for j = 1:size_map
        x_center = i*(size_net/div) - size_map/2 - (size_net/div)/2;
        y_center = j*(size_net/div) - size_map/2 - (size_net/div)/2;
        pls = round(10000.*[x_center - l_r/2,y_center - l_r/2])./10000;
        pln = round(10000.*[x_center - l_r/2,y_center + l_r/2])./10000;
        prn = round(10000.*[x_center + l_r/2,y_center + l_r/2])./10000;
        prs = round(10000.*[x_center + l_r/2,y_center - l_r/2])./10000;
        ip_boundary = zeros(4,1);
        for k = 1 : size(boundary,1)
            if ((sum(point(boundary(k,1),:)==pls) == 2) && (sum(point(boundary(k,2),:)==pln) == 2)) || ((sum(point(boundary(k,2),:)==pls) == 2) && (sum(point(boundary(k,1),:)==pln) == 2))
                ip_boundary(1) = k;
            end;
            if ((sum(point(boundary(k,1),:)==pln) == 2) && (sum(point(boundary(k,2),:)==prn) == 2)) || ((sum(point(boundary(k,2),:)==pln) == 2) && (sum(point(boundary(k,1),:)==prn) == 2))
                ip_boundary(2) = k;
            end;
            if ((sum(point(boundary(k,1),:)==prn) == 2) && (sum(point(boundary(k,2),:)==prs) == 2)) || ((sum(point(boundary(k,2),:)==prn) == 2) && (sum(point(boundary(k,1),:)==prs) == 2))
                ip_boundary(3) = k;
            end;
            if ((sum(point(boundary(k,1),:)==prs) == 2) && (sum(point(boundary(k,2),:)==pls) == 2)) || ((sum(point(boundary(k,2),:)==prs) == 2) && (sum(point(boundary(k,1),:)==pls) == 2))
                ip_boundary(4) = k;
            end;
        end;
        map_f = 0;count = 0;
%         disp(ip_boundary');
%         fprintf('\n');
        for k = 1:4
            if ip_boundary(k)~=0
                map_f = map_f + sum_f(ip_boundary(k));
                count = count+1;
            else
                map_f = map_f + 0;
                count = count+1;
            end;
        end;
        map(i,j) = map_f/count;
    end;
end;
end


