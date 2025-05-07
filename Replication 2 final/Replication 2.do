/// Replication Assignment 2
/// Paper: Export variety and country productivity: Estimating the monopolistic competition model with endogenous productivity by Feenstra and Kee (2008) 

/// Importing data to stata
use "Replication 2 data.dta"   ///Working directory is set to the current working folder

///Generating logs of varieies
gen lnAgric_variety = ln(agric_variety)
gen lnwood_variety=ln(wood_variety)
gen lnmining_variety = ln(mining_variety)
gen lnpetroleum_variety = ln(petroleum_variety)
gen lnmachinery_variety = ln(machinery_variety)
gen lnelectronics_variety = ln(electronics_variety)
gen lntextiles_variety = ln(textiles_variety)


/// Generating global variable for exports varieties
global log_of_varieties lnAgric_variety lnwood_variety lnmining_variety lnpetroleum_variety lnmachinery_variety lnelectronics_variety lntextiles_variety


/// 3sls regression using reg3
reg3 (agric_share $log_of_varieties lnLabor i.Year) (textiles_garment_share $log_of_varieties lnLabor i.Year) (wood_paper_share $log_of_varieties lnLabor i.Year) (petroleum_plastics_share $log_of_varieties lnLabor i.Year) (electronics_share $log_of_varieties lnLabor i.Year) (transport_share $log_of_varieties lnLabor i.Year) (mining_metals_share $log_of_varieties lnLabor i.Year), end(agric_share textiles_garment_share wood_paper_share petroleum_plastics_share electronics_share transport_share mining_metals_share) exog(dist dist_sq lnLabor) 3sls


/// Storing estimates
estimates store model3sls


/// Exporting estimates to latex
esttab model3sls using results_3sls.tex, ///
    title("3SLS Regression Results") ///
    label se star(* 0.10 ** 0.05 *** 0.01) ///
    alignment(D{.}{.}{-1}) replace ///
    tex
	

	
	
	
/// Extracting table manually

// Estimating equation 1
reg3 (agric_share $log_of_varieties lnLabor i.Year), end(agric_share textiles_garment_share wood_paper_share petroleum_plastics_share electronics_share transport_share mining_metals_share) exog(dist dist_sq lnLabor) 3sls

///Store the esrimates
estimates store eq1

// Estimating equation 2
reg3 (textiles_garment_share $log_of_varieties lnLabor i.Year), end(agric_share textiles_garment_share wood_paper_share petroleum_plastics_share electronics_share transport_share mining_metals_share) exog(dist dist_sq lnLabor) 3sls

///Store the esrimates
estimates store eq2


//Estimating eq3
reg3 (wood_paper_share $log_of_varieties lnLabor i.Year), end(agric_share textiles_garment_share wood_paper_share petroleum_plastics_share electronics_share transport_share mining_metals_share) exog(dist dist_sq lnLabor) 3sls

///Store the esrimates
estimates store eq3

//Estimating eq4
reg3 (petroleum_plastics_share $log_of_varieties lnLabor i.Year), end(agric_share textiles_garment_share wood_paper_share petroleum_plastics_share electronics_share transport_share mining_metals_share) exog(dist dist_sq lnLabor) 3sls

///Store the esrimates
estimates store eq4


///Estimating eq5
reg3 (transport_share $log_of_varieties lnLabor i.Year), end(agric_share textiles_garment_share wood_paper_share petroleum_plastics_share electronics_share transport_share mining_metals_share) exog(dist dist_sq lnLabor) 3sls

///Store the esrimates
estimates store eq5

//Estimating eq6
reg3 (mining_metals_share $log_of_varieties lnLabor i.Year), end(agric_share textiles_garment_share wood_paper_share petroleum_plastics_share electronics_share transport_share mining_metals_share) exog(dist dist_sq lnLabor) 3sls

///Store the estimates
estimates store eq6


// Estimating eq7
reg3 (electronics_share $log_of_varieties lnLabor i.Year), end(agric_share textiles_garment_share wood_paper_share petroleum_plastics_share electronics_share transport_share mining_metals_share) exog(dist dist_sq lnLabor) 3sls

///Store the esrimates
estimates store eq7


///Exporting all to overleaf
esttab eq1 eq2 eq3 eq4 eq5 eq6 eq7 using results_3sls_table.tex, ///
    se label star(* 0.10 ** 0.05 *** 0.01) ///
    title("3SLS Regression Results") ///
    alignment(D{.}{.}{-1}) replace tex









