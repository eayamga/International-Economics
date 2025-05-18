//// Results

/// Importing export performance data
 use "/Users/ayamga/Library/CloudStorage/OneDrive-TexasTechUniversity/International Trade/Term paper/Export.dta"
 
 
/// Merging data with sudden stops data
 merge m:m countryname using "/Users/ayamga/Library/CloudStorage/OneDrive-TexasTechUniversity/International Trade/Term paper/defined sudden stops.dta"

 
/// Dropping the empty entries
drop in 1972/2295

///Encoding countryname to numeric using id
encode countryname, generate(id2)

///Declaring data type
xtset id year

///Generating event year
gen event_year = .
replace event_year=year if sudden_stop_sd1==1

//// Generating Dummies
gen lag_3 =0
replace lag_3=1 if lag_sudden_stop==-3
gen lag_2 =0
replace lag_2=1 if lag_sudden_stop==-2
gen lag_1 =0
replace lag_1=1 if lag_sudden_stop==-1
gen lag1 =0
replace lag1=1 if lag_sudden_stop==1
gen lag2 =0
replace lag2=1 if lag_sudden_stop==2
gen lag3 =0
replace lag3=1 if lag_sudden_stop==3
gen lag0 =0
replace lag0=1 if lag_sudden_stop==0


////Regression
reg Export lag_3 lag_2 lag_1 lag0 lag1 lag2 lag3 i.id i.year

/// Plotting results

coefplot, keep(lag_3 lag_2 lag_1 lag0 lag1 lag2 lag3) xline(0) title("Event Study: Export Performance Around Sudden Stops")



reghdfe Export lag0, absorb(id) cluster(year)
reghdfe Export lag0, absorb(year) cluster(id)
reghdfe Export lag_3 lag_2 lag_1 lag0 lag1 lag2 lag3, absorb(year) cluster(id)
reghdfe Export lag_3 lag_2 lag0 lag1 lag2 lag3, absorb(year) cluster(id)
reghdfe Export lag0 lag1 lag2 lag3, absorb(year) cluster(id)
clear all
use "/Users/ayamga/Library/CloudStorage/OneDrive-TexasTechUniversity/International Trade/Term paper/Trade_data_1.dta"
reghdfe Export lag0, absorb(year) cluster(id)
reghdfe Export lag0, absorb(year id) cluster(id)
reghdfe Export lag0, absorb(id) cluster(id)
reghdfe Export lag_3 lag_2 lag_1 lag0 lead1 lead2 lead3, absorb(id) cluster(id)
reghdfe Export lag_3 lag_2 lag_1 lag0 lead1 lead2 lead3, absorb(year) cluster(id)
reghdfe lnExport lag_3 lag_2 lag_1 lag0 lead1 lead2 lead3, absorb(year) cluster(id)
reghdfe lnExport lag_3 lag_2 lag_1 lag0 lead1 lead2 lead3, absorb(year id) cluster(id)
reghdfe lnExport lag0, absorb(year id) cluster(id)
reghdfe Export lag0, absorb(year id) cluster(id)
reghdfe Export lag0, absorb(id) cluster(id)
reghdfe Export lag0, absorb(year) cluster(id)
reghdfe Export lag0, absorb(year id) cluster(id)
reghdfe Export lag0
reghdfe Export lag0, absorb(year) cluster(id)
reghdfe Export lag0, absorb(id) cluster(id)
reghdfe Export lag0, absorb(year id) cluster(id)
reghdfe Export lag0 lead1 lead2 lead3, absorb(year id) cluster(id)
reghdfe Export lag_3 lag_2 lag_1 lag0 lead1 lead2 lead3, absorb(year id) cluster(id)
twoway (line Export sudden_stop_sd1) if id==2 & year>=2010 & year <=2020
twoway (line Export year) if id==2 & year>=2010 & year <=2020
graph save "Graph" "/Users/ayamga/Library/CloudStorage/OneDrive-TexasTechUniversity/International Trade/Term paper/Graph.gph"
twoway (line Export year) if id==1 & year>=2010 & year <=2020
twoway (line Export year) if id==3 & year>=2010 & year <=2020
twoway (line Export year) if id==4 & year>=2010 & year <=2020
twoway (line Export year) if id==5 & year>=2010 & year <=2020
twoway (line Export year) if id==6 & year>=2010 & year <=2020
twoway (line Export year) if id==7 & year>=2010 & year <=2020
graph save "Graph" "/Users/ayamga/Library/CloudStorage/OneDrive-TexasTechUniversity/International Trade/Term paper/Graph.gph", replace
graph save "Graph" "/Users/ayamga/Library/CloudStorage/OneDrive-TexasTechUniversity/International Trade/Term paper/Graph.gph", replace
