*replication-norms: TABLE A8
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
	replace children2 = 99 if children2 == .
	replace male = 99 if male == .
	replace children3 = 99 if children3 == .

*ESTIMATES
	*Paper Controls
		*1	
		regress Punishment i.ViolationHelp##Child i.hugo i.male i.rich i.Morning i.witness i.Rain i.Hot , vce(cluster School)
		eststo
		*2	
		regress Punishment i.ViolationHelp##children i.hugo i.male i.rich i.Morning i.witness i.Rain i.Hot , vce(cluster School)
		eststo
		*3
		regress Punishment i.ViolationHelp##children2 i.hugo i.male i.rich i.Morning i.witness i.Rain i.Hot , vce(cluster School) 
		eststo
		*4
		regress Punishment i.ViolationHelp##children3 i.hugo i.male i.rich i.Morning i.witness i.Rain i.Hot , vce(cluster School) 
		eststo
		*5
		regress Punishment i.ViolationHelp i.male i.male##i.Child i.hugo i.hugo##i.Child i.rich i.Morning i.witness i.Rain i.Hot , vce(cluster School)
		eststo
		*6
		regress Punishment i.ViolationHelp##i.Child i.male i.hugo  i.male##i.hugo i.Morning i.witness i.rich i.Rain i.Hot  , vce(cluster School)
		eststo
		*7
		regress Punishment i.ViolationHelp##i.Child i.male i.hugo i.Morning i.witness i.rich i.Child##i.rich i.Rain i.Hot  , vce(cluster School)
		eststo 
		*8
		regress Punishment i.ViolationHelp##i.Child i.male i.hugo Child##i.inc_Q i.Morning i.witness i.Rain i.Hot  , vce(cluster School) coefl
		eststo
	
		esttab using "${results}\TableA8.tex", replace booktabs cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
					keep(1.Child ///
					1.children ///
					1.children2 2.children2 3.children2 4.children2 99.children2 ///
					1.children3 2.children3 3.children3 4.children3 5.children3 ///
					1.ViolationHelp ///
					1.ViolationHelp#1.Child ///
					1.ViolationHelp#1.children ///
					1.ViolationHelp#1.children2 1.ViolationHelp#2.children2 1.ViolationHelp#3.children2 1.ViolationHelp#4.children2 1.ViolationHelp#99.children2 ///
					1.ViolationHelp#1.children3 1.ViolationHelp#2.children3 1.ViolationHelp#3.children3 1.ViolationHelp#4.children3 1.ViolationHelp#5.children3  1.ViolationHelp#99.children3 ///
					1.male 1.male#1.Child 1.hugo  1.hugo#1.Child 1.male#1.hugo 1.rich 1.Child#1.rich ///
					2.inc_Q 3.inc_Q 4.inc_Q 1.Child#2.inc_Q 1.Child#3.inc_Q 1.Child#4.inc_Q ///
					1.Rain 1.Hot) ///)
					order(1.Child ///
					1.children ///
					1.children2 2.children2 3.children2 4.children2 99.children2 ///
					1.children3 2.children3 3.children3 4.children3 5.children3 ///
					1.ViolationHelp ///
					1.ViolationHelp#1.Child ///
					1.ViolationHelp#1.children ///
					1.ViolationHelp#1.children2 1.ViolationHelp#2.children2 1.ViolationHelp#3.children2 1.ViolationHelp#4.children2 1.ViolationHelp#99.children2 ///
					1.ViolationHelp#1.children3 1.ViolationHelp#2.children3 1.ViolationHelp#3.children3 1.ViolationHelp#4.children3 1.ViolationHelp#5.children3 1.ViolationHelp#99.children3 ///
					1.male 1.male#1.Child 1.hugo  1.hugo#1.Child 1.male#1.hugo 1.rich 1.Child#1.rich ///
					2.inc_Q 3.inc_Q 4.inc_Q 1.Child#2.inc_Q 1.Child#3.inc_Q 1.Child#4.inc_Q ///
					1.Rain 1.Hot) ///
					varlabels(1.Child "Child" ///
					1.children "1 Child" 2.children "2 Children" 3.children "3+ children" ///
					1.children2 "1 Boy" 2.children2 "1 Girl" 3.children2 "2 children" 4.children2 "3+ children" ///
					1.children3 "1 Child Age $\leq$ 5" 2.children3 "5 $<$ 1 Child Age $\leq$ 8" 3.children3 "1 Child Age $>$ 8" 4.children3 "2 Children" 5.children3 "3+ Children" 99.children3 "Children missing" ///
					1.ViolationHelp "VH" ///
					1.ViolationHelp#1.Child "VH $\times$ Child" ///
					1.ViolationHelp#1.children "VH $\times$ 1 Child" 1.ViolationHelp#2.children "VH $\times$ 2 Children" 1.ViolationHelp#3.children "VH $\times$ 3+ Children" ///
					1.ViolationHelp#1.children2 "VH $\times$ 1 Boy" 1.ViolationHelp#2.children2 "VH $\times$ 1 Girl" 1.ViolationHelp#3.children2 "VH $\times$ 2 Children" ///
						1.ViolationHelp#4.children2 "VH $\times$ 3+ Children" 1.ViolationHelp#99.children2 "VH $\times$ Missing" ///
					1.ViolationHelp#1.children3 "VH $\times$ 1 Child Age $\leq$ 5" 1.ViolationHelp#2.children3 "VH $\times$ 5 $<$ 1 Child Age $\leq$ 8" ///
						1.ViolationHelp#3.children3 "VH $\times$ 1 Child Age $>$ 9" 1.ViolationHelp#4.children3 "VH $\times$ 2 Children" 1.ViolationHelp#5.children3 "VH $\times$ 3+ Children" 1.ViolationHelp#99.children3 "VH $\times$ Missing" ///
					1.male "Male Target" 1.male#1.Child "Male Target $\times$ Child" 1.hugo "Male Actor" 1.hugo#1.Child "Male Actor $\times$ Child" 1.male#1.hugo "Male Actor $\times$ Male target" ///
					1.rich "Rich area" 1.Child#1.rich "Rich area $\times$ Child" ///
					1.Rain "Rain" 1.Hot "Hot" _cons "Constant" 2.inc_Q "Medium Low Income" 3.inc_Q "Medium High Income" 4.inc_Q "High Income" ///
					1.Child#2.inc_Q "Medium Low Income $\times$ Child" 1.Child#3.inc_Q "Medium High Income $\times$ Child" 1.Child#4.inc_Q "High Income $\times$ Child") ///
					mgroups("Base" "Child" "Target" "Income", pattern(1  1  0  0  1  0  1  0) ${multicol}) ///
					mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)" "(7)" "(8)") ///
					gaps collabels(none) nonumbers starlevels(* 0.10 ** 0.05 *** 0.01) ///
					postfoot("\bottomrule"  "\end{tabular}" "}") stats( N  N_clust  r2  F  df_r , labels ("Observations" "Clusters" "\$R^2\$" "\$F\$" "df")  ///
					fmt(%9.0g %9.0g  %9.2f %9.2f %9.0g))
										
					eststo clear
								
	*Prespecified Controls								
		*1	
		regress Punishment i.ViolationHelp##Child i.hugo i.male i.rich i.Rain i.Hot , vce(cluster School)
		eststo
		*2	
		regress Punishment i.ViolationHelp##children i.hugo i.male i.rich i.Rain i.Hot , vce(cluster School)
		eststo
		*3
		regress Punishment i.ViolationHelp##children2 i.hugo i.male i.rich i.Rain i.Hot , vce(cluster School) 
		eststo
		*4
		regress Punishment i.ViolationHelp##children3 i.hugo i.male i.rich i.Rain i.Hot , vce(cluster School) 
		eststo
		*5
		regress Punishment i.ViolationHelp i.male i.male##i.Child i.hugo##i.Child i.hugo i.male i.rich i.Rain i.Hot, vce(cluster School)
		eststo
		*6
		regress Punishment i.ViolationHelp##i.Child i.male##i.hugo i.hugo i.male i.rich i.Rain i.Hot  , vce(cluster School)
		eststo
		*7
		regress Punishment i.ViolationHelp##i.Child i.Child##i.rich i.hugo i.male i.rich i.Rain i.Hot  , vce(cluster School)
		eststo 
		*8
		regress Punishment i.ViolationHelp##i.Child Child##i.inc_Q i.hugo i.male i.rich i.Rain i.Hot  , vce(cluster School) coefl
		eststo

		esttab using "${results}\TableA8_prespecified.tex", replace booktabs cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
					keep(1.Child ///
					1.children ///
					1.children2 2.children2 3.children2 4.children2 99.children2 ///
					1.children3 2.children3 3.children3 4.children3 5.children3 ///
					1.ViolationHelp ///
					1.ViolationHelp#1.Child ///
					1.ViolationHelp#1.children ///
					1.ViolationHelp#1.children2 1.ViolationHelp#2.children2 1.ViolationHelp#3.children2 1.ViolationHelp#4.children2 1.ViolationHelp#99.children2 ///
					1.ViolationHelp#1.children3 1.ViolationHelp#2.children3 1.ViolationHelp#3.children3 1.ViolationHelp#4.children3 1.ViolationHelp#5.children3  1.ViolationHelp#99.children3 ///
					1.male 1.male#1.Child 1.hugo  1.hugo#1.Child 1.male#1.hugo 1.rich 1.Child#1.rich ///
					2.inc_Q 3.inc_Q 4.inc_Q 1.Child#2.inc_Q 1.Child#3.inc_Q 1.Child#4.inc_Q ///
					1.Rain 1.Hot) ///)
					order(1.Child ///
					1.children ///
					1.children2 2.children2 3.children2 4.children2 99.children2 ///
					1.children3 2.children3 3.children3 4.children3 5.children3 ///
					1.ViolationHelp ///
					1.ViolationHelp#1.Child ///
					1.ViolationHelp#1.children ///
					1.ViolationHelp#1.children2 1.ViolationHelp#2.children2 1.ViolationHelp#3.children2 1.ViolationHelp#4.children2 1.ViolationHelp#99.children2 ///
					1.ViolationHelp#1.children3 1.ViolationHelp#2.children3 1.ViolationHelp#3.children3 1.ViolationHelp#4.children3 1.ViolationHelp#5.children3 1.ViolationHelp#99.children3 ///
					1.male 1.male#1.Child 1.hugo  1.hugo#1.Child 1.male#1.hugo 1.rich 1.Child#1.rich ///
					2.inc_Q 3.inc_Q 4.inc_Q 1.Child#2.inc_Q 1.Child#3.inc_Q 1.Child#4.inc_Q ///
					1.Rain 1.Hot) ///
					varlabels(1.Child "Child" ///
					1.children "1 Child" 2.children "2 Children" 3.children "3+ children" ///
					1.children2 "1 Boy" 2.children2 "1 Girl" 3.children2 "2 children" 4.children2 "3+ children" ///
					1.children3 "1 Child Age $\leq$ 5" 2.children3 "5 $<$ 1 Child Age $\leq$ 8" 3.children3 "1 Child Age $>$ 8" 4.children3 "2 Children" 5.children3 "3+ Children" 99.children3 "Children missing" ///
					1.ViolationHelp "VH" ///
					1.ViolationHelp#1.Child "VH $\times$ Child" ///
					1.ViolationHelp#1.children "VH $\times$ 1 Child" 1.ViolationHelp#2.children "VH $\times$ 2 Children" 1.ViolationHelp#3.children "VH $\times$ 3+ Children" ///
					1.ViolationHelp#1.children2 "VH $\times$ 1 Boy" 1.ViolationHelp#2.children2 "VH $\times$ 1 Girl" 1.ViolationHelp#3.children2 "VH $\times$ 2 Children" ///
						1.ViolationHelp#4.children2 "VH $\times$ 3+ Children" 1.ViolationHelp#99.children2 "VH $\times$ Missing" ///
					1.ViolationHelp#1.children3 "VH $\times$ 1 Child Age $\leq$ 5" 1.ViolationHelp#2.children3 "VH $\times$ 5 $<$ 1 Child Age $\leq$ 8" ///
						1.ViolationHelp#3.children3 "VH $\times$ 1 Child Age $>$ 9" 1.ViolationHelp#4.children3 "VH $\times$ 2 Children" 1.ViolationHelp#5.children3 "VH $\times$ 3+ Children" 1.ViolationHelp#99.children3 "VH $\times$ Missing" ///
					1.male "Male Target" 1.male#1.Child "Male Target $\times$ Child" 1.hugo "Male Actor" 1.hugo#1.Child "Male Actor $\times$ Child" 1.male#1.hugo "Male Actor $\times$ Male target" ///
					1.rich "Rich area" 1.Child#1.rich "Rich area $\times$ Child" ///
					1.Rain "Rain" 1.Hot "Hot" _cons "Constant" 2.inc_Q "Medium Low Income" 3.inc_Q "Medium High Income" 4.inc_Q "High Income" ///
					1.Child#2.inc_Q "Medium Low Income $\times$ Child" 1.Child#3.inc_Q "Medium High Income $\times$ Child" 1.Child#4.inc_Q "High Income $\times$ Child") ///
					mgroups("Base" "Child" "Target" "Income", pattern(1  1  0  0  1  0  1  0) ${multicol}) ///
					mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)" "(7)" "(8)") ///
					gaps collabels(none) nonumbers starlevels(* 0.10 ** 0.05 *** 0.01) ///
					postfoot("\bottomrule"  "\end{tabular}" "}") stats( N  N_clust  r2  F  df_r , labels ("Observations" "Clusters" "\$R^2\$" "\$F\$" "df")  ///
					fmt(%9.0g %9.0g  %9.2f %9.2f %9.0g))
										
		eststo clear
						
	*Extended Controls
		*1	
		regress Punishment i.ViolationHelp##Child i.hugo i.male i.rich i.Rain i.Hot i.day c.povrate, vce(cluster School)
		eststo
		*2	
		regress Punishment i.ViolationHelp##children i.hugo i.male i.rich i.Rain i.Hot i.day c.povrate, vce(cluster School)
		eststo
		*3
		regress Punishment i.ViolationHelp##children2 i.hugo i.male i.rich i.Rain i.Hot i.day c.povrate, vce(cluster School) 
		eststo
		*4
		regress Punishment i.ViolationHelp##children3 i.hugo i.male i.rich i.Rain i.Hot i.day c.povrate, vce(cluster School) 
		eststo
		*5
		regress Punishment i.ViolationHelp i.male i.male##i.Child i.hugo##i.Child i.hugo i.male i.rich i.Rain i.Hot i.day c.povrate, vce(cluster School)
		eststo
		*6
		regress Punishment i.ViolationHelp##i.Child i.male##i.hugo i.hugo i.male i.rich i.Rain i.Hot i.day c.povrate, vce(cluster School)
		eststo
		*7
		regress Punishment i.ViolationHelp##i.Child i.Child##i.rich i.hugo i.male i.rich i.Rain i.Hot i.day c.povrate , vce(cluster School)
		eststo 
		*8
		regress Punishment i.ViolationHelp##i.Child Child##i.inc_Q i.hugo i.male i.rich i.Rain i.Hot i.day c.povrate , vce(cluster School) coefl
		eststo

		esttab using "${results}\TableA8_extended.tex", replace booktabs cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
					keep(1.Child ///
					1.children ///
					1.children2 2.children2 3.children2 4.children2 99.children2 ///
					1.children3 2.children3 3.children3 4.children3 5.children3 ///
					1.ViolationHelp ///
					1.ViolationHelp#1.Child ///
					1.ViolationHelp#1.children ///
					1.ViolationHelp#1.children2 1.ViolationHelp#2.children2 1.ViolationHelp#3.children2 1.ViolationHelp#4.children2 1.ViolationHelp#99.children2 ///
					1.ViolationHelp#1.children3 1.ViolationHelp#2.children3 1.ViolationHelp#3.children3 1.ViolationHelp#4.children3 1.ViolationHelp#5.children3  1.ViolationHelp#99.children3 ///
					1.male 1.male#1.Child 1.hugo  1.hugo#1.Child 1.male#1.hugo 1.rich 1.Child#1.rich ///
					2.inc_Q 3.inc_Q 4.inc_Q 1.Child#2.inc_Q 1.Child#3.inc_Q 1.Child#4.inc_Q ///
					1.Rain 1.Hot) ///)
					order(1.Child ///
					1.children ///
					1.children2 2.children2 3.children2 4.children2 99.children2 ///
					1.children3 2.children3 3.children3 4.children3 5.children3 ///
					1.ViolationHelp ///
					1.ViolationHelp#1.Child ///
					1.ViolationHelp#1.children ///
					1.ViolationHelp#1.children2 1.ViolationHelp#2.children2 1.ViolationHelp#3.children2 1.ViolationHelp#4.children2 1.ViolationHelp#99.children2 ///
					1.ViolationHelp#1.children3 1.ViolationHelp#2.children3 1.ViolationHelp#3.children3 1.ViolationHelp#4.children3 1.ViolationHelp#5.children3 1.ViolationHelp#99.children3 ///
					1.male 1.male#1.Child 1.hugo  1.hugo#1.Child 1.male#1.hugo 1.rich 1.Child#1.rich ///
					2.inc_Q 3.inc_Q 4.inc_Q 1.Child#2.inc_Q 1.Child#3.inc_Q 1.Child#4.inc_Q ///
					1.Rain 1.Hot) ///
					varlabels(1.Child "Child" ///
					1.children "1 Child" 2.children "2 Children" 3.children "3+ children" ///
					1.children2 "1 Boy" 2.children2 "1 Girl" 3.children2 "2 children" 4.children2 "3+ children" ///
					1.children3 "1 Child Age $\leq$ 5" 2.children3 "5 $<$ 1 Child Age $\leq$ 8" 3.children3 "1 Child Age $>$ 8" 4.children3 "2 Children" 5.children3 "3+ Children" 99.children3 "Children missing" ///
					1.ViolationHelp "VH" ///
					1.ViolationHelp#1.Child "VH $\times$ Child" ///
					1.ViolationHelp#1.children "VH $\times$ 1 Child" 1.ViolationHelp#2.children "VH $\times$ 2 Children" 1.ViolationHelp#3.children "VH $\times$ 3+ Children" ///
					1.ViolationHelp#1.children2 "VH $\times$ 1 Boy" 1.ViolationHelp#2.children2 "VH $\times$ 1 Girl" 1.ViolationHelp#3.children2 "VH $\times$ 2 Children" ///
						1.ViolationHelp#4.children2 "VH $\times$ 3+ Children" 1.ViolationHelp#99.children2 "VH $\times$ Missing" ///
					1.ViolationHelp#1.children3 "VH $\times$ 1 Child Age $\leq$ 5" 1.ViolationHelp#2.children3 "VH $\times$ 5 $<$ 1 Child Age $\leq$ 8" ///
						1.ViolationHelp#3.children3 "VH $\times$ 1 Child Age $>$ 9" 1.ViolationHelp#4.children3 "VH $\times$ 2 Children" 1.ViolationHelp#5.children3 "VH $\times$ 3+ Children" 1.ViolationHelp#99.children3 "VH $\times$ Missing" ///
					1.male "Male Target" 1.male#1.Child "Male Target $\times$ Child" 1.hugo "Male Actor" 1.hugo#1.Child "Male Actor $\times$ Child" 1.male#1.hugo "Male Actor $\times$ Male target" ///
					1.rich "Rich area" 1.Child#1.rich "Rich area $\times$ Child" ///
					1.Rain "Rain" 1.Hot "Hot" _cons "Constant" 2.inc_Q "Medium Low Income" 3.inc_Q "Medium High Income" 4.inc_Q "High Income" ///
					1.Child#2.inc_Q "Medium Low Income $\times$ Child" 1.Child#3.inc_Q "Medium High Income $\times$ Child" 1.Child#4.inc_Q "High Income $\times$ Child") ///
					mgroups("Base" "Child" "Target" "Income", pattern(1  1  0  0  1  0  1  0) ${multicol}) ///
					mtitles("(1)" "(2)" "(3)" "(4)" "(5)" "(6)" "(7)" "(8)") ///
					gaps collabels(none) nonumbers starlevels(* 0.10 ** 0.05 *** 0.01) ///
					postfoot("\bottomrule"  "\end{tabular}" "}") stats( N  N_clust  r2  F  df_r , labels ("Observations" "Clusters" "\$R^2\$" "\$F\$" "df")  ///
					fmt(%9.0g %9.0g  %9.2f %9.2f %9.0g))
										
		eststo clear