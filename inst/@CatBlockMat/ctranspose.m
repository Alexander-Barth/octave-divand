% Conjugate transpose of a CatBlockMat matrix.
%
% T = ctranspose(C)
%
% Returns the conjugate transpose of matrix C.


function T = ctranspose(self)

B = cell(1,self.N);

for l=1:self.N
    B{l} = self.B{l}';
end

d = 3-self.dim;
T = CatBlockMat(d,B{:});


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
