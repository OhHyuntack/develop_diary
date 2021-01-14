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
	
	---------------------------------------------------------------------------------------------------------------------------
	CASE WHEN a.atnlc_usr_se_cd = '1' AND b.writng_sttus_cd = '30' THEN '작성' END AS trn_edc_rstrpt_btn,[b테이블에 없는 학교일경우 null]
	
			         (
		            /* 해당 교육의 수강자들이 모두 수료증발급번호가 지정되어있을때 발급가능(Y) */
					/*수정 : 해당 교육 학교 수류증발급번호 지정되었을경우 Y*/
		            SELECT CASE WHEN COUNT(1) > 0 THEN 'Y' ELSE 'N' END
		            FROM (
		               SELECT sch_year, edc_sn, univ_cd, ctfhv_issu_no
		               FROM trn_univ_edact_ldr where ctfhv_issu_no is not null  --[발급번호가 부여된 항목만 (지도자)]
		               UNION ALL												--[지도자, 학생 테이블 유니온 합친 데이터]
		               SELECT sch_year, edc_sn, univ_cd, ctfhv_issu_no
		               FROM trn_univ_edact_stdat                                
		               WHERE sch_year = a.sch_year  --[년도 조인]
		               AND edc_sn = a.edc_sn     --[강좌 조인]
		               AND univ_cd = b.univ_cd  --[학교 조인]
		               AND ctfhv_issu_no is not null   --[발급번호 부여된항목만(학생)]
		            ) a
	
   FROM trn_edc_schdul_mng a  /*[기준 테이블을 어떤걸 잡을것인가 ?(강좌테이블)]*/
		         INNER JOIN com_univ univ        /*[(학교많음)]*/
		         ON a.sch_year = univ.sch_year    /*[(모든학교 년도만 조인함)]*/
				 --------------------- 기준 ------------------------
		         LEFT OUTER JOIN trn_univ_edact b  /*[(해당 테이블 조인)]*/
		            ON a.sch_year = b.sch_year 
		            AND a.edc_sn = b.edc_sn 
		            AND b.sch_year = univ.sch_year
		            AND b.univ_cd = univ.univ_cd