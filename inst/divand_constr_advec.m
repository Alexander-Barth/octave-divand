% Create the advection constrain.
%
% c = divand_constr_advec(s,velocity)
%
% Create the advection constrain using the specified velocity.
%
% Input:
%   s: structure created by divand_background
%   velocity: cell array of velocity vectors
%
% Output:
%   c: structure to be used by divand_addc with the following fields: R (a 
%     covariance matrix), H (extraction operator) and yo (specified value for 
%     the constrain).

function c = divand_constr_advec(s,velocity)

velocity = cat_cell_array(velocity);

% check for NaNs
nancount = sum(isnan(velocity(:)));
if nancount > 0
    error('%d velocity values are equal to NaN',nancount);
end

mask = s.mask;
n  = s.n;
iscyclic = s.iscyclic;

sz = size(mask);

A = sparse(0);

vel = reshape(velocity,numel(mask),n);



for i=1:n
  S = sparse_stagger(sz,i,iscyclic(i));
  m = (S * mask(:) == 1);
  
  d = vel(:,i);
  
  A = A + sparse_diag(d(mask==1)) * sparse_pack(mask) * S' * sparse_pack(m)' * s.Dx{i};
end

l = size(A,1);

c.H = A;
c.yo = sparse(l,1);
c.R = speye(l);


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
