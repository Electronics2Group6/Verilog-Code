clear all

p = zeros(1,1)
k = zeros(1,1)
p = 1:1:14
for i = 1:14
    if p(i) < 14
        if p(i) > 7
            k(i) = (p(i)-6)*(-1);
        elseif p <= 7
            k(i) = 6-p(i);
        end
    elseif p(i) >= 14
        k(i) = p(i);
    end
end

k