% Matrix left division A \ B.
%
% p = mldivide(A,B)
%
% Return the matrix product between the inverse of DiagBlockMat A and another
% matrix B

function p = mldivide(self,b)

if size(self,2) ~= size(b,1)
    error('Inner matrix dimensions must agree.');
end


if isa(b,'CatBlockMat')
    B = {};
    for l=1:self.N
        B{l} = self.B{l} \ b(self.j(l)+1:self.j(l+1),:);
    end
    
   p = CatBlockMat(1,B{:});
else
    
    p = zeros(size(self,1),size(b,2));
    
    for l=1:self.N
        p(self.i(l)+1:self.i(l+1),:) = self.B{l} \ b(self.j(l)+1:self.j(l+1),:);
    end
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
