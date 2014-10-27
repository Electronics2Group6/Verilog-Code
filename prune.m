function y = prune(y, k)
%Sets how much of the image pixels is saved from the original and used to 
%reconstruct the image.
B = zeros(8, 8);
Y = fliplr(y);
% for j=k:-1:-8
%   y2 = spdiags(B,j,Y);
%   y = full(y2)
% end

% Y = triu(Y,k);
y = fliplr(Y);
