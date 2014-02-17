% Testing divand in 2 dimensions in a cyclic domain.

% grid of background field
n = 30;

[xi,yi] = ndgrid(0:n-1);

x = xi(2,15);
y = yi(2,15);
f = 1;

mask = ones(size(xi));
pm = ones(size(xi)) / (xi(2,1)-xi(1,1));
pn = ones(size(xi)) / (yi(1,2)-yi(1,1));



fi = divand(mask,{pm,pn},{xi,yi},{x,y},f,5,200,'moddim',[n 0]);
rms_diff = [];

rms_diff(end+1) = divand_rms(fi(end,:),fi(4,:));


x = xi(2,2);
y = yi(2,2);

fi = divand(mask,{pm,pn},{xi,yi},{x,y},f,5,200,'moddim',[n n]);

rms_diff(end+1) = abs(fi(4,4) - fi(end,end));


fi2 = divand(mask,{pm,pn},{xi,yi},{x,y},f,5,200,'moddim',[n 0],'fracindex',[0.5; 15.]);
fi3 = divand(mask,{pm,pn},{xi,yi},{x,y},f,5,200,'moddim',[n 0],'fracindex',[30.5; 15.]);
rms_diff(end+1) = divand_rms(fi2,fi3);



fi3 = divand(mask,{pm,pn},{xi,yi},{x,y},f,5,200,'moddim',[n 0],'fracindex',[10.5; 15.]);
fi4 = cat(1,fi3(11:end,:),fi3(1:10,:));

rms_diff(end+1) = divand_rms(fi2,fi4);





% test with mask
mask(11,4) = 0;
mask(3:15,20) = 0;

fi3 = divand(mask,{pm,pn},{xi,yi},{x,y},f,5,200,'moddim',[n 0],'fracindex',[10.5; 15.]);
fi4 = cat(1,fi3(11:end,:),fi3(1:10,:));

mask = cat(1,mask(11:end,:),mask(1:10,:));

fi2 = divand(mask,{pm,pn},{xi,yi},{x,y},f,5,200,'moddim',[n 0],'fracindex',[0.5; 15.]);


rms_diff(end+1) = divand_rms(fi2,fi4);
rms_diff(end+1) = divand_rms(isnan(fi2),isnan(fi4));

% advection

a = 5;
u = a*cos(2*pi*yi/n);
v = a*cos(2*pi*xi/n);

mask = ones(size(xi));
fi = divand(mask,{pm,pn},{xi,yi},{x,y},f,5,200,'moddim',[n 0],'fracindex',[10.5; 15.],'velocity',{u,v});
fi2 = cat(1,fi(11:end,:),fi(1:10,:));

ut = cat(1,u(11:end,:),u(1:10,:));
vt = cat(1,v(11:end,:),v(1:10,:));
fi3 = divand(mask,{pm,pn},{xi,yi},{x,y},f,5,200,'moddim',[n 0],'fracindex',[0.5; 15.],'velocity',{ut,vt});

rms_diff(end+1) = divand_rms(fi2,fi3);

if any(rms_diff > 1e-10) || any(isnan(rms_diff))
  error('unexpected large difference');
end

fprintf('(max rms=%g) ',max(rms_diff));

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
