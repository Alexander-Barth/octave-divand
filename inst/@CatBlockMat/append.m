% Append a matrix to a CatBlockMat matrix.
%
% A = append(B,M)
%
% Append the matrix M to a CatBlockMat matrix B.


function self = append(self,M)

sz = size(M);

if any(self.sz(self.d ~= self.dim) ~= sz(self.d ~= self.dim))
    error('arguments dimensions are not consistent.');
end

self.B{end+1} = M;
self.N = self.N+1;


self.i(end+1) = self.i(end) + sz(self.dim);
self.sz(self.dim) = self.i(end);
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
