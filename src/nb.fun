#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

function Nb(i,klass,indep) {
  i.m=2
  i.k=1
  i.start=5
  i.skip="?"
  i.sep=","
  for(j in indep) i.indep[j]
  i.klass=klass
}
function NbStream(i,f) {
  f=f?f:"-"
  while((getline < f) > 0)  {
    if (n>i.start)
      print $i.k,classify();
    if (n++ == 0) {
      for(j=1;j<=NF;j++) 
        i.name[j]=$j;
    } else {
      for(j=1;j<=NF;j++) 
        i.data[$i.k][j][$j]++
} 
    
function likelihoods(k  
   like = -10^32
   for(class in h) {
      prior = (h[class]+opt("K"))/(instances(h) + opt("K")*H);
      temp  = log(prior)
      for(i=1;i<=NF;i++) {
         if (i != k)
            if ( $i != opt("D") )
                temp += log((n[class,i,$i]+opt("M")*prior)/(h[class]+opt("M")))
      }
      l[class]= temp
      if ( temp >= like ) 
    if (class != opt("A")) {
      like = temp
      what=class
    }
   }
   return what
 } 
 
