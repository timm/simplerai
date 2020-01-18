## Usage: 
##   make help
B=$(HOME)/opt/fun/bin
SHELL=bash
PATH:=$(PATH):$B

ok: dirs files

dirs:; @mkdir -p $B
files: $B/clean $B/cols $B/bins $B/super

$B/% : %.awk; @../fun $< make
$B/% : %.fun; @../fun $< make


test: ok

.PHONY: clean1 cols1 bins1 bins2 super1

clean1: ../data/bad.csv ok
	@cat $< | clean
 
cols1: ../data/bad.csv ok
	@cat $< | clean | cols
bins1: ok
	@cat ../data/weather.csv | clean | cols | bins
bins2: ok
	@cat ../data/auto93.csv | clean | cols | bins
super1: ok
	@cat ../data/weather.csv | clean | cols | bins # clean | super
super2: ok
	@cat ../data/auto93.csv | clean | cols | bins | clean | super 
super3: ok
	@cat ../data/weather2.csv | super
