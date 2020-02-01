#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

@include "csv.awk"
@include "o.awk"
@include "data.fun"

function MyLsh(my) {
  my.p = 2
  my.start
}
function  lshMain( f) { Lsh(f) }

function Lsh(f,   data, my,a,n,seen) {
  MyLsh(my)
  Data(data)
  while(csv(a,f)) 
   if(DataReady(data,a)) {
     seen[ Data1(data,a) ]
     if (n++ > my.start)
       LshPoles(my,data.rows,seen)
  }
  if(n < my.start)
    LshPoles(my,data.rows)
  #o(data)
}
function LshPoles(my,rows,seen,   m,a,b,n) {
  n=length(seen)
  m =20
  while(m-- >0) {
    a = seen[int(n*rand())]
    b = seen[int(n*rand())]
    if(used[a,b]++ == 0)
      print a,b }
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
