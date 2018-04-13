% This function is to judge the location of roads. 
% x = [coordinate_x, coordinate_y], in_size = inside roads, out_size = outside roads
function tol=judge(x,in_size,out_size)
if( abs(x(1))<in_size && abs(x(2))<in_size )
    tol = 1;
else
    if( abs(x(1))<out_size && abs(x(2))<out_size )
        tol = 2;
    else
        tol = 3;
    end
end
end