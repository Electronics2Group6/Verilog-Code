function acb = acbits(y)

% look at page 343 in the book for this function information


% This computes the number of bits in AC coefficients in VLC coding scheme.
% Two arrays called ‘RL’ (runlength) & ‘level’ (value of coefficients) are
% calculated.
y = fliplr(y);
runlength = 0;
r = 1;
RL = [];
level = [];
%Use a loop to sift through each element of the deconstructed matrix
for j=6:-1:-7 % Topmost diagonal is the DC coefficient and hence skip it.
    y3 = diag(y,j); % Select elements of a diagonal.
    L = length(y3);
    k = abs(j);
    %If K is even and below 8, set b to the length of diagonal elements
    %This will make the loop sift forwards
    if k == 6 || k == 4 || k == 2 || k == 0; 
        a = 1;
        b = L;
        c = 1;
    else
    %If K is odd and below 8, set a to the length of diagonal elements
    %This will make the loop sift backwards
        a = L;
        b = 1;
        c = -1;
    end
    for h = a : c : b % 1 to ‘L’ in steps of 1 or L to 1 in steps of –1.
        check = y3(h);
        if check == 0; % If the AC coefficient is “0”,
            runlength = runlength + 1; % advance the counter.
        else level(r) = check;
            RL(r) = runlength;
            r = r + 1;
            runlength = 0;
        end 
    end % Process the next coefficient in diagonal (for ‘h’ loop).
end % Process the next coefficient in diagonal (for ‘j’ loop).
%RL
%level
% Based on the two arrays ‘RL’ and ‘level’, the number of bits
% (for encoding AC coefficients) are counted.
len = length(RL);
acbit = 0; %Set acbit to 0 so there is no garbage value
if runlength~=63; % 63 means all AC coefficients are 0.
    for x=1:1:len
        level(x) = abs(level(x));
        k = 0;
        if RL(x)==0 && level(x)<41 
            if level(x) < 2 ;
                acbit = acbit + 3; %Increment based on algorithm on pg 434
            elseif level(x) < 3 ; 
                acbit = acbit + 5 ;
            elseif level(x) < 4 ;
                acbit = acbit + 6 ;
            elseif level(x) < 5 ;
                acbit = acbit + 8 ;
            elseif level(x) < 7 ;
                acbit = acbit + 9 ;
            elseif level(x) < 8 ;
                acbit = acbit + 11 ;
            elseif level(x) < 12 ;
                acbit = acbit + 13 ;
            elseif level(x) < 16 ;
                acbit = acbit + 14 ;
            elseif level(x) < 32 ;
                acbit = acbit + 15 ;
            elseif level(x) < 41 ;
                acbit = acbit + 16 ;
            end
        elseif RL(x)==1 && level(x)<19
            if level(x) < 2 ;
                acbit = acbit + 4 ;
            elseif level(x) < 3 ;
                acbit = acbit + 7 ;
            elseif level(x) < 4 ;
                acbit = acbit + 9 ;
            elseif level(x) < 5 ;
                acbit = acbit + 11 ;
            elseif level(x) < 6 ;
                acbit = acbit + 13 ;
            elseif level(x) < 8 ;
                acbit = acbit + 14 ;
            elseif level(x) < 15 ;
                acbit = acbit + 16 ;
            elseif level(x) < 19 ;
                acbit = acbit + 17 ;
            end
        elseif RL(x)==2 && level(x)<6
            if level(x) == 1 ;
                acbit = acbit + 5 ;
            elseif level(x) == 2 ;
                acbit = acbit + 8 ;
            elseif level(x) == 3 ;
                acbit = acbit + 11 ;
            elseif level(x) == 4 ;
                acbit = acbit + 13 ;
            elseif level(x) == 5 ;
                acbit = acbit + 14 ;
            end
        elseif RL(x)==3 && level(x)<5
            if level(x) == 1 ;
                acbit = acbit + 6 ;
            elseif level(x) == 2 ;
                acbit = acbit + 9 ;
            elseif level(x) == 3 ;
                acbit = acbit + 13 ;
            elseif level(x) == 4 ;
                acbit = acbit + 14 ;
            end
        elseif RL(x)==4 && level(x)<4
            if level(x) == 1 ;
                acbit = acbit + 6 ;
            elseif level(x) == 2 ;
                acbit = acbit + 11 ;
            elseif level(x) == 3 ;
                acbit = acbit + 13 ;
            end
        elseif RL(x)==5 && level(x)<4
            if level(x) == 1 ;
                acbit = acbit + 7 ;
            elseif level(x) == 2 ;
                acbit = acbit + 11 ;
            elseif level(x) == 3 ;
                acbit = acbit + 14 ;
            end
        elseif RL(x)==6 && level(x)<4
            if level(x) == 1 ;
                acbit = acbit + 7 ;
            elseif level(x) == 2 ;
                acbit = acbit + 13 ;
            elseif level(x) == 3 ;
                acbit = acbit + 17 ;
            end
        elseif RL(x)==7 && level(x)<3
            if level(x) == 1 ;
                acbit = acbit + 7 ;
            elseif level(x) == 2 ;
                acbit = acbit + 13 ;
            end
        elseif RL(x)< 10 && level(x)<3
            if level(x) == 1 ;
                acbit = acbit + 8 ;
            elseif level(x) == 2 ;
                acbit = acbit + 13 ;
            end
        elseif RL(x)==10 && level(x)<3
            if level(x) == 1 ;
                acbit = acbit + 9 ;
            elseif level(x) == 2 ;
                acbit = acbit + 14 ;
            end
        elseif RL(x)< 14 && level(x)<3
            if level(x) == 1 ;
                acbit = acbit + 9 ;
            elseif level(x) == 2 ;
                acbit = acbit + 17 ;
            end
        elseif RL(x)< 17 && level(x)<3
            if level(x) == 1 ;
                acbit = acbit + 11 ;
            elseif level(x) == 2 ;
                acbit = acbit + 17 ;
            end
        elseif RL(x)< 22 && RL(x)>=17 ;
            acbit = acbit + 13 ;
        elseif RL(x)< 27 && RL(x)>=22 ;
            acbit = acbit + 14 ;
        elseif RL(x)< 32 && RL(x)>=27 ;
            acbit = acbit + 17 ;
        else
            k = 1;
        end
        if k == 1
            if level(x)< 128 ;
                acbit = acbit + 20;
                % Extra bits required when ESCAPE is encountered.
            elseif level(x)>128;
                acbit = acbit + 28;
            end
        end % End of calculation of bits for level(x); proceed to level(x+1).
        %disp(acbit)
    end % End of calculation for all elements in ‘level’.
end % End for runlength~=63 loop.
acbit = acbit + 2 ; % EOB (end of block) indication bits.
acb = acbit;
disp(acb);