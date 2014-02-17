% Form the inverse of the background error covariance matrix.
%
% s = divand_background(mask,pmn,Labs,alpha,moddim)
%
% Form the inverse of the background error covariance matrix with
% finite-difference operators on a curvilinear grid
%
% Input:
%   mask: binary mask delimiting the domain. 1 is inside and 0 outside.
%         For oceanographic application, this is the land-sea mask.
%
%   pmn: scale factor of the grid.
%
%   Labs: correlation length
%
%   alpha: a dimensional coefficients for norm, gradient, laplacian,...
%      alpha is usually [1 2 1]. 
%       
%
% Output:
%   s: stucture containing
%   s.iB: inverse of the background error covariance
%   s.L: spatial average correlation length
%   s.n: number of dimenions
%   s.coeff: scaling coefficient such that the background variance
%     diag(inv(iB)) is one far away from the boundary.

function s = divand_background(mask,pmn,Labs,alpha,moddim,mapindex)

sz = size(mask);
% number of dimensions
pmn = cat_cell_array(pmn);
n = size(pmn,ndims(pmn));

if isempty(moddim)
  moddim = zeros(1,n);
end

if nargin == 5 
    mapindex = [];
end

iscyclic = moddim > 0;


if isscalar(Labs)
    Labs = Labs * ones([size(mask) n]);
elseif iscell(Labs)
    for i=1:n
        if isscalar(Labs{i})
            Labs{i} = Labs{i} * ones(size(mask));
        else
            if ~isequal(size(mask),size(Labs{i}))
                error('mask (%s) and correlation length (%s) have incompatible size',...
                      formatsize(size(mask)),formatsize(size(Labs{i})));
            end            
        end
    end
    
    Labs = cat_cell_array(Labs);
else
    if ~isequal(size(mask),size(Labs))
        error('mask (%s) and correlation length (%s) have incompatible size',...
              formatsize(size(mask)),formatsize(size(Labs)));
    end
    
    Labs = repmat(Labs,[ones(1,ndims(mask)) n]);
end

if isempty(alpha)
  % kernel should has be continuous derivative
  
  % highest derivative in cost function
  m = ceil(1+n/2);
  
  % alpha is the (m+1)th row of the Pascal triangle:
  % m=0         1
  % m=1       1   1
  % m=1     1   2   1
  % m=2   1   3   3   1
  % ...
  
  alpha = arrayfun (@(k) nchoosek(m,k), 0:m);
end

%if ~isequal([size(mask) n],size(pmn))
%  error('mask (%s) and metric (%s) have incompatible size',formatsize(size(mask)),formatsize(size(pmn)));
%end

s = divand_operators(mask,pmn,Labs.^2,iscyclic,mapindex);
D = s.D; % laplacian (a dimensional, since nu = Labs.^2)
sv = s.sv;
n = s.n;


% Labsp: 1st index represents the dimensions
Labsp = permute(Labs,[n+1 1:n]);
pmnp = permute(pmn,[n+1 1:n]);

% must handle the case when Labs is zero in some dimension
% thus reducing the effective dimension

% mean correlation length in every dimension
Ld = mean(reshape(Labsp,[n sv.numels_all]),2);
neff = sum(Ld > 0);
%L = mean(Ld(Ld > 0));

% geometric mean
L = geomean(Ld(Ld > 0));


% norm taking only dimension into account with non-zero correlation
% WE: units length^(neff/2)
d = prod(pmnp(find(Ld > 0),:),1)';
WE = sparse_diag(statevector_pack(sv,1./sqrt(d)));


% scale iB such that the diagonal of inv(iB) is 1 far from
% the boundary
% we use the effective dimension neff to take into account that the
% correlation length-scale might be zero in some directions

Ln = prod(Ld(Ld > 0));

if any(Ld <= 0)   
   pmnd = mean(reshape(pmnp,[n sv.numels_all]),2);
   %Ln = Ln * prod(pmnd(Ld <= 0)); 
end


coeff = divand_kernel(neff,alpha) * Ln; % units length^n

pmnv = reshape(pmn,numel(mask),n);
pmnv(:,Ld == 0) = 1;

% staggered version of norm

for i=1:n
  S = sparse_stagger(sz,i,iscyclic(i));
  ma = (S * mask(:) == 1);
  d = sparse_pack(ma) * prod(S * pmnv,2);
  d = 1./d;
  s.WEs{i} = sparse_diag(sqrt(d));
end

% staggered version of norm scaled by length-scale

s.WEss = cell(n,1);
s.Dxs = cell(n,1);
for i=1:n
  Li2 = Labsp(i,:).^2;
  
  S = sparse_stagger(sz,i,iscyclic(i));
  % mask for staggered variable
  m = (S * mask(:) == 1);
  
  tmp = sparse_pack(m) * sqrt(S*Li2(:));
  
  s.WEss{i} = sparse_diag(tmp) * s.WEs{i};
%  s.Dxs{i} = sparse_diag(sqrt(tmp)) * s.Dx{i};
end

% adjust weight of halo points
if ~isempty(mapindex)
  % ignore halo points at the center of the cell

  WE = sparse_diag(s.isinterior) * WE;

  % divide weight be two at the edged of halo-interior cell
    % weight of the grid points between halo and interior points 
    % are 1/2 (as there are two) and interior points are 1    
  for i=1:n
    s.WEs{i} = sparse_diag(sqrt(s.isinterior_stag{i})) * s.WEs{i};  
  end
end

s.WE = WE;
s.coeff = coeff;
% number of dimensions
s.n = n;

[iB_,iB] = divand_background_components(s,alpha);

if 0
iB_ = cell(length(alpha),1);

% constrain of total norm

iB_{1} =  (1/coeff) * (WE'*WE);


% loop over all derivatives

for j=2:length(alpha)    
    % exponent of laplacian
    k = floor((j-2)/2);
        
    if mod(j,2) == 0
        % constrain of derivative with uneven order (j-1)
        % (gradient, gradient*laplacian,...)
        % normalized by surface
                
        iB_{j} = sparse(size(D,1),size(D,1));
        
        for i=1:n
            Dx = s.WEss{i} * s.Dx{i} * D^k;
            
            iB_{j} = iB_{j} + Dx'*Dx;
        end                
    else
        % constrain of derivative with even order (j-1)
        % (laplacian, biharmonic,...)
        
        % normalize by surface of each cell
        % such that inner produces (i.e. WE'*WE)
        % become integrals
        % WD: units length^(n/2)
        
        WD = WE * D^(k+1);
        iB_{j} = WD'*WD;
    end
    
    iB_{j} = iB_{j}/coeff;
end


% sum all terms of iB
% iB is adimentional
iB = alpha(1) * iB_{1};
for j=2:length(alpha)    
  iB = iB + alpha(j) * iB_{j};
end

s.coeff = coeff;
end

% inverse of background covariance matrix
s.iB = iB;

% individual terms of background covariance matrix (corresponding alpha)
s.iB_ = iB_;

s.L = L;
s.Ln = Ln;

s.moddim = moddim;
s.iscyclic = iscyclic;

s.alpha = alpha;
s.neff = neff;
s.WE = WE; % units length^(n/2)
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
