*replication-norms: TABLE A7
*MAY 2023

clear all
set more off
	
*LOAD DATA
	use "${data}/master.dta", clear
	
*AUXILIARIES	
	global prespecified_controls i.hugo i.male i.rich i.Rain i.Hot
	global main_controls i.hugo i.male i.Morning i.witness i.rich i.Rain i.Hot
	
****** ROBUSTNESS 1: GUARDIANS EXCLUDED
*ESTIMATE REGRESSIONS
	* Punishment
	eststo tableA7_a1_col1: ///
		reg Punishment i.Child##i.ViolationHelp if OwnChild != 0, vce(cluster School)
		
	eststo tableA7_a1_col2: ///
		reg Punishment i.Child##i.ViolationHelp $prespecified_controls if OwnChild != 0, vce(cluster School)
		
	eststo tableA7_a1_col3: ///
		reg Punishment i.Child##i.ViolationHelp $main_controls if OwnChild != 0, vce(cluster School)
		
	eststo tableA7_a1_col4: ///
		reg Punishment i.Child##i.ViolationHelp if OwnChild == 1, vce(cluster School)
		
	eststo tableA7_a1_col5: ///
		reg Punishment i.Child##i.ViolationHelp $prespecified_controls if OwnChild == 1, vce(cluster School)
		
	eststo tableA7_a1_col6: ///
		reg Punishment i.Child##i.ViolationHelp $main_controls if OwnChild == 1, vce(cluster School)
	
	* Helping
	eststo tableA7_a2_col1: ///
		reg Helping i.Child##i.ViolationHelp if Violation==0 & OwnChild != 0, vce(cluster School)
		
	eststo tableA7_a2_col2: ///
		reg Helping i.Child##i.ViolationHelp $prespecified_controls if Violation==0 & OwnChild != 0, vce(cluster School)
		
	eststo tableA7_a2_col3: ///
		reg Helping i.Child##i.ViolationHelp $main_controls if Violation==0 & OwnChild != 0, vce(cluster School)
		
	eststo tableA7_a2_col4: ///
		reg Helping i.Child##i.ViolationHelp if Violation==0 & OwnChild == 1, vce(cluster School)
		
	eststo tableA7_a2_col5: ///
		reg Helping i.Child##i.ViolationHelp $prespecified_controls if Violation==0 & OwnChild == 1, vce(cluster School)
		
	eststo tableA7_a2_col6: ///
		reg Helping i.Child##i.ViolationHelp $main_controls if Violation==0 & OwnChild == 1, vce(cluster School)	
			
*EXPORT RESULTS
	esttab tableA7_a1_col1 tableA7_a1_col2 tableA7_a1_col3 tableA7_a1_col4 tableA7_a1_col5 tableA7_a1_col6 ///
		using "${results}/TableA7_a1.tex", replace booktabs ///
			cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.Child#1.ViolationHelp "Child $\times$ VH" 1.male "Male Target" 1.hugo "Male Actor" 1.Morning "Morning" 1.witness "Witness" 1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///	
			collabels(none) nobaselevels b(%3.2f) se(%3.2f) star(* 0.10 ** 0.05 *** 0.01) ///
			scalars("N Observations" "N_clust Clusters" "r2 \(R^2\)" "F" "df_r df") sfmt(%7.0fc %2.0fc %3.2fc %3.2fc %2.0fc) ///
			postfoot("\bottomrule\end{tabular}\linebreak Notes: Outcome is Punishment, guardians excluded. (1)-(3) excluding OwnChild = 0, (4)-(6) using only OwnChild = 1. * p < 0.10 ** p < 0.05 *** p < 0.01.}") 
			
	esttab tableA7_a2_col1 tableA7_a2_col2 tableA7_a2_col3 tableA7_a2_col4 tableA7_a2_col5 tableA7_a2_col6 ///
		using "${results}/TableA7_a2.tex", replace booktabs ///
			cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.Child#1.ViolationHelp "Child $\times$ VH" 1.male "Male Target" 1.hugo "Male Actor" 1.Morning "Morning" 1.witness "Witness" 1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///	
			collabels(none) nobaselevels b(%3.2f) se(%3.2f) star(* 0.10 ** 0.05 *** 0.01) ///
			scalars("N Observations" "N_clust Clusters" "r2 \(R^2\)" "F" "df_r df") sfmt(%7.0fc %2.0fc %3.2fc %3.2fc %2.0fc) ///
			postfoot("\bottomrule\end{tabular}\linebreak Notes: Outcome is Helping, guardians excluded. (1)-(3) excluding OwnChild = 0, (4)-(6) using only OwnChild = 1. * p < 0.10 ** p < 0.05 *** p < 0.01.}") 
			
			
