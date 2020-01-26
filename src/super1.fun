#!/usr/bin/env ./fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "table.fun"
@include "methods.fun"

function SuperY(i,r ,  z) { return r.cells[i.y]   }
function SuperX(i,r)      { return r.cells[i.x]   }
function SuperXput(i,r,x) { return r.cells[i.x]=x }

function SuperGlue(table,x,y,what,  trivial,
                   i,yall,j) {
  i.x = x
  i.y = y
  i.trivial = trivial ? trivial : FUN.trivial
  cellsort(table.rows, x) # sort table on the 'x' values
  i.ynew=what
  @what(yall)
  for(j in table.rows) # fill yall with data from column 'y"
    add(yall, table.rows[j].cells[y])
  SuperGlue1(i,table.rows, 1, l(table.rows), yall)
}
function SuperGlue1(i,rows,lo,hi,right0,
                   right,left,min,j,x,cut,
                   y,u,v,left1,right1,new) {
  copy(right0, right)
  new = i.ynew; @new(left)
  min = var(right)
  for(j=lo; j<hi; j++)  {
    x = SuperX(i, rows[j])
    y = SuperY(i, rows[j])
    add(left,  y)
    dec(right, y)
    if (x != FUN.skip)             
      if (x != SuperX(i, rows[j+1])) {
       new = xpect(left,right)
       if (new*i.trivial < min)  {
         min = new
         cut = j 
         copy(left,  left1)
         copy(right, right1)  }}
  }
  if (cut) {
    SuperGlue1(i,rows,lo,   cut,left1)
    SuperGlue1(i,rows,cut+1,hi, right1)
  } else {
    print "## fusing " i.x " lo " lo  " to " hi
    for(j=lo;j<=hi;j++) {
      u = SuperX(i, rows[j])
      if(u==FUN.skip)  continue
      v=v?v:u # first none-skip value
      SuperXput(i,rows[j], v) }}
}
-------------------------
function TableGlue(table,y,what,  x) {
  y = y?y:table.klass
  if (!what)
    what = y in table.nums ? "Num" : "Sym" 
  for(x in table.indep)  
     if(x in table.nums)
      SuperGlue(table,x,y,what)
}
function super1Main(   table,j) {
  Table(table)
  TableRead(table)
  TableGlue(table)
  TableDump(table)
}
  
