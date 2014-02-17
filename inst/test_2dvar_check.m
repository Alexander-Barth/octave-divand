% Testing divand in 2 dimensions with independent verification.

% grid of background field
[xi,yi] = ndgrid(linspace(0,1,10));

mask = ones(size(xi));
pm = ones(size(xi)) / (xi(2,1)-xi(1,1));
pn = ones(size(xi)) / (yi(1,2)-yi(1,1));

% grid of observations
[x,y] = ndgrid(linspace(eps,1-eps,10));
x = x(:);
y = y(:);
v = sin( x*6 ) .* cos( y*6);


lenx = .15;
leny = .15;

lambda = 20;

[va,err,s] = divand(mask,{pm,pn},{xi,yi},{x,y},v,{lenx,leny},lambda,'diagnostics',1,'primal',1);



iR = inv(full(s.R));
iB = full(s.iB);
H = full(s.H);
sv = s.sv;

iP = iB + H'*iR*H;

P = inv(iP);

xa2 = P* (H'*iR*v(:));

[fi2] = statevector_unpack(sv,xa2);
fi2(~s.mask) = NaN;

rms_diff = [];
rms_diff(end+1) = divand_rms(va,fi2);
rms_diff(end+1) = divand_rms(diag(P),err(:));


if any(rms_diff > 1e-6)
  error('unexpected large difference');
end

fprintf('(max rms=%g) ',max(rms_diff));

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