****** ROBUSTNESS 2: EXCLUDE PARENTS ACCOMPANYING 2 OR MORE CHILDREN
*ESTIMATE REGRESSIONS
	* Punishment
	eststo tableA7_b_col1: ///
		reg Punishment i.Child##i.ViolationHelp if children < 2, vce(cluster School)
		
	eststo tableA7_b_col2: ///
		reg Punishment i.Child##i.ViolationHelp $prespecified_controls if children < 2, vce(cluster School)
		
	eststo tableA7_b_col3: ///
		reg Punishment i.Child##i.ViolationHelp $main_controls if children < 2, vce(cluster School)
	
	* Helping
	eststo tableA7_b_col4: ///
		reg Helping i.Child##i.ViolationHelp if Violation==0 & children < 2, vce(cluster School)
		
	eststo tableA7_b_col5: ///
		reg Helping i.Child##i.ViolationHelp $prespecified_controls if Violation==0 & children < 2, vce(cluster School)
		
	eststo tableA7_b_col6: ///
		reg Helping i.Child##i.ViolationHelp $main_controls if Violation==0 & children < 2, vce(cluster School)
			
*EXPORT RESULTS
	esttab tableA7_b_col1 tableA7_b_col2 tableA7_b_col3 tableA7_b_col4 tableA7_b_col5 tableA7_b_col6 ///
		using "${results}/TableA7_b.tex", replace booktabs ///
			cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.Child#1.ViolationHelp "Child $\times$ VH" 1.male "Male Target" 1.hugo "Male Actor" 1.Morning "Morning" 1.witness "Witness" 1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///	
			collabels(none) nobaselevels b(%3.2f) se(%3.2f) star(* 0.10 ** 0.05 *** 0.01) ///
			scalars("N Observations" "N_clust Clusters" "r2 \(R^2\)" "F" "df_r df") sfmt(%7.0fc %2.0fc %3.2fc %3.2fc %2.0fc) ///
			postfoot("\bottomrule\end{tabular}\linebreak Notes: Excluding parents with 2 or more children. * p < 0.10 ** p < 0.05 *** p < 0.01.}") 
			

****** ROBUSTNESS 3: ONLY NO WITNESS
*ESTIMATE REGRESSIONS
	* Punishment
	eststo tableA7_c_col1: ///
		reg Punishment i.Child##i.ViolationHelp if witness == 0, vce(cluster School)
		
	eststo tableA7_c_col2: ///
		reg Punishment i.Child##i.ViolationHelp $prespecified_controls if witness == 0, vce(cluster School)
		
	eststo tableA7_c_col3: ///
		reg Punishment i.Child##i.ViolationHelp $main_controls if witness == 0, vce(cluster School)
	
	* Helping
	eststo tableA7_c_col4: ///
		reg Helping i.Child##i.ViolationHelp if Violation==0 & witness == 0, vce(cluster School)
		
	eststo tableA7_c_col5: ///
		reg Helping i.Child##i.ViolationHelp $prespecified_controls if Violation==0 & witness == 0, vce(cluster School)
		
	eststo tableA7_c_col6: ///
		reg Helping i.Child##i.ViolationHelp $main_controls if Violation==0 & witness == 0, vce(cluster School)
			
*EXPORT RESULTS
	esttab tableA7_c_col1 tableA7_c_col2 tableA7_c_col3 tableA7_c_col4 tableA7_c_col5 tableA7_c_col6 ///
		using "${results}/TableA7_c.tex", replace booktabs ///
			cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.Child#1.ViolationHelp "Child $\times$ VH" 1.male "Male Target" 1.hugo "Male Actor" 1.Morning "Morning" 1.witness "Witness" 1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///	
			collabels(none) nobaselevels b(%3.2f) se(%3.2f) star(* 0.10 ** 0.05 *** 0.01) ///
			scalars("N Observations" "N_clust Clusters" "r2 \(R^2\)" "F" "df_r df") sfmt(%7.0fc %2.0fc %3.2fc %3.2fc %2.0fc) ///
			postfoot("\bottomrule\end{tabular}\linebreak Notes: Only cases where no witness was recorded. * p < 0.10 ** p < 0.05 *** p < 0.01.}") 
			
