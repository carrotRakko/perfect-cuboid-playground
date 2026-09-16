\\ Known face cuboid (104,153,672): face (153,104,185) = (p,q)=(13,4); third edge 672; b^2+c^2=680^2, a^2+b^2+c^2=697^2, a^2+c^2 irrational.
\\ Which reading of EF4 contains the corresponding point x = c^2 = 672^2 ?
p=13; q=4; a=p^2-q^2; b=2*p*q; d=p^2+q^2; s=a+b; c=672;
print("a b d a+b = ", [a,b,d,s]);
print("text curve x(x+b^2)(x+d^2): x=c^2 -> x+b^2 sq? ", issquare(c^2+b^2), "  x+d^2 sq? ", issquare(c^2+d^2));
print("displayed EF4 x(x+b^2)(x+(a+b)^2): x+(a+b)^2 sq? ", issquare(c^2+s^2));
Etxt = ellinit([0, b^2+d^2, 0, b^2*d^2, 0]); Edef = ellinit([0, b^2+s^2, 0, b^2*s^2, 0]);
print("text curve ellrank: ", ellrank(Etxt)[1..2], "   displayed EF4 ellrank: ", ellrank(Edef)[1..2]);
P = [c^2, c*680*697]; print("point on text curve? ", ellisoncurve(Etxt, P));
