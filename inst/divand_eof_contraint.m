% Include constraint from EOFs.
%
% s = divand_eof_contraint(s,EOF_lambda,EOF)
%
% Include the constraint from the EOF and their eigenvalues (EOF_lambda)
% in the cost function described by the structure s.
%

function s = divand_eof_contraint(s,EOF_lambda,EOF)

iB = s.iB;
sv = s.sv;
WE = s.WE;

coeff = s.coeff;

% remove land points
E = statevector_pack(sv,EOF); 
% units m^(-n/2)

% normalize by surface
% for coeff see divand_background.m
%E = WE * E;
%EOF_lambda

E = WE^2 * E * diag(sqrt(EOF_lambda / coeff)); 
%% units:  m^(n) m^(-n/2) sqrt(m^(-n)) = 1

if 0

BE = iB \ E;



A = BE * inv(E'*BE - eye(size(E,2)));
Beof_var = - sum(A .* BE,2);

% scaling factor to enshure that:
% scaling * inv(iB - E E') has a  variance of 1 far from boundaries

scaling = 1/(1 + mean(Beof_var))
scaling = 1

%disp('apply scaling')
E = 1/sqrt(scaling) * E;
iB = iB/scaling;

s.scaling = scaling;

end

s.E = E;
s.iB = iB;

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
