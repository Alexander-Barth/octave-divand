% Size of a CovarParam matrix.
%
% sz = size(C)
% sz = size(C,dim)
%
% Return the size of the CovarParam C matrix. If dim is specified, then only 
% the size along dimension dim is returned.

function sz = size(self,dim);

sz = [self.m, self.m];

if nargin == 2
    sz = sz(dim);
end


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
