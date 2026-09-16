\\ 12-rs-curves.gp : the two "elliptic reducibility curves" of Ramsden-Sharipov arXiv:1208.1227 (eqs 2.7, 2.8): conductor, j, rank
default(parisize, 128000000);
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
{
foreach([-7*x^4+40*x^3-84*x^2+80*x-28, x^4-8*x^3+12*x^2-16*x+4], pol,
  my(E = Eq(pol), Em = ellminimalmodel(E));
  printf("curve y^2 = %s : conductor %d, j = %s, torsion %s, ellrank %s, quartic disc = %s\n", pol, ellglobalred(Em)[1], Em.j, elltors(Em)[2], ellrank(Em)[1..2], poldisc(pol));
);
}
