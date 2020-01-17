---
title: libok.fun
---

<button class="button button1"><a href="/simpleai/index>home"</a></button>
<button class="button button2"><a href="/simpleai/INSTALL>install"</a></button>
<button class="button button1"><a href="/simpleai/ABOUT>doc"</a></button>
<button class="button button2"><a href="http://github.com/timm/simpleai/issues>discuss"</a></button>
<button class="button button1"><a href="/simpleai/LICENSE">license</a></button>

@include "lib.fun"

```awk
function Demo(i) {
  Object(i)
  i.aaa = 10
  i.bbb = "no"
  i.ccc = "where" FUN.dot "csv"
}
```

```awk
function libargs(w,   i,j) {
  Demo(i)
  argv(i)
  for(j in ARGV) print j, ARGV[j]
  oo(i)
  is(w, typeof(i.aaa),"number")
  is(w, typeof(i.bbb),"string")
}
```

```awk
function libokMain() { 
  tests("libok","libargs") 
}
```

