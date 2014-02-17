% Append a matrix to a DiagBlockMat matrix.
%
% A = append(B,M)
%
% Append the matrix M to a DiagBlockMat matrix B along its diagonal.

function self = append(self,M)

self.B{end+1} = M;
self.N = self.N+1;

sz = size(M);

self.i(end+1) = self.i(end) + sz(1);
self.j(end+1) = self.j(end) + sz(2);  

self.sz = [self.i(end), self.j(end)];

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
