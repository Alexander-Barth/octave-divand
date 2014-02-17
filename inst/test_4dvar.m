% Testing divand in 4 dimensions.

% grid of background field
[xi,yi,zi,ti] = ndgrid(linspace(0,1,7));
len = 1;
k = pi/2;
k = pi;
fun = @(x,y,z,t) sin(k*x) .* sin(k*y) .* sin(k*z) .* sin(k*t);
fi_ref = fun(xi,yi,zi,ti);

% grid of observations
[x,y,z,t] = ndgrid(linspace(2*eps,1-2*eps,5));
x = x(:);
y = y(:);
z = z(:);
t = t(:);

pm = ones(size(xi)) / (xi(2,1,1,1)-xi(1));
pn = ones(size(xi)) / (yi(1,2,1,1)-yi(1));
po = ones(size(xi)) / (zi(1,1,2,1)-zi(1));
pp = ones(size(xi)) / (ti(1,1,1,2)-ti(1));


f = fun(x,y,z,t);
mask = ones(size(xi));

%f = x = y = z = t = 0.5

fi = divand(mask,{pm,pn,po,pp},{xi,yi,zi,ti},{x,y,z,t},f,.12,10);
rms = divand_rms(fi_ref,fi);

% rms should be 0.0111807

if (rms > 0.012) 
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
