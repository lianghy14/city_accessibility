[X,Y] = meshgrid(-1:2);
V = map;
[xx,yy] = meshgrid(-1:0.1:2);
vv = interp2(X,Y,V,xx,yy,'cubic');