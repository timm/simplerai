---
title: super.fun
---

<button class="button button1"><a href="/simpleai/index>home">home</a></button>
<button class="button button2"><a href="/simpleai/INSTALL>install">install</a></button>
<button class="button button1"><a href="/simpleai/ABOUT>doc">about</a></button>
<button class="button button2"><a href="http://github.com/timm/simpleai/issues>discuss">discuss</a></button>
<button class="button button1"><a href="/simpleai/LICENSE">license</a></button>

```awk
@include "lib.fun"
```
```awk
@include "table.fun"
```
```awk
@include "num.fun"
```
```awk
@include "sym.fun"
```

```awk
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
```

```awk
function SuperY(super,r ,   z)      { 
  return r.cells[super.y]   
}
```

```awk
function SuperX(super,r)         { return r.cells[super.x]   }
```
```awk
function SuperXput(super,r,x)    { return r.cells[super.x]=x }
```
```awk
function SuperYnew(super,j,   f) { f=super.ynew; @f(j) }
```
```awk
function SuperYvar(super,j,   f) { f=super.var; return @f(j) }
```
```awk
function SuperYadd(super,j,r, f) { f=super.add; @f(j,SuperY(super,r)) }
```
```awk
function SuperYdec(super,j,r, f) { f=super.dec; @f(j,SuperY(super,r)) }
```

```awk
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
```

 
```awk
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
```

```awk
function SuperYxpect(super,a,b,va,vb) {
  va = SuperYvar(super,a)
  vb = SuperYvar(super,b)
  return (a.n*va + b.n*vb) / (a.n + b.n)
}
```

-------------------------
```awk
function TableGlue(table,y,what,  x) {
  y = y?y:table.klass
  if (!what)
    what = y in table.nums ? "Num" : "Sym" 
  for(x in table.nums)  
    if(x != y) 
     if(! (x in table.goal))
      SuperGlue(table,x,y,what)
}
```

```awk
function superMain(   table,j) {
  Table(table)
  TableRead(table)
  TableGlue(table)
  TableDump(table)
}
```

  
