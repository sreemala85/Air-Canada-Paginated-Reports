
create or replace view TERADATA_MIG.PEDW_BAGS_V.SITA_MASTER_REPORT(
	DATE_YEAR,
	DATE_MONTH,
	DATE_FLIGHT,
	STATION,
	PAX,
	CODED_FILES,
	RL_10,
	ERROR_10,
	RL_12,
	RL_16,
	RL_20,
	ERROR_20,
	RL_21,
	RL_22,
	RL_26,
	RL_30,
	ERROR_30,
	RL_31,
	RL_32,
	RL_40,
	ERROR_40,
	RL_41,
	RL_49,
	RL_50,
	ERROR_50,
	RL_53,
	RL_54,
	RL_56,
	RL_57,
	RL_60,
	ERROR_60,
	RL_62,
	RL_63,
	RL_65,
	RL_66,
	RL_67,
	RL_70,
	ERROR_70,
	RL_72,
	RL_73,
	RL_74,
	RL_76,
	RL_77,
	RL_ERROR,
	STATION_TARGET,
	REGIONAL_TARGET,
	GLOBAL_TARGET,
	SYSTEM_TARGET,
	TARGET_FILES,
	BUDGETED_PAX,
	REPORT_LEVEL_2,
	SORT_ORDER,
	REGION_LEVEL_3,
	REGION_ORDER,
	TARGET_FLAG
) as 

