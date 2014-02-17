% Testing divand in 2 dimensions.

%try
% grid of background field
[xi,yi] = ndgrid(linspace(0,1,30));
fi_ref = sin( xi*6 ) .* cos( yi*6);

% grid of observations
[x,y] = ndgrid(linspace(eps,1-eps,20));
x = x(:);
y = y(:);

on = numel(x);
var = 0.01 * ones(on,1);
f = sin( x*6 ) .* cos( y*6);

mask = ones(size(xi));
pm = ones(size(xi)) / (xi(2,1)-xi(1,1));
pn = ones(size(xi)) / (yi(1,2)-yi(1,1));

%fi = divand(mask,{pm,pn},{xi,yi},{x,y},f,.1,20);
fi = divand(mask,{pm,pn},{xi,yi},{x,y},f,.1,20,'factorize',0);
rms = divand_rms(fi_ref,fi);

if (rms > 0.005) 
  error('unexpected large difference with reference field');
end

%fprintf('OK (rms=%g)\n',rms);


fi_dual = divand(mask,{pm,pn},{xi,yi},{x,y},f,.1,20,'primal',0);
rms = divand_rms(fi_dual,fi);

%fprintf(1,'Testing dual 2D-optimal variational inverse: ');

if (rms > 1e-6) 
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
