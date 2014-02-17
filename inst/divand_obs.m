% Include the constrain from the observations.
%
% s = divand_obs(s,xi,x,lambda,I)
%
% Set observations of variational problem.
% It is assumed that the each coordinate depends only on one
% index. If this is not the case, then matrix I must be provided.
%
% Input:
%   s: structure created by divand_background
%   xi: coordinates of observations*
%   x: coordinates of grid*
%   lambda: signal-to-noise ratio of observations
%   I (optional): fractional indexes of location of observation 
%     within the grid
%
% Output:
%   s: structure to be used by divand_factorize
%
% Note:
%   *these parameters can either be specified as a cell
%   array of all dimenions:
%   xi = {Xi,Yi,Zi}
%   or as n+1 dimensional array

function c = divand_obs(s,xi,x,yo,lambda,I)

if nargin == 5
  I = [];
end

xi = cat_cell_array(xi);
x = cat_cell_array(x);
  
mask = s.mask;
iscyclic = s.iscyclic;
moddim = s.moddim;


if isempty(I)
  I = localize_separable_grid(x,mask,xi);
end

[H,out] = sparse_interp(mask,I,iscyclic);

nout = sum(out);
if nout ~= 0
  fprintf(1,'Observations out of domain: %d\n',nout);
end


H = H * sparse_pack(mask)';

% iB is scaled such that diag(inv(iB)) is 1 far from the
% boundary

if isscalar(lambda)
  R = 1/lambda * speye(size(H,1));
elseif isvector(lambda)
  R = sparse_diag(lambda);
else
  R = lambda;    
end

c.H = H;
s.out = out;
c.R = R;
c.yo = yo;

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
