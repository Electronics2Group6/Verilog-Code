clear

x = imread('./lena.tif');
y = imread('./iqidct.tif');

orig = double(x);
recon = double(y);
[m n] = size(orig);
psnr = 10 * log10(((255^2)*m*n)/(sum(sum((orig-recon).^2))))