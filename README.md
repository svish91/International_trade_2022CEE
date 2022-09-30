# # Wheat trade tends to happen between countries with contrasting extreme weather stress and synchronous yield variation

This repository contains data belonging to manuscript published in Communications Earth and Environment journal.

## File descriptions <br />
Figure_1.csv: this file contains the data belonging to the Figure 1 and Supplemtary Figures 13-S29. <br />
Figure_2.csv: this file contains the data used to generate Figure 2 in the manuscript file. <br />
ERGM_Model.R: this file contains the model fitting with ERGM using the data in Figure_2.csv. <br />
RG_Model.R: this file contains the model fitting from RF using the data in Figure_2.csv.<br />


### Figure_1.csv <br />
Units: <br />
Trade volume: kg <br />
Production: kg N <br />
Imports: kg <br />
Exports: kg	<br />
IDR: unitless <br />
Degree_imp: unitless (importing degree)	 <br />
Degree_exp:	unitless (exporting degree) <br />
PC_coldstress,	PC_heatstress,	countDGDH 26 C,	countDGDH 27 C,	countDGDH 28 C,	countDGDH 29 C,	countDGDH 30 C,	countDGDL 6 C	, countDGDL 7 C,
countDGDL 8 C,	countDGDL 9 C,	countDGDL 10 C,	countNGDL 0 C,	countNGDL 1 C,	countNGDL 2 C,	countNGDL 3 C,	countNGDL 4 C,	countPREH,	countPREL: unitless <br />


### Figure_2.csv <br />
Units: <br />
Trade: log(kg) <br />
Cold_stress: unitless	<br />
Heat_Stress: unitless	<br />
STS: unitless (correlation of yield fluctuations) <br />
GDP per capita: 2010 US$ <br />
GDP: 2010 US$	 <br />
GATT_WTO, RTA, Contiguity, Common official language: unitless dichotomous variable <br />
Production: Kg N	<br />	
Distance: km		<br />
