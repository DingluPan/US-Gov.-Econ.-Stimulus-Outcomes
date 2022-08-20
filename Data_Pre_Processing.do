clear all

global dir /Users/Lou/Desktop/USC/22 Spring/501/501 Group Project/Lab

/*  用real的data的
local vars1 "WEI RPC IP NE EL UEL TPI RDPI CPI"
local vars2 "RGDP RPC IP NX EL UEL RGPDI RDPI CPI GTE"
local vars3 "IR WEI RM1"
local vars4 "UEL WEI IR WAGE"
*/

*** 用名义的data的
local vars1 "WEI PC IP NE EL UEL TPI DPI CPI"
local vars2 "GDP PC IP NX EL UEL GPDI DPI CPI GTE"
local vars3 "IR WEI M1"
local vars4 "UEL UER WEI IR WAGE PC IP DPI M1"

forvalues i = 1(1)4 {
	foreach v in `vars`i'' {
	insheet using "$dir/reg`i'/`v'.csv", clear
	save "$dir/reg`i'/`v'.dta", replace
	}
}

*** For Reg 1

/* 对 NEorg.csv 操作将str改float 但encode让实际数值成为累加值2、3、4...不能用来回归，则用 NE.csv(直接复制了数据到excel再导出为csv来弄的就ok）
use "$dir/reg1/NE.dta"
rename v1 date
rename v2 netexports
drop in 1
encode netexports, gen(netex)
drop netexports
save "$dir/reg1/NE.dta", replace
*/ 

mergemany 1:1 "$dir/reg1/WEI" "$dir/reg1/PC" "$dir/reg1/IP" "$dir/reg1/NE" "$dir/reg1/EL" "$dir/reg1/UEL" "$dir/reg1/TPI" "$dir/reg1/DPI" "$dir/reg1/CPI", match(date)
rename (wei pce indpro ne ce16ov unemploy wpsfd49215 dspi usacpiallminmei) (WEI PC IP NE EL UEL TPI DPI CPI) 
gen UEtoE = UEL/EL
save "$dir/reg1/Reg_WEI.dta", replace

*** For Reg 2
mergemany 1:1 "$dir/reg2/GDP" "$dir/reg2/PC" "$dir/reg2/IP" "$dir/reg2/NX" "$dir/reg2/EL" "$dir/reg2/UEL" "$dir/reg2/GPDI" "$dir/reg2/DPI" "$dir/reg2/CPI" "$dir/reg2/GTE", match(date)
rename (gdp pce indpro netexp ce16ov unemploy gpdi dspi usacpiallminmei w068rcq027sbea) (GDP PC IP NX EL UEL GPDI DPI CPI GTE)
gen UEtoE = UEL/EL
save "$dir/reg2/Reg_GDP.dta", replace

*** For Reg 3
mergemany 1:1 "$dir/reg3/IR" "$dir/reg3/WEI" "$dir/reg3/M1", match(date)
rename (t5yie wei wm1ns) (IR WEI M1)
save "$dir/reg3/Reg_IR.dta", replace

*** For Reg 4
mergemany 1:1 "$dir/reg4/UEL" "$dir/reg4/UER" "$dir/reg4/WEI" "$dir/reg4/IR" "$dir/reg4/WAGE" "$dir/reg4/PC" "$dir/reg4/IP" "$dir/reg4/DPI" "$dir/reg4/M1", match(date)
rename (unemploy unrate wei t5yie ces0500000003 pce indpro dspi wm1ns) (UEL UER WEI IR WAGE PC IP DPI M1)
save "$dir/reg4/Reg_UEL.dta", replace

