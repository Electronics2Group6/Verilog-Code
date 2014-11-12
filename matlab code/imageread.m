function [x] = imageread(image, rows, cols, size)

x = zeros(rows,cols);

for i = 0 : size*cols : rows*cols - size * cols
    for j = i + 1 : size : i + cols - size + 1
        
        for k = 0:1:size - 1
            for m = 0:1:size-1
                x = [x,image(j+k*cols + m)];
            end
        end
    end
end