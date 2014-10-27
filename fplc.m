function dccoeff = fplc(x, c, q, k)

y = (fix((c*x*c)./q));
dccoeff = y(1,1);
