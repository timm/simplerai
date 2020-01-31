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
  has(i,"name")
  has(i,"rows")
  has(i,"all")
}
function DataPrior(i,my,class) {
  return  (i.all[class] + my.k) / (i.instances + my.k*length(i.rows))
}
function DataEH(i,my,prior,class,col,x,   count) {
  count = i.rows[class][col][x]
  return  (count + my.m*prior) / (i.all[class]+my.m) 
}
function NbLearn(my,run,a,   initialized,rows,want,got) {
  initialized = length(run.data.name)
  if (! initialized)
     NbHeader(my,run.data, a)
  else {
    if (run.data.instances > my.start)  {
      want = a[my.goal]
      got  = NbClassify(my,run.data,a)
      Abcd1(run.results, want, got)
    }
    NbTrain(my, run.data,a) 
  }
}
function NbHeader(my,data,a,     col,name) { 
  my.goal = my.goal? my.goal : length(a)
  for(col in a) {
    name = a[col]
    if (name !~ /%/) {
      data.cols[col]  = name
      data.name[name] = col }}
}
function NbTrain(my,data,a,   class,col,x) {
  class = a[my.goal]
  data.instances++
  data.all[class]++
  for(col in data.cols) 
    if ((x = a[col]) != "?")   
      data.rows[class][col][x]++
}
function NbClassify(my,data,a,     
                    like,class,prior,tmp,col,x,out) {
  like = -10^32
  for(class in data.rows) {
    prior = DataPrior(data, my,class)
    tmp   = log(prior)
    for(col in data.cols) {
      if (col != my.goal)  
        if ((x = a[col]) != "?")  
          tmp += log( DataEH(data,my,prior,class,col,x) )
    }
    if ( tmp >= like )  {
      like = tmp
      out  = class }}
  return out
}
function nbMain(       my,run,funs) {
  MyNb(my)
  Run(run)
  funs["^data"] = "NbLearn"
  read(my,run,funs)
  AbcdReport(run.results)
}
