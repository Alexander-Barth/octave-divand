% Solve the variational problem with the contraints from EOFs.
%
% [fi,s] = divand_solve_eof(s,yo,EOF_lambda,EOF)
%
% Derive the analysis based on all contraints included in s and using the 
% observations yo and EOFs
%
% Input:
%   s: structure created by divand_factorize
%   yo: value of the observations
%   EOF_lambda: weight of each EOF (adimentional)
%   EOF: matrix containing the EOFs (units m^(-n/2))
%
% Output:
%   fi: analyzed field
%   s.E: scaled EOFs


function [fi,s] = divand_solve_eof(s,yo,EOF_lambda,EOF)

H = s.H;
sv = s.sv;
R = s.R;
P = s.P;
E = s.E;


r = size(E,2);

%E = zeros(s.sv.n,r);
%for i=1:r  
%  E(:,i) = statevector_pack(sv,EOF(:,i));
%end

yo2 =  (H'* (R \ yo(:)));

% "classical analysis"
xa = P * yo2;

% apply Pa to all EOFs
PaE = P * E;

%keyboard

M = E'*PaE - eye(r);

% analysis with EOFs
xa = xa - PaE * pinv(M) * (E'*xa);

[fi] = statevector_unpack(sv,xa);

fi(~s.mask) = NaN;


% debugging information
s.cond = cond(M);
%lam = eig(M);
%s.lambda_min = min(lam);

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
