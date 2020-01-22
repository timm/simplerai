---
title: col.fun
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
@include "some.fun"
```
```awk
@include "num.fun"
```
```awk
@include "sym.fun"
```

```awk
function add(i,v) {
  if ("sd"  in i) return Num1(i,v) 
  if ("ent" in i) return Sym1(i,v)
  return Some1(i,v)
}
```

```awk
function var(i) {
  if ("sd"  in i) return NumSd(i) 
  if ("ent" in i) return SymEnt(i)
  return sd(i,1,l(i.has))
}
```

```awk
function middle(i) {
  if ("sd"  in i) return i.mu 
  if ("ent" in i) return i.most
  return mid(i,1,l(i.has))
}
```

# need to rewrite expect elsewhere;
```awk
function xpect(i,j,   n) {
  n  =i.n+j.n
  return (i.n*var(i) + j.n*var(j))/n
}
```

```awk
function show(i, s) {
  s= ":n "i.n" :middle "middle(i)" :var "var(i)
  if (i.txt)
     s= s " :txt " i.txt
  return s
}
```

