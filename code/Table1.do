*replication-norms: TABLE 1
*MAY 2023

clear all
set more off

*LOAD DATA
	use "$data\master.dta", clear
	
*DATA PROCESSING
	label variable male "Male Target"
	label variable witness "Witness"
	label variable hugo "Male Actor"
	label variable rich "Rich IRIS"
	label variable Morning "Morning"
	label variable Rain "Rain"
	label variable Hot "Hot"
	label variable response2 "Survey Response"
	
*AUXILIARIES
	local vars male witness hugo rich Morning Rain Hot response2 
	gen aux_obs=1 
	label variable aux_obs "Observations"
	
*PROGRAM
	program myttest, eclass
		syntax varname(min=1 max=1) [if], by(varname) [ * ]
		marksample sample // identifies sample
		markout `sample' `by'
		tempname tot_mean tot_sd zero_mean zero_sd one_mean one_sd diff_coef diff_se diff_p n_0 n_1 n_tot
		foreach var of local varlist {
			qui sum `var' if `sample'
			mat `tot_mean' = nullmat(`mu_tot'), round(r(mean),0.01)
			mat `tot_sd' = nullmat(`sd_tot'), round(r(sd),0.01)
			qui tabstat `var' if `sample', by(`by') s(mean sd) save
			mat `zero_mean' = nullmat(`mu_0'), round(el(r(Stat1),1,1),0.01)	
			mat `zero_sd' = nullmat(`mu_0'), round(el(r(Stat1),2,1),0.01)		
			mat `one_mean' = nullmat(`mu_1'), round(el(r(Stat2),1,1),0.01)	
			mat `one_sd' = nullmat(`mu_1'), round(el(r(Stat2),2,1),0.01)		
			qui ttest `var', by(`by')
			mat `diff_coef' = nullmat(`d_coef'), round(r(mu_1)-r(mu_2),0.01)
			mat `diff_se' = nullmat(`d_se'), round(r(se),0.01)
			mat `diff_p'  = nullmat(`d_p' ), r(p)
			mat `n_0'  = nullmat(`d_p' ), r(N_1)
			mat `n_1'  = nullmat(`d_p' ), r(N_2)
			mat `n_tot'  = nullmat(`d_p' ), r(N_1)+r(N_2)
		}
		foreach mat in tot_mean tot_sd zero_mean zero_sd one_mean one_sd diff_coef diff_se diff_p n_0 n_1 n_tot {
			mat coln ``mat'' = `varlist'
		}
		tempname b V
		mat `b' = `tot_mean'*0
		mat `V' = `b''*`b'
		eret post `b' `V'
		eret local cmd "myttests"
		foreach mat in tot_mean tot_sd zero_mean zero_sd one_mean one_sd diff_coef diff_se diff_p n_0 n_1 n_tot {
			eret mat `mat' = ``mat''
		}
	end	
	
*ESTIMATES
	*VARIABLES
		local i=1
		foreach var of local vars {
			eststo var`i': ///
				myttest `var', by(Child)	
			local ++i
		}	
		
	*OBSERVATIONS
		eststo obs: ///
			myttest aux_obs, by(Child)
		
*EXPORT RESULTS
	esttab var1 ///
		using "${results}\Table1.tex" ///
		, prehead("\begin{tabular}{l*{4}{c}} \hline &(1)&(2)&(3)&(4) \\ &ALL &ALONE &CHILD & DIFF. \\ \hline") ///
		label collabels(none) nomtitles nonumbers noobs eqlabels(none) ///
		fragment nolines noeqlines ///
		star(* 0.10 ** 0.05 *** 0.01) ///
		cells("tot_mean(fmt(a2)) zero_mean(fmt(a2)) one_mean(fmt(a2)) diff_coef(star pvalue(diff_p) fmt(2))" "tot_sd(par fmt(a2)) zero_sd(par fmt(a2)) one_sd(par fmt(a2)) diff_se(par fmt(2))") ///
		replace
	
	forvalues i=2/8 {
		esttab var`i' ///
			using "${results}\Table1.tex" ///
			, label collabels(none) nomtitles nonumbers noobs eqlabels(none) ///
			fragment nolines noeqlines ///
			star(* 0.10 ** 0.05 *** 0.01) ///
			cells("tot_mean(fmt(a2)) zero_mean(fmt(a2)) one_mean(fmt(a2)) diff_coef(star pvalue(diff_p) fmt(2))" "tot_sd(par fmt(a2)) zero_sd(par fmt(a2)) one_sd(par fmt(a2)) diff_se(par fmt(2))") ///
			append					
	}
	
	esttab obs ///
		using "${results}\Table1.tex" ///
		, label collabels(none) nomtitles nonumbers noobs eqlabels(none) ///
		fragment nolines noeqlines ///
		star(* 0.10 ** 0.05 *** 0.01) ///
		cells("n_tot(fmt(a2)) n_0(fmt(a2)) n_1(fmt(a2)) n_tot(fmt(a2))") ///
		prehead("\hline") ///
		postfoot("\hline \end{tabular} \\ \textit{Notes:} Columns (1)-(3) contain standard deviations in parentheses. Column (4) contains standard errors in parentheses. a: Parents who could not be reached are excluded. Hence, the statistics are computed based on 503, 251, 252 observations in All, Alone, and Child, respectively. All tests are two-sided t-tests on the equality of means. * p < 0.10 ** p < 0.05 *** p < 0.01") ///
		append					
		