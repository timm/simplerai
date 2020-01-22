---
title: num.fun
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
function Num(i,pos,txt,w) {
  List(i)
  i.pos=pos
  i.txt=txt
  i.n  = i.mu = i.m2 = i.sd = 0
  i.lo = 10^32
  i.hi = -1*i.lo
  i.w  = w?w:1
}
```

```awk
function Num1(i,v,    d) {
  if (v==FUN.skip) return v
  v += 0
  i.n++
  i.lo  = v < i.lo ? v : i.lo
  i.hi  = v > i.hi ? v : i.hi
  d     = v - i.mu
  i.mu += d/i.n
  i.m2 += d*(v - i.mu)
  NumSd(i)
  return v
}
```

```awk
function NumSd(i) {
  if (i.m2 < 0) return 0
  if (i.n < 2)  return 0
  i.sd = (i.m2/(i.n - 1))^0.5
  return i.sd
}
```

```awk
function NumDec(i,v,    d)  {
  if (v == "?") return v 
  if (i.n == 0) return v 
  i.n  -= 1
  d     = v - i.mu
  i.mu -= d/i.n
  i.m2 -= d*(v- i.mu)
  NumSd(i)
  return v
}
```


