<button class="button button1"><a href=/fun/index>home</a></button>
<button class="button button2"><a href=/fun/INSTALL>install</a></button>
<button class="button button1"><a href=/fun/ABOUT>doc</a></button>
<button class="button button2"><a href=http://github.com/timm/fun/issues>discuss</a></button>
<button class="button button1"><a href=/fun/LICENSE>license</a></button>

```awk
function l(a) { return length(a) }
```

```awk
function o(a,t   ,x,s,sep) {
  for(x in a) {
    s= s sep  t"["x"]="a[x]; sep=", " }
  return s
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
  SORT=k; return asort(lst,lst,"kcompare") 
}
```

```awk
function kcompare(i1,v1,i2,v2,  l,r) {
  l = v1[SORT] +0
  r = v2[SORT] +0
  if (l < r) return -1
  if (l == r) return 0
  return 1 
} 
```

