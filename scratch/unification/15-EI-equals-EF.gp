\\ 15-EI-equals-EF.gp : dGGH's EI3, EI4 are the *same curves* as EF4, EF3 after x -> x - d^2.
\\ EF3 = x(x+a^2)(x+d^2) ; put x = X - d^2 : X(X-b^2)(X-d^2) = EI4.
\\ EF4 = x(x+b^2)(x+d^2) ; put x = X - d^2 : X(X-a^2)(X-d^2) = EI3.
\\ Also: the internal-rectangle genus-5 curve has an extra involution a <-> b, so QI1 ~ QI2 and QI3 ~ PI+.
Eq(pol) = ellinit(ellfromeqn(y^2 - pol));
mm(E) = ellminimalmodel(E)[1..5];
{
for(p=2,20, for(q=1,p-1, if(gcd(p,q)!=1 || (p-q)%2==0, next);
  my(a=p^2-q^2, b=2*p*q, d=p^2+q^2);
  my(EF3 = ellinit([0,a^2+d^2,0,a^2*d^2,0]), EF4 = ellinit([0,b^2+d^2,0,b^2*d^2,0]));
  my(EI3 = ellinit([0,-2*(p^4+q^4),0,(p^4-q^4)^2,0]), EI4 = ellinit([0,-((p^2+q^2)^2+4*p^2*q^2),0,4*p^2*q^2*(p^2+q^2)^2,0]));
  if(mm(EF3) != mm(EI4), print("MISMATCH EF3 vs EI4 at ", [p,q]));
  if(mm(EF4) != mm(EI3), print("MISMATCH EF4 vs EI3 at ", [p,q]));
));
print("checked all faces with p <= 20: EF3 and EI4 have the same minimal model, and EF4 and EI3 do too.");
}
{
foreach([[2,1],[3,2],[5,2],[8,5]], pq, my(p=pq[1],q=pq[2],c=p^2-q^2,d=2*p*q,g=p^2+q^2);
  my(QI1 = Eq((d^2-x^2)*(x^2+c^2)), QI2 = Eq((d^2-x^2)*(g^2-x^2)),
     QI3 = Eq((x^2+c^2)*(g^2-x^2)), PIp = Eq((d^2-x)*(x+c^2)*(g^2-x)), PIm = Eq(x*(d^2-x)*(x+c^2)*(g^2-x)));
  printf("(p,q)=%-8s internal fibration (edge p^2-q^2): N(QI1)=%-10s N(QI2)=%-10s N(QI3)=%-10s N(PI+)=%-10s N(PI-)=%s\n",
    Str(pq), ellglobalred(QI1)[1], ellglobalred(QI2)[1], ellglobalred(QI3)[1], ellglobalred(PIp)[1], ellglobalred(PIm)[1]);
  printf("            j(QI1)==j(QI2)? %d    QI1 minmodel == QI2 minmodel? %d    j(QI3)==j(PI+)? %d   QI3 minmodel == PI+ minmodel? %d\n",
    QI1.j==QI2.j, mm(QI1)==mm(QI2), QI3.j==PIp.j, mm(QI3)==mm(PIp));
);
}