****** ROBUSTNESS 4: Consider Help only if parent help
*ESTIMATE REGRESSIONS
	
	* Helping
	eststo tableA7_d_col1: ///
		reg HelpingParent i.Child##i.ViolationHelp if Violation==0, vce(cluster School)
		
	eststo tableA7_d_col2: ///
		reg HelpingParent i.Child##i.ViolationHelp $prespecified_controls if Violation==0, vce(cluster School)
		
	eststo tableA7_d_col3: ///
		reg HelpingParent i.Child##i.ViolationHelp $main_controls if Violation==0, vce(cluster School)
			
*EXPORT RESULTS
	esttab tableA7_d_col1 tableA7_d_col2 tableA7_d_col3 ///
		using "${results}/TableA7_d.tex", replace booktabs ///
			cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.Child#1.ViolationHelp "Child $\times$ VH" 1.male "Male Target" 1.hugo "Male Actor" 1.Morning "Morning" 1.witness "Witness" 1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///	
			collabels(none) nobaselevels b(%3.2f) se(%3.2f) star(* 0.10 ** 0.05 *** 0.01) ///
			scalars("N Observations" "N_clust Clusters" "r2 \(R^2\)" "F" "df_r df") sfmt(%7.0fc %2.0fc %3.2fc %3.2fc %2.0fc) ///
			postfoot("\bottomrule\end{tabular}\linebreak Notes: Code children helping as not helping, rather than helping. * p < 0.10 ** p < 0.05 *** p < 0.01.}") 
			
****** REPRODUCTION OF TABLE IN PAPER
*EXPORT RESULTS
	esttab tableA7_a1_col3 tableA7_b_col3 tableA7_c_col3 tableA7_a2_col3 tableA7_b_col6 tableA7_c_col6 tableA7_d_col3 ///
		using "${results}/TableA7.tex", replace booktabs ///
			cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.Child#1.ViolationHelp "Child $\times$ VH" 1.male "Male Target" 1.hugo "Male Actor" 1.Morning "Morning" 1.witness "Witness" 1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///	
			collabels(none) nobaselevels b(%3.2f) se(%3.2f) star(* 0.10 ** 0.05 *** 0.01) ///
			scalars("N Observations" "N_clust Clusters" "r2 \(R^2\)" "F" "df_r df") sfmt(%7.0fc %2.0fc %3.2fc %3.2fc %2.0fc) ///
			postfoot("\bottomrule\end{tabular} Notes: * p < 0.10 ** p < 0.05 *** p < 0.01.}") 
			
****** ROBUSTNESS 5: COMBINING ROBUSTNESS 1-3
*ESTIMATE REGRESSIONS
	* Punishment
	eststo tableA7_e_col1: ///
		reg Punishment i.Child##i.ViolationHelp if OwnChild != 0 & children < 2 & witness == 0, vce(cluster School)
		
	eststo tableA7_e_col2: ///
		reg Punishment i.Child##i.ViolationHelp $prespecified_controls if OwnChild != 0 & children < 2 & witness == 0, vce(cluster School)
		
	eststo tableA7_e_col3: ///
		reg Punishment i.Child##i.ViolationHelp $main_controls if OwnChild != 0 & children < 2 & witness == 0, vce(cluster School)
	
	* Helping
	eststo tableA7_e_col4: ///
		reg Helping i.Child##i.ViolationHelp if Violation==0 & OwnChild != 0 & children < 2 & witness == 0, vce(cluster School)
		
	eststo tableA7_e_col5: ///
		reg Helping i.Child##i.ViolationHelp $prespecified_controls if Violation==0 & OwnChild != 0 & children < 2 & witness == 0, vce(cluster School)
		
	eststo tableA7_e_col6: ///
		reg Helping i.Child##i.ViolationHelp $main_controls if Violation==0 & OwnChild != 0 & children < 2 & witness == 0, vce(cluster School)
			
*EXPORT RESULTS
	esttab tableA7_e_col1 tableA7_e_col2 tableA7_e_col3 tableA7_e_col4 tableA7_e_col5 tableA7_e_col6 ///
		using "${results}/TableA7_e.tex", replace booktabs ///
			cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.Child#1.ViolationHelp "Child $\times$ VH" 1.male "Male Target" 1.hugo "Male Actor" 1.Morning "Morning" 1.witness "Witness" 1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///	
			collabels(none) nobaselevels b(%3.2f) se(%3.2f) star(* 0.10 ** 0.05 *** 0.01) ///
			scalars("N Observations" "N_clust Clusters" "r2 \(R^2\)" "F" "df_r df") sfmt(%7.0fc %2.0fc %3.2fc %3.2fc %2.0fc) ///
			postfoot("\bottomrule\end{tabular}\linebreak Notes: * p < 0.10 ** p < 0.05 *** p < 0.01.}") 