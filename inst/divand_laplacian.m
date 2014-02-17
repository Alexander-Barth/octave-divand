% Create the laplacian operator.
% 
% Lap = divand_laplacian(mask,pmn,nu,iscyclic)
%
% Form a Laplacian using finite differences
% assumes that gradient is zero at "coastline"
%
% Input:
%   mask: binary mask delimiting the domain. 1 is inside and 0 outside.
%         For oceanographic application, this is the land-sea mask.
%   pmn: scale factor of the grid. 
%   nu: diffusion coefficient of the Laplacian
%      field of the size mask or cell arrays of fields
%
% Output:
%   Lap: sparce matrix represeting a Laplaciant 
%
% 
function Lap = divand_laplacian(mask,pmn,nu,iscyclic)

pmn = cat_cell_array(pmn);

% number of dimensions
n = size(pmn,ndims(pmn));

sz = size(mask);

if nargin == 2
  nu = ones(sz);
end

if isequal(sz,size(nu))
  % assume diffusion is the same along all dimensions
  nu = repmat(nu,[ones(1,n) n]);
end

% nu: 1st index represents the dimensions 
nu = permute(nu,[n+1 1:n]);

% extraction operator of sea points
H = sparse_pack(mask==1);


sz = size(mask);

%DD = sparse(0);
DD = sparse(prod(sz),prod(sz));

Pmn = reshape(pmn,[prod(sz) n]);    
for i=1:n
  % operator for staggering in dimension i
  S = sparse_stagger(sz,i,iscyclic(i));

  % d = 1 for interfaces surounded by water, zero otherwise
  d = S * mask(:) == 1;
  
  % metric
  for j = 1:n
    tmp = S * Pmn(:,j);
    
    if j==i
      d = d .* tmp;
    else
      d = d ./ tmp;
    end  
  end
  
  % tmp: "diffusion coefficient"  along dimension i  
  tmp = nu(i,:);
  
  %whos tmp d S nu
  %keyboard
  d = d .* (S * tmp(:));

  % Flux operators D
  % zero at "coastline"
  
  D = sparse_diag(d) * sparse_diff(sz,i,iscyclic(i));
  szt = sz;
  
  if ~iscyclic(i)
    % extx: extension operator
    szt(i) = szt(i)+1;
    extx = sparse_trim(szt,i)';
  
    D = extx * D;
  else
    % shift back one grid cell along dimension i
    D = sparse_shift(sz,i,iscyclic(i))' * D;
  end
  
  % add laplacian along dimension i  
  DD = DD + sparse_diff(szt,i,iscyclic(i)) * D;  
end

ivol = prod(pmn,n+1);

% Laplacian on regualar grid DD
DD = sparse_diag(ivol) * DD;

% Laplacian on grid with on sea points Lap
Lap = H * DD * H';



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
