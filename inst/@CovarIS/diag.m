% Diagonal elements.
% 
% d = diag(C)
%
% Return the diagonal elements of the CovarIS matrix C. 

function d = diag(self)

N = size(self.IS,1);
d = zeros(N,1);


if self.f  
  t0 = cputime;

  for i=1:N
    % show progress every 5 seconds
    if (t0 + 5 < cputime)
      t0 = cputime;
      fprintf('%d/%d\n',i,N);
    end
    
    d(i) = self.PP(i,:) * (self.RP \ (self.RP' \ self.PP(i,:)'));
  end
else
  disp('factorize CovarIS');
  self_fact = factorize(self);
  d = diag(self_fact);
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
