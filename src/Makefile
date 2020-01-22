## Usage: 
##   make help
B=$(HOME)/opt/fun/bin
SHELL=bash
PATH:=$(PATH):$B

ok: dirs files

dirs:; @mkdir -p $B
files: $B/clean $B/cols $B/bins $B/super $B/stats $B/dom  $B/super1

$B/% : %.awk; @../fun $< make
$B/% : %.fun; @../fun $< make

test: ok

.PHONY: clean1 cols1 bins1 bins2 super1 super2 super3 super4 

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

super4: ok
	@cat ../data/nasa93dem.csv | clean | cols | dom | bins| clean | super | sort -t, -n -k 28

super21: ok
	@cat ../data/auto93.csv | clean | cols | bins | clean | super1 
super31: ok
	@cat ../data/weather2.csv | super1


.PHONY: dom1 dom1Header dom1Prim 

dom1: ok
	@echo "worst"
	@$(MAKE) dom1Header dom1Prim  | head -11 | stats
	@printf "\nbest\n"
	@($(MAKE) dom1Header; $(MAKE) dom1Prim | tail -10)  | stats

dom1Header: ;@echo "<effort,<defects,<months,!>dom"

dom1Prim: ok        
	@cat ../data/nasa93dem.csv | clean|cols | dom #| grep -v "loc" | sort -t, -n -k 28 | cut -d, -f 25-

.PHONY: dom2 dom2Header dom2Prim 

dom2: ok
	@echo "worst"
	@$(MAKE) dom2Header dom2Prim  | head -11 | stats
	@printf "\nbest\n"
	@($(MAKE) dom2Header; $(MAKE) dom2Prim | tail -10)  | stats

dom2Header: ;@echo " <weight, >acceleration,>!mpg"

dom2Prim: ok        
	@cat ../data/auto93.csv | clean|cols | dom \
	| grep -v "horse" | sort -t, -n -k 9 | cut -d, -f 4,5,8,9


