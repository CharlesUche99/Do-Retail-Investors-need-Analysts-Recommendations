*Working for Period 1992 to 1999
use "C:\Users\uchen\OneDrive - University of Massachusetts Boston\Desktop\Papers\Capstone Ideas\Analyst Recommendation\Data\rec_return.dta", clear

* Create year_month variable
gen year_month = ym(year, month)

* Format the year_month variable as a Stata monthly date
format year_month %tm

/*
* Keep observations within the specified recession periods
keep if (year == 2000 & month >= 3) | (year == 2002 & month <= 10) | ///
        (year == 2007 & month >= 12) | (year == 2009 & month <= 6) | ///
        (year == 2020 & month >= 2) | (year == 2023 & month <= 5)
*/


sort cusip year_month

*winsor2 month_return, cuts(1 99) by(year_month)

*keep if ff_17 == "Cars"

* Output the final matrix to Excel in the specified path
putexcel set "C:\Users\uchen\OneDrive - University of Massachusetts Boston\Desktop\Papers\Capstone Ideas\Analyst Recommendation\Tables\test.xlsx", replace
putexcel A1 = "Equal Weighted Returns" B1 = "T-statistics" C1 = "Value Weighted Returns" D1 = "T-statistics"

*Excess return EW
portfolio month_return_winsorized, groupby(year_month avg_ireccd) nq(10) rf(RF) all
matrix ew_res = r(result)
matrix ew_res_t = r(tstat)

*Excess return VW
portfolio month_return_winsorized, groupby(year_month avg_ireccd) w(prior_month_avg_cap) nq(10) rf(RF) all
matrix ew_res = r(result)
matrix ew_res_t = r(tstat)


********************************


*CAPM Factor EW
portfolio month_return_winsorized Mkt_RF, groupby(year_month avg_ireccd) nq(10) rf(RF) reg all
matrix ew_res = r(result)
matrix ew_res_t = r(tstat)
*CAPM Factor VW
portfolio month_return_winsorized Mkt_RF, groupby(year_month avg_ireccd) nq(10) rf(RF) w(prior_month_avg_cap) reg all
matrix vw_res = r(result)
matrix vw_res_t = r(tstat)

matrix final_matrix = ew_res \ ew_res_t \ vw_res \ vw_res_t

*FF3 Factor EW
portfolio month_return_winsorized Mkt_RF SMB HML, groupby(year_month avg_ireccd) nq(10) rf(RF) reg all
matrix ew_res = r(result)
matrix ew_res_t = r(tstat)
*FF3 Factor VW
portfolio month_return_winsorized Mkt_RF SMB HML, groupby(year_month avg_ireccd) nq(10) rf(RF) w(prior_month_avg_cap) reg all
matrix vw_res = r(result)
matrix vw_res_t = r(tstat)
matrix final_matrix = ew_res \ ew_res_t \ vw_res \ vw_res_t

*FFC Factor EW
portfolio month_return_winsorized Mkt_RF SMB HML Mom___, groupby(year_month avg_ireccd) nq(10) rf(RF) reg all
matrix ew_res = r(result)
matrix ew_res_t = r(tstat)
*FFC Factor VW
portfolio month_return_winsorized Mkt_RF SMB HML Mom___, groupby(year_month avg_ireccd) nq(10) rf(RF) w(prior_month_avg_cap) reg all
matrix vw_res = r(result)
matrix vw_res_t = r(tstat)
matrix final_matrix = ew_res \ ew_res_t \ vw_res \ vw_res_t

*FF5 Factor EW
portfolio month_return_winsorized Mkt_RF_ff5 SMB_ff5 HML_ff5 RMW CMA, groupby(year_month avg_ireccd) nq(10) rf(RF) reg all
matrix ew_res = r(result)
matrix ew_res_t = r(tstat)
*FF5 Factor VW
portfolio month_return_winsorized Mkt_RF_ff5 SMB_ff5 HML_ff5 RMW CMA, groupby(year_month avg_ireccd) nq(10) rf(RF) w(prior_month_avg_cap) reg all
matrix vw_res = r(result)
matrix vw_res_t = r(tstat)
matrix final_matrix = ew_res \ ew_res_t \ vw_res \ vw_res_t

