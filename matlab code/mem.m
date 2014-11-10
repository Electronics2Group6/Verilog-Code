function mem(blk8,col,fp);

for i = 1:8
    hextr = [];
    for j = 1:8
        if col == 1
            num = blk8(j,i);
        else
            num = blk8(i,j);
        end
        
        temp = dec2hex(num,2)
        hexstr = [hexstr temp];
    end
    
    fprintf(fp,'%s\n',hexstr);
end