% Compute a preconditioner using a modified incomplete Cholesky decomposition.
%
% [M1,M2] = diavnd_pc_michol(iB,H,R,icholparam)
%
% Compute preconditioner matrices M1 and M2 based on
% the inverse background error covariance iB, observation operator
% H and observation R covariance R. icholparam is a structure will parameters
% for ichol. The default value is struct('michol','on'). A modified incomplete
% Cholesky factorization of the matrix iP = iB + H'*(R\H) is computed per 
% default.
% M2 is the transpose of M1 for this preconditioner.
%
% The function ichol is necessary.
%
% See also:
% ichol, divand_pc_sqrtiB

function [M1,M2] = diavnd_pc_michol(iB,H,R,icholparam)

if nargin == 3
  icholparam = struct('michol','on');
end

iP = iB + H'*(R\H);

if which('ichol')
  M1 = ichol(iP,icholparam);
else
    warning('divand-noichol','ichol is not available')
    M1 = [];
end

M2 = M1';

% LocalWords:  preconditioner Cholesky diavnd pc michol iB icholparam ichol struct iP divand sqrtiB

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
