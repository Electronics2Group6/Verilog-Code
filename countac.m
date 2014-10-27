function accoeff = countac(x,c,q,k)
%Round the resultant of the basis and transposed basis over the max
%Result must be an unsigned integer matrix
y = (fix((c*x*c')./q));
    if k < 14
        y = prune(y,k);
    end
accoeff = acbits(y);
