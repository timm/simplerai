#!/usr/bin/env ../fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

@include "lib.fun"
@include "table.fun"
@include "methods.fun"

function statsMain( t, col) { 
   Table(t)
   TableRead(t) #  reads from stdin
   print("")
   for(col in t.nums) print(col, show(t.nums[col]))
   for(col in t.syms) print(col, show(t.syms[col]))
    
}
