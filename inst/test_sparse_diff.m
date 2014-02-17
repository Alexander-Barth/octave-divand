% Testing sparse operators.

clear d
f = randn(21,30,10);

S = sparse_diff(size(f),1);
f1 = f(2:end,:,:) - f(1:end-1,:,:);
f2 = S*f(:);
d(1) = max(abs(f1(:) - f2(:)));

S = sparse_diff(size(f),2);
f1 = f(:,2:end,:) - f(:,1:end-1,:);
f2 = S*f(:);
d(2) = max(abs(f1(:) - f2(:)));


S = sparse_diff(size(f),3);
f1 = f(:,:,2:end) - f(:,:,1:end-1);
f2 = S*f(:);
d(3) = max(abs(f1(:) - f2(:)));


% cyclic

% dim 1 cyclic
fc = cat(1,f,f(1,:,:));
dfc = fc(2:end,:,:) - fc(1:end-1,:,:);

S = sparse_diff(size(f),1,true);
f2 = S*f(:);
d(4) = max(abs(dfc(:) - f2(:)));


% dim 2 cyclic
fc = cat(2,f,f(:,1,:));
f1 = fc(:,2:end,:) - fc(:,1:end-1,:);

S = sparse_diff(size(f),2,true);
f2 = S*f(:);
d(5) = max(abs(f1(:) - f2(:)));


% stagger

S = sparse_stagger(size(f),1);
f1 = (f(2:end,:,:) + f(1:end-1,:,:))/2;
f2 = S*f(:);
d(end+1) = max(abs(f1(:) - f2(:)));


% dim 1 cyclic
fc = cat(1,f,f(1,:,:));
f1 = (fc(2:end,:,:) + fc(1:end-1,:,:))/2;

S = sparse_stagger(size(f),1,true);
f2 = S*f(:);
d(end+1) = max(abs(f1(:) - f2(:)));


if any(d > 1e-6) 
  error('unexpected large difference with reference field');
end

fprintf('(max difference=%g) ',max(d));



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
