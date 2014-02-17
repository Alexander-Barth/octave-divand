% Subreference of a CovarIS matrix.
%
% B = subsref(C,idx)
%
% Perform the subscripted element selection operation according to
% the subscript specified by idx.
%
% See also: subsref.

function x = subsref(self,idx)

assert(length(idx) == 1)
assert(strcmp(idx.type,'()'))
N = size(self.IS,1);

i = idx.subs{1};

if strcmp(i,':')
    i = 1:N;
end

j = idx.subs{2};

if strcmp(j,':')
    j = 1:N;
end

x = zeros(length(i),length(j));

if self.f  
  t0 = cputime;

  k = 0;
  for jj=1:length(j)
    for ii=1:length(i)
      
      % show progress every 5 seconds
      if (t0 + 5 < cputime)
        t0 = cputime;
        fprintf('%d/%d\n',k,numel(x));
      end
    
      x(ii,jj) = self.PP(i(ii),:) * (self.RP \ (self.RP' \ self.PP(j(jj),:)'));
      k = k+1;
    end
  end
else
  disp('factorize CovarIS');
  self_fact = factorize(self);
  x = subsref(self_fact,idx);
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
