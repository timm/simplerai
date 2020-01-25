#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "some.fun"

function Rule(i) {
  List(i)
  has(i,"has")
  i.score=0
}
function learns(table,repeats,picks,stack,f,   
                j,k,a,b,c,j,k) {
  List(stack)
  for(j=1; j<=repeats; j++) {
    n = justTheBest(i.beam, stack)
    for(k=1; k<=picks; k++) {
      a = pick(stack,n, "score",beam)
      b = pick(stack,n, "score",beam)
      c = has1more(stack,"Rule")
      if (a>b) 
        combine(stack[a], stack[b], stack[c],f,table)
      else {
        combine(stack[b], stack[a], stack[c],f,table) };
  }}
  justTheBest(i.beam, stack)
}
function justTheBest(beam,stack,     i,n) {
  ksort(stack,"score")
  for(i=1; i<=beam; i++) {
    n += stack[i].score
  for(i=beam+1; i<=length(stack); i++)
    del stack[i]
  return n
}
function combine(good,better,new,f,table,    a) {
  for(a in good.has) 
    new.has[a] = good.has[a]
  for(a in better,has) # the better can overwrite the good
    new.has[a] = better.has[a]
  new.score = @f(new, table) 
}  
function pick(a,sum,beam,k,    i,r) {
  r = rand()
  for(i=1; i<=length(a); i++) {
    r -= a[i][k] / sum
    if (i>=beam) break
    if (r<=0) break
  }
  return i
}
