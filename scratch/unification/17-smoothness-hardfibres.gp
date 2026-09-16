\\ 17-smoothness-hardfibres.gp
\\ (i) X_s is a *diagonal* genus 5 curve in Stoll's sense: the 3x5 coefficient matrix has no vanishing 3x3 minor.
\\ (ii) data for the hardest fibres.
M(a,b,d) = [-a^2,-1,1,0,0; -b^2,-1,0,1,0; -d^2,-1,0,0,1];
{
my(bad = 0, n = 0, mins = List());
for(p=2,60, for(q=1,p-1, if(gcd(p,q)!=1 || (p-q)%2==0, next); n++;
  my(a=p^2-q^2,b=2*p*q,d=p^2+q^2, A=M(a,b,d));
  forvec(v=[[1,3],[2,4],[3,5]],
    my(B = matrix(3,3,i,j,A[i,v[j]]));
    if(matdet(B) == 0, bad++);
    if(p==2 && q==1, listput(mins, [v, matdet(B)])), 2)));
print("faces p <= 60 tested: ", n, "   faces with a vanishing 3x3 minor: ", bad);
print("the ten 3x3 minors at (p,q)=(2,1) (columns are w,c,y1,y2,y3): ", Vec(mins));
print("symbolically the minors are  -a^2, -b^2, -(a^2-b^2), -d^2, ... , 1 : none vanishes for an admissible face.");
}
print("");
print("--- the hardest fibres: the five rank bounds [lower,upper] ---");
{
foreach([[5,2],[32,7],[34,11],[35,2],[42,13],[47,10]], pq, my(p=pq[1],q=pq[2],a=p^2-q^2,b=2*p*q,d=p^2+q^2);
  my(E = [ellinit([0,a^2+b^2,0,a^2*b^2,0]), ellinit([0,a^4+b^4,0,a^4*b^4,0]),
          ellinit([0,a^2+d^2,0,a^2*d^2,0]), ellinit([0,b^2+d^2,0,b^2*d^2,0]),
          ellinit([0,-(a^2+b^2),0,a^2*b^2,0])]);
  printf("(p,q)=%-8s (a,b,d)=%-18s bounds: EF1=%s EF2=%s EF3=%s EF4=%s P+=%s\n", Str(pq), Str([a,b,d]),
    ellrank(E[1])[1..2], ellrank(E[2])[1..2], ellrank(E[3])[1..2], ellrank(E[4])[1..2], ellrank(E[5])[1..2]));
}
