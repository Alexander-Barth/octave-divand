% Block diagonal matrix.
%
% DB = DiagBlockMat(A1,A2,...,An)
%
% Create the block diagonal matrix DB from the matrices A1, A2,...,An
%
%      /  A1   0    0    ... 0 \
%      |  0    A2   0        : |
% DB = |  0    0    A3         |
%      |  :              .   0 |
%      \  0  ...         0  An /  

function retval = DiagBlockMat(varargin)

self.B = varargin;
self.N = length(varargin);
self.i = zeros(self.N+1,1);
self.j = zeros(self.N+1,1);

for i=1:self.N
  sz = size(self.B{i});
  self.i(i+1) = self.i(i) + sz(1);
  self.j(i+1) = self.j(i) + sz(2);  
end

self.sz = [self.i(end), self.j(end)];

retval = class(self,'DiagBlockMat');


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
