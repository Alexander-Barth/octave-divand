% Derive fractional indices on a regular grid.
%
% I = localize_regular_grid(xi,mask,x)
%
% Derive fractional indices where xi are the points to localize in the 
% regular grid x (constant increment in all dimension).  
% The output I is an n-by-m array where n number of dimensions and m number of 
% observations

function I = localize_regular_grid(xi,mask,x)

x = cat_cell_array(x);
xi = cat_cell_array(xi);

% m is the number of arbitrarily distributed observations
tmp = size(xi);
mi = prod(tmp(1:end-1));

% sz is the size of the grid
tmp = size(x);
sz = tmp(1:end-1);
m = prod(sz);

% n dimension of the problem
n = tmp(end);

xi = reshape(xi,mi,n);

scale = [1 cumprod(sz(1:end-1))];

A = zeros(n,n);

x0 = x([0:n-1]' * m +1)';

E = eye(n);

I = zeros(n,size(xi,1));

for i=1:n
  I(i,:) = (xi(:,i) - x0(i));

  % linear index of element (2,1,1,...,:),
  % (1,2,1,...,:), (1,1,2,...,:) ...
  
  l = scale*E(:,i) + [0:n-1]' * m +1;
  A(i,:) = x(l)- x0(:);
end


I = A \ I + 1;

% LocalWords:  indices sz

% Copyright (C) 2014 Alexander Barth <a.barth@ulg.ac.be>
%
% This program is free software; you can redistribute it and/or modify it under
% the terms of the GNU General Public License as published by the Free Software
% Foundation; either version 2 of the License, or (at your option) any later
% version.
%
% This program is distributed in the hope that it will be useful, but WITHOUT
% ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
% FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
% details.
%
% You should have received a copy of the GNU General Public License along with
% this program; if not, see <http://www.gnu.org/licenses/>.
