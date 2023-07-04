*replication-norms: TABLE A6
*JUNE 2023

clear all
set more off

*LOAD DATA
	use "$data\master.dta", clear
	
*AUXILIARIES
	global prespecified_controls i.hugo i.male i.rich i.Rain i.Hot
	global paper_controls i.hugo i.male i.Morning i.witness i.rich i.Rain i.Hot
	global extended_controls i.Morning i.witness i.day c.povrate
	global multicol "prefix(\multicolumn{@span}{c}{\textbf{) suffix(}}) span erepeat(\cmidrule(lr){@span})"

*Paper Controls
	*ESTIMATES
		logit Helping i.Child##i.ViolationHelp $paper_controls if Violation==0, cluster(School)
			scalar pseudo_r2 = e(r2_p)
			scalar clusters = e(N_clust)
			scalar wald_chi2 = e(chi2)
			margins r.Child, dydx(ViolationHelp) post
			scalar VHC_VHA= e(chi2)[1,2]

		logit Helping i.Child##i.ViolationHelp $paper_controls if Violation==0, cluster(School)
			eststo margins1: margins, dydx(*) at(Child=0 ViolationHelp=0) post
			estadd scalar r2_p = pseudo_r2
			estadd scalar N_clusters = clusters
			estadd scalar chi2 = wald_chi2
			estadd scalar VHC_VHA_chi2 = VHC_VHA
			
		logit Helping i.Child##i.ViolationHelp $paper_controls if Violation==0, cluster(School)
			eststo margins2: margins, dydx(*) at(Child=1 ViolationHelp=0) post

		logit Punishment i.Child##i.ViolationHelp $paper_controls if Help==0, cluster(School)
			scalar pseudo_r2 = e(r2_p)
			scalar clusters = e(N_clust)
			scalar wald_chi2 = e(chi2)
			margins r.Child, dydx(ViolationHelp) post
			scalar VHC_VHA= e(chi2)[1,2]

		logit Punishment i.Child##i.ViolationHelp $paper_controls if Help==0, cluster(School)
			eststo margins3: margins, dydx(*) at(Child=0 ViolationHelp=0) post
			estadd scalar r2_p = pseudo_r2
			estadd scalar N_clusters = clusters
			estadd scalar chi2 = wald_chi2
			estadd scalar VHC_VHA_chi2 = VHC_VHA
			
		logit Punishment i.Child##i.ViolationHelp $paper_controls if Help==0, cluster(School)
			eststo margins4: margins, dydx(*) at(Child=1 ViolationHelp=0) post		

	*EXPORT RESULTS		
		esttab margins3 margins4 margins1 margins2 using "$results\TableA6.tex", ///
			booktabs cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
			label starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) ///
			stats(VHC_VHA_chi2 N N_clusters r2_p chi2, ///
				labels("VH\$_C\$ vs. VH\$_A\$" "N Observations" "N_clust Clusters" "r2_p (Pseudo) \$R^2\$" "chi2 Wald \$\chi^2\$") ///
				fmt(%9.2f %9.0g %9.0g %9.3f %9.2f)) ///
			order(1.Child 1.ViolationHelp) alignment(rrrr) nobaselevels ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.male "Male Target" 1.hugo "Male Actor" ///
				1.Morning "Morning" 1.witness "Witness" 1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///
			mgroups("Punishment" "Child", pattern(1 0 1 0 ) ${multicol}) ///
			mtitles("\shortstack{Alone}" ///
					"\shortstack{Child}" ///
					"\shortstack{Alone}" ///
					"\shortstack{Child}") ///
			replace		
		eststo clear

*Prespecified Controls	
	*ESTIMATES
		logit Helping i.Child##i.ViolationHelp $prespecified_controls if Violation==0, cluster(School)
			scalar pseudo_r2 = e(r2_p)
			scalar clusters = e(N_clust)
			scalar wald_chi2 = e(chi2)
			margins r.Child, dydx(ViolationHelp) post
			scalar VHC_VHA= e(chi2)[1,2]

		logit Helping i.Child##i.ViolationHelp $prespecified_controlspre_controls if Violation==0, cluster(School)
			eststo margins1: margins, dydx(*) at(Child=0 ViolationHelp=0) post
			estadd scalar r2_p = pseudo_r2
			estadd scalar N_clusters = clusters
			estadd scalar chi2 = wald_chi2
			estadd scalar VHC_VHA_chi2 = VHC_VHA
			
		logit Helping i.Child##i.ViolationHelp $prespecified_controls if Violation==0, cluster(School)
			eststo margins2: margins, dydx(*) at(Child=1 ViolationHelp=0) post

		logit Punishment i.Child##i.ViolationHelp $prespecified_controls if Help==0, cluster(School)
			scalar pseudo_r2 = e(r2_p)
			scalar clusters = e(N_clust)
			scalar wald_chi2 = e(chi2)
			margins r.Child, dydx(ViolationHelp) post
			scalar VHC_VHA= e(chi2)[1,2]

		logit Punishment i.Child##i.ViolationHelp $prespecified_controls if Help==0, cluster(School)
			eststo margins3: margins, dydx(*) at(Child=0 ViolationHelp=0) post
			estadd scalar r2_p = pseudo_r2
			estadd scalar N_clusters = clusters
			estadd scalar chi2 = wald_chi2
			estadd scalar VHC_VHA_chi2 = VHC_VHA
			
		logit Punishment i.Child##i.ViolationHelp $prespecified_controls if Help==0, cluster(School)
			eststo margins4: margins, dydx(*) at(Child=1 ViolationHelp=0) post
		
	*EXPORT RESULTS
		esttab margins3 margins4 margins1 margins2 using "$results\TableA6_prespecified.tex", ///
			booktabs cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
			label starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) ///
			stats(VHC_VHA_chi2 N N_clusters r2_p chi2, ///
				labels("VH\$_C\$ vs. VH\$_A\$" "N Observations" "N_clust Clusters" "r2_p (Pseudo) \$R^2\$" "chi2 Wald \$\chi^2\$") ///
				fmt(%9.2f %9.0g %9.0g %9.3f %9.2f)) ///
			keep(1.Child 1.ViolationHelp 1.male 1.hugo 1.rich 1.Rain 1.Hot) ///
			order(1.Child 1.ViolationHelp) alignment(rrrr) nobaselevels ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.male "Male Target" 1.hugo "Male Actor" ///
				1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///
			mgroups("Punishment" "Child", pattern(1 0 1 0 ) ${multicol}) ///
			mtitles("\shortstack{Alone}" ///
					"\shortstack{Child}" ///
					"\shortstack{Alone}" ///
					"\shortstack{Child}") ///
			replace	
		eststo clear

