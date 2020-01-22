---
title: list.fun
---

<button class="button button1"><a href="/simpleai/index>home">home</a></button>
<button class="button button2"><a href="/simpleai/INSTALL>install">install</a></button>
<button class="button button1"><a href="/simpleai/ABOUT>doc">about</a></button>
<button class="button button2"><a href="http://github.com/timm/simpleai/issues>discuss">discuss</a></button>
<button class="button button1"><a href="/simpleai/LICENSE">license</a></button>

```awk
function l(a) { return length(a) }
```

```awk
function first(a) { return a[   1] }
```
```awk
function last(a)  { return a[length(a)] }
```

```awk
function cat(a,   x,s,sep) {
  for(x in a) {
    s= s sep a[x]
    sep=", " }
  return s
}
```


```awk
function copy(a,b, i) {
  for(i in a)
    if (isarray(a[i])) {
      has(b,i)
      copy(a[i],b[i]) 
    } else
     b[i] = a[i]
}
```

```awk
function binChop(a,x,           y,lo, hi,mid)  {
  lo = 1
  hi = l(a)
  while (lo <= hi) {
    mid = int((hi + lo) / 2)
    y=a[mid]
    if (x == y) break
    if (x <  y) hi=mid-1; else lo=mid+1 }
  return mid 
}
```

```awk
function oo(x,p,pre, i,txt) {
  txt = pre ? pre : (p DOT)
  ooSortOrder(x)
  for(i in x)  {
    if (isarray(x[i]))   {
      print(txt i"" )
      oo(x[i],"","|  " pre)
    } else
      print(txt i (x[i]==""?"": ": " x[i])) }
}
```

```awk
function ooSortOrder(x, i) {
  for (i in x)
    return PROCINFO["sorted_in"] = \
      typeof(i + 1)=="number" ? "@ind_num_asc" : "@ind_str_asc" 
}
```

```awk
function ksort(lst,k) { 
  FUN.SORT.K=k; return asort(lst,lst,"kcompare")
}
```

```awk
function kcompare(i1,v1,i2,v2,  l,r) {
  l = v1[FUN.SORT.K] +0
  r = v2[FUN.SORT.K] +0
  if (l < r) return -1
  if (l == r) return 0
  return 1 
} 
```


```awk
function cellsort(lst,k) { 
  FUN.SORT.CELL=k; return asort(lst,lst,"cellcompare") 
}
```

```awk
function cellcompare(i1,v1,i2,v2,  l,r) {
  l = v1.cells[FUN.SORT.CELL]
  r = v2.cells[FUN.SORT.CELL]
  if (l < r) return -1
  if (l == r) return 0
  return 1 
}
```



