#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

#DEF _tbl head,name,data,all,abcd

@include "abcd.fun"
@include "lib.fun"

function MyNb(my) {
  my.m      = 2
  my.k      = 1
  my.start  = 5
  my.klass  = ""
}
function Nb(i) {
  has(i,"data","Rows")
  has(i,"results","Abcd")
}
function Rows(i) {
  i.instances=0
  has(i,"head")
  has(i,"name")
  has(i,"rows")
  has(i,"all")
}
function read(my,what,funs,file,   fun,pat,line,a) {
  file=file?file:"-"
  while((getline line < file) > 0)  {
    gsub("([ \t]|#.*)/","", line)
    if (line) {
      split(line, a, ",")
      for(pat in funs)
        if (line ~ pat) {
          fun = funs[pat]
          @fun(my,what, a) }}
  }  
  close(file)
}

#payload past ardoun file
# learn paired with evluation
# config seperaete to rest of sysmte
# learner and eval seperate (learner does not kow it is being evalautes)

function NbLearn(my,ai,a,   initialized,rows,want,got) {
  initialized = length(ai.data.name)
  if (! initialized)
     NbHeader(my,ai.data, a)
  else {
    if (ai.data.instances > my.start) 
         Abcd1(ai.results, a[my.klass], 
                           NbClassify(my,ai.data,a))
    else 
       NbTrain(my, ai.data,a) }
}
function NbHeader(my,data,a,     c) { 
  my.klass = my.klass? my.klass : length(a)
  for(c in a) { 
    data.head[c]    = a[c] 
    data.name[a[c]] = c }
}
function NbTrain(my,data,a,   k,c,x) {
  k = a[my.klass]
  data.instances++
  data.all[k]++
  for(c in data.name) 
    if ((x = a[c]) != "?")   
      data.rows[k][c][x]++ 
}
function NbClassify(my,data,a,     
                  some,like,all,k,prior,tmp,c,x,out) {
  like = -10^32
  all  = data.instances + my.k*length(data.rows)
  for(k in data.rows) {
    some  = data.all[k] + my.m
    prior = (data.all[k] + my.k) / all
    tmp   = log(prior)
    for(c in data.head) 
      if (c != my.klass)  
        if ((x = a[c]) != "?")
          tmp += log(data[k][c][x] + my.m*prior) / some;
    if ( tmp >= like )  {
      like = tmp
      out  = k }}
  return out
}
function nbMain(       my,nb,funs) {
  MyNb(my)
  Nb(nb)
  funs["^data"] = "NbLearn"
  read(my,nb,funs)
  AbcdReport(nb.results)
}
 
