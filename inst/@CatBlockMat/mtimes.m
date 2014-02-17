% Matrix product A*B.
%
% p = mtimes(A,B)
%
% Return the matrix product between the CatBlockMat A and another matrix B.

function p = mtimes(A,B)

if size(A,2) ~= size(B,1)
    error('Inner matrix dimensions must agree.');
end

if isa(A,'CatBlockMat')
    
    if A.dim == 1
        p = zeros(size(A,1),size(B,2));
        
        for l=1:A.N
            i = A.i(l)+1:A.i(l+1);
            p(i,:) = A.B{l} * B;
        end
    else
        for l=1:A.N
            i = (A.i(l)+1) :A.i(l+1);
            
            % must use subsref explicetly
            % subsref(B,S) = B(i,:)
            % http://www.mathworks.com/support/solutions/en/data/1-18J9B/
            
            S.type = '()';
            S.subs = {i, ':'};
            tmp = A.B{l} * subsref(B,S);
            
            if l==1
                p = tmp;
            else
                p = p + tmp;
            end
        end        
    end
    
elseif isa(B,'CatBlockMat') && B.dim == 2
    p = zeros(size(A,1),size(B,2));
    
    for l=1:B.N
        j = B.i(l)+1:B.i(l+1);
        p(:,j) = A * B.B{l};
    end    
else
    warning('divand:fullmat','use full matrices for product');
    p = full(A) * full(B);
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