*Extended Controls
	*ESTIMATES
		logit Helping i.Child##i.ViolationHelp $prespecified_controls $extended_controls if Violation==0, cluster(School)
			scalar pseudo_r2 = e(r2_p)
			scalar clusters = e(N_clust)
			scalar wald_chi2 = e(chi2)
			margins r.Child, dydx(ViolationHelp) post
			scalar VHC_VHA= e(chi2)[1,2]

		logit Helping i.Child##i.ViolationHelp $prespecified_controls $extended_controls if Violation==0, cluster(School)
			eststo margins1: margins, dydx(*) at(Child=0 ViolationHelp=0) post
			estadd scalar r2_p = pseudo_r2
			estadd scalar N_clusters = clusters
			estadd scalar chi2 = wald_chi2
			estadd scalar VHC_VHA_chi2 = VHC_VHA

		logit Helping i.Child##i.ViolationHelp $prespecified_controls $extended_controls if Violation==0, cluster(School)
			eststo margins2: margins, dydx(*) at(Child=1 ViolationHelp=0) post

		logit Punishment i.Child##i.ViolationHelp $prespecified_controls $extended_controls if Help==0, cluster(School)
			scalar pseudo_r2 = e(r2_p)
			scalar clusters = e(N_clust)
			scalar wald_chi2 = e(chi2)
			margins r.Child, dydx(ViolationHelp) post
			scalar VHC_VHA= e(chi2)[1,2]

		logit Punishment i.Child##i.ViolationHelp $prespecified_controls $extended_controls if Help==0, cluster(School)
			eststo margins3: margins, dydx(*) at(Child=0 ViolationHelp=0) post
			estadd scalar r2_p = pseudo_r2
			estadd scalar N_clusters = clusters
			estadd scalar chi2 = wald_chi2
			estadd scalar VHC_VHA_chi2 = VHC_VHA
			
		logit Punishment i.Child##i.ViolationHelp $prespecified_controls $extended_controls if Help==0, cluster(School)
			eststo margins4: margins, dydx(*) at(Child=1 ViolationHelp=0) post
			
	*EXPORT RESULTS
		esttab margins3 margins4 margins1 margins2 using "$results\TableA6_extended.tex", ///
			booktabs cells(b(star pattern(1 1 1) fmt(%10.2fc)) se(par pattern(1 1 1))) ///
			label starlevels(* 0.10 ** 0.05 *** 0.01) collabels(none) ///
			stats(VHC_VHA_chi2 N N_clusters r2_p chi2, ///
				labels("VH\$_C\$ vs. VH\$_A\$" "N Observations" "N_clust Clusters" "r2_p (Pseudo) \$R^2\$" "chi2 Wald \$\chi^2\$") ///
				fmt(%9.2f %9.0g %9.0g %9.3f %9.2f)) ///
			keep(1.Child 1.ViolationHelp 1.male 1.hugo 1.Morning 1.witness 1.rich 1.Rain 1.Hot) ///
			order(1.Child 1.ViolationHelp) alignment(rrrr) nobaselevels ///
			varlabels(1.Child "Child" 1.ViolationHelp "VH" 1.male "Male Target" 1.hugo "Male Actor" ///
				1.Morning "Morning" 1.witness "Witness" 1.rich "Rich area" 1.Rain "Rain" 1.Hot "Hot" _cons "Constant") ///
			mgroups("Punishment" "Child", pattern(1 0 1 0 ) ${multicol}) ///
			mtitles("\shortstack{Alone}" ///
					"\shortstack{Child}" ///
					"\shortstack{Alone}" ///
					"\shortstack{Child}") ///
			replace		
		eststo clear