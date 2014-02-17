% Diagonal elements.
% 
% d = diag(C)
%
% Return the diagonal elements of the CovarLanczos matrix C. 

function d = diag(self)

N = size(self.Q,1);
d = zeros(N,1);

for i=1:N
  d(i) = self.Q(i,:) * (self.T \ self.Q(i,:)');
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
