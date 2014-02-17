% Subreference of a CatBlockMat matrix.
%
% B = subsref(C,idx)
%
% Perform the subscripted element selection operation according to
% the subscript specified by idx.
%
% See also: subsref.

function B = subsref(self,S)

if strcmp(S.type,'()')           
    i = S.subs{self.dim};
    l = find(self.i+1 == i(1));
    
    itest = self.i(l)+1:self.i(l+1);
    
    if any(i ~= itest) || ~all(strcmp(':',S.subs(self.d ~= self.dim)))
        error('only whole blocks can be referenced');
    end
    
    B = self.B{l};    
else
    error('Attempt to reference field of non-structure array');
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
