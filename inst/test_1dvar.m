% Testing divand in 1 dimension.

% grid of background field
[xi] = linspace(0,1,30)';

x = [.4 .6]';
f = [.4 .6]';

mask = ones(size(xi));
mask([1 end]) = 0;
  
pm = ones(size(xi)) / (xi(2)-xi(1));
  
[fi,err] = divand(mask,pm,{xi},{x},f,.1,2);


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
