#!/usr/bin/env ./fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "table.fun"
@include "col.fun"

function SuperY(i,r ,  z) { return r.cells[i.y]   }
function SuperX(i,r)      { return r.cells[i.x]   }
function SuperXput(i,r,x) { return r.cells[i.x]=x }

function SuperGlue(table,x,y,what,  trivial,
                   i,yall,j) {
  i.x= x
  i.y= y
  i.trivial = trivial ? trivial : FUN.trivial
  # sort table on the 'x' values
  cellsort(table.rows, x)
  # initialize a new "i" object
  i.ynew=what; @what(yall)
  # fill the tracker with data from column 'y"
  for(j in table.rows) 
    add(yall, table.rows[j].cells[y])
  # check if we can glue together any of the 'x' ranges
  SuperGlue1(i,table.rows, 1, l(table.rows), yall)
}
 
function SuperGlue1(i,a,lo,hi,right0,
                   right,left,min,j,after,now,cut,
                   v,left1,right1,new) {
  copy(right0, right)
  new = i.ynew; @new(left)
  min = var(right)
  for(j=lo; j<hi; j++)  {
    after = SuperX(i, a[j+1])
    now   = SuperX(i, a[j])
    add(left,  SuperY(i, a[j]))
    dec(right, SuperY(i, a[j]))
    if ((now   != FUN.skip) && (now   != after)) {
       new = xpect(left,right)
       if (min > new * i.trivial) 
         { min = new
           cut = j 
           copy(left,  left1)
           copy(right, right1) }}
  }
  if (cut) {
    SuperGlue1(i,a,lo,   cut,left1)
    SuperGlue1(i,a,cut+1,hi, right1)
  } else {
    print "## fusing " i.x " lo " lo  " to " hi
    for(j=lo;j<=hi;j++) {
      if(v==FUN.skip)  continue
      v=v==""?SuperX(i,a[j]):v
      SuperXput(i,a[j], v) }
  }
}
-------------------------
function TableGlue(table,y,what,  x) {
  y = y?y:table.klass
  if (!what)
    what = y in table.nums ? "Num" : "Sym" 
  for(x in table.nums)  
    if(x != y) 
     if(! (x in table.goal))
      SuperGlue(table,x,y,what)
}
function super1Main(   table,j) {
  Table(table)
  TableRead(table)
  TableGlue(table)
  TableDump(table)
}
  
