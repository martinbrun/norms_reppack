*replication-norms: TABLE A10
*MAY 2023

clear all
set more off

*LOAD DATA
	use "$data\master.dta", clear

*AUXILIARIES	
	global prespecified_controls i.hugo i.male i.rich i.Rain i.Hot
	global paper_controls i.hugo i.male i.Morning i.witness i.rich i.Rain i.Hot
	global extended_controls i.Morning i.witness i.day c.povrate
	global multicol "prefix(\multicolumn{@span}{c}{\textbf{) suffix(}}) span erepeat(\cmidrule(lr){@span})"
	
*DATA PROCESSING
	gen TIME_arriving = 0 
	replace TIME_arriving =  TIME_arriving + TIME if Child ==1 & Morning == 1
	replace TIME_arriving =  TIME_arriving + TIME if Child ==0 & Morning == 0

	gen TIME_leaving = 0
	replace TIME_leaving = TIME_leaving + TIME if Child == 0 & Morning == 1
	replace TIME_leaving = TIME_leaving + TIME if Child == 1 & Morning == 0

	gen T10_arriving = 0 
	replace T10_arriving =  T10_arriving + T10 if Child ==1 & Morning == 1
	replace T10_arriving =  T10_arriving + T10 if Child ==0 & Morning == 0

	gen T10_leaving = 0
	replace T10_leaving = T10_leaving + T10 if Child == 0 & Morning == 1
	replace T10_leaving = T10_leaving + T10 if Child == 1 & Morning == 0

	gen wobs_arriving = 0
	replace wobs_arriving =  wobs_arriving + wobs if Child ==1 & Morning == 1
	replace wobs_arriving =  wobs_arriving + wobs if Child ==0 & Morning == 0

	gen wobs_leaving = 0
	replace wobs_leaving =  wobs_leaving + wobs if Child ==0 & Morning == 1
	replace wobs_leaving =  wobs_leaving + wobs if Child ==1 & Morning == 0

