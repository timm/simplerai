function cat(a,  i,sep,s) {
  for(i in a) {
   s= s sep a[i]
   sep=", " }
  return s
}
function pcat(a) { print cat(a) }
