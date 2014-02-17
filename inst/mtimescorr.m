% Product between a Gaussian covariance matrix and a vector.
%
% p = mtimescorr(xi,len,b)
%
% Compute the product between a Gaussian covariance with a length scale len and
% grid points located in xi and the vector b. The covariance matrix has a unit
% variance.

function p = mtimescorr(xi,len,b)

%'mat'
m = size(xi,1);
p = zeros(size(b));

% for j=1:m
%     for i=1:m
%         d2 = sum( (self.xi(i,:) - self.xi(j,:)).^2 );
%         p(i) = p(i) + exp(-d2 / self.len^2) * b(j);
%     end
% end
%


for i=1:m    
    X = repmat(xi(i,:),[m 1]);
    d2 = sum( (X - xi).^2, 2) ;
    ed = exp(-d2 / len^2);
    p(i,:) = ed' * b;
end

% LocalWords:  mtimescorr len

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
