function A = pic(v,M,N)
% A = pic(v,M,N), where A is M by N matrix and v is M*N vector, 
%   obtained through reshaping the v into a square matrix
%   For example:
%     v = [1;3;2;4], A = pic(v,2,2) results in A = [1 2;3 4]
%

A = reshape(v,M,N);

end
