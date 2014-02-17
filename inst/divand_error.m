% Compute the expected error variance of the analysis.
%
% err = divand_error(s)
%
% Compute the expected error variance of the analysis based on the
% background error covariance, observation error covariance and data
% distribution.
%
% Input:
%   s: structure created by divand_factorize
%
% Output:
%   err: expected error variance of the analysis


function err = divand_error(s)

H = s.H;
sv = s.sv;
N = sum(s.mask(:)==1);
n = s.n;

errp = zeros(N,1);

if s.primal  
  errp = diag(s.P);
  
  %global P_CL
  %errp = diag(P_CL);
else
  %dual  
  B = s.B;
  R = s.R;
  
  % fun(x) computes (H B H' + R)*x
  fun = @(x) H * (B * (H'*x)) + R*x;    
  t0 = cputime;

  for i=1:N
    % show progress every 5 seconds
    if (t0 + 5 < cputime)
      t0 = cputime;
      fprintf('%d/%d\n',i,N);
    end
  
    e = zeros(N,1);
    e(i) = 1;
    % analyzed covariance
    % P = B - B * H' * inv(H * B * H' + R) * H * B
    % analyzed variance
    % P = e' B e - e' * B * H' * inv(H * B * H' + R) * H * B * e
        
    Be = B * e;
    errp(i) = e' * Be;
    HBe = H*Be;
    %keyboard
    
    % tmp is inv(H * B * H' + R) * H * B * e
    %tic
    [tmp,flag,relres,iter] = pcg(fun, HBe,s.tol,s.maxit,s.funPC);
    %toc

    if (flag ~= 0)
        error('divand:pcg', ['Preconditioned conjugate gradients method'...
            ' did not converge %d %g %g'],flag,relres,iter);
    end
    
    errp(i) = errp(i) - HBe' * tmp;
  end  
end

err = statevector_unpack(sv,errp);
err(~s.mask) = NaN;

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
