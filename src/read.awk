#Run the preferences `my` and the payload `what` over a `file`. Each
#line starts with one of the keys of `funs`-- and that key is to
#select the handler for each line.

function read(my,what,funs,file,   fun,pat,line,a) {
  file=file?file:"-"
  while((getline line < file) > 0)  {
    gsub("([ \t]|#.*)/", "", line)
    if (line) {
      split(line, a, ",")
      for(pat in funs)
        if (line ~ pat) {
          fun = funs[pat]
          @fun(my,what, a) }}
  }  
  close(file)
}


