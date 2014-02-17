% Matrix product A*B.
%
% p = mtimes(A,B)
%
% Return the matrix product between the CovarIS matrix A and another matrix B.

function p = mtimes(self,b)

%keyboard
if self.f
  %'fact'
  p = self.PP * (self.RP \ (self.RP' \ (self.PP' * b)));
else  
%  'direct'
%  tic
%  A = (self.IS + self.IS')/2;
%  p = A \ b;
%  toc
%  tic
  p = self.IS \ b;  
%  toc
%  'end'
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