*ESTIMATES
	*Paper Controls
		*1
		regress Punishment i.ViolationHelp##Child c.TIME_arriving c.TIME_leaving $paper_controls , vce(cluster School) coefl
		eststo
		*2
		regress Punishment i.ViolationHelp##Child c.T10_arriving c.T10_leaving $paper_controls , vce(cluster School)
		eststo
		*3
		regress Punishment i.ViolationHelp##Child c.wobs_arriving c.wobs_leaving $paper_controls , vce(cluster School)
		eststo
		*4
		regress Helping i.ViolationHelp##Child c.TIME_arriving c.TIME_leaving $paper_controls if Violation == 0, vce(cluster School)
		eststo
		*5
		regress Helping i.ViolationHelp##Child c.T10_arriving c.T10_leaving $paper_controls if Violation == 0, vce(cluster School)
		eststo
		*6
		regress Helping i.ViolationHelp##Child c.wobs_arriving c.wobs_leaving $paper_controls if Violation == 0, vce(cluster School)
		eststo

		esttab using "${results}\TableA10.tex", replace booktabs cells(b(star pattern(1 1 1) fmt(%9.3f)) se(par pattern(1 1 1)))  ///
			keep(1.Child ///
			1.ViolationHelp ///
			1.ViolationHelp#1.Child ///
			TIME_arriving TIME_leaving T10_arriving T10_leaving wobs_arriving wobs_leaving) ///
			order(1.Child ///
			1.ViolationHelp ///
			1.ViolationHelp#1.Child ///
			TIME_arriving TIME_leaving T10_arriving T10_leaving wobs_arriving wobs_leaving) ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.Child#1.ViolationHelp "Child $\times$ VH" TIME_arriving "Time $\times$ Arriving" ///
			TIME_leaving "Time $\times$ Leaving" T10_arriving "T10 $\times$ Arriving" T10_leaving "T10 $\times$ Leaving" wobs_arriving "No. $\times$ Arriving" ///
			wobs_leaving "No. $\times$ Leaving" _cons "Constant") indicate(Controls = 1.male 1.hugo 1.Morning 1.witness 1.rich 1.Rain 1.Hot) ///
			mgroups("Punishment" "Helping", pattern(1 0 0 1 0 0) ${multicol}) ///
			mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)" ) ///
			gaps collabels(none) nonumbers starlevels(* 0.10 ** 0.05 *** 0.01) ///
			postfoot("\bottomrule"  "\end{tabular}" "}") stats( N  N_clust  r2  F  df_r , labels ("Observations" "Clusters" "\$R^2\$" "\$F\$" "df")  ///
			fmt(%9.0g %9.0g  %9.2f %9.2f %9.0g))
		eststo clear
									
	*Prespecified Controls
		*1						
		regress Punishment i.ViolationHelp##Child c.TIME_arriving c.TIME_leaving $prespecified_controls , vce(cluster School) coefl
		eststo
		*2
		regress Punishment i.ViolationHelp##Child c.T10_arriving c.T10_leaving $prespecified_controls , vce(cluster School)
		eststo
		*3
		regress Punishment i.ViolationHelp##Child c.wobs_arriving c.wobs_leaving $prespecified_controls , vce(cluster School)
		eststo
		*4
		regress Helping i.ViolationHelp##Child c.TIME_arriving c.TIME_leaving $prespecified_controls if Violation == 0, vce(cluster School)
		eststo
		*5
		regress Helping i.ViolationHelp##Child c.T10_arriving c.T10_leaving $prespecified_controls if Violation == 0, vce(cluster School)
		eststo
		*6
		regress Helping i.ViolationHelp##Child c.wobs_arriving c.wobs_leaving $prespecified_controls if Violation == 0, vce(cluster School)
		eststo

		esttab using "${results}\TableA10_prespecified.tex", replace booktabs cells(b(star pattern(1 1 1) fmt(%9.3f)) se(par pattern(1 1 1)))  ///
			keep(1.Child ///
			1.ViolationHelp ///
			1.ViolationHelp#1.Child ///
			TIME_arriving TIME_leaving T10_arriving T10_leaving wobs_arriving wobs_leaving) ///
			order(1.Child ///
			1.ViolationHelp ///
			1.ViolationHelp#1.Child ///
			TIME_arriving TIME_leaving T10_arriving T10_leaving wobs_arriving wobs_leaving) ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.Child#1.ViolationHelp "Child $\times$ VH" TIME_arriving "Time $\times$ Arriving" ///
			TIME_leaving "Time $\times$ Leaving" T10_arriving "T10 $\times$ Arriving" T10_leaving "T10 $\times$ Leaving" wobs_arriving "No. $\times$ Arriving" ///
			wobs_leaving "No. $\times$ Leaving" _cons "Constant") indicate(Prespecified Controls = 1.male 1.hugo 1.rich 1.Rain 1.Hot) ///
			mgroups("Punishment" "Helping", pattern(1 0 0 1 0 0) ${multicol}) ///
			mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)" ) ///
			gaps collabels(none) nonumbers starlevels(* 0.10 ** 0.05 *** 0.01) ///
			postfoot("\bottomrule"  "\end{tabular}" "}") stats( N  N_clust  r2  F  df_r , labels ("Observations" "Clusters" "\$R^2\$" "\$F\$" "df")  ///
			fmt(%9.0g %9.0g  %9.2f %9.2f %9.0g))
		eststo clear

	*Extended Controls
		*1
		regress Punishment i.ViolationHelp##Child c.TIME_arriving c.TIME_leaving $prespecified_controls $extended_controls , vce(cluster School) coefl
		eststo
		*2
		regress Punishment i.ViolationHelp##Child c.T10_arriving c.T10_leaving $prespecified_controls $extended_controls , vce(cluster School)
		eststo
		*3
		regress Punishment i.ViolationHelp##Child c.wobs_arriving c.wobs_leaving $prespecified_controls $extended_controls , vce(cluster School)
		eststo
		*4
		regress Helping i.ViolationHelp##Child c.TIME_arriving c.TIME_leaving $prespecified_controls $extended_controls if Violation == 0, vce(cluster School)
		eststo
		*5
		regress Helping i.ViolationHelp##Child c.T10_arriving c.T10_leaving $prespecified_controls $extended_controls if Violation == 0, vce(cluster School)
		eststo
		*6
		regress Helping i.ViolationHelp##Child c.wobs_arriving c.wobs_leaving $prespecified_controls $extended_controls if Violation == 0, vce(cluster School)
		eststo

		esttab using "${results}\TableA10_extended.tex", replace booktabs cells(b(star pattern(1 1 1) fmt(%9.3f)) se(par pattern(1 1 1)))  ///
			keep(1.Child ///
			1.ViolationHelp ///
			1.ViolationHelp#1.Child ///
			TIME_arriving TIME_leaving T10_arriving T10_leaving wobs_arriving wobs_leaving) ///
			order(1.Child ///
			1.ViolationHelp ///
			1.ViolationHelp#1.Child ///
			TIME_arriving TIME_leaving T10_arriving T10_leaving wobs_arriving wobs_leaving) ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.Child#1.ViolationHelp "Child $\times$ VH" TIME_arriving "Time $\times$ Arriving" ///
			TIME_leaving "Time $\times$ Leaving" T10_arriving "T10 $\times$ Arriving" T10_leaving "T10 $\times$ Leaving" wobs_arriving "No. $\times$ Arriving" ///
			wobs_leaving "No. $\times$ Leaving" _cons "Constant") indicate(Extended Controls = 1.male 1.hugo 1.rich 1.Rain 1.Hot) ///
			mgroups("Punishment" "Helping", pattern(1 0 0 1 0 0) ${multicol}) ///
			mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)" ) ///
			gaps collabels(none) nonumbers starlevels(* 0.10 ** 0.05 *** 0.01) ///
			postfoot("\bottomrule"  "\end{tabular}" "}") stats( N  N_clust  r2  F  df_r , labels ("Observations" "Clusters" "\$R^2\$" "\$F\$" "df")  ///
			fmt(%9.0g %9.0g  %9.2f %9.2f %9.0g))
		eststo clear