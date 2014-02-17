% Create a covariance matrix based on a function handler.
%
% CF = = CovarFun(n,fun)
% CF = = CovarFun(n,fun,...)
%
% Create the covariance matrix CF of size n-by-n based on the function handler 
% fun. Optional key word parameters are:
%  'isvec': 1 if function is vectorized and 0 (default) if not.
%  'pc': function hander of the preconditioner for pcg
%  'M1','M2','matit','tol': parameters for pcg.
%
% See also: pcg


function retval = CovarFun(n,fun,varargin)

isvec = 0;
self.pc = [];
self.M1 = [];
self.M2 = [];
self.tol = 1e-6;
self.maxit = 100;

for i=1:2:length(varargin)
    if strcmp(varargin{i},'isvec')
        isvec = varargin{i+1};
    elseif strcmp(varargin{i},'pc')
        self.pc = varargin{i+1};
    elseif strcmp(varargin{i},'M1')
        self.M1 = varargin{i+1};
    elseif strcmp(varargin{i},'M2')
        self.M2 = varargin{i+1};
    elseif strcmp(varargin{i},'maxit')
        self.maxit = varargin{i+1};
    elseif strcmp(varargin{i},'tol')
        self.tol = varargin{i+1};
    else
        error('CovarFun:param','unknown param');
    end
end

self.fun = fun;

retval = class(self,'CovarFun',MatFun([n,n],fun,fun,isvec));


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
