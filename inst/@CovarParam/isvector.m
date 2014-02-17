% Return true if argument is a vector.
%
% b = isscalar(X)
%
% Return true if X is a vector. A vector is a N-by-1 or 1-by-N matrix.

function b = isvector(self)

sz = size(self);
b = length(sz) == 2 && (sz(1) == 1 || sz(2) == 1);

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
