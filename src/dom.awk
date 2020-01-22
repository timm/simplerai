#!/usr/bin/env gawk -f
# vim: filetype=awk ts=2 sw=2 sts=2  et :

BEGIN { srand(Seed ? Seed : 1)
        FS="," 
        Samples=100 
}
function domMain(f,     nr,txt,d,w,lo,hi,c,r) {
  f  = f?f:"/dev/stdin"
  nr = 0
  while ((getline <f) > 0) {
    txt[nr] = $0
    print $0,$1,$NF
    if (nr++) 
      for(c in w)  {
        print("L",c,w[c])
        d[nr][c] = $c
        if ( $c > hi[c] ) hi[c] = $c
        if ( $c < lo[c] ) lo[c] = $c }
    else 
      for(c=1;c<=NF;c++)  
        if( $c ~ /[<>]/ )  {
          w[ c] =  ($c ~ /</) ? -1 : 1 
          lo[c] =  10^32
          hi[c] = -10^32 }
   }  
   print txt[0]",!>dom"
   for(r=1; r<=nr; r++)
     print txt[r]",", doms(r,d,w,lo,hi) 
}
function doms(r1,d,w,lo,hi,         r2,n,out) {
  r2 = 1 + int(rand()*length(d))
  n = Samples
  while(n--) 
    out += dom(r1,r2,d,w,lo,hi)
  return out/Samples
}
function dom(r1,r2,d,w,lo,hi,    n,c,a,b,s1,s2) {
  n = length(w)
  for(c in w) {
    a   = d[r1][c]
    b   - d[r2][c]
    a   = (a - lo[c]) / (hi[c] - lo[c] + 10^-32)
    b   = (b - lo[c]) / (hi[c] - lo[c] + 10^-32)
    s1 -= 10^( w[c] * (a-b)/n )
    s2 -= 10^( w[c] * (b-a)/n ) 
  }
  return s1/n < s2/n
}
