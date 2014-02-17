% Compute metric scale factors.
%
% [pm,pn] = divand_metric(lon,lat)
%
% Compute metric scale factors pm and pn based on 
% longitude lon and latitude lat. The variables pm and pn
% represent the inverse of the local resolution in meters using
% the mean Earth radius.



function [pm,pn] = divand_metric(lon,lat)

sz = size(lon);
i = 2:sz(1)-1;
j = 2:sz(2)-1;


dx = distance(lat(i-1,:),lon(i-1,:),lat(i+1,:),lon(i+1,:));
dx = cat(1,dx(1,:),dx,dx(end,:));

dy = distance(lat(:,j-1),lon(:,j-1),lat(:,j+1),lon(:,j+1));
dy = cat(2,dy(:,1),dy,dy(:,end));

dx = real(dx);
dy = real(dy);

dx = deg2m(dx);
dy = deg2m(dy);


pm = 1./dx;
pn = 1./dy;

end

function dy = deg2m(dlat)
% Mean radius (http://en.wikipedia.org/wiki/Earth_radius)
R = 6371.009e3;

dy = dlat*(2*pi*R)/360;
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
