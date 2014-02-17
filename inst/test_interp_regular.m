% Testing linear interpolation on regular grid.

D = [];

[xi,yi,zi] = ndgrid(linspace(0,1,11));
fi = sin(6*xi) .* cos(6*yi) .* sin(6*zi);

no = 20;
x = rand(no,1);
y = rand(no,1);
z = rand(no,1);

[H,out] = interp_regular(ones(size(xi)),{xi,yi,zi},{x,y,z});
f1 = interpn(xi,yi,zi,fi,x,y,z);

f2 = H * fi(:);
D(end+1) = max(abs(f1(:) - f2(:)));


% 4d 
[xi,yi,zi,ti] = ndgrid(linspace(0,1,5));
fi = sin(6*xi) .* cos(6*yi) .* sin(6*zi) .* cos(6*ti);
no = 20;
x = rand(no,1);
y = rand(no,1);
z = rand(no,1);
t = rand(no,1);

[H,out] = interp_regular(ones(size(xi)),{xi,yi,zi,ti},{x,y,z,t});
f1 = interpn(xi,yi,zi,ti,fi,x,y,z,t);

f2 = H * fi(:);
D(end+1) = max(abs(f1(:) - f2(:)));

% 2d with outside points

[xi,yi] = ndgrid(linspace(0,1,30));
fi = sin( xi*6 ) .* cos( yi*6);
fi(1:4,:) = NaN;

no = 200;
x = 2*rand(no,1);
y = 2*rand(no,1);


%x =  0.805224734876956
%y =  1.00822133283472

%x = 0.134579335939626
%y = 0.716156681034316

f = sin( x*6 ) .* cos( y*6);

mask = ~isnan(fi);

[H,out] = interp_regular(mask,{xi,yi},{x,y});

f1 = interpn(xi,yi,fi,x,y);
f2 = H * fi(:);
f2 = reshape(f2,size(x));

D(end+1) = max(abs(f1(~out) - f2(~out)));


if any(D > 1e-6) || any(isnan(f1(:) ~= out(:)))
  error('unexpected large difference with reference field');
end

fprintf('(max difference=%g) ',Difference);
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
