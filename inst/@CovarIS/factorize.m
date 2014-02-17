% Factorize matrix.
% 
% self = factorize(self)
%
% Factorize matrix self using the Cholesky decomposition.

function self = factorize(self)


if issparse(self.IS)
  [self.RP, self.q, self.PP] = chol (self.IS);
   
  if self.q ~= 0
    error('factoziation failed (matrix is not positive definite)');
  end

  
  %length(find(self.PP))/numel(self.PP)
  %length(find(self.RP))/numel(self.RP)

else
  self.RP = chol(self.IS);
  self.PP = speye(size(self.IS));
end

self.f = 1;

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
