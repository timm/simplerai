#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"

function Sym(i,pos,txt,w) {
  List(i)
  i.pos=pos
  i.txt=txt
  has(i,"all")
  i.mode = i.ent=  ""
  i.n = i.most = 0
  i.w = w?w:1
}
function Sym1(i,v) {
  if (v==FUN.skip) return v
  i.ent=""
  i.n++
  i.all[v]++
  if (i.all[v] > i.most) {
    i.most = i.all[v]
    i.mode = v }
  return v
}
function SymEnt(i,    k,p) {
  if (i.ent == "")
    i.ent = 0
    for (k in i.all) {
      p = i.all[k] / i.n
      i.ent += p*log(p)/log(2) }
  return i.ent
}
function SymDec(i,v,   d) {
  if (v==FUN.skip) return v
  i.ent= ""
  if (i.n> 0) {
   i.n--
   i.all[v]-- }
}
