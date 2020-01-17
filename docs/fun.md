---
title: fun.fun
---

<button class="button button1"><a href="/simpleai/index>home">home</a></button>
<button class="button button2"><a href="/simpleai/INSTALL>install">install</a></button>
<button class="button button1"><a href="/simpleai/ABOUT>doc">about</a></button>
<button class="button button2"><a href="http://github.com/timm/simpleai/issues>discuss">discuss</a></button>
<button class="button button1"><a href="/simpleai/LICENSE">license</a></button>

```awk
function Globals(i) {
  i.dot  = sprintf("%c",46)
  i.trivial = 1.05
  i.skip = "?"
  i.some.magic  = 2.56
  i.some.max    = 256
  i.stats.cliffs.small   = 0.147
  i.stats.cohen.small   = 0.3
  i.bins.step = .5
}
```

```awk
BEGIN { Globals(FUN) }
```
