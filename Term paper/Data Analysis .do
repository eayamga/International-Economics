/// This do file only contaains the commands for estimating the results present in the term paper but does not contained how the data was managed

/// Importing export performance data
use Trade_data

///Declaring data type
xtset id year


////Regression : Estimating thee effect of sudden stops on export performancee using the full sample. The dummies are compared to the periods out the three years around the eevent
reg Export lag_3 lag_2 lag_1 lag0 lag1 lag2 lag3 i.id i.year

/// Plotting results

coefplot, keep(lag_3 lag_2 lag_1 lag0 lag1 lag2 lag3) xline(0) title("Event Study: Export Performance Around Sudden Stops")


//// Dropping all periods out side the event window
keep if lag_sudden_stop >=-3 & lag_sudden_stop <=3


//// Running the regression again with the unbalanced panel using high dimension fixed effects model
reghdfe Export lag0    /// Static with no fixed effects

/// Storing the results
estimates store eq1

reghdfe Export lag0, absorb(year) cluster(id) /// Static with no country fixed effects

/// Storing the results
estimates store eq2


reghdfe Export lag0, absorb(id) cluster(id)  /// Static with no year fixed effects

/// Storing the results
estimates store eq3


reghdfe Export lag0, absorb(year id) cluster(id)  /// Static with all fixed effects 

/// Storing the results
estimates store eq4


reghdfe Export lag0 lead1 lead2 lead3, absorb(year id) cluster(id)  /// Dynamic with only leads

/// Storing the results
estimates store eq5



reghdfe Export lag_3 lag_2 lag_1 lag0 lead1 lead2, absorb(year id) cluster(id) /// Full Dynamic(lag 3 as based category)

/// Storing the results
estimates store eq6


reghdfe Export lag_3 lag_2 lag0 lead1 lead2 lead3, absorb(year id) cluster(id) /// Full Dynamic (lag 1 as based category)

/// Storing the results
estimates store eq7


///Exporting all to overleaf
esttab eq1 eq2 eq3 eq4 eq5 eq6 eq7 using results_Export_Performance.tex, ///
    se label star(* 0.10 ** 0.05 *** 0.01) ///
    title("The effect of Sudden Stops on Export Performance") ///
    alignment(D{.}{.}{-1}) replace tex



//// Graphing Exports performance around sudden stops

twoway (line Export year) if id==2 & year>=2010 & year <=2020, xline(2014)

twoway (line Export year) if id==6 & year>=2010 & year <=2020, xline(2011)

twoway (line Export year) if id==7 & year>=2010 & year <=2020, xline(2014) xline(2016) xline(2019)



