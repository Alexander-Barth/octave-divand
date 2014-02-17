% Test if divand is working correctly.

tests = {...
   'test_interp_1d',...
   'test_interp_2d',...
   'test_interp_regular',...
   'test_sparse_diff',...
   'test_1dvar',...
   'test_2dvar',...
   'test_2dvar_check',...
   'test_2dvar_adv',...
   'test_2dvar_rellen',...
   'test_2dvar_lenxy',...
   'test_2dvar_check_correrr',...
   'test_2dvar_pcg',...
   'test_2dvar_constrain',...
   'test_2dvar_cyclic',...
   'test_2dvar_eof_check',...
   'test_3dvar',...
    'test_3dvar_large_stacked',...
   'test_4dvar'};

% disable warning for full matrice product
state = warning('query','divand:fullmat');
warning('off','divand:fullmat')

for iindex=1:length(tests);

  fprintf('run %s: ',tests{iindex});
  try
    eval(tests{iindex});
    colordisp('  OK  ','green');
  catch
    colordisp(' FAIL ','red');        
    disp(lasterr)
  end
end

% restore warning state
warning(state.state,'divand:fullmat')

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