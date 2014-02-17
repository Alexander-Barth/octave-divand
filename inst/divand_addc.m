% Add a constraint to the cost function.
%
% s = divand_addc(s,constrain)
%
% Include in the structure s the specified constrain. 
%
% Input:
%   s: structure created by divand_background
%   constrain: The parameter constrain has the following fields: R (a covariance
%     matrix), H (extraction operator) and yo (specified value for the 
%     constrain).
%
% Output:
%   s: structure to be used by divand_factorize

function s = divand_addc(s,constrain)

if isfield(s,'R')
  s.R = append(s.R,constrain.R);
  s.H = append(s.H,constrain.H);
  s.yo = cat(1,s.yo,constrain.yo);
else
   s.H = CatBlockMat(1,constrain.H);
   s.R = DiagBlockMat(constrain.R);
   s.yo = constrain.yo; 
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
