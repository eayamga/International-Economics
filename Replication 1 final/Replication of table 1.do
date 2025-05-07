/// Replication of Table 3
/// Here I import the completed data to carry out the analysis

/// importing the data
use "/Users/ayamga/Library/CloudStorage/OneDrive-TexasTechUniversity/International Trade/Replication 1/2017 data/data/Complete_data.dta"

/// Scaling exports, imports, RnD and gross output to their actual values by multiplying xports aand imports by 1000 and gross output and RnD by 1000000
replace exports = exports*1000
replace imports = imports*1000
replace gross_output= gross_output*1000000
replace rnd = rnd*1000000

/// Generating imports penerating ratio (ipr)
/// ipr defined as imports divided by the sum gross output and net imports
generate ipr = (imports/(gross_output + (imports - exports)))

/// Drop all observations with ipr greater than 1
drop if ipr >1

/// Trnasforming the data to natural logs
gen lnPPP_y=ln(PPP_y)
gen lnExports=ln(exports)
gen lnImports = ln(imports)
gen lnGross_ouput = ln(gross_output)
gen lnRnD = ln(rnd)
gen lnExports_corrected = (ln(lnExports - ln(1-ipr)))


*** Generating dummy variables (for fixed effects): 
	sort exporter industry importer year
	quietly: tabulate exporter, generate(idum)
	quietly: tabulate importer, generate(jdum)
	foreach var1 of varlist idum* {
		foreach var2 of varlist jdum* {
			quietly: generate alpha`var1'`var2'=`var1'*`var2'
			}
		}

	quietly: tabulate industry, generate(kdum)
	foreach var1 of varlist idum* {
		foreach var2 of varlist kdum* {
			quietly: generate gamma`var1'`var2'=`var1'*`var2'
			}
		}
	
	foreach var1 of varlist kdum* {
		foreach var2 of varlist jdum* {
			quietly: generate beta`var1'`var2'=`var1'*`var2'
		}
	}

/// Table 3
/// Installing eststo to store the estimates
ssc install eststo /// or
search eststo


/// Clearing all stored estimates
capture: eststo clear

/// Estimating the first ols regression with fixed effects. I suppressed the results due the length of the results
eststo: quietly regress lnExports lnPPP_y alpha* beta*, robust noomitted	

/// Estimating the same ols regression model using corrected exports
eststo: quietly regress lnExports_corrected lnPPP_y alpha* beta*, robust noomitted	

/// Instrumental variable approach with RnD as an instrument for productivity
eststo: quietly ivregress 2sls lnExports alpha* beta* (lnPPP_y = lnRnD), robust first noomitted	

/// IV with corrected exports 
eststo: quietly ivregress 2sls lnExports_corrected alpha* beta* (lnPPP_y = lnRnD), robust first noomitted

/// Tabulating the results in one table
esttab using riplication_of_Table3.csv, replace r2 se indicate("exporter*importer Fixed Effects = alpha*" "importer*industry Fixed Effects = beta*") keep(lnPPP_y)

/// Overleaf file of the Table 3
esttab using riplication_of_Table3.tex, replace r2 se indicate("exporter*importer Fixed Effects = alpha*" "importer*industry Fixed Effects = beta*") keep(lnPPP_y)



	
	
