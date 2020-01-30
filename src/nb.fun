#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

#DEF _tbl head,name,data,all,abcd

@include "abcd.fun"

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
function lines(my,what,fun,file,   line,a) {
  file=file?file:"-"
  while((getline line < file) > 0)  {
    gsub("([ \t]|#.*)/","", line)
    if (line) {
      split(line, a, ",")
      @fun(my,what, a) }
  }  
  close(file)
}
function learn(my,ai,a,    got,want) {
  if ((n = length(ai.data.name)) == 0)
     header(my,ai.data, a)
  else if (n > my.start) {
    want = a[my.k]
    got  = classify(my,ai.data,a)
    Abcd1(ai.results, want, got)
  } else
    train(my, ai.data,a, a[i.k]) 
}
function header(my,data,a,     c) { 
  my.klass = my.klass? my.klass : length(a)
  for(c in a) { 
    data.head[c]    = a[c] 
    data.name[a[c]] = c }
}
function train(my,data,a,k,   c,x,k) {
  k = a[my.klass]
  data.instances++
  data.all[k]++
  for(c in a) 
    if ((x = a[c]) != "?")  
      data.rows[k][c][x]++ 
}
function classify(my,data,a,     
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
function nbMain(my) {
  MyNb(my)
  Nb(nb)
  lines(my,nb,"learn")
  AbcdReport(nb.results)
  print(my.k)
}
 
