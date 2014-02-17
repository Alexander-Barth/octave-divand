% Display a message in a color (without a newline).
%
% colormsg(msg,color)
%
% The message msg in printed on the terminal the specified color. Acceptable 
% values color color are:
%   black  
%   red    
%   green  
%   yellow 
%   blue   
%   magenta
%   cyan   
%   white  
%
% In Matlab the message is displayed in black (due to the lack of ANSI escape 
% code support).
%
% See also
%   colordisp

function colormsg (msg,color)

%getenv('TERM')
%if strcmp(getenv('TERM'),'xterm') % && exist('puts') > 1
% only in octave
if exist('puts') > 1
  esc = char(27);          

  % ANSI escape codes
  colors.black   = [esc, '[40m'];
  colors.red     = [esc, '[41m'];
  colors.green   = [esc, '[42m'];
  colors.yellow  = [esc, '[43m'];
  colors.blue    = [esc, '[44m'];
  colors.magenta = [esc, '[45m'];
  colors.cyan    = [esc, '[46m'];
  colors.white   = [esc, '[47m'];

  reset = [esc, '[0m'];
  
  c = getfield(colors,color);
           
  %oldpso = page_screen_output (0);

  try
    fprintf([c, msg, reset]);
    %puts (reset); % reset terminal
  catch
    %page_screen_output (oldpso);
  end
else
  fprintf(msg);
end
           


% Copyright (C) 2004 Alexander Barth <a.barth@ulg.ac.be>
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
