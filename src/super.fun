#!/usr/bin/env ./fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib"
@include "table"
@include "num"
@include "sym"

function Super(i,col1,col2,new) {
  i.trivial = Fun.trivial
  i.x= col1
  i.y= col2
  i.ynew=new
  if (new=="Sym") {
   i.add = "Sym1"; i.dec = "SymDec"; i.var = "SymEnt" 
  } else {
   i.add = "Num1"; i.dec = "NumDec"; i.var = "NumSd"
 }
}
function SuperY(i,r)      { return r.cells[i.y]   }
function SuperX(i,r)      { return r.cells[i.x]   }
function SuperXput(i,r,x) { return r.cells[i.x]=x }

function SuperYnew(i,j,   f) { f=i.new; @f(j) }
function SuperYvar(i,j,   f) { f=i.var; @f(j) }
function SuperYadd(i,j,r, f) { f=i.add; @f(j,SuperY(r)) }
function SuperYdec(i,j,r, f) { f=i.dec; @f(j,SuperY(r)) }

function SuperGlue(t,x,y,what,
                   super,yall,j) {
  Super(super,x,y,what)
  # initialize a tracker for "y"
  SuperYnew(super, yall) 
  # fill the tracker
  for(j in t.rows) SuperYadd(super, yall, t.rows[j])
  # sort table on the 'x' vaues
  cellsort(t.rows, x)
  # see if we can combine any of the 'x' ranges
  SuperGlue1(super,t.rows, 1, l(t.rows), yall)
}
 
function SuperGlue1(i,a,lo,hi,right0,
                   right,left,min,j,after,now,cut,v) {
  deepCopy(right0, right)
  SuperYnew(i,left)
  min = SuperVar(right)
  for(j=lo; j<hi; j++)  {
    after = SuperX(i,a[j+1])
    now   = SuperX(i,a[j])
    SuperYadd(i,left,  a[j])
    SuperYdec(i,right, a[j])
    if ((now   != FUN.skip) &&
        (now   != after)    &&
        min > (new = SuperYxpect(i,left,right) * i.trivial))
      { min = new
        cut = j 
        deepCopy(left,  left1)
        deepCopy(right, right1) }
    }
  if (cut) {
    SuperGlue1(i,a,lo,   cut,left1)
    SuperGlue1(i,a,cut+1,hi, right1)
  } else {
    for(j=lo;j<=hi;j++) {
      if(v==FUN.skip)  continue
      v=v?v: SuperX(i,a[j])
      SuperXput(i,a[j], v) }
  }
}
function SuperYxpect(i,a,b) {
  return (a.n*SuperYvar(i,a) + b.n*SuperYvar(i,b)
         ) / (a.n + b.n)
} 
-------------------------
function TableGlue(t,y,what,) {
  y = y?y:t.klass
  if (!what)
    what = y in t.nums : "Num" ? "Sym" 
  for(x in t.nums)  
    SuperGlue(t,x,y,what)
}
function superMain(i,  t, what) {
  Table(t)
  TableRead(t)
  TableGlue(t)
  TableDump(t)
}
  
