function dcb = dcbits(dci2)
%Determine the value of the dc bits for the total reconstructed image
[u,v] = size(dci2);
dci2 = dci2';
dci5 = reshape(dci2,1,u*v);

dci4 = [];
dci4(1) = dci5(1);
for i = 1: ((u*v)-1)
    first = dci5(i);
    second = dci5(i+1);
    diff = second-first;
    dci4(i+1) = diff;
end

bits = 0;
for i = 1: (u*v)
    ii = abs(dci4(i));
        if ii < 2;
            bits = bits+3; 
        elseif ii < 4;
            bits = bits+4;
        elseif ii < 8;
            bits = bits+6;
        elseif ii < 16;
            bits = bits+7;
        elseif ii < 32;
            bits = bits+9;
        elseif ii < 64;
            bits = bits+11;
        elseif ii < 128;
            bits = bits+13;
        elseif ii < 256;
            bits = bits+15;
        end
end
disp('DC BITS: ')
disp(bits)
dcb = bits;
