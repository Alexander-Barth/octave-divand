% Derive fractional indices on a separable grid.
%
% I = localize_separable_grid(xi,mask,x)
%
% Derive fractional indices where xi are the points to localize in the 
% separable grid x (every dimension in independent on other dimension).  
% The output I is an n-by-m array where n number of dimensions and m number of 
% observations

function I = localize_separable_grid(xi,mask,x)

x = cat_cell_array(x);
xi = cat_cell_array(xi);

% m is the number of arbitrarily distributed observations
tmp = size(xi);
mi = prod(tmp(1:end-1));

% sz is the size of the grid
tmp = size(x);
sz = tmp(1:end-1);

if isvector(x)
  n = 1;
  mi = length(xi);
  I = zeros(1,mi);
  I(1,:) = interp1(x,1:length(x),xi);
else  
  % n dimension of the problem
  n = tmp(end);
  m = prod(sz);

  xi = reshape(xi,mi,n);
  x = reshape(x,[m n]);

  IJ = cell(n,1);
  vi = cell(n,1);
  X = cell(n,1);
  XI = cell(n,1);
  I = zeros(n,mi);

  for i=1:n
    vi{i} = 1:sz(i);
    X{i} = reshape(x(:,i),sz);
    XI{i} = xi(:,i);
  end

  [IJ{:}] = ndgrid(vi{:});


  for i=1:n
    I(i,:) = interpn(X{:},IJ{i},XI{:});
  end

end


% handle rounding errors
% snap to domain bounding box if difference does not exceeds tol
tol = 50*eps;

for i=1:n
  % upper bound
  ind = sz(i) < I(i,:) & I(i,:) <= sz(i) + tol;
  I(i,ind) = sz(i);

  % lower bound
  ind = 1 < I(i,:) & I(i,:) <= 1 + tol;
  I(i,ind) = 1;
end




% LocalWords:  indices sz tol

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
