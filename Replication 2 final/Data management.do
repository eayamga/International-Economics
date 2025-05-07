/// International Trade Replication 2 Data management
import excel "/Users/ayamga/Library/CloudStorage/OneDrive-TexasTechUniversity/International Trade/Repl 2/data.xlsx", sheet("Sheet1") firstrow
drop if Year <2002
drop Agric Miningandquarrying food metals
rename Q agric_import
rename R wood_paper_import
rename mining_metals mining_metals_import
rename T petroleum_plastic_import
rename machinery_transport machinery_transport_import
rename Electronics Electronics_import
rename W textiles_garment_import
encode country_id_o, generate(origin)
gen agric_share = Agriculture/GDP_exp
gen textiles_garment_share = textiles_garments/GDP_exp
gen wood_paper_share= wood_paper/GDP_exp
gen petroleum_plastics_share= petroleum_plastics/GDP_exp
gen electronics_share= electronics/GDP_exp
gen transport_share = transport/GDP_exp
gen mining_metals_share= Mining_metals/GDP_exp
egen sum_agric=total(agric_import), by(origin)
egen sum_wood = total(wood_paper_import), by(origin)
egen sum_mining=total(mining_metals_import), by(origin)
egen sum_petroleum = total(petroleum_plastic_import), by(origin)
egen sum_machinery = total(machinery_transport_import), by(origin)
egen sum_lecteronics = total(Electronics_import), by(origin)
egen sum_textiles = total(textiles_garment_import), by(origin)
gen agric_variety = agric_import/sum_agric
gen wood_variety = wood_paper_import/sum_wood
gen mining_variety = mining_metals_import/sum_mining
gen petroleum_variety = petroleum_plastic_import/sum_petroleum
gen machinery_variety = machinery_transport_import/sum_machinery
gen electronics_variety = Electronics_import/sum_lecteronics
gen textiles_variety = textiles_garment_import/sum_textiles
gen dist_sq= dist^2
gen lnLabor=ln(Labor_exp)






