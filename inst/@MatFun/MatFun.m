% Matrix operator object based on a function handel.
%
% MF = MatFun(sz,fun,funt,isvec)
%
% Create a operator of size sz based on the linear function fun and its adjoint 
% funt. For a matrix X of approriate size:
%
% MF*X is fun(X) and MF'*X is funt(X)
% 
% If isvec is 0 (default), then the function must be applied on the columns of X
% individually, otherwise fun and funt are assumed to be "vectorized". 

function retval = MatFun(sz,fun,funt,isvec)

if nargin == 3
  isvec = 0;
end

self.sz = sz;
self.fun = fun;
self.funt = funt;
self.isvec = isvec;

retval = class(self,'MatFun');

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
