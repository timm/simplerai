#!/usr/bin/env bash

Stem=$(basename $1 ".fun")

Docs=$HOME/opt/fun/docs
mkdir -p  $Docs

fun2md()  { 
  a="</button>"
  b="<button class=\"button button1\">"
  c="<button class=\"button button2\">"
  cat <<-EOF
	$b<a href=/fun/index>home</a>$a
	$c<a href=/fun/INSTALL>install</a>$a
	$b<a href=/fun/ABOUT>doc</a>$a
	$c<a href=http://github.com/timm/fun/issues>discuss</a>$a
	$b<a href=/fun/LICENSE>license</a>$a
	EOF
  
  gawk '
 /^# vim:/ {next}
 /^#!/     {next}
  NR==1                    { print "\n# '$1'\n"; next }
  /^}/                     { print; print "```\n";  next }
  /^(func|BEGIN|END).*}$/  { print "```awk"; print; print "```"; next }
  /^(func|BEGIN|END)/      { print "```awk"; print; next }
                           { print $0 } '
}

cat $1 | fun2md $1 > $Docs/$Stem.md
