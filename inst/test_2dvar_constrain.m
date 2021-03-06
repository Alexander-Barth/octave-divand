% Testing divand in 2 dimensions with a custom constrain.

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


len = 3;
lambda = 20;
n = sum(mask(:));

% constrain
fun = @(x) mean(x,1);
funt = @(x) repmat(x,[n 1])/n;

H = ones(1,n)/n;
c.H = MatFun([1 n],fun,funt);
%c.H = H;
c.R = 0.001;
c.yo = 1;

% bug
%[va,err,s] = divand(mask,{pm,pn},{xi,yi},{x,y},v,len,lambda,'diagnostics',1,'primal',1,'factorize',0,'constraint',c,'inversion','pcg');

[va,err,s] = divand(mask,{pm,pn},{xi,yi},{x,y},v,len,lambda,...
    'diagnostics',1,'primal',1,'factorize',0,'inversion','pcg',...
    'tol',1e-6,'minit',100,'keepLanczosVectors',1);


% ok
%[va,err,s] = divand(mask,{pm,pn},{xi,yi},{x,y},v,len,lambda,'diagnostics',1,'primal',1,'factorize',0);




iR = inv(full(s.R));
iB = full(s.iB);
H = double(s.H);
yo = s.yo;
sv = s.sv;

iB = iB + H'*iR*H;

Pa = inv(iB);

xa2 = Pa* (H'*iR*yo);

[fi2] = statevector_unpack(sv,xa2);
fi2(~s.mask) = NaN;

rms_diff = [];
rms_diff(end+1) = sqrt(mean((va(:) - fi2(:)).^2));
rms_diff(end+1) = sqrt(mean((diag(Pa) - err(:)).^2));


if any(rms_diff > 1e-4)
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
