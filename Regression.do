clear all

global dir "/Users/Lou/Desktop/USC/22 Spring/501/501 Group Project/Lab"


***************************************************************************************************************************************************************
*** For reg 1 wei
use "$dir/reg1/Reg_WEI.dta", clear
* reg WEI NE UEtoE TPI CPI // Best for now !!!!!

gen CFCP = 1 if date >= "2020-06-01" & date <= "2021-06-01"
replace CFCP = 0 if CFCP == .
gen ARP = 1 if date >= "2021-04-01"
replace ARP = 0 if ARP == .

reg WEI CFCP ARP PC IP UEL DPI CPI  // Done 
outreg2 using "$dir/Reg_Rslt.doc", replace

/*  日期格式
gen date2 = date(date, "YMD")
format date2 %td
gen month = mofd(date2)
format month %tm
gen quarter = qofd(date2)
format quarter %tq
*/

/*
gen lnpc = log(PC) 
gen lnip = log(IP) 
gen lnne = -log(abs(NE))
gen lnel = log(EL) 
gen lntpi = log(TPI) 
gen lnrdpi = log(RDPI)
gen lncpi = log(CPI)

reg WEI lnrpc lnip ne lnel lntpi lnrdpi lncpi
*/

/* test 
reg WEI PC IP NE UEtoE TPI DPI CPI 

gen lnne = -log(abs(NE))
gen lndpi = log(DPI)
reg WEI lnne UEtoE TPI lndpi CPI

gen ne = NE/1000
gen dpi = DPI/1000
reg WEI ne UEtoE TPI dpi CPI
*/

/************** test *************

insheet using "$dir/reg1/UEL.csv", clear
save "$dir/reg1/UEL.dta", replace
use "$dir/reg1/UEL.dta", clear
drop if date <"2020-01-01" | date == "2022-02-01"
save "$dir/reg1/UEL.dta", replace
merge 1:1 date using "$dir/reg1/Reg_WEI.dta"
drop _merge
rename unemploy UEL
save "$dir/reg1/testreg.dta", replace
reg WEI PC
reg WEI PC IP
reg WEI PC IP NE
reg WEI PC IP NE EL
reg WEI PC IP NE EL TPI
reg WEI PC IP NE EL UEL TPI DPI
reg WEI NE EL TPI CPI
use "$dir/reg1/testreg.dta", clear
reg WEI IP CPI
reg WEI PC NE EL TPI CPI
reg WEI NE EL TPI CPI
reg WEI NE UEL TPI CPI // Best for now !!!!!
gen index = UEL/EL
reg WEI NE TPI CPI index
reg WEI IP TPI CPI index
reg WEI PC IP NE TPI DPI CPI index
*/

***************************************************************************************************************************************************************
use "$dir/reg2/Reg_GDP.dta", clear 

/*
drop ESAD EESAD ARRAD
gen ESAD = 1 if date >= "2008-04-01" & date <= "2009-04-01"
replace ESAD = 0 if ESAD == .
gen EESAD = 1 if date >= "2008-10-01" & date <= "2009-10-01"
replace EESAD = 0 if EESAD == .
gen ARRAD = 1 if date >= "2009-04-01" & date <= "2010-04-01"
replace ARRAD = 0 if ARRAD == .
*/

* drop BUSH OBAMA
gen BUSH = 1 if date >= "2008-04-01" & date <= "2010-04-01"
replace BUSH = 0 if BUSH == .
gen OBAMA = 1 if date >= "2009-04-01" & date <= "2011-04-01"
replace OBAMA = 0 if OBAMA == .

gen CFCP = 1 if date >= "2020-01-01"
replace CFCP = 0 if CFCP == .
gen ARP = 1 if date >= "2021-01-01"
replace ARP = 0 if ARP == .


reg GDP BUSH OBAMA CFCP ARP PC NX GPDI GTE //best Done
outreg2 using "$dir/Reg_Rslt.doc", append

/*
gen lnpc = log(PC)
gen lngpdi = log(GPDI)
gen lndpi = log(DPI)
gen lngte = log(GTE)
reg lnGDP lnpc IP NX UEtoE lngpdi lndpi CPI lngte
*/

***************************************************************************************************************************************************************
use "$dir/reg3/Reg_IR.dta", clear 
gen CFCP = 1 if date >= "2020-06-01" & date <= "2021-06-01"
replace CFCP = 0 if CFCP == .
gen ARP = 1 if date >= "2021-04-01" 
replace ARP = 0 if ARP == .
reg IR CFCP ARP WEI // Done
outreg2 using "$dir/Reg_Rslt.doc", append

***************************************************************************************************************************************************************
use "$dir/reg4/Reg_UEL.dta", clear
gen lnUEL = log(UEL)

* drop CFCP ARP
gen CFCP = 1 if date >= "2020-05-01" & date <= "2021-05-01"
replace CFCP = 0 if CFCP == .
gen ARP = 1 if date >= "2021-04-01" 
replace ARP = 0 if ARP == .

*reg lnUEL CFCP ARP WEI IR // Done

reg UER CFCP ARP WEI IR // Done
outreg2 using "$dir/Reg_Rslt.doc", append



