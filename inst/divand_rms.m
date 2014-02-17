% The RMS error between two variables.
%
% r = divand_rms(x,y,norm)
%
% Returns rms between x and y (taking norm into account if present)

% Alexander Barth
function r = divand_rms(x,y,norm)

d = x-y;

if nargin == 3
  d = d .* sqrt(norm);
end

m = ~isnan(d);
r = mean(d(m).^2);

if nargin == 3
  r = r/mean(norm(m));
end

r = sqrt(r);
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
