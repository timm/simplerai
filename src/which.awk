#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "some.fun"

function Range(i,a,v) {
  Object(i)
  i.attribute=a
  i.value=v
}
function Learn0(i) {
  i.m=20
  i.n=20
  i.beam=20
}
function Rule(i) {
  List(i)
  has(i,"has")
  i.score=0
}
function Learn(i) {
  Learn0(i)
  Learning(i.m, i.n)
}
function learns(repeats,picks,stack,   j,k,a,b,c) {
  List(stack)
  for(j=1; j<=repeats; j++) {
    n = justTheBest(i.beam, stack)
    for(k=1; k<=picks; k++) {
      a = pick(stack,n, "score")
      b = pick(stack,n, "score")
      c = has1more(stack,"Rule")
      if (a>b)
        combine(stack[a], stack[b], stack[c])
      else
        combine(stack[b], stack[a], stack[c]) }} 
  justTheBest(i.beam, stack)
}
function justTheBest(beam,stack,     i,n) {
  ksort(stack,"score")
  for(i=1; i<=beam; i++) 
    n += stack[i].score
  for(i=beam+1; i<=length(stack); i++)
    del stack[i]
  return n
}
function combine(good,better,new,    a) {
  for(a in good.has) 
    new.has[a] = good.has[a]
  for(a in better,has) # the better can overwrite the good
    new.has[a] = better.has[a]
}  
   
function RuleAdd(i,j,stack) {
  for(a in lst) 
    i.has[ l(i.has[a]) + 1 ] = lst[a]
  List(new)
  for(a in i.has)
   for(v in i.has[a])
     rule1(lst, a, v)
       
function rule1(has,lst,i,n,out)
  if (i > n) {
    j = length(out) + 1
    for(x in lst)
      out[j][x] = lst[x]
  } else {
     for(j in has[i])
       copyw
    
1.a=10
1.v=[11,12]
2.a=3
2.v=[2,3]   
for(a in has)
  for(v in has[a])
    print a,v
    copy(rule,new)
    n=length(rules)+1
    new[a]=v
    
new[a]=v
    
    print a,v  
     
       changed=1
       i.has[one] 
       a=axxxx ranges new attr
       }}
  if (changed)
    i.score = @f(i,context)
} 
  
  
function Rule(i) {
  i.score=0
  has(i,"ranges")
}

