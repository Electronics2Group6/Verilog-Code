function [image] = write_image(filename,rows,cols,blksize);

file_in = [filename,'.txt'];
file_out = [filename,'.raw'];
fp1 = fopen(file_in,'r');
fp2 = fopen(file_out,'w');
blks = fscanf(fp1,'%d');

image = imagewrite(blks,rows,cols,blksize);
fprintf(fp2,'%c');

fclose('all');