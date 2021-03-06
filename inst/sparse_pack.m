% Create a sparse matrix which packs an array under the control of a mask.
%
% H = sparse_pack(mask)
%
% Create a sparse matrix H which packs an array. It selects the elements where 
% mask is true.

function H = sparse_pack(mask)


j = find(mask)';
m = length(j);
i = 1:m;
s = ones(1,m);

n = numel(mask);

%whos i j s
H = sparse(i,j,s,m,n);

% Copyright (C) 2009 Alexander Barth <a.barth@ulg.ac.be>
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; If not, see <http://www.gnu.org/licenses/>.

