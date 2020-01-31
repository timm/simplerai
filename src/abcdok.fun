#!/usr/bin/env ../fun
# vim: filetype=awk nospell ts=2 sw=2 sts=2  et :

#DEF _tbl head,name,data,all,abcd

@include "abcd.fun"

function abcdokMain(   i,j) {
  Abcd(i)
  for(j=1;j<=6;j++) Abcd1(i,"y","y")
  for(j=1;j<=2;j++) Abcd1(i,"n","n")
  for(j=1;j<=5;j++) Abcd1(i,"m","m")
  Abcd1(i,"m","n")
  AbcdReport(i)
}


Expect

   num |     a |     b |     c |     d |  acc |  pre |   pd |   pf |    f |    g | class
  ---- |  ---- |  ---- |  ---- |  ---- | ---- | ---- | ---- | ---- | ---- | ---- |-----
    14 |     8 |       |       |     6 | 0.93 | 1.00 | 1.00 | 0.00 | 1.00 | 1.00 | y
    14 |     8 |     1 |       |     5 | 0.93 | 1.00 | 0.83 | 0.00 | 0.91 | 0.91 | m
    14 |    11 |       |     1 |     2 | 0.93 | 0.67 | 1.00 | 0.08 | 0.80 | 0.96 | n

