---
title: table.fun
---

<button class="button button1"><a href=/fun/index>home</a></button>
<button class="button button2"><a href=/fun/INSTALL>install</a></button>
<button class="button button1"><a href=/fun/ABOUT>doc</a></button>
<button class="button button2"><a href=http://github.com/timm/fun/issues>discuss</a></button>
<button class="button button1"><a href=/fun/LICENSE>license</a></button>

```awk
function Table0(i) {
  i.data = "data/weather" DOT "csv"
  i.sep  = ","
}
```

```awk
function Table(i) {
  Object(i)
  has(i,"rows")
  has(i,"names")
  has(i,"nums") 
}
```

```awk
function TableRead(i,f) { lines(i,f, "Table1") }
```

```awk
function Table1(i,r,lst,      c,x) {
  if (r>1)  
    return hasss(i.rows,r-1,"Row",lst,i)
  for(c in lst)  {
    x = i.names[c] = lst[c]
    if (x ~ /[\$<>]/) 
      hass(i.nums,c,"Some",c) }
}
```

```awk
function TableDump(i,   r) {
  print(cat(i.names))
  for(r in i.rows)
    print(cat(i.rows[r].cells)) 
}
```

_______________________________
```awk
function Row(i,lst,t,     x,c) {
  Object(i)
  has(i,"cells")
  for(c in t.names) {
    x = lst[c]
    if (x != "?") {
      if (c in t.nums) {
         x += 0
         Some1(t.nums[c], x) }
      i.cells[c] = x }}
}
```

```awk
function cellsort(lst,k) { 
  CELLSORT=k; return asort(lst,lst,"cellcompare") 
}
```

```awk
function cellcompare(i1,v1,i2,v2,  l,r) {
  l = v1.cells[CELLSORT]
  r = v2.cells[CELLSORT]
  if (l < r) return -1
  if (l == r) return 0
  return 1 
}
```