SELECT Extract(year FROM pax_date) AS DATE_YEAR, 
Extract(month FROM pax_date) AS DATE_MONTH, 
pax_date AS DATE_FLIGHT, pax_dep_stn AS STATION, 
Max (T1.pax_cnt) AS PAX, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss IN ( ( '12' ), ( '16' ), ( '21' ), ( '22' ), ( '26' ), ( '31' ), ( '32' ), ( '41' ), ( '49' ), ( '53' ), ( '54' ), ( '56' ), ( '57' ), ( '62' ), ( '63' ), ( '65' ), ( '66' ), ( '67' ), ( '72' ), ( '73' ), ( '74' ), ( '76' ), ( '77' )) THEN 1 ELSE 0 END) AS CODED_FILES, --( '78' ) was removed as per Catherine's request on 2024-04-17
Sum (CASE WHEN SITAF.rl_rsn_for_loss IN ( ( '12' ), ( '16' ) ) THEN 1 ELSE 0 END) AS RL_10, 
Sum (CASE WHEN Cast(SITAF.rl_rsn_for_loss AS STRING) LIKE ((( '1%' ))) AND SITAF.rl_rsn_for_loss NOT IN ( ( '12' ), ( '16' ) ) THEN 1 ELSE 0 END) AS ERROR_10, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '12' THEN 1 ELSE 0 END) AS RL_12, Sum (CASE WHEN SITAF.rl_rsn_for_loss = '16' THEN 1 ELSE 0 END) AS RL_16, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss IN ( ( '21' ), ( '22' ), ( '26' ) ) THEN 1 ELSE 0 END) AS RL_20, 
Sum (CASE WHEN Cast(SITAF.rl_rsn_for_loss AS STRING) LIKE ((( '2%' ))) AND SITAF.rl_rsn_for_loss NOT IN ( ( '21' ), ( '22' ), ( '26' ) ) THEN 1 ELSE 0 END) AS ERROR_20, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '21' THEN 1 ELSE 0 END) AS RL_21, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '22' THEN 1 ELSE 0 END) AS RL_22, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '26' THEN 1 ELSE 0 END) AS RL_26, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss IN ( ( '31' ), ( '32' ) ) THEN 1 ELSE 0 END) AS RL_30, 
Sum (CASE WHEN Cast(SITAF.rl_rsn_for_loss AS STRING) LIKE ((( '3%' ))) AND SITAF.rl_rsn_for_loss NOT IN ( ( '31' ), ( '32' ) ) THEN 1 ELSE 0 END) AS ERROR_30, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '31' THEN 1 ELSE 0 END) AS RL_31, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '32' THEN 1 ELSE 0 END) AS RL_32, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss IN ( ( '41' ), ( '49' ) ) THEN 1 ELSE 0 END) AS RL_40, 
Sum (CASE WHEN Cast(SITAF.rl_rsn_for_loss AS STRING) LIKE ((( '4%' ))) AND SITAF.rl_rsn_for_loss NOT IN ( ( '41' ), ( '49' ) ) THEN 1 ELSE 0 END) AS ERROR_40, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '41' THEN 1 ELSE 0 END) AS RL_41, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '49' THEN 1 ELSE 0 END) AS RL_49, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss IN ( ( '53' ), ( '54' ), ( '56' ), ( '57' ) ) THEN 1 ELSE 0 END) AS RL_50, 
Sum (CASE WHEN Cast(SITAF.rl_rsn_for_loss AS STRING) LIKE ((( '5%' ))) AND SITAF.rl_rsn_for_loss NOT IN ( ( '53' ), ( '54' ), ( '56' ), ( '57' ) ) THEN 1 ELSE 0 END) AS ERROR_50, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '53' THEN 1 ELSE 0 END) AS RL_53, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '54' THEN 1 ELSE 0 END) AS RL_54, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '56' THEN 1 ELSE 0 END) AS RL_56, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '57' THEN 1 ELSE 0 END) AS RL_57, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss IN ( ( '62' ), ( '63' ), ( '65' ), ( '66' ), ( '67' ) ) THEN 1 ELSE 0 END) AS RL_60, 
Sum (CASE WHEN Cast(SITAF.rl_rsn_for_loss AS STRING) LIKE ((( '6%' ))) AND SITAF.rl_rsn_for_loss NOT IN ( ( '62' ), ( '63' ), ( '65' ), ( '66' ) , ( '67' ) ) THEN 1 ELSE 0 END) AS ERROR_60, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '62' THEN 1 ELSE 0 END) AS RL_62,
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '63' THEN 1 ELSE 0 END) AS RL_63,
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '65' THEN 1 ELSE 0 END) AS RL_65, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '66' THEN 1 ELSE 0 END) AS RL_66, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '67' THEN 1 ELSE 0 END) AS RL_67, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss IN ( ( '72' ), ( '73' ), ( '74' ), ( '76' ), ( '77' ) ) THEN 1 ELSE 0 END) AS RL_70, --( '78' ) was removed as per Catherine's request on 2024-04-17
Sum (CASE WHEN Cast(SITAF.rl_rsn_for_loss AS STRING) LIKE ((( '7%' ))) AND SITAF.rl_rsn_for_loss NOT IN ( ( '72' ), ( '73' ), ( '74' ), ( '76' ) , ( '77' ) ) THEN 1 ELSE 0 END) AS ERROR_70, --( '78' ) was removed as per Catherine's request on 2024-04-17
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '72' THEN 1 ELSE 0 END) AS RL_72, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '73' THEN 1 ELSE 0 END) AS RL_73, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '74' THEN 1 ELSE 0 END) AS RL_74, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '76' THEN 1 ELSE 0 END) AS RL_76, 
Sum (CASE WHEN SITAF.rl_rsn_for_loss = '77' THEN 1 ELSE 0 END) AS RL_77, 
 --Sum (CASE WHEN SITAF.rl_rsn_for_loss = '78' THEN 1 ELSE 0 END) AS RL_78, --( '78' ) was removed as per Catherine's request on 2024-04-17
