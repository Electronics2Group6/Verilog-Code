function read_image(filename,rowas,cols,blksize);

file_in = [filename,'.raw'];
file_out = [filename,'.text'];

fp1 = fopen(file_in,'r');
fp2 = fopen(fileout,'w');
image = fscanf(fp1,'%c');

blks = imageread(image,rows,cols,blksize);

blkn = [];
n = 0;

for k = 1:1024
    for i = 1:8
        for j = 1:8
            oneblk(i,j) = blks(n);
            n = n + 1;
        end
    end
    mem(oneblk,0,fp2)
end

flcose('all');