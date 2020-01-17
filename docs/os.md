---
title: os.fun
---

<button class="button button1"><a href=/fun/index>home</a></button>
<button class="button button2"><a href=/fun/INSTALL>install</a></button>
<button class="button button1"><a href=/fun/ABOUT>doc</a></button>
<button class="button button2"><a href=http://github.com/timm/fun/issues>discuss</a></button>
<button class="button button1"><a href=/fun/LICENSE>license</a></button>

```awk
function lines(i,f, update,sep,  r,line,lst) {
  f   = f ? f : "/dev/stdin"
  sep = sep ? sep : "[ \t]*,[ \t]*"
  while((getline line < f) > 0) {
    gsub(/^[ \t\r]*/,"",line)
    gsub(/[ \t\r]*$/,"",line)
    if (line) { 
      split(line,lst,sep)
      @update(i,++r,lst) }}
  close(f) 
} 
```


```awk
function argv(b4,   x,k,old,new) {
  for (x in ARGV)  {
   k = ARGV[x]
   if (sub(/^--/,"",k))  
     b4[k] = argv1(k, k in b4, b4[k], ARGV[x+1]) }
}
```


```awk
function argv1(k,known,old,new) {
  if (known) {
    if (typeof(old) != "number")
      return new
    else if (new ~ /[0-9]+(\.[0-9]*)?/)
      return strtonum(new)   }
  print "#W> bad arg --"k" " new
  exit 1 
}
```


