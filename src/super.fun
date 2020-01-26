#!/usr/bin/env ./fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "table.fun"
@include "num.fun"
@include "sym.fun"

function Super(super,col1,col2,new) {
  List(super)
  super.trivial = FUN.trivial
  super.x= col1
  super.y= col2
  super.ynew=new
  if (new=="Sym") {
   super.add = "Sym1"; super.dec = "SymDec"; super.var = "SymEnt" 
  } else {
   super.add = "Num1"; super.dec = "NumDec"; super.var = "NumSd"
 }
}
function SuperY(super,r ,   z)      { 
  return r.cells[super.y]   
}
function SuperX(super,r)         { return r.cells[super.x]   }
function SuperXput(super,r,x)    { return r.cells[super.x]=x }
function SuperYnew(super,j,   f) { f=super.ynew; @f(j) }
function SuperYvar(super,j,   f) { f=super.var; return @f(j) }
function SuperYadd(super,j,r, f) { f=super.add; @f(j,SuperY(super,r)) }
function SuperYdec(super,j,r, f) { f=super.dec; @f(j,SuperY(super,r)) }

function SuperGlue(table,x,y,what,
                   super,yall,j) {
  # sort table on the 'x' values
  cellsort(table.rows, x)
  # initialize a new "super" object
  Super(super,x,y,what)
  # initialize a tracker for column "y"
  SuperYnew(super, yall) 
  # fill the tracker with data from column 'y"
  for(j in table.rows) 
    SuperYadd(super, yall, table.rows[j])
  # check if we can glue together any of the 'x' ranges
  SuperGlue1(super,table.rows, 1, l(table.rows), yall)
}
 
function SuperGlue1(super,a,lo,hi,right0,
                   right,left,min,j,after,now,cut,
                   v,left1,right1,new) {
  copy(right0, right)
  SuperYnew(super,left)
  min = SuperYvar(super,right)
  for(j=lo; j<hi; j++)  {
    after = SuperX(super,a[j+1])
    now   = SuperX(super,a[j])
    SuperYadd(super,left,  a[j])
    SuperYdec(super,right, a[j])
    if ((now   != FUN.skip) &&
        (now   != after)) {
       new = SuperYxpect(super,left,right)
       if (min > new * super.trivial) 
         { min = new
           cut = j 
           copy(left,  left1)
           copy(right, right1) }}
    }
  if (cut) {
    SuperGlue1(super,a,lo,   cut,left1)
    SuperGlue1(super,a,cut+1,hi, right1)
  } else {
    print "## fusing " super.x " lo " lo  " to " hi
    for(j=lo;j<=hi;j++) {
      if(v==FUN.skip)  continue
      v=v==""?SuperX(super,a[j]):v
      SuperXput(super,a[j], v) }
  }
}
function SuperYxpect(super,a,b,va,vb) {
  va = SuperYvar(super,a)
  vb = SuperYvar(super,b)
  return (a.n*va + b.n*vb) / (a.n + b.n)
}
-------------------------
function TableGlue(table,y,what,  x) {
  y = y?y:table.klass
  if (!what)
    what = y in table.nums ? "Num" : "Sym" 
  for(x in i.indep)
    if(x in table.nums)  
      SuperGlue(table,x,y,what)
}
function superMain(   table,j) {
  Table(table)
  TableRead(table)
  TableGlue(table)
  TableDump(table)
}
  
