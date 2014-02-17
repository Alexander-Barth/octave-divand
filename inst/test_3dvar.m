% Testing divand in 3 dimensions.

% grid of background field
[xi,yi,zi] = ndgrid(linspace(0,1.,15));
fi_ref = sin(6*xi) .* cos(6*yi) .* sin(6*zi);

% grid of observations
[x,y,z] = ndgrid(linspace(eps,1-eps,10));
x = x(:);
y = y(:);
z = z(:);

on = numel(x);
var = 0.01 * ones(on,1);
f = sin(6*x) .* cos(6*y) .* sin(6*z);

if 0
  x = .5;
  y = .5; 
  z = .5; 
  f = 1;
  var = 0.01;
end

m = 20;

mask = ones(size(xi));
pm = ones(size(xi)) / (xi(2,1,1)-xi(1,1,1));
pn = ones(size(xi)) / (yi(1,2,1)-yi(1,1,1));
po = ones(size(xi)) / (zi(1,1,2)-zi(1,1,1));

fi = divand(mask,{pm,pn,po},{xi,yi,zi},{x,y,z},f,.1,100);
rms = sqrt(mean((fi_ref(:) - fi(:)).^2));

if (rms > 0.04) 
  error('unexpected large difference with reference field');
end

fprintf('(max difference=%g) ',rms);

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
