% Computes diagnostics for the analysis.
%
% [Jb,Jo,Jeof,J] = divand_diagnose(s,fi,d)
%
% Computes the value of different terms of the cost-function
%
% Input:
%   s: structure created by divand_solve
%   fi: analysis
%   d: observations
%
% Output:
%   Jb: background constrain
%   Jeof: observation constrain
%   Jeof: EOF constrain

function [Jb,Jo,Jeof,J] = divand_diagnose(s,fi,d)

d = s.yo;
xa = statevector_pack(s.sv,fi);

Jb = xa' * s.iB * xa - s.betap * (s.WE'*xa)' * (s.WE'*xa);
Jo = (s.H*xa - d)' * (s.R \ (s.H*xa - d));

if all(s.EOF_lambda == 0)
  Jeof = 0;
else
  Jeof = s.betap * ((s.WE'*xa)' * (s.WE'*xa)) - (s.E'*xa)' * (s.E'*xa);
end

Jo = full(Jo);

J = Jb + Jo + Jeof;
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
