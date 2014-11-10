function [image] = imagewrite(blks,rows,cols,size)

n = 1;

for i = 0:size*cols:rows*cols - size*cols
    for j = i+1:size:i+cols-size+1
        for k = 0:1:size-1
            for m = 0:1:size-1
                image(j+k*cols+m) = blks(n);
                n = n+1;
            end
        end
    end
end