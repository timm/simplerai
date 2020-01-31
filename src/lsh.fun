#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

@include "read.awk"

function MyLsh(my) {
  my.p      = 2
}
function LshNorm(x,lo,hi) {
  return (x - lo) / (hi - lo + 10^-32)
}
function LshDistance(i,a,b,lo,hi,p,  col,x,y,d,n) {
  d=0
  n=10^-32
  for(col in i.indep) {
     x=a[col]
     y=b[col]
     if (! (x=="?" && y=="?")) {
       n++
       if (col in hi) {
         if (x=="?") {
            y=LshNorm(y,lo[col],hi[col])
            x=y > 0.5? 0 : 1 }
         else if (y=="?") {
            x=LshNorm(x,lo[col],hi[col])
            y=x > 0.5? 0 : 1 }
         else {
            x=LshNorm(x,lo[col],hi[col])
            y=LshNorm(y,lo[col],hi[col]) }
         inc= x > y ? x-y: y-x
       } else {
         inc = x != y }
       d += inc^p}
   }
   return (d/n)^(1/p)
} 
    

function NbLearn(my,run,a) {
  if (! length(run.data.cols))
     return NbHeader(my,run.data, a)
  if (run.data.instances > my.start)  
    Abcd1(run.results, a[my.goal], NbClassify(my,run.data,a))
  NbTrain(my, run.data,a) 
}
function NbHeader(my,data,a,     col) { 
  my.goal = my.goal? my.goal : length(a)
  for(col in a) 
    if (a[col] !~ /%/) 
      data.cols[col]  = a[col]
}
function NbTrain(my,data,a,   class,col,x) {
  class = a[my.goal]
  data.instances++
  for(col in data.cols) 
    if ((x = a[col]) != "?")   
      data.freq[class][col][x]++
}
function NbClassify(my,data,a,     
                    like,class,prior,tmp,col,x,out) {
  like = -10^32
  for(class in data.freq) {
    prior = DataPrior(data, my,class)
    tmp   = log(prior)
    for(col in data.cols) {
      if (col != my.goal)  
        if ((x = a[col]) != "?")  
          tmp += log( DataEH(data,my,prior,class,col,x) )
    }
    if ( tmp >= like )  {
      like = tmp
      out  = class }
  }
  return out
}
function nbMain(       my,run,funs) {
  MyNb(my)
  Run(run)
  funs["^data"] = "NbLearn"
  read(my,run,funs)
  AbcdReport(run.results)
}
