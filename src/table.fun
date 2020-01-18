#!/usr/bin/env ./fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "sym.awk"
@include "some.awk"

function Table0(i) {
  i.data = "data/weather" DOT "csv"
  i.sep  = ","
}
function Table(i) {
  Object(i)
  i.klass=""
  has(i,"less")
  has(i,"more")
  has(i,"indep")
  has(i,"rows")
  has(i,"names")
  has(i,"nums") 
  has(i,"syms") 
}
function TableRead(i,f) { lines(i,f, "Table1") }

function Table1(i,r,lst,      c,x, what) {
  if (r>1)  
    return hasss(i.rows,r-1,"Row",lst,i,w)
  else {
   for(c in lst)  {
      x = i.names[c] = lst[c]
      if (x ~  /!/)     i.klass=c
      if (x ~  /</)     i.less[c]
      if (x ~  />/)     i.more[c]
      if (x !~ /[!<>]/) i.indep[c]
      w = x ~  /</ ? -1 : 1  
      if (x ~  /[\$<>]/)
        hass(i.nums,c,"Some",c,x,w) 
      else
        hass(i.syms,c,"Sym",c,x,w)  }}
}
function TableDump(i,   r) {
  print(cat(i.names))
  for(r in i.rows)
    print(cat(i.rows[r].cells)) 
}
_______________________________
function Row(i,lst,t,     x,c) {
  Object(i)
  has(i,"cells")
  for(c in t.names) {
    x = lst[c]
    if (x != "?") {
      if (c in t.nums) {
         x += 0
         Some1(t.nums[c], x) }
      i.cells[c] = x }}
}

