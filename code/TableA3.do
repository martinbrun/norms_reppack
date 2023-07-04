*replication-norms: TABLE A3
*MAY 2023

clear all
set more off

*LOAD DATA
	use "$data\master.dta", clear
	
*COMPUTE SUMMARY STATS
	eststo tableA3_col1: estpost ///
		sum OwnChild boy girl numkids childage3 childage4 ///
			childage5 childage6 childage7 childage8 childage9 ///
			childage10 childage11 if response2 == 1
			
	eststo tableA3_col2: estpost ///
		sum OwnChild boy girl numkids childage3 childage4 ///
			childage5 childage6 childage7 childage8 childage9 ///
			childage10 childage11 if Child == 0 & response2 == 1
			
	eststo tableA3_col3: estpost ///
		sum OwnChild boy girl numkids childage3 childage4 ///
			childage5 childage6 childage7 childage8 childage9 ///
			childage10 childage11 if Child == 1 & response2 == 1
			
	eststo tableA3_col4: estpost ///
		ttest OwnChild boy girl numkids childage3 childage4 ///
			childage5 childage6 childage7 childage8 childage9 ///
			childage10 childage11 if response2 == 1, by(Child)
			
*EXPORT RESULTS
	esttab tableA3_col1 tableA3_col2 tableA3_col3 tableA3_col4 ///
		using "${results}/TableA3.tex", replace booktabs ///
			cells("mean(pattern(1 1 1 0) fmt(%3.2fc)) b(star pattern(0 0 0 1))" "sd(par pattern(1 1 1 0) fmt(%3.2fc)) se(par pattern(0 0 0 1) fmt(%3.2fc))") ///
			varlabels(OwnChild "Own Child" boy "Son" girl "Daughter" numkids "No. of Children" childage3 "Child Age = 3" childage4 "Child Age = 4" childage5 "Child Age = 5" childage6 "Child Age = 6" childage7 "Child Age = 7" childage8 "Child Age = 8" childage9 "Child Age = 9" childage10 "Child Age = 10" childage11 "Child Age = 11") ///
			mlabels(All Alone Child Diff.) collabels(none) ///
			star(* 0.10 ** 0.05 *** 0.01) ///
			postfoot("\bottomrule\end{tabular}\linebreak Notes: For gender and age, totals are not equal to 1 because some parents reported having more than one child at the school. * p < 0.10 ** p < 0.05 *** p < 0.01.}") 
			
			
			
			