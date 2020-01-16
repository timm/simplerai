#!/usr/bin/env ./fun
# vim: filetype=awk ts=2 sw=2 sts=2  et :

function Globals(i) {
  i.dot  = sprintf("%c",46)
  i.trivial = 1.05
  i.some.magic  = 2.56
  i.some.max    = 256
  i.stats.cliffs.small   = 0.147
  i.stats.cohen.small   = 0.3
  i.bins.step = .5
  i.
}
BEGIN { Globals(FUN) }