*Q Factor EW
portfolio month_return_winsorized R_MKT R_ME R_IA R_ROE, groupby(year_month avg_ireccd) nq(10) rf(R_F) reg all
matrix ew_res = r(result)
matrix ew_res_t = r(tstat)
*Q Factor VW
portfolio month_return_winsorized R_MKT R_ME R_IA R_ROE, groupby(year_month avg_ireccd) nq(10) rf(R_F) w(prior_month_avg_cap) reg all
matrix vw_res = r(result)
matrix vw_res_t = r(tstat)
matrix final_matrix = ew_res \ ew_res_t \ vw_res \ vw_res_t

*Augumented Q Factor EW
portfolio month_return_winsorized R_MKT R_ME R_IA R_ROE R_EG, groupby(year_month avg_ireccd) nq(10) rf(R_F) reg all
matrix ew_res = r(result)
matrix ew_res_t = r(tstat)
*Augumented Q Factor VW
portfolio month_return_winsorized R_MKT R_ME R_IA R_ROE R_EG, groupby(year_month avg_ireccd) nq(10) rf(R_F) w(prior_month_avg_cap) reg all
matrix vw_res = r(result)
matrix vw_res_t = r(tstat)
matrix final_matrix = ew_res \ ew_res_t \ vw_res \ vw_res_t



***********************************************************************
use "C:\Users\uchen\OneDrive - University of Massachusetts Boston\Desktop\Papers\Capstone Ideas\Analyst Recommendation\Data\rec_return.dta", clear

* Create year_month variable
gen year_month = ym(year, month)

* Format the year_month variable as a Stata monthly date
format year_month %tm

* Sort the dataset
sort year month

* Get a list of unique values in the ff_10 column
levelsof ff_5, local(ff5_groups)

