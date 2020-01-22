---
title: stats.fun
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
@include "col.fun"
```

```awk
function statsMain( t, col) { 
   Table(t)
   TableRead(t) #  reads from stdin
   print("")
   for(col in t.nums) print("num" col, show(t.nums[col]))
   for(col in t.syms) print("sym" col, show(t.syms[col]))
    
}
```

