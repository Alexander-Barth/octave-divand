% Compute the sum.
%
% S = sum (X, DIM)
%
% Compute the sum along dimension DIM.


function d = sum(self,i)

t = cell(1,self.N);

for l=1:self.N
    t{l} = sum(self.B{l},i);
end

d = cat(3-i,t{:});