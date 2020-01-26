#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "some.fun"
@include "num.fun"
@include "sym.fun"

function add(i,v,  f) { f= how(i,"1"); return @f(i,v) }
function dec(i,v,  f) { f= how(i,"Dec"); return @f(i,v) }
function var(i,    f) { f= how(i,"Var"); return @f(i) }
function middle(i, f) { f= how(i,"Middle"); return @f(i) }

# need to rewrite expect elsewhere;
function xpect(i,j,   n) {
  n  =i.n+j.n
  return (i.n*var(i) + j.n*var(j))/n
}
function show(i, s) {
  s= ":n "i.n" :middle "middle(i)" :var "var(i)" :isa "i.isa
  if (i.txt)
     s= s " :txt " i.txt
  return s
}
