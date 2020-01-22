#!/usr/bin/env gawk -f
# vim: filetype=awk ts=2 sw=2 sts=2  et :

BEGIN { srand(Seed ? Seed : 1)
        FS="," 
        Samples=100
}
function domMain(f,     
                 line,c,r,nr,
                 d,      # data
                 w,      # weights for columns
                 lo,hi){ # min,mac for columns
  f  = f?f:"/dev/stdin"
  nr = 0
  while ((getline <f) > 0) {
    line[nr] = $0
    if (nr++) 
      for(c in w)  {
        d[nr][c] = $c
        if ( $c > hi[c] ) hi[c] = $c
        if ( $c < lo[c] ) lo[c] = $c 
    } else 
      for(c=1;c<=NF;c++)  
        if( $c ~ /[<>]/ )  {
          w[ c] =  ($c ~ /</) ? -1 : 1 
          lo[c] =  10^32
          hi[c] = -10^32 }
   }  
   print line[0]",!>dom"
   for(r=1; r<=nr; r++)
     print line[r]",", doms(r,d,w,lo,hi,Samples) 
}
function doms(r1,d,w,lo,hi,n,      out) {
  while(n--) 
    out += dom(r1,d,w,lo,hi)
  return out/Samples
}
function dom(r1,d,w,lo,hi,    
             r2,n,c,a,b,a1,b1,s1,s2) {
  r2= 1 + int(rand()*length(d))
  n = length(w)
  for(c in w) {
    a   = d[r1][c]
    b   = d[r2][c]
    a1  = (a - lo[c]) / (hi[c] - lo[c] + 10^-32)
    b1  = (b - lo[c]) / (hi[c] - lo[c] + 10^-32)
    s1 -= 10^( w[c] * (a1-b1)/n )
    s2 -= 10^( w[c] * (b1-a1)/n ) 
  }
  return s1/n < s2/n
}
