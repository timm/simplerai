#!/usr/bin/env ./fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "sym.fun"
@include "some.fun"

function Table0(i) {
  i.data = "data/weather" DOT "csv"
  i.sep  = ","
}
function Table(table) {
  Object(table)
  table.klass=""
  has(table,"rows")
  has(table,"names")
  has(table,"goal")
  has(table,"indep")
  has(table,"nums") 
  has(table,"syms") 
}
function TableRead(i,f) { lines(i,f, "Table1") }

function Table1(i,r,lst,      c,x, what,w) {
  if (r>1)  
    return hasss(i.rows,r-1,"Row",lst,i)
  else {
   for(c in lst)  {
      x = i.names[c] = lst[c]
      if (x ~  /!/)     i.klass=c
      if (x ~  /</)     i.goal[c]
      if (x ~  />/)     i.goal[c]
      if (x !~ /[!<>]/) i.indep[c]
      w = x ~  /</ ? -1: 1 
      if (x ~  /[\$<>]/)
        hassss(i.nums,c,"Some",c,x,w) 
      else
        hassss(i.syms,c,"Sym",c,x,w) }} 
}
function TableDump(i,   r) {
  print(cat(i.names))
  for(r in i.rows) print(cat(i.rows[r].cells)) 
}
_______________________________
function Row(i,lst,table,     x,c) {
  Object(i)
  has(i,"cells")
  for(c in table.names) {
    x = lst[c]
    if (x != "?") {
      if (c in table.nums)  {
         x = Some1(table.nums[c], x+0) 
      } else {
         x = Sym1(table.syms[c], x)  };
      i.cells[c] = x }}
}

