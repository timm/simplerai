#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "some.fun"

function cliffsDeltaSlow(a,b,    tmp,la,lb,x,y,j,k,gt,lt) {
  la = l(a.a)
  lb = l(b.a)
  for(j in a.a)
    for(k in b.a) {
      x= a.a[j]
      y= b.a[k]
      gt += x > y
      lt += x < y}
  tmp=  abs(lt-gt)/(la*lb) 
  #printf("%s ","a "la" b "lb" lt "lt" gt "gt" tmp "tmp)
  return 0.147 < tmp
}
function cliffsDeltaFaster(a,b,   n,tmp,j,la,lb,x,lo,hi,gt,lt) {
  la = sorted(a)
  lb = sorted(b)
  n= l(b.a)
  for(j in a.a) {
    x= a.a[j]
    lo= hi= binChop(b.a, x)
    while(lo > 1 && b.a[lo] == x) lo--
    while(hi < n && b.a[hi] == x) hi++
    gt += lb - hi 
    lt += lo
  }
  tmp=  abs(lt-gt)/(la*lb) 
  #printf("%s ","a1 "la" b1 "lb" lt1 "lt" gt1 "gt" tmp1 "tmp)
  return 0.147 < tmp
}
function cliffsDeltaFastest(a,b,s,   a1,la,j) {
  s=s ? s : min(l(a.a), 20)
  la = sorted(a)
  Some(a1)
  la= l(a.a)
  for(j=1; j<=la; j= int(j+la/s)) {
    Some1(a1, a.a[j])
  }
  return cliffsDeltaFaster(a1,b)
}

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
function demos(   r,j,n) { 
   j=1
   while(j-- > 0) {
     print("") 
     for(n=4;n<=128;n *= 1.5)  {
       print ""
       for(r=1;r<=1.3;r *= 1.025) 
         demo(n,r) }}}
BEGIN { demos(); rogues() }
