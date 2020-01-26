#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"

function Num(i,pos,txt,w) {
  List(i)
  i.isa = "Num"
  i.pos=pos
  i.txt=txt
  i.n  = i.mu = i.m2 = i.sd = 0
  i.lo = 10^32
  i.hi = -1*i.lo
  i.w  = w?w:1
}
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
# var is not "variance" but "variability"
function NumVar(i)    { return i.sd }
function NumMiddle(i) { return i.mu }

function NumSd(i) {
  if (i.m2 < 0) return 0
  if (i.n < 2)  return 0
  i.sd = (i.m2/(i.n - 1))^0.5
  return i.sd
}
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

