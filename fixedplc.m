function y = fixedplc(x, c, q, k)
y = (fix((c*x*c')./q)); % Compute DCTQ. 
if k < 14
    y = prune(y,k);     % Call the pruning function to prune DCTQ
end
y = fix(c'*(y.*q)*c);   % Compute IQIDCT to reconstruct the frame. 