Sum (CASE WHEN SITAF.rl_rsn_for_loss NOT IN ( ( '12' ), ( '16' ), ( '21' ), ( '22' ), ( '26' ), ( '31' ), ( '32' ), ( '41' ), ( '49' ), ( '53' ), ( '54' ), ( '56' ), ( '57' ), ( '62' ), ( '63' ), ( '65' ), ( '66' ), ( '67' ), ( '72' ), ( '73' ), ( '74' ), ( '76' ), ( '77' ) ) THEN 1 ELSE 0 END) AS RL_ERROR, --( '78' ) was removed as per Catherine's request on 2024-04-17
 Max (station_tgt) AS STATION_TARGET, Max (region_tgt) AS REGIONAL_TARGET, 
 Max (global_tgt) AS GLOBAL_TARGET, 
 Max (system_tgt) AS SYSTEM_TARGET, Max (fcst_files) AS TARGET_FILES, 
 Max (fcst_pax) AS BUDGETED_PAX, 
 Max (region_lvl) AS REPORT_LEVEL_2, 
 Max (region_sort) AS SORT_ORDER, 
 Max (global_lvl) AS REGION_LEVEL_3, 
 Max (global_sort) AS REGION_ORDER, 
 Max (CASE WHEN station_tgt IS NOT NULL THEN 1 ELSE 0 END) AS TARGET_FLAG 
 
 FROM (
	 SELECT L2.flight_orig_lcl_dte AS PAX_DATE, 
	 L2.leg_schd_orig AS PAX_DEP_STN, 
	 Sum (COALESCE(P3.tot_psgr_cnt, L2.pax_flwn_cnt, 0)) AS PAX_CNT, 
	 Max (TPS.station_tgt) AS STATION_TGT, 
	 Max (TPS.region_tgt) AS REGION_TGT, 
	 Max (TPS.global_tgt) AS GLOBAL_TGT, 
	 Max (TPS.system_tgt) AS SYSTEM_TGT, 
	 Max (TPS.fcst_files) AS FCST_FILES, 
	 Max (TPS.fcst_pax) AS FCST_PAX, 
	 Max (region_lvl) AS REGION_LVL , 
	 Max (region_sort) AS REGION_SORT, 
	 Max (global_lvl) AS GLOBAL_LVL , 
	 Max (global_sort) AS GLOBAL_SORT 
	 FROM pedw.leg_flown AS L2 
	 LEFT OUTER JOIN pedw.leg_flown_cabin AS P3 
	 ON ( L2.leg_id = P3.leg_id 
	 AND upper(trim(P3.sel_srce_cde)) IN ( ( 'C' ), ( 'D' ) ) ) 
	 LEFT OUTER JOIN pedw.leg_flown_cabin AS P4 
	 ON ( L2.leg_id = P4.leg_id AND Upper(Trim(P4.sel_srce_cde)) = Upper(Trim('F')) ) 
	 LEFT OUTER JOIN pedw_soc.ref_oprn_flight_range AS R 
	 ON ( Upper(Trim(L2.carrier_cde)) = Upper(Trim(R.carrier_cde)) 
	 AND ( L2.flight_num BETWEEN R.flight_rng_strt AND R.flight_rng_end ) 
	 AND ( L2.flight_orig_lcl_dte BETWEEN R.eff_from_dte AND R.eff_to_dte ) ) 
	 LEFT OUTER JOIN pedw_soc.targets_carrier_stn_pawob AS TPS 
	 ON ( TPS.target_year = Cast (To_varchar(L2.flight_orig_lcl_dte,'YYYY') AS CHAR(4)) 
	 AND TPS.target_month = Cast (To_varchar(L2.flight_orig_lcl_dte, 'MM') AS CHAR(2)) 
	 AND upper(trim(TPS.station)) = upper(trim(L2.leg_schd_orig ))) 
	 WHERE L2.leg_dvrt_ind IS NULL 
	 AND R.oprn_incl_flg = 1 
	 GROUP BY L2.flight_orig_lcl_dte, L2.leg_schd_orig
 ) AS T1 
 
 LEFT OUTER JOIN (
	 SELECT CASE WHEN SITAFX.fs_fault_stn IS NOT NULL THEN SITAFX.fs_fault_stn ELSE Substring (SITAFX.wtr_file_ref, 1, 3) END AS STATION, 
	 SITAFX.wtr_file_ref, SITAFX.rl_rsn_for_loss, 
	 PSGRF.flight_dte 
	 FROM pedw_bags_v.sita_file AS SITAFX 
	 LEFT OUTER JOIN pedw_bags_v.sita_file_psgr_flight_leg AS PSGRF 
		 ON ( upper(trim(SITAFX.wtr_file_ref)) = upper(trim(PSGRF.wtr_file_ref)) 
		 AND upper(trim(SITAFX.wtr_rec_typ)) = upper(trim(PSGRF.wtr_rec_typ)) 
		 AND SITAFX.wtr_crt_dte = PSGRF.wtr_crt_dte 
		 AND PSGRF.leg_seq_id = 1 ) 
	 WHERE Upper(Trim(SITAFX.wtr_rec_typ)) = Upper(Trim('AHL'))
	 ) AS SITAF 
	ON ( T1.pax_dep_stn = station AND T1.pax_date = Cast (flight_dte AS DATE) ) 
 GROUP BY pax_date, pax_dep_stn;
