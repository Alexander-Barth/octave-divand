% Testing divand in 2 dimensions with EOF constraints.

[xi,yi] = ndgrid(linspace(0,1,30));

mask = ones(size(xi));
pm = ones(size(xi)) / (xi(2,1)-xi(1,1));
pn = ones(size(xi)) / (yi(1,2)-yi(1,1));


x = .5;
y = .5;
v = 1;

len = .1;
lambda = 10;

clear U2
U2(:,1) = mask(:);
U2(:,2) = xi(:);
U2(:,3) = yi(:);

%U2 = randn(numel(mask),10);
r = size(U2,2);
[U3,S3,V3] = svds(U2,r);
U3 = reshape(U3,[size(mask) r]);

[va,s] = divand(mask,{pm,pn},{xi,yi},{x,y},v,len,lambda,'diagnostics',1);
beta = 10;

[va_eof,s_eof] = divand(mask,{pm,pn},{xi,yi},{x,y},v,len,lambda,'EOF',U3,'EOF_scaling',beta*ones(r,1),'diagnostics',1);

[Jb,Jo,Jeof] = divand_diagnose(s,va_eof,v);

%assert(s_eof.Jb,Jb,1e-6) -> should no longer be the case since s.iB is modified to ensure that B - EE is positive defined
assert(abs(s_eof.Jo-Jo) < 1e-6)



s = s_eof;

iR = inv(full(s.R));
iB = s.iB;
H = s.H;
E = s.E;
sv = s.sv;

iP = iB + H'*iR*H;

Pa = inv(iP - E*E');

xa2 = Pa* (H'*iR*v(:));

[fi2] = statevector_unpack(sv,xa2);
fi2(~s.mask) = NaN;

rms_diff = divand_rms(va_eof,fi2);

if rms_diff > 1e-6
  error('unexpected large difference');
end

Pf = inv(iB - E*E');
R = inv(iR);
xa3 = Pf*H' * inv(H*Pf*H' + R) * v;

[fi3] = statevector_unpack(sv,xa3);
fi3(~s.mask) = NaN;

rms_diff = divand_rms(va_eof,fi3);

if rms_diff > 1e-6
  error('unexpected large difference');
end

[U,L] = eig(Pf);
L = real(diag(L));

if any(L < 0)
  error('some eingenvalues are negative');
end
  
Pfvar = inv(iB);

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
