---
title: test.fun
---

<button class="button button1"><a href="/simpleai/index>home">home</a></button>
<button class="button button2"><a href="/simpleai/INSTALL>install">install</a></button>
<button class="button button1"><a href="/simpleai/ABOUT>doc">about</a></button>
<button class="button button2"><a href="http://github.com/timm/simpleai/issues>discuss">discuss</a></button>
<button class="button button1"><a href="/simpleai/LICENSE">license</a></button>

```awk
function tests(what, all,   one,a,i,n) {
  n = split(all,a,",")
  print "\n#--- " what " -----------------------"
  for(i=1;i<=n;i++) { 
    one = a[i]; @one(one) }
  rogues()
}
```


```awk
function is(f,got,want,   epsilon,     ok) {
  if (typeof(want) == "number") {
     epsilon = epsilon ? epsilon : 0.001
     ok = abs(want - got)/(want + 10^-32)  < epsilon
  } else
     ok = want == got
  if (ok) 
    print "#TEST:\tPASSED\t" f "\t" want "\t" got 
  else 
    print "#TEST:\tFAILED\t" f "\t" want "\t" got 
}
```

