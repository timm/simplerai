#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

function Cols(i) {
  has(i,"lo")
  has(i,"hi")
  has(i,"names")
  has(i,"indep")
}
function Data(i) {
  has(i,"cols","Cols")
  has(i,"rows")
}
function Cols0(i,a,    col,x) {
  for(col in a) {
    x = i.names[col] = a[col]
    if(x !~ /[!<>%]/) i.indep[col] 
    if(x ~ /\$/) {
      i.lo[col] =  10^32
      i.hi[col] = -10^32 }}
}
function Cols1(i,row,     col,x) {
  for(col in i.lo) 
    if (row[col] != "?") {
      x = row[col] = row[col]+0
      if (x > i.hi[col]) i.hi[col] = x
      if (x < i.lo[col]) i.lo[col] = x }
}
function Data1(i,a,   col,row) {
  Cols1(i.cols,a)
  row = length(i.rows) + 1
  for(col in a)
   i.rows[row][col] = a[col]
  return row
}
function DataReady(i,a) {
  if (length(i.cols.names))
    return 1
  else # set up columns (ready for next time), return 0
    Cols0(i.cols,a) 
}
function DataDist(i,a,b,p,   n,col,a1,b1,inc,d) {
  p= p?p:2
  n=10^-32
  for(col in i.cols.indep) {
    n++
    a1  = a[col]
    b1  = b[col]
    inc= col in i.cols.hi ? DataDist1(i,a1,b1,col) : a1!=b1
    d += inc^p
  }
  return (d / n)^(1/p)
} 
function DataDist1(i,x,y,col,  e,hi,lo) {
  e = 10^-32
  if ((x=="?") && (y=="?")) 
    return 1
  hi = i.cols.hi[col]
  lo = i.cols.lo[col]
  if (x=="?") {
    y = (y- lo)/ (hi - lo + e)
    x = y > 0.5 ? 0 : 1
  } else if (y=="?") {
    x = (x- lo)/ (hi - lo + e)
    y = x > 0.5 ? 0 : 1 
  } else {
    x = (x- lo)/ (hi - lo + e)
    y = (y- lo)/ (hi - lo + e)
  }
  return x > y ? x-y: y-x
}
