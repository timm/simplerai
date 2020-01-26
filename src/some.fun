#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
______________________________

function Some0(i) {
  if (!i.magic) {
    List(i)
    i.isa = "Some"
    i.magic = FUN.some.magic # 2.56
    i.max   = FUN.some.max   # 256
    i.small = FUN.stats.cliffs.small} # 0.147
}
function Some(i,pos,txt,w) {
  Some0(i)
  has(i,"has")
  has(i,"cuts")
  i.w = 1
  i.pos    = pos ? pos : 1
  i.txt    = txt
  i.sorted = 0
  i.n      = 0 
  i.w      = w?w:1
}
function Some1(i,v) {
  if (v == "?") return
  i.n++
  if (i.n < i.max) {
    i.has[ l(i.has)+1 ] = v
    i.sorted=0
  } else {
    if (i.n == i.max) 
      sorted(i)
    if (rand() < i.max/i.n)
      i.has[ binChop(i.has,v) ] = v }
  return v
}
function SomeDiff(a,b,  
                  n,la,lb,j,x,lo,hi,gt,lt) {
  la = sorted(a)
  lb = sorted(b)
  n  = l(b.has)
  for(j in a.has) {
    x  = a.has[j]
    lo = hi= binChop(b.has, x)
    while(lo > 1 && b.has[lo] == x) lo--
    while(hi < n && b.has[hi] == x) hi++
    gt += lb - hi 
    lt += lo
  }
  return abs(lt-gt)/(la*lb) > a.small 
}
function SomeBest(i,lo,hi,bigger,step,e,tiny,  
                  j,cut,min,now,after,new,start,stop) {
  lo    = lo     ? lo     : 1
  hi    = hi     ? hi     : l(i.has)
  bigger= bigger ? bigger : 1
  tiny  = tiny   ? tiny   : 1.05
  step  = step   ? step   : length(i.has)^0.5
  e     = e      ? e      : sd(i,1,l(i.has))*0.3
  start = first(i.has)
  stop  = last(i.has)
  if (hi - lo > step) {
    min = sd(i,lo,hi)
    for(j = lo + step; j<=hi-step; j++) {
      now   = at(i,j)
      after = at(i,j+1)
      if (now != after && 
          e < after - start  && 
          e < stop - now     &&
          e < mid(i,j+1,hi) - mid(i,lo,j)) 
         { new= SomeXpect(i,lo,j,hi)
           if (min>  new * tiny) 
             { min = new
               cut = j }}}}
  if (!cut)   return bigger ? i.has[lo] : i.has[hi]
  if (bigger) return SomeBest(i, cut+1, hi,bigger,step,e,tiny)
  else        return SomeBest(i, lo,   cut,bigger,step,e,tiny)
}

function SomeXpect(i,j,m,k,   n) {
  n=k-j+1
  return (m-j)/n*sd(i,j,m) + (k-m -1)/n*sd(i,m+1,k) 
}

function SomeVar(i)    { return sd( i,1,l(i.has)) }
function SomeMiddle(i) { return mid(i,1,l(i.has)) }

----------------------------

function sorted(i)  { 
  if (!i.sorted) 
    i.sorted=asort(i.has) 
  return length(i.has)
}
function at(i,z)      { 
  if(!i.sorted) sorted(i)
  return i.has[int(z)] 
}
function per(i,j,k,p) { return at(i,j + p*(k-j))   }
function mid(i,j,k)   { return per(i,j,k,0.5) }
function sd(i,j,k)    {
  return abs(per(i,j,k,.9) - per(i,j,k,.1))/i.magic 
}

