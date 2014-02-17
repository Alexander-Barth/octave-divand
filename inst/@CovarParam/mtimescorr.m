% Matrix product with correlation matrix.
%
% p = mtimescorr(A,B)
%
% Return the matrix product between the CovarParam matrix A (with unit variance)
% and another matrix B.


function p = mtimescorr(self,b)

m = self.m;
p = zeros(size(b));

% for j=1:m
%     for i=1:m
%         d2 = sum( (self.xi(i,:) - self.xi(j,:)).^2 );
%         p(i) = p(i) + exp(-d2 / self.len^2) * b(j);
%     end
% end
%

p = mtimescorr(self.xi,self.len,b);
%p = mtimescorr_f(self.xi,self.len,b);
p = self.var_add * p + (1-self.var_add) * b;


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
