% Testing divand in 2 dimensions with relative correlation length.

% grid of background field
[xi,yi] = ndgrid(linspace(-1,1,30));

x = 0;
y = 0;
f = 1;

mask = ones(size(xi));
pm = ones(size(xi)) / (xi(2,1)-xi(1,1));
pn = ones(size(xi)) / (yi(1,2)-yi(1,1));



u = ones(size(xi));
v = u;

a = 5;
u = a*yi;
v = -a*xi;

L = 0.2 * ones(size(xi));
%L = 0.2 * ones(size(xi));
L = 0.4 * (2 - xi);

fi = divand(mask,{pm,pn},{xi,yi},{x,y},f,L,200);


if any(fi(1,:) < fi(end,:))
    error('unexpected values');
end
  
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
