% A realistic example of divand in 2 dimensions
% with salinity observations in the Mediterranean Sea at 30m.
%
% Data is available at 
% http://modb.oce.ulg.ac.be/mediawiki/index.php/Divand

% load observations

load data.dat

% extract columns of data
lonobs = data(:,1);
latobs = data(:,2);
S = data(:,3);                                            

% load bathymetry
% bath is negative in water and positive in air
bat = ncread('diva_bath.nc','bat');
lon = ncread('diva_bath.nc','lon');
lat = ncread('diva_bath.nc','lat');

% compute grid metric
% pm and pn are in meters^-1
[lon,lat] = ndgrid(lon,lat);     
[pm,pn] = divand_metric(lon,lat);

% compute mean and anomalies
Smean = mean(S);
Sanom = S - mean(S);

% correlation length (in meters)
len = 200e3;
len = 100e3;
% signal-to-noise ratio
lambda = 50.5;

% land-sea mask
% mask everything below 30 m
mask = bat < -30;

% mask for the analysis
maska = mask;
% remove Atlantic
maska(1:60,130:end) = 0; 
% remove Black Sea
maska(323:end,100:end) = 0;

% make analysis
Sa =  divand(maska,{pm,pn},{lon,lat},{lonobs,latobs},Sanom,len,lambda);

% add mean back
Sa2 = Sa + Smean;

% create plots

% color axis
ca = [36.2520   39.4480];

% aspect ratio
ar = [1  cos(mean(lat(:)) * pi/180) 1];


subplot(2,1,1);
scatter(lonobs,latobs,10,S)
caxis(ca);
colorbar
hold on, contour(lon,lat,mask,0.5,'k')
xlim(lon([1 end]))
ylim(lat([1 end]))
title('Observations');
set(gca,'DataAspectRatio',ar,'Layer','top')

subplot(2,1,2);
pcolor(lon,lat,Sa2), shading flat,colorbar
hold on
plot(lonobs,latobs,'k.','MarkerSize',1)
caxis(ca)
contour(lon,lat,mask,0.5,'k')
xlim(lon([1 end]))
ylim(lat([1 end]))
title('Analysis');
set(gca,'DataAspectRatio',ar,'Layer','top')

set(gcf,'PaperUnits','centimeters','PaperPosition',[0 0 15 15 ]);
print -dpng divand_realistic_example.png
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
