#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

eg. at ../data/weathered.csv | ./nb.fun
expect:

   num |     a |     b |     c |     d |  acc |  pre |   pd |   pf |    f |    g | class
  ---- |  ---- |  ---- |  ---- |  ---- | ---- | ---- | ---- | ---- | ---- | ---- |-----
    22 |    11 |     2 |     4 |     5 | 0.73 | 0.56 | 0.71 | 0.27 | 0.63 | 0.72 | no
    22 |     5 |     4 |     2 |    11 | 0.73 | 0.85 | 0.73 | 0.29 | 0.79 | 0.72 | yes


@include "abcd.fun"
@include "read.awk"

function MyNb(my) {
  my.m      = 2
  my.k      = 1
  my.start  = 5
  my.goal  = ""
}
function Run(i) {
  has(i,"data","Data")
  has(i,"results","Abcd")
}
function Data(i) {
  i.instances=0
  has(i,"cols")
  has(i,"freq")
}
function DataPrior(i,my,class) {
  return  (i.all[class] + my.k) / (i.instances + my.k*length(i.freq))
}
function DataEH(i,my,prior,class,col,x,   count,all) {
  count = i.freq[class][col][x]
  all   = i.freq[class][my.goal][class]
  return  (count + my.m*prior) / (all +my.m) 
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
