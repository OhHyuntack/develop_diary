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


SELECT 
	MAX(QUE_01)    AS QUE_01
	, MAX(QUE_02)  AS QUE_02
	, MAX(QUE_03)  AS QUE_03
	, MAX(QUE_04)  AS QUE_04
	, MAX(QUE_05)  AS QUE_05
	, MAX(QUE_06)  AS QUE_06
	, MAX(QUE_07)  AS QUE_07
	, MAX(QUE_08)  AS QUE_08
	, MAX(QUE_09)  AS QUE_09
	, MAX(ANS_01)  AS ANS_01
	, MAX(ANS_02)  AS ANS_02
	, MAX(ANS_03)  AS ANS_03
	, MAX(ANS_04)  AS ANS_04
	, MAX(ANS_05)  AS ANS_05
	, MAX(ANS_06)  AS ANS_06
	, MAX(ANS_07)  AS ANS_07
	, MAX(ANS_08)  AS ANS_08
	, MAX(ANS_09)  AS ANS_09
FROM
	(
	SELECT 
		CASE WHEN a.edc_evl_cd = '10' THEN QUE ELSE NULL END AS QUE_01
		, CASE WHEN a.edc_evl_cd = '20' THEN QUE ELSE NULL END AS QUE_02
		, CASE WHEN a.edc_evl_cd = '30' THEN QUE ELSE NULL END AS QUE_03
		, CASE WHEN a.edc_evl_cd = '40' THEN QUE ELSE NULL END AS QUE_04
		, CASE WHEN a.edc_evl_cd = '50' THEN QUE ELSE NULL END AS QUE_05
		, CASE WHEN a.edc_evl_cd = '60' THEN QUE ELSE NULL END AS QUE_06
		, CASE WHEN a.edc_evl_cd = '70' THEN QUE ELSE NULL END AS QUE_07
		, CASE WHEN a.edc_evl_cd = '80' THEN QUE ELSE NULL END AS QUE_08
		, CASE WHEN a.edc_evl_cd = '90' THEN QUE ELSE NULL END AS QUE_09
		, CASE WHEN a.edc_evl_cd = '10' THEN edc_evl_ans_cn ELSE NULL END AS ANS_01
		, CASE WHEN a.edc_evl_cd = '20' THEN edc_evl_ans_cn ELSE NULL END AS ANS_02
		, CASE WHEN a.edc_evl_cd = '30' THEN edc_evl_ans_cn ELSE NULL END AS ANS_03
		, CASE WHEN a.edc_evl_cd = '40' THEN edc_evl_ans_cn ELSE NULL END AS ANS_04
		, CASE WHEN a.edc_evl_cd = '50' THEN edc_evl_ans_cn ELSE NULL END AS ANS_05
		, CASE WHEN a.edc_evl_cd = '60' THEN edc_evl_ans_cn ELSE NULL END AS ANS_06
		, CASE WHEN a.edc_evl_cd = '70' THEN edc_evl_ans_cn ELSE NULL END AS ANS_07
		, CASE WHEN a.edc_evl_cd = '80' THEN edc_evl_ans_cn ELSE NULL END AS ANS_08
		, CASE WHEN a.edc_evl_cd = '90' THEN edc_evl_ans_cn ELSE NULL END AS ANS_09
	FROM 
		(
		SELECT 
			*
			, (SELECT MAX(cd_nm) from com_cmmn_cd ccd WHERE cd_grp = 'USIS86' AND teree.edc_evl_cd = ccd.cd) AS QUE
		FROM trn_edc_rstrpt_edc_evl teree
		WHERE teree.sch_year = '2020'
			AND teree.univ_cd = '0000063'
			AND teree.edc_sn = '9'
		) a
	) aa	