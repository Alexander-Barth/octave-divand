% Matrix left division A \ B.
%
% p = mldivide(A,B)
%
% Return the matrix product between the inverse of CovarParam matrix A and 
% another matrix B.

function q = mldivide(self,b)

q = zeros(size(b));
b = self.S \ b; 

for i=1:size(b,2)
  M = [];
  %M = @(x) ifft(x);
  
  if 1
    [q(:,i),flag,relres,iter] = pcg(@(x) mtimescorr(self,x), b(:,i),self.tol,self.maxit,M);
  else
    
    [q(:,i),flag,relres,iter] = pcg(@(x) fft(mtimescorr(self,ifft(x))), fft(b(:,i)),self.tol,self.maxit,M);
    q(:,i) = real(ifft(q(:,i)));
  end

  
    if flag > 0
        relres,iter
        warning('divand:pcgFlag','pcg flag %d',flag);
    end
end

q = self.S \ q; 

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
