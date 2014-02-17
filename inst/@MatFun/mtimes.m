% Matrix product A*B.
%
% p = mtimes(A,B)
%
% Return the matrix product between the MatFun matrix A and another matrix B.

function p = mtimes(A,B)

if size(A,2) ~= size(B,1)
    error('Inner matrix dimensions must agree.');
end

if isa(A,'MatFun')  
  if A.isvec
    p = A.fun(B);
  else    
    p = zeros(size(A,1),size(B,2));
  
    for l=1:size(B,2)
      p(:,l) = A.fun(B(:,l));
    end
  end
else
  error('not implemented');
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
