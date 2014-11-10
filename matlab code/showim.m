function showim(file1,file2)

fp1 = fopen(file1,'r');
im1 = fscanf(fp1,'%c');
n = 1;
for i = 1:256
    for j = 1:256
        image(i,j) = uint8(double(im1(n)));
        n = n+1;
    end
end

fp1 = fopen(file2,'r');
im1 = fscanf(fp2,'%c');
n = 1;
for i = 1:256
    for j = 1:256
        recon(i,j) = uint8(double(im2(n)));
        n = n+1;
    end
end

figure
title('Original Image');
imshow(image,256);

figure
title('Reconstructed Image');
imshow(recon,256);
fclose('all');