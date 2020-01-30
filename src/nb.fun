#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

#DEF table hi
function Nb(i,klass,indep) {
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
function what2do(i, n, a) {
  if (n == 0)      return header(i, a)
  if (n > i.start) return classify(i, a)
  train(i, a, a[i.k]) }
}
function header(i,a,     c) { 
  i.klass = length(a)
  for(c in a) { 
    i.head[c]    = a[c] 
    i.name[a[c]] = c }
}
function train(i,a,k,   c) {
  i.instances++
  i.all[k]++
  for(c in a) 
    if ((x = a[c]) != "?")  
      i.data[k][c][x]++ 
}
function classify(i,a,     like,all,klass,prior,tmp,c,x,out,demon,nom) {
  like = -10^32
  all  = i.instances + i.k*length(i.data)
  for(k in i.data) {
    prior = (i.all[class] + i.k) / all
    tmp  = log(prior)
    for(c in a) 
      if (c != i.klass)  
        if ((x = a[c]) != i.skip) 
          tmp += log(i.data[klass][c][x] + i.m*prior)/(i.all[klass] + i.m);
    if ( tmp >= like )  {
      like = tmp
      out  = class }}
  return out
} 
