global exectime

clear all
close all

prompt = {'Image file ".tif""','Enter the start frame no. :',...
    'Enter the end frame no. :','Pruning Level: '};
dlg_title = 'Input';
num_lines = 1;
def = {'car7','0','0','1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
f1 = answer{1};
f2 = str2num(answer{2});
f3 = str2num(answer{3});
p = str2num(answer{4});

% for p = 1:14
    if p < 14
        if p > 7
            k = (p-6)*(-1);
        elseif p <= 7
            k = 6-p;
        end
    elseif p >= 14
        k = p;
    end
    
    counter = 1;
    Psnr = [];
    Bitspp = [];
    Frame = [];
    for frameno = f2:1:f3
        frameno = num2str(frameno);
        fidopen = cat(2, f1, frameno, '.tif');
        i = double(imread(fidopen));
        exectime = 0;
        
        c = [ 0.3536 0.3536 0.3536 0.3536 0.3536 0.3536 0.3536 0.3536 ;
            0.4904 0.4158 0.2778 0.0976 -0.0976 -0.2778 -0.4158 -0.4904 ;
            0.4620 0.1914 -0.1914 -0.4620 -0.4620 -0.1914 0.1914 0.4620 ;
            0.4156 -0.0976 -0.4904 -0.2778 0.2778 0.4904 0.0976 -0.4158 ;
            0.3536 -0.3536 -0.3536 0.3536 0.3536 -0.3536 -0.3536 0.3536 ;
            0.2778 -0.4904 0.0976 0.4156 -0.4158 -0.0976 0.4904 -0.2778 ;
            0.1914 -0.4620 0.4620 -0.1914 -0.1914 0.4620 -0.4620 0.1914 ;
            0.0976 -0.2778 0.4156 -0.4904 0.4904 -0.4158 0.2778 -0.0976 ];
        
        q =  [8 16 19 22 26 27 29 34 ;
            16 16 22 24 27 29 34 37 ;
            19 22 26 27 29 34 34 38 ;
            22 22 26 27 29 34 37 40 ;
            22 26 27 29 32 35 40 48 ;
            26 27 29 32 35 40 48 58 ;
            26 27 29 34 38 46 56 69 ;
            27 29 35 38 46 56 69 83];
        
        [m, n] = size(i);
        
        i2 = blkproc(i, [8 8], 'fixedplc', c, q, k);
        
        dci2 = blkproc(i, [8 8], 'fplc', c, q, k);
        
        DCB = dcbits(dci2);
        aci2 = blkproc(i, [8 8], 'countac', c, q, k);
        
        ACB = sum(sum(aci2));
        BITS = DCB + ACB;
        BPP = BITS/(m*n);
        
        %we need to scale i2 appropriately
        i2 = i2 * 255 / max(i2(:));
        
        i4 = 10*log10(((255^2)*m*n)/(sum(sum((i-i2).^2))));
        
        disp('PSNR value (in dB) is: ')
        disp(i4)
        disp('BITS PER PIXEL: ')
        disp(BPP)
        
        i5 = uint8(i); figure, imshow(i5), title('ORIGINAL IMAGE')
        i3 = uint8(i2); figure, imshow(i3), title(['RECONSTRUCTED IMAGE: pruning level',num2str(p)])
        [d] = sprintf('%2.4f %2.4f', i4, BPP);
        Psnr(counter) = i4;
        Bitspp(counter) = BPP;
        Frame(counter) = (str2num(frameno));
        counter = counter + 1;
        e = 'r';
        imwrite(i3, (cat(2, e, f1, frameno, '.tif')));
    end
% end