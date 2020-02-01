#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

@include "read.awk"
@include "o.awk"

function  lshMain(  data, my,funs) {
  MyLsh(my)
  Data(data)
  funs["^data"] = "DataRead" 
  read(my,data,funs)
  o(data)
}

function MyLsh(my) {
  my.p = 2
}
 
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
  row = length(i.rows) + 1
  for(col in a)
   i.rows[row][col] = a[col]
}
function DataRead(my,data,a) {
  if (length(data.cols.names)) {
    Cols1(data.cols,a)
    Data1(data,     a) 
  } else 
    Cols0(data.cols, a)
}
#function LshDistance(a,b,lo,hi,p,  e,col,b,inc,x,y,d,n) {
#  n=10^-32
#  for(col in i.indep) {
#    n++
#    x  = a[col]
#    y  = b[col]
#    inc= col in hi ? LshDistance1(x,y,lo[col],hi[col]) : x!=y
#    d += inc^p
#   }
#   return (d / n)^(1/p)
#} 
#function LshDistance1(x,y,lo,hi,  e) {
#  e = 10^-32
#  if ((x=="?") && (y=="?")) 
#    return 1
#  if (x=="?") {
#    y = (y- lo)/ (hi - lo + e)
#    x = y > 0.5 ? 0 : 1
#  } else if (y=="?") {
#    x = (x- lo)/ (hi - lo + e)
#    y = x > 0.5 ? 0 : 1 }
#  } else {
#    x = (x- lo)/ (hi - lo + e)
#    y = (y- lo)/ (hi - lo + e)
#  }
#  return x > y ? x-y: y-x
#}   # function Pair(i) {
#   has(i,"a")
#   has(i,"b")
#   i.dist=0
# }
# function PairSet(i,my,table,a,b) {
#   split(a,i.a,",")
#   split(b,i.b,",")
#   i.dist = LshDistance(i.a,i.b,table.lo,table.hi,my.p)
# }
# function lines(a,data,f,   line,n) {
#   n=-1
#   while((getline line < f) > 0) { 
#     n++
#     split(line,row,",")
#     if (n>0) { 
#       ColsUpdate(data.cols, row)
#     } else
#       has(data,"cols","Cols",row)
#       
#     a[n++] = line
#   close(f)
# }
# function any(a) { a[int(rand()*length[a])] }
# function pairs(f) {
#   lines(a,f?f:"-")
#   for(j in a) {
#     n++
#     if(n> 256) break
#     has(all,n,"Pair")
#     PairSet(all[n], my, table, a[k], any(a))
# }
# function NbLearn(my,run,a) {
#   if (! length(run.data.cols))
#      return NbHeader(my,run.data, a)
#   if (run.data.instances > my.start)  
#     Abcd1(run.results, a[my.goal], NbClassify(my,run.data,a))
#   NbTrain(my, run.data,a) 
# }
# function NbHeader(my,data,a,     col) { 
#   my.goal = my.goal? my.goal : length(a)
#   for(col in a) 
#     if (a[col] !~ /%/) 
#       data.cols[col]  = a[col]
# }
# function NbTrain(my,data,a,   class,col,x) {
#   class = a[my.goal]
#   data.instances++
#   for(col in data.cols) 
#     if ((x = a[col]) != "?")   
#       data.freq[class][col][x]++
# }
# function NbClassify(my,data,a,     
#                     like,class,prior,tmp,col,x,out) {
#   like = -10^32
#   for(class in data.freq) {
#     prior = DataPrior(data, my,class)
#     tmp   = log(prior)
#     for(col in data.cols) {
#       if (col != my.goal)  
#         if ((x = a[col]) != "?")  
#           tmp += log( DataEH(data,my,prior,class,col,x) )
#     }
#     if ( tmp >= like )  {
#       like = tmp
#       out  = class }
#   }
#   return out
# }
# function nbMain(       my,run,funs) {
#   MyNb(my)
#   Run(run)
#   funs["^data"] = "NbLearn"
#   read(my,run,funs)
#   AbcdReport(run.results)
# }
