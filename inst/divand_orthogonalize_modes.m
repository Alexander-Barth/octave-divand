% Orthogonalize EOF modes.
%
% [U3,WE] = divand_orthogonalize_mode(mask,pmn,U)
%
% The modes U are orthogonalized using the mask and metric (pmn). WE is square 
% root of norm. Diagonal of WE.^2 is the surface of corresponding cell (units: 
% m). The output U3 represent the normalized EOFs (units: m-1)

function [U3,WE] = divand_orthogonalize_modes(mask,pmn,U);

pmn = cat_cell_array(pmn);
% number of dimensions
n = size(pmn,ndims(pmn));

sv = statevector_init(mask);
d = statevector_pack(sv,1./(prod(pmn,n+1)));

% spare root of the norm
WE = sparse_diag(sqrt(d));

U2 = statevector_pack(sv,U);
U2 = WE * U2;

r = size(U2,2);
[U3,S3,V3] = svds(U2,r);
%U3 = reshape(U3,[size(mask) r]);

U3 = inv(WE) * U3;

%assert(U3' * WE^2 * U3, eye(r),1e-8)

U3 = statevector_unpack(sv,U3);


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
