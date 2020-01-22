#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "some.fun"
@include "num.fun"
@include "sym.fun"

function add(i,v) {
  if ("sd"  in i) return Num1(i,v) 
  if ("ent" in i) return Sym1(i,v)
  return Some1(i,v)
}
function dec(i,v) {
  if ("sd"  in i) return NumDec(i,v) 
  if ("ent" in i) return SymDec(i,v)
  print("# can dec from 'some'")
  exit 1
}
function var(i) {
  if ("sd"  in i) return NumSd(i) 
  if ("ent" in i) return SymEnt(i)
  return sd(i,1,l(i.has))
}
function middle(i) {
  if ("sd"  in i) return i.mu 
  if ("ent" in i) return i.most
  return mid(i,1,l(i.has))
}
# need to rewrite expect elsewhere;
function xpect(i,j,   n) {
  n  =i.n+j.n
  return (i.n*var(i) + j.n*var(j))/n
}
function show(i, s) {
  s= ":n "i.n" :middle "middle(i)" :var "var(i)
  if (i.txt)
     s= s " :txt " i.txt
  return s
}
