#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

#DEF table hi
@include "abcd.fun"

function nbMain(i) {
  Nb(i)
  lines(i,"what2do")
  AbcdReport(i.abcd)
  print(i.k)
}
function Nb(i) {
  i.skip="?"
  i.m=2
  i.k=1
  i.sep=","
  i.start = 5
  i.doomed = "([ \t]|#.*)"
  i.instances = 0
  has(i,"head")
  has(i,"name")
  has(i,"data")
  has(i,"all")
  i.klass=""
  has(i,"abcd","Abcd")
}
function lines(i,fun, file,   n,line,a) {
  file=file?file:"-"
  while((getline line < file) > 0)  {
    gsub(i.doomed, "", line)
    if (line) {
      split(line, a, i.sep)
      @fun(i, n++, a) }
  }  
  close(file)
}
function what2do(i, n, a,    got,want) {
  if (n == 0)      return header(i, a)
  if (n > i.start) {
    want = a[i.k]
    got = classify(i,a)
    Abcd1(i.abcd, want, got)
  } else
    train(i, a, a[i.k]) 
}
function header(i,a,     c) { 
  i.k = length(a)
  for(c in a) { 
    i.head[c]    = a[c] 
    i.name[a[c]] = c }
}
function train(i,a,k,   c,x) {
  i.instances++
  i.all[k]++
  for(c in a) 
    if ((x = a[c]) != "?")  
      i.data[k][c][x]++ 
}
function classify(i,a,     
                  some,like,all,k,prior,tmp,c,x,out) {
  like = -10^32
  all  = i.instances + i.k*length(i.data)
  for(k in i.data) {
    some  = i.all[k] + i.m
    prior = (i.all[k] + i.k) / all
    tmp   = log(prior)
    for(c in a) 
      if (c != i.klass)  
        if ((x = a[c]) != i.skip) 
          tmp += log(i.data[k][c][x] + i.m*prior) / some;
    if ( tmp >= like )  {
      like = tmp
      out  = k }}
  return out
} 
