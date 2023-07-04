*replication-norms: TABLE 2
*MAY 2023

clear all
set more off
	
*LOAD DATA
	use "$data\master.dta", clear
	
*AUXILIARIES	
	global pre_controls i.hugo i.male i.rich i.Rain i.Hot
	global main_controls i.hugo i.male i.Morning i.witness i.rich i.Rain i.Hot
	global ext_controls i.Morning i.witness i.day i.school c.povrate

*ESTIMATES
	eststo table1_col1: ///
		qui reg Punishment i.ViolationHelp##i.Child, vce(cluster School)	

	eststo table1_col2: ///	
		qui reg Punishment i.ViolationHelp##i.Child $main_controls , vce(cluster School)

	eststo table1_col3: ///	
		qui reg Helping i.ViolationHelp##i.Child if inlist(Violation,0), vce(cluster School)

	eststo table1_col4: ///	
		qui reg Helping i.ViolationHelp##i.Child $main_controls if inlist(Violation,0), vce(cluster School)
			
*EXPORT RESULTS		
	esttab table1_col1 table1_col2 table1_col3 table1_col4 ///
	using "${results}\Table2.tex", ///
			rename(1.Child "Child" 1.ViolationHelp "VH" 1.ViolationHelp#1.Child "Child x VH" 1.male "Male Target" 1.hugo "Male Actor" 1.Morning "Morning" 1.witness "Witness" 1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///	
			keep("Child" "VH" "Child x VH" "Male Target" "Male Actor" "Morning" "Witness" "Rich area" "Rain" "Hot" "Constant") ///
			order("Child" "VH" "Child x VH" "Male Target" "Male Actor" "Morning" "Witness" "Rich area" "Rain" "Hot" "Constant") ///
			b(%3.2f) se(%3.2f) star(* 0.10 ** 0.05 *** 0.01) ///
			collabels(none) nomtitles nonumber nonote noobs eqlabels(none) ///
			scalars("N Observations" "N_clust Clusters" "r2 R2" "F" "df_r df") sfmt(%7.0fc %2.0fc %3.2fc %3.2fc %2.0fc) ///
			prehead("\begin{tabular}{m{4cm}*{4}{>{\centering\arraybackslash}m{1.75cm}}} \hline &\multicolumn{2}{c}{Punishment}&\multicolumn{2}{c}{Helping} \\ \cline{2-3} \cline{4-5} &(1)&(2)&(3)&(4) \\") ///
			postfoot("\hline \\ \end{tabular} \\ \footnotesize \textit{Notes:} The table contains results from pooled Ordinary Least Squared regressions. The dependent variable is a binary variable for punishment (columns 1 and 2) or helping (columns 3 and 4). Standard errors in parentheses are clustered at the school level (30 clusters). One observation is dropped due to missing data on the target's gender. * p < 0.10 ** p < 0.05 *** p < 0.01.") ///
			replace