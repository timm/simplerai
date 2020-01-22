BEGIN { srand(Seed ? Seed : 1)
        FS="," 
        Samples=100
}
function domMain(f,     nr,line,cols,rows) {
  f  = f?f:"/dev/stdin"
  nr = 0
  while ((getline <f) > 0) {
    line[nr] = $0
    if (nr++)  {
      for(c in cols)  
        rows[nr][c] = update(cols[c],$c)
    } else {
      for(c=1;c<=NF;c++)  
        create(cols,c,$c) }
   print line[0]",!>dom"
   for(r=1; r<=nr; r++)
     print line[r]",", doms(r,rows,cols)
}
function create(a,i,s  ) {
  if (s ~ /[<>]/) {
    a[i]["w"]  = (s ~ /</) ? -1 : 1
    a[i]["lo"] =  10^32
    a[i]["hi"] = -10^32 }
}
function update(i,v) {
  if (v < i["lo"]) i["lo"]=v
  if (v > i["hi"]) i["hi"]=v
  return v
}
function norm(i,v) {
  return (v-i["lo"])/(i["hi"]- i["lo"])
}
function doms(r1,rows,cols,      n,out) {
  n = Samples
  while(n--) 
    out += dom(r1,rows,cols)
  return out/Samples
}
function dom(r1,rows,cols,   r2,w,n,c,a,b,s1,s2) {
  r2= 1 + int(rand()*length(rows))
  n = length(cols)
  for(c in cols) {
    a   = norm(cols[c], rows[r1][c])
    b   = norm(cols[c], rows[r2][c])
    w   = cols[c]["w"]
    s1 -= 10^( w * (a-b)/n )
    s2 -= 10^( w * (b-a)/n ) 
  }
  return s1/n < s2/n
}
