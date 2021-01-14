SELECT 
   sch_year
   ,progrs_schdul_cd
   ,count(sch_reprsnt_cd) AS total_cnt
   ,sum(decode(clos_yn, 'Y', 1, 0)) AS clos_y_co
   ,sum(decode(clos_yn, 'N', 1, 0)) AS clos_n_co
FROM  vw_cls
WHERE clos_odr_rnum = 1
AND clos_cancl_sn_rnum =1
GROUP BY sch_year, progrs_schdul_cd