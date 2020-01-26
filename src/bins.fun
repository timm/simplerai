#!/usr/bin/env ./fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "table.fun"
@include "some.fun"

this is unsuper. it should be followed by super

needs a pre-processor cols (to prune sillies)

cat | clean | cols | ranges | super | rows | cluster | privitize | contrast

repeat the above without super 

-----------------------
# some extensions to the basic table stuff
function TableChop(i,   c) {
  for(c in i.nums)  
    TableChop1(i,c,i.nums[c]) 
}
function TableChop1(i,c,some,    r,cut,x,rs) {
  Cuts(some) # sets some.cuts to some useful thresholds
  rs  = l(i.rows)
  cut = 1
  cellsort(i.rows, c)
  for(r=1; r<=rs; r++)  {
    x = i.rows[r].cells[c]
    if (x != "?") {
      if (x > some.cuts[cut]) 
        if (cut< l(some.cuts) -1 )
          cut++
      i.rows[r].cells[c] = some.cuts[cut]  }}
}
---------------------
function Cuts(some,     i) {
  Cuts0(i,some)
  sorted(some)
  has(some,"cuts")
  Cutting(i,some)
}
function Cuts0(i,some,    n) {
  if (!i.cohen) {
    List(i)
    i.cohen   = FUN.stats.cohen.small
    i.trivial = FUN.trivial 
    n         = l(some.a)
    i.step    = int(n^FUN.bins.step)
    i.epsilon = sd(some,1, n )*i.cohen }
}
function Cutting(i,some,lo,hi,       
               j,cut,min,now,after,new,start,stop) {
  sorted(some)
  lo    = lo ? lo : 1
  hi    = hi ? hi : l(some.a)
  start = first(some.a)
  stop  = last(some.a)
  if (hi - lo > i.step) {
    min = sd(some,lo,hi)
    for(j = lo + i.step; j<=hi-i.step; j++) {
      now =  some.a[j]
      after = some.a[j+1]
      if (now != after && 
          i.epsilon < after - start  && 
          i.epsilon < stop - now  &&
          i.epsilon < mid(some,j+1,hi) - mid(some,lo,j) ) 
         { new= SomeXpect(some,lo,j,hi)
           if (min>  new *i.trivial) 
             { min = new
               cut = j }}}}
  if (cut) {
    Cutting(i, some, lo,    cut)
    Cutting(i, some, cut+1, hi)
  } else 
    some.cuts[l(some.cuts)+1] = some.a[hi] 
}
---------------------
function binsMain( t,c) { 
   Table(t)
   TableRead(t) #  reads from stdin
   TableChop(t)
   for(c in t.indep)  
     if(c in t.nums)  
       oo(t.nums[c].cuts,"## " c " ")
   TableDump(t)
}
