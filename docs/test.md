<button class="button button1"><a href=/fun/index>home</a></button>
<button class="button button2"><a href=/fun/INSTALL>install</a></button>
<button class="button button1"><a href=/fun/ABOUT>doc</a></button>
<button class="button button2"><a href=http://github.com/timm/fun/issues>discuss</a></button>
<button class="button button1"><a href=/fun/LICENSE>license</a></button>

```awk
function rogues(    s) {
  for(s in SYMTAB) {
     if (s ~ /^[A-Z][a-z]/) print "Global " s
     if (s ~ /^[_a-z]/    ) print "Rogue: " s }
}
```


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

