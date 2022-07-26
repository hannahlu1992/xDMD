function a = vec(A)
% a = vec(A), where A is m by n matrix and a is mn column vector
%   obtained through stacking the columns of A sequentially
%   For example:
%      A = [1 2;3 4], a = vec(A) results in a = [1;3;2;4]

a = A(:);


end

