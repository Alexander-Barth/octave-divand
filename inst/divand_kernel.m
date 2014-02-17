% Return the analytical kernel and normalization factor.
%
% [mu,K] = divand_kernel(n,alpha)
% [mu,K] = divand_kernel(n,alpha,r)
%
% Analytical (normalized) kernels for infinite domain in dimension n and for 
% coefficients alpha
% Input
%   n: number of dimensions
%   alpha: coefficients
%   r (optional): distance from origin
% Output:
%   K: kernel function evaluate at the values of r if present or a function handle
%   mu: normalization factor

function [mu,K,rh] = divand_kernel(n,alpha,r)


% remove trailling zeros
ind = max(find(alpha ~= 0));
alpha = alpha(1:ind);

m = length(alpha)-1;
K = [];
if isequal(arrayfun(@(k) nchoosek(m,k),0:m),alpha)
  % alpha are binomial coefficients
  
  [mu,K] = divand_kernel_binom(n,m);
else
  error('unsupported sequence of alpha')  
end

if nargin == 3
  % evaluate the kernel for the given values of r
  K = K(r);
end

if nargout == 3
  % determine at which distance r K(r) = 1/2
  rh = abs(fzero(@(r) K(abs(r))-.5,1));
end

end

function [mu,K] = divand_kernel_binom(n,m)


% %if isequal(alpha,1)

nu = m-n/2;
mu = (4*pi)^(n/2) * gamma(m) / gamma(nu);
K = @(x) divand_rbesselk(nu,x);

if nu <= 0
  warning('divand:nonorm','No normalization possible. Extend parameter alpha.');
  mu = 1;
end

end


function [K] = divand_rbesselk(nu,r)
r = abs(r);
K = 2/gamma(nu) * ((r/2).^nu .* besselk(nu,r));
K(r == 0) = 1;
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
