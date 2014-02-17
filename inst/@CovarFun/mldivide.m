% Matrix left division A \ B.
%
% p = mldivide(A,B)
%
% Return the matrix product between the inverse of CovarParam A and another
% matrix B using pcg.

function p = mldivide(self,b)

if size(self,2) ~= size(b,1)
    error('Inner matrix dimensions must agree.');
end

if isempty(self.M1)
    args = {self.pc};
else
    args = {self.M1,self.M2};
end

for i= 1:size(b,2)
    
    [p(:,i),flag,relres,iter] = pcg(self.fun, b(:,i), self.tol,...
        self.maxit,args{:});    
    
    %whos b
    self.pc
    fprintf('iter %d %g \n',iter,relres);
    if (flag ~= 0)
        error('CovarFun:pcg', ['Preconditioned conjugate gradients method'...
            ' did not converge %d %g %g'],flag,relres,iter);
    end
    
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
