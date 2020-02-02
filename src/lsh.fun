#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

@include "csv.awk"
@include "o.awk"
@include "data.fun"
@include "ksort.awk"
@include "cat.awk"

function MyLsh(my) {
  my.p       = 2
  my.start   = 5
  my.samples = 100
  my.poles   = 10
  my.trim    = 0.95
}
function  lshMain( f) { srand(1); Lsh(f) }

function Lsh(f,   data, my,a,n,poles) {
  MyLsh(my)
  Data(data)
  List(poles)
  while(csv(a,f)) 
   if(DataReady(data,a)) 
     Data1(data,a)
  LshPoles(my,data,poles)
  o(poles)
}
function Pole(i,zero,one,d) {
  i.zero = zero
  i.one = one
  i.d =  d
}
function LshPoles(my,data,poles,
                  m,a,b,n,used) {
  n=length(data.rows)
  for(m=1; m<=my.samples; m++) {
    a = int(n*rand())+1
    b = int(n*rand())+1
    if(a != b)
      if(used[a,b]++ == 0)  
         hassss(poles,length(poles)+1, "Pole",a,b,
                DataDist(data, data.rows[a], data.rows[b], my.p)) }
  LshPolesPrune(my,poles)
}
function LshPolesPrune(my,poles,  hi,lo,p) {
  ksort(poles,"d")
  hi = int(length(poles)*my.trim) 
  lo = hi - my.poles
  if (lo<1) lo = 1
  for(p in poles) 
    if ((p>= hi) || (p <= lo)) 
      delete poles[p]  
}

  # function Pair(i) {
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
