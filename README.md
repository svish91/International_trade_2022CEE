# Wheat trade tends to happen between countries with contrasting extreme weather stress and synchronous yield variation
Citaion: Vishwakarma, S., Zhang, X. & Lyubchich, V. Wheat trade tends to happen between countries with contrasting extreme weather stress and synchronous yield variation. Commun Earth Environ 3, 261 (2022). https://doi.org/10.1038/s43247-022-00591-7


This repository contains data belonging to manuscript published in Communications Earth and Environment journal.
The data are for the period of 2005-2014

## File descriptions <br />
Figure_1.csv: this file contains the data belonging to the Figure 1 and Supplemtary Figures 13-29. <br />
Figure_2.csv: this file contains the data used to generate Figure 2 in the manuscript file. <br />
ERGM_Model.R: this file contains the model fitting with ERGM using the data in Figure_2.csv. <br />
RG_Model.R: this file contains the model fitting from RF using the data in Figure_2.csv.<br />


### Figure_1.csv <br />
Units and definitions: <br />
Trade volume: international wheat trade volume (kg) <br />
Production: wheat production (kg N) <br />
Imports: wheat imports (kg) <br />
Exports: wheat exports (kg)	<br />
IDR: import dependency ratio unitless <br />
Degree_imp: importing degree (unitless)	 <br />
Degree_exp:	exporting degree (unitless) <br />
PC_coldstress,	PC_heatstress,	countDGDH 26 C,	countDGDH 27 C,	countDGDH 28 C,	countDGDH 29 C,	countDGDH 30 C,	countDGDL 6 C	, countDGDL 7 C,
countDGDL 8 C,	countDGDL 9 C,	countDGDL 10 C,	countNGDL 0 C,	countNGDL 1 C,	countNGDL 2 C,	countNGDL 3 C,	countNGDL 4 C,	countPREH,	countPREL: weahter indices for wheat (unitless) <br />


### Figure_2.csv <br />
Units and definitions: <br />
Trade: net trade (log(kg)) <br />
Cold_stress: difference in cold stress (unitless)	<br />
Heat_Stress: difference in heat stress (unitless)	<br />
STS: correlation of yield fluctuations (unitless) <br />
GDP per capita: GDP per capita of exporting country + importing country (2010 US$) <br />
GDP: GDP of exporting country + importing country (2010 US$)	 <br />
GATT_WTO, RTA, Contiguity, Common official language: unitless dichotomous variable <br />
Production: difference in production (Kg N)	<br />	
Distance: distance between exporting and importing coutry km		<br />
