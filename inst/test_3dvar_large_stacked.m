% Testing divand in 3 dimensions without correlation in the 3rd dimension 
% (vertically stacked).

kmax = 4;

% grid of background field
[xi,yi,zi] = ndgrid(linspace(0,1.,30),linspace(0,1.,30),linspace(0,1.,10));
fi_ref = sin(6*xi) .* cos(6*yi) .* sin(6*zi);

% grid of observations
[x,y,z] = ndgrid(linspace(eps,1-eps,10),linspace(eps,1-eps,10),linspace(eps,1-eps,10));
x = reshape(x,100,10);
y = reshape(y,100,10);
z = reshape(z,100,10);


f = sin(6*x) .* cos(6*y) .* sin(6*z);


mask = ones(size(xi));
pm = ones(size(xi)) / (xi(2,1,1)-xi(1,1,1));
pn = ones(size(xi)) / (yi(1,2,1)-yi(1,1,1));
po = ones(size(xi)) / (zi(1,1,2)-zi(1,1,1));

len = {0.1*mask,0.1*mask,0.*mask};

fi = divand(mask,{pm,pn,po},{xi,yi,zi},{x,y,z},f,len,20,'primal',1,'alpha',[1 2 1]);
len = {0.1*mask(:,:,1),0.1*mask(:,:,1)};

fi2 = zeros(size(fi));
for k = 1:size(mask,3);
  fi2(:,:,k) = divand(mask(:,:,k),{pm(:,:,k),pn(:,:,k)},{xi(:,:,k),yi(:,:,k)},{x(:,k),y(:,k)},f(:,k),len,20);
end

rms = divand_rms(fi2,fi);

if (rms > 1e-10) 
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
