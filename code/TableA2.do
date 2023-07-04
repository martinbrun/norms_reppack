*replication-norms: TABLE A2
*MAY 2023

clear all
set more off

*LOAD DATA
	use "$data\master.dta", clear
	
*ESTIMATES
	eststo morning_alone: ///
		estpost tabstat response2 if Morning == 1 & Child == 0, by(scene) statistics(mean semean) columns(statistics) listwise
		
	eststo morning_child: ///
		estpost tabstat response2 if Morning == 1 & Child == 1, by(scene) statistics(mean semean) columns(statistics) listwise
		
	eststo all_morning: ///
		estpost tabstat response2 if Morning == 1, by(scene) statistics(mean semean) columns(statistics) listwise
		
	matrix p_chi2 = J(1, 4, .)
	forvalues i = 1(1)3 {
		tab response2 Child if Morning == 1 & scene == `i', chi2
		matrix p_chi2[1, `i'] = r(p)
	}
	tab response2 Child if Morning == 1, chi2
	matrix p_chi2[1, 4] = r(p)
	matrix colnames p_chi2 = "Help" "Violation" "Violation+Help" "Total"
	estadd matrix p_chi2_m = p_chi2, replace
		
	eststo afternoon_alone: ///
		estpost tabstat response2 if Morning == 0 & Child == 0, by(scene) statistics(mean semean) columns(statistics) listwise
		
	eststo afternoon_child: ///
		estpost tabstat response2 if Morning == 0 & Child == 1, by(scene) statistics(mean semean) columns(statistics) listwise
		
	eststo all_afternoon: ///
		estpost tabstat response2 if Morning == 0, by(scene) statistics(mean semean) columns(statistics) listwise
		
	matrix p_chi2 = J(1, 4, .)
	forvalues i = 1(1)3 {
		tab response2 Child if Morning == 0 & scene == `i', chi2
		matrix p_chi2[1, `i'] = r(p)
	}
	tab response2 Child if Morning == 0, chi2
	matrix p_chi2[1, 4] = r(p)
	matrix colnames p_chi2 = "Help" "Violation" "Violation+Help" "Total"
	estadd matrix p_chi2_a = p_chi2, replace
		
*EXPORT RESULTS
	esttab morning_alone morning_child all_morning afternoon_alone afternoon_child all_afternoon ///
		using "${results}\TableA2.tex", replace booktabs ///
			cells("mean(pattern(1 1 1 1 1 1) fmt(%10.2fc)) p_chi2_m(pattern(0 0 1 0 0 0) fmt(%10.2fc))  p_chi2_a(pattern(0 0 0 0 0 1) fmt(%10.2fc))" "semean(par pattern(1 1 1 1 1 1))") ///
			mgroups("Morning" "Afternoon", pattern(1 0 0 1 0 0)) ///
			mlabels(Alone Child All Alone Child All) nomtitle collabels(none) nonumbers 
			