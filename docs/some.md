---
title: some.fun
---

<button class="button button1"><a href=/fun/index>home</a></button>
<button class="button button2"><a href=/fun/INSTALL>install</a></button>
<button class="button button1"><a href=/fun/ABOUT>doc</a></button>
<button class="button button2"><a href=http://github.com/timm/fun/issues>discuss</a></button>
<button class="button button1"><a href=/fun/LICENSE>license</a></button>

@include "lib.fun"
______________________________

```awk
function Some0(i) {
  if (!i.magic) {
    List(i)
    i.magic = FUN.some.magic # 2.56
    i.max   = FUN.some.max   # 256
    i.small = FUN.stats.cliffs.small} # 0.147
}
```

```awk
function Some(i,pos) {
  Some0(i)
  has(i,"has")
  has(i,"cuts")
  i.pos    = pos ? pos : 1
  i.sorted = 0
  i.n      = 0 
}
```

```awk
function Some1(i,x) {
  if (x == "?") return
  i.n++
  if (i.n < i.max) {
    i.has[ l(i.has)+1 ] = x
    i.sorted=0
  } else {
    if (i.n == i.max) 
      sorted(i)
    if (rand() < i.max/i.n)
      i.has[ binChop(i.has,x) ] = x }
}
```

```awk
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
```


```awk
function sorted(i)  { 
  if (!i.sorted) 
    i.sorted=asort(i.has) 
  return length(i.has)
}
```

```awk
function at(i,z)      { 
  if(!i.sorted) sorted(i)
  return i.has[int(z)] 
}
```

```awk
function per(i,j,k,p) { return at(i,j + p*(k-j))   }
```
```awk
function mid(i,j,k)   { return per(i,j,k,0.5) }
```
```awk
function sd(i,j,k)    {
  return abs(per(i,j,k,.9) - per(i,j,k,.1))/i.magic 
}
```

```awk
function xpect(i,j,m,k,   n) {
  n=k-j+1
  return (m-j)/n*sd(i,j,m) + (k-m -1)/n*sd(i,m+1,k) 
}
```


