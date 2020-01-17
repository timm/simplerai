---
title: num.fun
---

<button class="button button1"><a href=/fun/index>home</a></button>
<button class="button button2"><a href=/fun/INSTALL>install</a></button>
<button class="button button1"><a href=/fun/ABOUT>doc</a></button>
<button class="button button2"><a href=http://github.com/timm/fun/issues>discuss</a></button>
<button class="button button1"><a href=/fun/LICENSE>license</a></button>

@include "lib.fun"

```awk
function Num(i) {
  List(i)
  i.n  = i.mu = i.m2 = i.sd = 0
  i.lo = 10^32
  i.hi = -1*i.lo
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
  i.sd =   (i.m2/(i.n - 1))^0.5
  return i.sd
}
```


