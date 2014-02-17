% Covariance matrix than can be inverted using the Sherman-Morrison-Woodbury 
% forumla.
%
% CSMW = CovarSMW(C,B)
%
% Create the covariance matrix CSMW = C +  B*B' than can be inverted efficiently
% using the Sherman-Morrison-Woodbury formula, if size(B,2) is much smaller than
% size(C,1):
%
% inv(C +  B*B') = inv(C) -  inv(C)*B*inv(B'*inv(C)*B +  I)*B'*inv(C) 
%
% The  symetric matrix C should implement the methods: size, diag, mtimes, 
% mldivde and the matrix B should implement the methods: size, tranpose, mtimes,
% sum.

function retval = CovarSMW(C,B)

if size(C,1) ~= size(C,2)
  error('C should be square matrix');
end

if size(C,1) ~= size(B,1)
  error('size of C and B are not compatible');
end

self.C = C;
self.B = B;
self.D = inv(B' * (C \ B) +  eye(size(B,2)));

retval = class(self,'CovarSMW');


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
