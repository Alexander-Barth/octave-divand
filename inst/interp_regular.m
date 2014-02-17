% Interpolation matrix for a n-dimensional interpolation.
%
% [H,out] = interp_regular(mask,x,xi)
%
% Creates sparse interpolation matrix H for n-dimensional interpolation problem.
%
% Input:
%   mask: binary mask delimiting the domain. 1 is inside and 0 outside.
%         For oceanographic application, this is the land-sea mask.
%   x: cell array with n elements. Every element represents a coordinate of the 
%         observations
%   xi: cell array with n elements. Every element represents a coordinate of the
%         final grid on which the observations are interpolated.
%
% Output:
%   H: sparse matrix representing the linear interpolation
%   out: 1 for each observation out of the grid, 0 otherwise

function [H,out] = interp_regular(mask,x,xi)

%I = localize_regular_grid(xi,mask,x);
I = localize_separable_grid(xi,mask,x);
[H,out] = sparse_interp(mask,I);


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