* Create a new Excel file (if it doesn't exist) or modify it (if it does)
putexcel set "C:\Users\uchen\OneDrive - University of Massachusetts Boston\Desktop\Papers\Capstone Ideas\Analyst Recommendation\Results\industry_ff5.xlsx", modify

* Add headers for the first row (just once)
putexcel A1 = "Industry" B1 = "EW Results (11,1)" C1 = "EW T-Stat (12,1)" D1 = "VW Results (11,1)" E1 = "VW T-Stat (12,1)"

* Initialize row counter for Excel output
local row = 2

* Loop over each unique value in ff_10
foreach group in `ff5_groups' {
    
    * Preserve the data before subsetting
    preserve
    
    * Keep only the observations for the current group
    keep if ff_5 == "`group'"
    
    * Sort data by year and month
    sort year month

    * Display the group being processed
    di "Processing group: `group'"
    
    * Calculate equally-weighted (EW) excess return
    portfolio month_return_winsorized R_MKT R_ME R_IA R_ROE R_EG, groupby(year_month avg_ireccd) nq(10) rf(R_F) all
    matrix ew_res = r(result)  // Save EW results in matrix

    * Calculate value-weighted (VW) excess return
    portfolio month_return_winsorized R_MKT R_ME R_IA R_ROE R_EG, groupby(year_month avg_ireccd) nq(10) rf(R_F) w(prior_month_avg_cap) all
    matrix vw_res = r(result)  // Save VW results in matrix

    * Combine the EW and VW results into one matrix
    matrix onesorts = ew_res, vw_res
    matrix colname onesorts = ew:ew_res vw:vw_res

    * Display the results
    matlist onesorts, showcoleq(c)
    
    * Append the results for each ratio to the Excel file
    putexcel A`row' = "`group'" B`row' = ew_res[11,1] C`row' = ew_res[12,1] D`row' = vw_res[11,1] E`row' = vw_res[12,1]
    
    * Increment the row counter for the next output
    local row = `row' + 1

    * Restore the dataset to its original state before moving to the next group
    restore
    
}

********************************************************************************
***********************************************************************
use "C:\Users\uchen\OneDrive - University of Massachusetts Boston\Desktop\Papers\Capstone Ideas\Analyst Recommendation\Data\rec_return_broker.dta", clear

* Create year_month variable
gen year_month = ym(year, month)

* Format the year_month variable as a Stata monthly date
format year_month %tm

* Sort the dataset
sort year month

* Get a list of unique values in the ff_10 column
levelsof broker, local(broker)

* Create a new Excel file (if it doesn't exist) or modify it (if it does)
putexcel set "C:\Users\uchen\OneDrive - University of Massachusetts Boston\Desktop\Papers\Capstone Ideas\Analyst Recommendation\Results\broker_1&3.xlsx", modify

* Add headers for the first row (just once)
putexcel A1 = "Firm" B1 = "EW Results low 1" C1 = "EW high 10" D1 = "VW Results Low 1" E1 = "VW High 10"

* Initialize row counter for Excel output
local row = 2

* Loop over each unique value in broker
foreach group in `broker' {
    
    * Preserve the data before subsetting
    preserve
    
    * Keep only the observations for the current group
    keep if broker == "`group'"

    * Sort data by year and month
    sort year month

    * Display the group being processed
    di "Processing group: `group'"
    
    * Calculate equally-weighted (EW) excess return
    portfolio month_return_winsorized Mkt_RF SMB HML RMW CMA, groupby(year_month avg_ireccd) nq(3) rf(RF) all
    matrix ew_res = r(result)  // Save EW results in matrix
	matrix ew_res_t = r(tstat)

    * Calculate value-weighted (VW) excess return
    portfolio month_return_winsorized Mkt_RF SMB HML RMW CMA, groupby(year_month avg_ireccd) nq(3) rf(RF) w(prior_month_avg_cap) all
    matrix vw_res = r(result)  // Save VW results in matrix
	matrix vw_res_t = r(tstat)

    * Combine the EW and VW results into one matrix
    matrix onesorts = ew_res, vw_res
    matrix colname onesorts = ew:ew_res vw:vw_res

    * Display the results
    matlist onesorts, showcoleq(c)
	
    local row2 = `row' + 1
	
    * Append the EW results and t-stats for the current group to the Excel file
    putexcel A`row' = "`group'" B`row' = ew_res[1,1] B`row2' = ew_res_t[1,1] C`row' = ew_res[3,1] C`row2' = ew_res_t[3,1] D`row' = vw_res[1,1] D`row2'  = vw_res_t[1,1] E`row' = vw_res[3,1] E`row2'  = vw_res_t[3,1]
    

    * Increment the row counter for the next output
    local row = `row' + 2

    * Restore the dataset to its original state before moving to the next group
    restore
    
}



***********************Fama-McBeth Regression*************************************
*Working for Period 1992 to 1999
use "C:\Users\uchen\OneDrive - University of Massachusetts Boston\Desktop\Papers\Capstone Ideas\Analyst Recommendation\Data\rec_return.dta", clear

* Create year_month variable
gen year_month = ym(year, month)

* Format the year_month variable as a Stata monthly date
format year_month %tm

sort cusip year_month

encode cusip, gen(cusip_num)

xtset cusip_num year_month


* Step 1: Generate the market return Rm
gen Rm = Mkt_RF + RF

* Step 3: Perform rolling regression over the past 60 months
* Sort the data
sort cusip year_month

* Perform the rolling regression
bys cusip_num: asreg month_return_winsorized Rm, wind(year_month 60) min(60)

drop _Nobs _R2 _adjR2 _b_cons

*Fama McBeth Reg
//Step0 : Timeseries Regression
bys cusip_num: asreg month_return_winsorized avg_ireccd _b_Rm prior_month_avg_cap

//Step1 and 2 : Crossectional Regression and averages
drop _R2 _adjR2
asreg month_return_winsorized _b_avg_ireccd _b__b_Rm _b_prior_month_avg_cap, fmb newey(2)
