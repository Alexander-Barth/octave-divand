% Testing 1D linear interpolation.

[xi] = linspace(0,1,30);
fi = sin( xi*6 );

no = 20;
x = rand(no,1);

mask = ones(size(xi));

[H,out] = interp_regular(mask,{xi},{x});

f1 = interp1(xi,fi,x);

f2 = H * fi(:);
Difference = max(abs(f1(:) - f2(:)));

if (Difference > 1e-6) 
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
