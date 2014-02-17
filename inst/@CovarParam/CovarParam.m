% Parametric covariance matrix with a guassian kernel.
%
% C = CovarParam({x,y,...},variance,len)
%
% Creates a parametric covariance matrix C with a guassian 
% kernel, a correlation length of len and a variance of 
% variance. The first parameter is a cell array with the coordinates.

function retval = CovarParam(xi,variance,len,varargin)

xi = squeeze(cat_cell_array(xi));
m = size(xi,1);


% fun = @(xi1,xi2) exp(- sum( (xi1 - xi2).^2 , 2) / len^2);
% 
% tic
% for j=1:m    
%     for i=1:m    
%         R2(i,j) = fun(xi(i,:),xi(j,:));
%     end
% end
% toc
% 
% maxdiff(R,R2);

self.tol = 1e-6;
self.maxit = 100;
self.var_add = 1;

for i=1:2:length(varargin)
    if strcmp(varargin{i},'tolerance')
        self.tol = varargin{i+1};
    elseif strcmp(varargin{i},'maxit')
        self.maxit = varargin{i+1};
    elseif strcmp(varargin{i},'fraccorr')
        self.var_add = varargin{i+1};
    end
end
    
self.m = m;
self.xi = xi;
self.len = len;

if isscalar(variance)
  variance = ones(self.m,1) * variance;
end
  
self.variance = variance;
self.std = sqrt(variance);
self.S = sparse_diag(self.std);

retval = class(self,'CovarParam');


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
