% No preconditioner is used.
%
% [M1,M2] = diavnd_pc_none(iB,H,R)
%
% Dummy function for requiring that no preconditioner is used in divand.
%
% See also:
% diavnd_pc_michol, diavnd_pc_sqrtiB

function [M1,M2] = diavnd_pc_none(iB,H,R)

M1 = []; 
M2 = [];



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
