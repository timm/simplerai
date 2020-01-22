---
title: sym.fun
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
function Sym(i,pos,txt,w) {
  List(i)
  i.pos=pos
  i.txt=txt
  has(i,"all")
  i.mode = i.ent=  ""
  i.n = i.most = 0
  i.w = w?w:1
}
```

```awk
function Sym1(i,v) {
  if (v==FUN.skip) return v
  i.ent=""
  i.n++
  i.all[v]++
  if (i.all[v] > i.most) {
    i.most = i.all[v]
    i.mode = v }
  return v
}
```

```awk
function SymEnt(i,    k,p) {
  if (i.ent == "")
    i.ent = 0
    for (k in i.all) {
      p = i.all[k] / i.n
      i.ent -= p*log(p)/log(2) }
  return i.ent
}
```

```awk
function SymDec(i,v,   d) {
  if (v==FUN.skip) return v
  i.ent= ""
  if (i.n> 0) {
   i.n--
   i.all[v]-- }
}
```

