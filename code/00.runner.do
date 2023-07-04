*replication-norms: RUNNER
*JUNE 2023

*SETUP
	*PROJECT
		*global PATH "XXX"
		cd "$PATH" 
		
	*PATHS	
		global scripts "$PATH\code"
		global data "$PATH\data"
		global results "$PATH\results"

*TABLES
	run "${scripts}\Table1.do"
	run "${scripts}\Table2.do"
	rscript using "${scripts}\Table2.R"
	
*FIGURES
	run "${scripts}\Figure1a.do"
	run "${scripts}\Figure1b.do"
	
*ANNEX TABLES
	run "${scripts}\TableA2.do"
	run "${scripts}\TableA3.do"
	run "${scripts}\TableA4.do"
	run "${scripts}\TableA5.do"
	run "${scripts}\TableA6.do"
	run "${scripts}\TableA7.do"
	run "${scripts}\TableA8.do"
	run "${scripts}\TableA9.do"
	run "${scripts}\TableA10.do"