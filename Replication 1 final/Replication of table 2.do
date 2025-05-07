/// Replicating table 2

///Importing the productivity data
use productivity

/// Counting the country industry specifics: Each observation must have a one country-industry specific value
bys country industry: gen count = _n

/// Drop observations with more than one count
drop if count>1

/// Drop the variable count
drop count

/// Keeping the variables needed for this replication
keep country industry ppp_y

/// Generating the inverse of productivity
gen z = 1/ppp_y

/// Droping productivity
drop ppp_y

///
gen z_US_Food = z if countrycode=="USA" & sector == "agr"
		egen z_US_Agr_m = mean(z_US_Agr)
		drop z_US_Agr
		rename z_US_Food_m z_US_Agr

		gen z_US = z if countrycode=="USA" 
		bys sector: egen z_US_m = mean(z_US)
		drop z_US
		rename z_US_m z_US
		
		gen z_Agr = z if sector == "agr"
		bys countrycode: egen z_Agr_m = mean(z_Agr)
		drop z_Agr
		rename z_Agr_m z_Agr
				
		gen output = z * z_US_Agr/(z_US*z_Agr)
		drop z*

		reshape wide output, i(countrycode) j(sector) string
		drop countrycode
		outsheet output* using "replication_of_Table2.csv", comma nonames replace
