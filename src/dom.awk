
#!/usr/bin/env gawk -f
# vim: filetype=awk ts=2 sw=2 sts=2  et :

BEGIN { srand(Seed ? Seed : 1)
        FS="," 
        Samples=5 }
      { Txt[NR-1] = $0}
NR==1 { for(col=1;col<=NF;col++)  {
          W[col] =  $col !~ /</ ? -1 : 1 
          Lo[col]=   10^32
          Hi[col] = -10^32 } }
NR> 1 { for(col in W) 
          keep(NR-1,col,$col) }
END   { print Txt[0]",!>dom"
        for(r=1;r<NR;r++)
          print Txt[r]",", doms(r) }

function keep(r,c,v) {
  D[r][c] = v
  if ( v > Hi[c] ) Hi[c]=v
  if ( v < Lo[c] ) Lo[c]=v
}
function norm(col,v) { 
  return  (v - Lo[col]) / (Hi[col] - Lo[col] + 10^-32) 
}
function doms(row1,    n,score) {
  n=Samples
  while(n--) 
    score  += better(row1, 1+ int(rand()* length(D)))
  return score/Samples
}
function better(row1,row2,    n,col,a,b,s1,s2) {
  n = length(W)
  for(col in W) {
    a   = norm(col, D[row1][col])
    b   = norm(col, D[row2][col])
    s1 -= 10^( W[col] * (a-b)/n )
    s2 -= 10^( W[col] * (b-a)/n ) 
  }
  return s1/n > s2/n
}
