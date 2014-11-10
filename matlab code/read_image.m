function read_image(filename,rows,cols,blksize);

file_in = [filename,'.raw'];
file_out = [filename,'.text'];

fp1 = fopen(file_in,'r');
fp2 = fopen(file_out,'w');
image = fscanf(fp1,'%c');

blks = imageread(image,rows,cols,blksize);

blkn = [];
n = 1;

for k = 1:1024
    for i = 1:8
        for j = 1:8
            oneblk(i,j) = blks(n);
            n = n + 1;
        end
    end
    mem(oneblk,0,fp2);
end

% fclose('all');