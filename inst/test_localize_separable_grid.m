

% 1D

assert(localize_separable_grid(4,ones(10,1),2*[1:10]) == 2)

% 2D

[x,y] = ndgrid(2 * [1:5],1:6);
mask = ones(size(x));
xi = {3,3};
I = localize_separable_grid(xi,mask,{x,y})


assert(max(abs(I - [1.5; 3])) < 1e-9);