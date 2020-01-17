---
title: cliffok.fun
---

<button class="button button1"><a href="/simpleai/index>home"</a></button>
<button class="button button2"><a href="/simpleai/INSTALL>install"</a></button>
<button class="button button1"><a href="/simpleai/ABOUT>doc"</a></button>
<button class="button button2"><a href="http://github.com/timm/simpleai/issues>discuss"</a></button>
<button class="button button1"><a href="/simpleai/LICENSE">license</a></button>

@include "lib.fun"
@include "some.fun"

```awk
function cliffsDeltaSlow(a,b,    tmp,la,lb,x,y,j,k,gt,lt) {
  la = l(a.has)
  lb = l(b.has)
  for(j in a.has)
    for(k in b.has) {
      x= a.has[j]
      y= b.has[k]
      gt += x > y
      lt += x < y}
  tmp=  abs(lt-gt)/(la*lb) 
  #printf("%s ","a "la" b "lb" lt "lt" gt "gt" tmp "tmp)
  return 0.147 < tmp
}
```

```awk
function cliffsDeltaFaster(a,b,   n,tmp,j,la,lb,x,lo,hi,gt,lt) {
  la = sorted(a)
  lb = sorted(b)
  n= l(b.has)
  for(j in a.has) {
    x= a.has[j]
    lo= hi= binChop(b.has, x)
    while(lo > 1 && b.has[lo] == x) lo--
    while(hi < n && b.has[hi] == x) hi++
    gt += lb - hi 
    lt += lo
  }
  tmp=  abs(lt-gt)/(la*lb) 
  #printf("%s ","a1 "la" b1 "lb" lt1 "lt" gt1 "gt" tmp1 "tmp)
  return 0.147 < tmp
}
```

```awk
function cliffsDeltaFastest(a,b,s,   a1,la,j) {
  s=s ? s : min(l(a.has), 20)
  la = sorted(a)
  Some(a1)
  la= l(a.has)
  for(j=1; j<=la; j= int(j+la/s)) {
    Some1(a1, a.has[j])
  }
  return cliffsDeltaFaster(a1,b)
}
```


```awk
function demo(n,r,   m1,s1, m2,s2,a,b,k,z) {
   srand(1)
   Some(a)
   Some(b)
   m1=10; s1=4
   m2= 2; s2=1
   for(k=1;k<=n;k++)  {
     z = gauss(m1,s1) + gauss(m2,s2)
     Some1(a,z)
     Some1(b,z*r) }
   #print("n",n,"r",r, "slow",  cliffsDeltaSlow(a,b))
   #print("n",n,"r",r, "slow",  cliffsDeltaSlow(a,b), "fast",  cliffsDeltaFaster(a,b))
   #cliffsDeltaFastest(a,b)
   print("n",n,"r",r, "slow",  cliffsDeltaSlow(a,b),  "fast",  cliffsDeltaFaster(a,b), "fastest",cliffsDeltaFastest(a,b))
}
```

```awk
function demos(   r,j,n) { 
   j=1
   while(j-- > 0) {
     print("") 
     for(n=4;n<=128;n *= 1.5)  {
       print ""
       for(r=1;r<=1.3;r *= 1.025) 
         demo(n,r) }}}
```awk
BEGIN { demos(); rogues() }
```
