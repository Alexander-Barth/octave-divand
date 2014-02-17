% Subreference of a CovarParam matrix.
%
% B = subsref(C,idx)
%
% Perform the subscripted element selection operation according to
% the subscript specified by idx.
%
% See also: subsref.

function C = subsref(self,idx)

assert(strcmp(idx.type,'()'))

i = idx.subs{1};
j = idx.subs{2};

assert(isequal(i,j));


C = CovarParam(self.xi(i,:),self.variance(i),self.len);

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
