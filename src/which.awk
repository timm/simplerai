#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "some.fun"

function Range(i,v,a) {
  Object(i)
  i.attribute=a
  i.value=a
}

function Ranges(i) {
  List(i)
  oo
}
function Rule(i) {
  i.score=0
  has(i,"ranges")
}

