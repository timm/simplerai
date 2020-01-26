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
 
stats1: ../data/bad.csv ok
	@cat ../data/weather2.csv | clean | cols | stats
bins1: ok
	@cat ../data/weather.csv | clean | cols | bins
bins2: ok
	@cat ../data/auto93.csv | clean | cols | bins

## bins2
## 2 1: 131
## 2 2: 168
## 2 3: 360
## 2 4: 455
## 3 1: 77
## 3 2: 90
## 3 3: 100
## 3 4: 116
## 3 5: 133
## 3 6: 153
## 3 7: 180
## 3 8: 230
## 4 1: 2228
## 4 2: 2525
## 4 3: 2745
## 4 4: 4141
## 4 5: 4499
## 4 6: 5140
## 5 1: 11
## 5 2: 12.5
## 5 3: 13.8
## 5 4: 14.9
## 5 5: 15.7
## 5 6: 16.1
## 5 7: 17.5
## 5 8: 19.4
## 5 9: 24.6
## 6 1: 71
## 6 2: 73
## 6 3: 76
## 6 4: 79
## 6 5: 82
## 8 1: 10
## 8 2: 20
## 8 3: 40


super1b: ok
	@cat ../data/weather2.csv | sort -t, -n -k 2 | column -t -s,
	@echo ""
	@cat ../data/weather2.csv | sort -t, -n -k 3 | column -t -s,
	@echo ""
	@cat ../data/weather2.csv | clean | cols | super1 | column -t -s,
super2: ok
	@cat ../data/auto93.csv | clean | cols | bins | grep '#'
	@echo ""
	@cat ../data/auto93.csv | clean | cols | bins | clean | super1 | column -t -s, 

super4: ok
	@cat ../data/nasa93dem.csv | clean | cols | dom | bins| clean | super1 | sort -t, -n -k 28

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


