---
title: bins.fun
---

<button class="button button1"><a href="/simpleai/index>home">home</a></button>
<button class="button button2"><a href="/simpleai/INSTALL>install">install</a></button>
<button class="button button1"><a href="/simpleai/ABOUT>doc">about</a></button>
<button class="button button2"><a href="http://github.com/timm/simpleai/issues>discuss">discuss</a></button>
<button class="button button1"><a href="/simpleai/LICENSE">license</a></button>

```awk
@include "lib.fun"
```
```awk
@include "table.fun"
```
```awk
@include "some.fun"
```

this is unsuper. it should be followed by super

needs a pre-processor cols (to prune sillies)

cat | clean | cols | ranges | super | rows | cluster | privitize | contrast

repeat the above without super 

-----------------------
# some extensions to the basic table stuff
```awk
function TableChop(i,   c) {
  for(c in i.nums)  
    TableChop1(i,c,i.nums[c]) 
}
```

```awk
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
```

---------------------
```awk
function Cuts(some,     i) {
  Cuts0(i,some)
  sorted(some)
  has(some,"cuts")
  Cutting(i,some)
}
```

```awk
function Cuts0(i,some,    n) {
  if (!i.cohen) {
    List(i)
    i.cohen   = FUN.stats.cohen.small
    i.trivial = FUN.trivial 
    n         = l(some.has)
    i.step    = int(n^FUN.bins.step)
    i.epsilon = sd(some,1, n )*i.cohen }
}
```

```awk
function Cutting(i,some,lo,hi,       
               j,cut,min,now,after,new,start,stop) {
  lo    = lo ? lo : 1
  hi    = hi ? hi : l(some.has)
  start = first(some.has)
  stop  = last(some.has)
  if (hi - lo > i.step) {
    min = sd(some,lo,hi)
    for(j = lo + i.step; j<=hi-i.step; j++) {
      now =  at(some,j)
      after = at(some,j+1)
      if (now != after && 
          after - start > i.epsilon && 
          stop - now    > i.epsilon &&
          mid(some,j+1,hi) - mid(some,lo,j) > i.epsilon && 
          min > (new = xpect(some,lo,j,hi)) * i.trivial) 
         # then
         { min = new
           cut = j }}}
  if (cut) {
    Cutting(i, some, lo,    cut)
    Cutting(i, some, cut+1, hi)
  } else 
    some.cuts[l(some.cuts)+1] = some.has[hi] 
}
```

---------------------
```awk
function binsMain( t,c) { 
   Table(t)
   TableRead(t) #  reads from stdin
   TableChop(t)
   for(c in t.nums)  
     oo(t.nums[c].cuts,"# " c " ")
   TableDump(t)
}
```

