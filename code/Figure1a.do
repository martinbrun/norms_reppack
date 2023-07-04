*replication-norms: FIGURE 1a
*MAY 2023

*SETUP
	clear all
	set graphics off
	
*LOAD DATA
	use "$data\master.dta", clear

*FIGURE 1a:
	preserve
	*KEEP RELEVANT VARIABLES
		keep if !missing(Punishment)
		keep Punishment Child Violation ViolationHelp 
		
		collapse (mean) mean=Punishment (sd) sd=Punishment (count) n=Punishment, by(Child ViolationHelp)
		generate ub = mean + invttail(n-1,0.025)*(sd / sqrt(n))
		generate lb= mean - invttail(n-1,0.025)*(sd / sqrt(n))
		
		gen categories=0
		replace categories=1 if inlist(Child,0) & inlist(ViolationHelp,0)
		replace categories=2 if inlist(Child,0) & inlist(ViolationHelp,1)
		replace categories=4 if inlist(Child,1) & inlist(ViolationHelp,0)
		replace categories=5 if inlist(Child,1) & inlist(ViolationHelp,1)
		
	*GRAPH
		twoway (bar mean categories if inlist(ViolationHelp,0)) ///
			(bar mean categories if inlist(ViolationHelp,1)) ///
			(rcap lb ub categories, lcolor(black)) ///
			(scatter mean categories, msym(none) mlab(mean) mlabformat(%9.2f)  mlabpos(6) mlabcolor(white) mlabstyle(p1) mlabsize(medsmall)), ///
				xtitle("") ytitle("Punishment Rate", size(medium)) ///
				graphregion(color(white)) bgcolor(white) ///
				aspect(1, placement(left)) ///
				yscale(range(0(.1).6)) ///				
				ylabel(0 "0" .1 ".1" .2 ".2" .3 ".3" .4 ".4" .5 ".5" .6 ".6") ///
				xlabel(1.5 "Alone" 4.5 "Child", noticks) ///
				legend(order(1 "Violation" 2 "Violation+Help")) ///
				legend(pos(6) col(2) bmargin(medium)) ///
				text(.6 1 "n = 100" .6 2 "n = 100" .6 4 "n = 100" .6 5 "n = 100") 
					
		graph export "${results}\Figure1a.pdf", replace		
	restore