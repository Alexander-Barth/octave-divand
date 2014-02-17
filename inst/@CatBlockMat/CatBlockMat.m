% Create a matrix which represents the concatenation of a series of matrices.
% 
% C = CatBlockMat(dim,X1,X2,...)
%
% Create a matrix C which represents the concatenation of a series of matrices
% X1,X2,... over dimension dim. The matrices X1,X2,... can be special matrix
% objects. The resulting matrix C behaves as a regular matrix.

function retval = CatBlockMat(dim,varargin)

self.d = 1:2; % only for matrices now
self.dim = dim;
self.B = varargin;
self.N = length(varargin);
self.i = zeros(self.N+1,1);

self.sz = size(self.B{1});
self.sz(dim) = 0;


for i=1:self.N
  sz = size(self.B{i});
  
    if any(self.sz(self.d ~= dim) ~= sz(self.d ~= dim))
        error('arguments dimensions are not consistent.');
    end

  self.i(i+1) = self.i(i) + sz(dim);
end

self.sz(dim) = self.i(end);

retval = class(self,'CatBlockMat');


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
