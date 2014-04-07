-- MySQL dump 10.13  Distrib 5.5.35, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: oscar_12_reference_opthalmology_enhanced
-- ------------------------------------------------------
-- Server version	5.5.35-0+wheezy1-log
CREATE TABLE billingperclimit (
  service_code varchar(10) NOT NULL ,
  min varchar(8) default '0',
  max varchar(8) default '0',
  effective_date date default '1970-01-01',
  id int auto_increment,
  PRIMARY KEY  (id)
) ;



create table labReportInformation(
  id  int(10) NOT NULL auto_increment primary key,
  location_id  varchar(255),
  print_date varchar(10),
  print_time varchar(10),
  total_BType varchar(5),
  total_CType varchar(5),
  total_DType  varchar(5)
);

create table labPatientPhysicianInfo(
  id int(10) NOT NULL auto_increment primary key,
  labReportInfo_id int(10),
  accession_num varchar(64),
  physician_account_num varchar(30),
  service_date varchar(10),
  patient_first_name varchar(100),
  patient_last_name varchar(100),
  patient_sex char(1),
  patient_health_num varchar(20),
  patient_dob varchar(15),
  lab_status char(1),
  doc_num varchar(50),
  doc_name varchar(100),
  doc_addr1 varchar(100),
  doc_addr2 varchar(100),
  doc_addr3 varchar(100),
  doc_postal varchar(15),
  doc_route varchar(50),
  comment1 text,
  comment2 text,
  patient_phone varchar(20),
  doc_phone varchar(20),
  collection_date varchar(20),
  lastUpdateDate datetime not null
);

create table labTestResults(
  id int(10) NOT NULL auto_increment primary key,
  labPatientPhysicianInfo_id int(10),
  line_type char (1),
  title varchar(255),
  notUsed1 varchar(255),
  notUsed2 varchar(255),
  test_name varchar(255),
  abn char(1),
  minimum varchar(65),
  maximum varchar(65),
  units varchar(65),
  result varchar(65),
  description text,
  location_id  varchar(255),
  last char(1)
);

CREATE TABLE formONAR(
  ID int(10) NOT NULL  auto_increment,
  demographic_no int(10) NOT NULL default '0',
  provider_no int(10)  default NULL,
  formCreated date  default NULL,
  formEdited timestamp,
  c_lastName varchar(80),
  c_firstName varchar(80),
  c_address varchar(80),
  c_apt varchar(20),
  c_city varchar(80),
  c_province varchar(80),
  c_postal varchar(10),
  c_partnerLastName varchar(80),
  c_partnerFirstName varchar(80),
  pg1_homePhone varchar(20),
  pg1_workPhone varchar(20),
  pg1_language varchar(25),
  pg1_partnerOccupation varchar(25),
  pg1_partnerEduLevel varchar(25),
  pg1_partnerAge varchar(5),
  pg1_dateOfBirth date,
  pg1_age varchar(10),
  pg1_occupation varchar(25),
  pg1_eduLevel varchar(25),
  pg1_ethnicBg varchar(200),
  c_hin varchar(20),
  c_fileNo varchar(20),
  pg1_msSingle tinyint(1) default NULL,
  pg1_msCommonLaw tinyint(1) default NULL,
  pg1_msMarried tinyint(1) default NULL,
  pg1_baObs tinyint(1) default NULL,
  pg1_baFP tinyint(1) default NULL,
  pg1_baMidwife tinyint(1) default NULL,
  c_ba varchar(25) default NULL,
  pg1_ncPed tinyint(1) default NULL,
  pg1_ncFP tinyint(1) default NULL,
  pg1_ncMidwife tinyint(1) default NULL,
  c_nc varchar(25) default NULL,
  c_famPhys varchar(80) default NULL,
  c_allergies text,
  c_meds text,
  pg1_menLMP date,
  pg1_psCertY tinyint(1),
  pg1_psCertN tinyint(1),
  pg1_menCycle varchar(7),
  pg1_menReg tinyint(1),
  pg1_menRegN tinyint(1),
  pg1_contracep varchar(25),
  pg1_lastUsed date,
  pg1_menEDB date,
  c_finalEDB date,
  pg1_edbByDate tinyint(1),
  pg1_edbByT1 tinyint(1),
  pg1_edbByT2 tinyint(1),
  pg1_edbByART tinyint(1),
  c_gravida varchar(3) default NULL,
  c_term varchar(3) default NULL,
  c_prem varchar(3) default NULL,
  c_abort varchar(3) default NULL,
  c_living varchar(3) default NULL,

  pg1_year1 varchar(10) default NULL,
  pg1_sex1 char(1) default NULL,
  pg1_oh_gest1 varchar(5) default NULL,
  pg1_weight1 varchar(6) default NULL,
  pg1_length1 varchar(6) default NULL,
  pg1_place1 varchar(20) default NULL,
  pg1_svb1 tinyint(1) default NULL,
  pg1_cs1 tinyint(1) default NULL,
  pg1_ass1 tinyint(1) default NULL,
  pg1_oh_comments1 varchar(80) default NULL,
  pg1_year2 varchar(10) default NULL,
  pg1_sex2 char(1) default NULL,
  pg1_oh_gest2 varchar(5) default NULL,
  pg1_weight2 varchar(6) default NULL,
  pg1_length2 varchar(6) default NULL,
  pg1_place2 varchar(20) default NULL,
  pg1_svb2 tinyint(1) default NULL,
  pg1_cs2 tinyint(1) default NULL,
  pg1_ass2 tinyint(1) default NULL,
  pg1_oh_comments2 varchar(80) default NULL,
  pg1_year3 varchar(10) default NULL,
  pg1_sex3 char(1) default NULL,
  pg1_oh_gest3 varchar(5) default NULL,
  pg1_weight3 varchar(6) default NULL,
  pg1_length3 varchar(6) default NULL,
  pg1_place3 varchar(20) default NULL,
  pg1_svb3 tinyint(1) default NULL,
  pg1_cs3 tinyint(1) default NULL,
  pg1_ass3 tinyint(1) default NULL,
  pg1_oh_comments3 varchar(80) default NULL,
  pg1_year4 varchar(10) default NULL,
  pg1_sex4 char(1) default NULL,
  pg1_oh_gest4 varchar(5) default NULL,
  pg1_weight4 varchar(6) default NULL,
  pg1_length4 varchar(6) default NULL,
  pg1_place4 varchar(20) default NULL,
  pg1_svb4 tinyint(1) default NULL,
  pg1_cs4 tinyint(1) default NULL,
  pg1_ass4 tinyint(1) default NULL,
  pg1_oh_comments4 varchar(80) default NULL,
  pg1_year5 varchar(10) default NULL,
  pg1_sex5 char(1) default NULL,
  pg1_oh_gest5 varchar(5) default NULL,
  pg1_weight5 varchar(6) default NULL,
  pg1_length5 varchar(6) default NULL,
  pg1_place5 varchar(20) default NULL,
  pg1_svb5 tinyint(1) default NULL,
  pg1_cs5 tinyint(1) default NULL,
  pg1_ass5 tinyint(1) default NULL,
  pg1_oh_comments5 varchar(80) default NULL,
  pg1_year6 varchar(10) default NULL,
  pg1_sex6 char(1) default NULL,
  pg1_oh_gest6 varchar(5) default NULL,
  pg1_weight6 varchar(6) default NULL,
  pg1_length6 varchar(6) default NULL,
  pg1_place6 varchar(20) default NULL,
  pg1_svb6 tinyint(1) default NULL,
  pg1_cs6 tinyint(1) default NULL,
  pg1_ass6 tinyint(1) default NULL,
  pg1_oh_comments6 varchar(80) default NULL,
  pg1_cp1 tinyint(1) default NULL,
  pg1_cp1N tinyint(1) default NULL,
  pg1_cp2 tinyint(1) default NULL,
  pg1_cp2N tinyint(1) default NULL,
  pg1_box3 varchar(3) default NULL,
  pg1_cp3 tinyint(1) default NULL,
  pg1_cp3N tinyint(1) default NULL,
  pg1_cp4 tinyint(1) default NULL,
  pg1_cp4N tinyint(1) default NULL,
  pg1_cp8 tinyint(1) default NULL,
  pg1_cp8N tinyint(1) default NULL,
  pg1_naDietRes tinyint(1) default NULL,
  pg1_naDietBal tinyint(1) default NULL,
  pg1_naMilk tinyint(1) default NULL,
  pg1_naMilkN tinyint(1) default NULL,
  pg1_naFolic tinyint(1) default NULL,
  pg1_naFolicN tinyint(1) default NULL,
  pg1_yes9 tinyint(1) default NULL,
  pg1_no9 tinyint(1) default NULL,
  pg1_yes10 tinyint(1) default NULL,
  pg1_no10 tinyint(1) default NULL,
  pg1_yes12 tinyint(1) default NULL,
  pg1_no12 tinyint(1) default NULL,
  pg1_yes13 tinyint(1) default NULL,
  pg1_no13 tinyint(1) default NULL,
  pg1_yes14 tinyint(1) default NULL,
  pg1_no14 tinyint(1) default NULL,
  pg1_yes17 tinyint(1) default NULL,
  pg1_no17 tinyint(1) default NULL,
  pg1_yes22 tinyint(1) default NULL,
  pg1_no22 tinyint(1) default NULL,
  pg1_yes20 tinyint(1) default NULL,
  pg1_no20 tinyint(1) default NULL,
  pg1_bloodTranY tinyint(1) default NULL,
  pg1_bloodTranN tinyint(1) default NULL,
  pg1_yes21 tinyint(1) default NULL,
  pg1_no21 tinyint(1) default NULL,
  pg1_yes24 tinyint(1) default NULL,
  pg1_no24 tinyint(1) default NULL,
  pg1_yes15 tinyint(1) default NULL,
  pg1_no15 tinyint(1) default NULL,
  pg1_box25  varchar(25) default NULL,
  pg1_yes25 tinyint(1) default NULL,
  pg1_no25 tinyint(1) default NULL,
  pg1_yes27 tinyint(1) default NULL,
  pg1_no27 tinyint(1) default NULL,
  pg1_yes31 tinyint(1) default NULL,
  pg1_no31 tinyint(1) default NULL,
  pg1_yes32 tinyint(1) default NULL,
  pg1_no32 tinyint(1) default NULL,
  pg1_yes34 tinyint(1) default NULL,
  pg1_no34 tinyint(1) default NULL,
  pg1_yes35 tinyint(1) default NULL,
  pg1_no35 tinyint(1) default NULL,
  pg1_idt40 tinyint(1) default NULL,
  pg1_idt40N tinyint(1) default NULL,
  pg1_idt38 tinyint(1) default NULL,
  pg1_idt38N tinyint(1) default NULL,
  pg1_idt42 tinyint(1) default NULL,
  pg1_idt42N tinyint(1) default NULL,
  pg1_infectDisOther varchar(20) default NULL,
  pg1_infectDisOtherY tinyint(1) default NULL,
  pg1_infectDisOtherN tinyint(1) default NULL,
  pg1_pdt43 tinyint(1) default NULL,
  pg1_pdt43N tinyint(1) default NULL,
  pg1_pdt44 tinyint(1) default NULL,
  pg1_pdt44N tinyint(1) default NULL,
  pg1_pdt45 tinyint(1) default NULL,
  pg1_pdt45N tinyint(1) default NULL,
  pg1_pdt46 tinyint(1) default NULL,
  pg1_pdt46N tinyint(1) default NULL,
  pg1_pdt47 tinyint(1) default NULL,
  pg1_pdt47N tinyint(1) default NULL,
  pg1_pdt48 tinyint(1) default NULL,
  pg1_pdt48N tinyint(1) default NULL,
  pg1_reliCultY tinyint(1) default NULL,
  pg1_reliCultN tinyint(1) default NULL,
  pg1_fhRiskY tinyint(1) default NULL,
  pg1_fhRiskN tinyint(1) default NULL,
  pg1_ht varchar(6) default NULL,
  pg1_wt varchar(6) default NULL,
  c_bmi varchar(6) default NULL,
  pg1_BP varchar(10) default NULL,
  pg1_thyroid tinyint(1) default NULL,
  pg1_thyroidA tinyint(1) default NULL,
  pg1_chest tinyint(1) default NULL,
  pg1_chestA tinyint(1) default NULL,
  pg1_breasts tinyint(1) default NULL,
  pg1_breastsA tinyint(1) default NULL,
  pg1_cardio tinyint(1) default NULL,
  pg1_cardioA tinyint(1) default NULL,
  pg1_abdomen tinyint(1) default NULL,
  pg1_abdomenA tinyint(1) default NULL,
  pg1_vari tinyint(1) default NULL,
  pg1_variA tinyint(1) default NULL,
  pg1_extGen tinyint(1) default NULL,
  pg1_extGenA tinyint(1) default NULL,
  pg1_cervix tinyint(1) default NULL,
  pg1_cervixA tinyint(1) default NULL,
  pg1_uterus tinyint(1) default NULL,
  pg1_uterusA tinyint(1) default NULL,
  pg1_uterusBox varchar(3) default NULL,
  pg1_adnexa tinyint(1) default NULL,
  pg1_adnexaA tinyint(1) default NULL,
  pg1_pExOther varchar(20) default NULL,
  pg1_pExOtherN tinyint(1) default NULL,
  pg1_pExOtherA tinyint(1) default NULL,

  pg1_labHb varchar(20) default NULL,
  pg1_labHIV varchar(20) default NULL,
  pg1_labMCV varchar(20) default NULL,
  pg1_labHIVCounsel tinyint(1) default NULL,
  pg1_labABO varchar(20) default NULL,
  pg1_labLastPapDate varchar(10) default NULL,
  pg1_labLastPap varchar(20) default NULL,

  pg1_labRh varchar(20) default NULL,
  pg1_labAntiScr varchar(20) default NULL,
  pg1_labGC varchar(20) default NULL,
  pg1_labRubella varchar(20) default NULL,
  pg1_labUrine varchar(20) default NULL,
  pg1_labHBsAg varchar(20) default NULL,
  pg1_labVDRL varchar(20) default NULL,
  pg1_labSickle varchar(20) default NULL,
  pg1_geneticA varchar(20) default NULL,
  pg1_geneticB varchar(20) default NULL,
  pg1_geneticC varchar(20) default NULL,
  pg1_geneticD tinyint(1) default NULL,
  pg1_commentsAR1 text,
  pg1_signature varchar(50) default NULL,
  pg1_formDate date default NULL,
  pg1_signature2 varchar(50) default NULL,
  pg1_formDate2 date default NULL,
  
  c_riskFactors1 varchar(50) default NULL,
  c_planManage1 varchar(100) default NULL,
  c_riskFactors2 varchar(50) default NULL,
  c_planManage2 varchar(100) default NULL,
  c_riskFactors3 varchar(50) default NULL,
  c_planManage3 varchar(100) default NULL,
  c_riskFactors4 varchar(50) default NULL,
  c_planManage4 varchar(100) default NULL,
  c_riskFactors5 varchar(50) default NULL,
  c_planManage5 varchar(100) default NULL,
  c_riskFactors6 varchar(50) default NULL,
  c_planManage6 varchar(100) default NULL,
  c_riskFactors7 varchar(50) default NULL,
  c_planManage7 varchar(100) default NULL,
  ar2_rhNeg tinyint(1) default NULL,
  ar2_rhIG varchar(10) default NULL,
  ar2_rubella tinyint(1) default NULL,
  ar2_hepBIG tinyint(1) default NULL,
  ar2_hepBVac tinyint(1) default NULL,
  pg2_date1 date default NULL,
  pg2_gest1 varchar(6) default NULL,
  pg2_wt1 varchar(6) default NULL,
  pg2_BP1 varchar(8) default NULL,
  pg2_urinePr1 char(3) default NULL,
  pg2_urineGl1 char(3) default NULL,
  pg2_ht1 varchar(6) default NULL,
  pg2_presn1 varchar(6) default NULL,
  pg2_FHR1 varchar(6) default NULL,
  pg2_comments1 varchar(255) default NULL,
  pg2_date2 date default NULL,
  pg2_gest2 varchar(6) default NULL,
  pg2_ht2 varchar(6) default NULL,
  pg2_wt2 varchar(6) default NULL,
  pg2_presn2 varchar(6) default NULL,
  pg2_FHR2 varchar(6) default NULL,
  pg2_urinePr2 char(3) default NULL,
  pg2_urineGl2 char(3) default NULL,
  pg2_BP2 varchar(8) default NULL,
  pg2_comments2 varchar(255) default NULL,
  pg2_date3 date default NULL,
  pg2_gest3 varchar(6) default NULL,
  pg2_ht3 varchar(6) default NULL,
  pg2_wt3 varchar(6) default NULL,
  pg2_presn3 varchar(6) default NULL,
  pg2_FHR3 varchar(6) default NULL,
  pg2_urinePr3 char(3) default NULL,
  pg2_urineGl3 char(3) default NULL,
  pg2_BP3 varchar(8) default NULL,
  pg2_comments3 varchar(255) default NULL,
  pg2_date4 date default NULL,
  pg2_gest4 varchar(6) default NULL,
  pg2_ht4 varchar(6) default NULL,
  pg2_wt4 varchar(6) default NULL,
  pg2_presn4 varchar(6) default NULL,
  pg2_FHR4 varchar(6) default NULL,
  pg2_urinePr4 char(3) default NULL,
  pg2_urineGl4 char(3) default NULL,
  pg2_BP4 varchar(8) default NULL,
  pg2_comments4 varchar(255) default NULL,
  pg2_date5 date default NULL,
  pg2_gest5 varchar(6) default NULL,
  pg2_ht5 varchar(6) default NULL,
  pg2_wt5 varchar(6) default NULL,
  pg2_presn5 varchar(6) default NULL,
  pg2_FHR5 varchar(6) default NULL,
  pg2_urinePr5 char(3) default NULL,
  pg2_urineGl5 char(3) default NULL,
  pg2_BP5 varchar(8) default NULL,
  pg2_comments5 varchar(255) default NULL,
  pg2_date6 date default NULL,
  pg2_gest6 varchar(6) default NULL,
  pg2_ht6 varchar(6) default NULL,
  pg2_wt6 varchar(6) default NULL,
  pg2_presn6 varchar(6) default NULL,
  pg2_FHR6 varchar(6) default NULL,
  pg2_urinePr6 char(3) default NULL,
  pg2_urineGl6 char(3) default NULL,
  pg2_BP6 varchar(8) default NULL,
  pg2_comments6 varchar(255) default NULL,
  pg2_date7 date default NULL,
  pg2_gest7 varchar(6) default NULL,
  pg2_ht7 varchar(6) default NULL,
  pg2_wt7 varchar(6) default NULL,
  pg2_presn7 varchar(6) default NULL,
  pg2_FHR7 varchar(6) default NULL,
  pg2_urinePr7 char(3) default NULL,
  pg2_urineGl7 char(3) default NULL,
  pg2_BP7 varchar(8) default NULL,
  pg2_comments7 varchar(255) default NULL,
  pg2_date8 date default NULL,
  pg2_gest8 varchar(6) default NULL,
  pg2_ht8 varchar(6) default NULL,
  pg2_wt8 varchar(6) default NULL,
  pg2_presn8 varchar(6) default NULL,
  pg2_FHR8 varchar(6) default NULL,
  pg2_urinePr8 char(3) default NULL,
  pg2_urineGl8 char(3) default NULL,
  pg2_BP8 varchar(8) default NULL,
  pg2_comments8 varchar(255) default NULL,
  pg2_date9 date default NULL,
  pg2_gest9 varchar(6) default NULL,
  pg2_ht9 varchar(6) default NULL,
  pg2_wt9 varchar(6) default NULL,
  pg2_presn9 varchar(6) default NULL,
  pg2_FHR9 varchar(6) default NULL,
  pg2_urinePr9 char(3) default NULL,
  pg2_urineGl9 char(3) default NULL,
  pg2_BP9 varchar(8) default NULL,
  pg2_comments9 varchar(255) default NULL,
  pg2_date10 date default NULL,
  pg2_gest10 varchar(6) default NULL,
  pg2_ht10 varchar(6) default NULL,
  pg2_wt10 varchar(6) default NULL,
  pg2_presn10 varchar(6) default NULL,
  pg2_FHR10 varchar(6) default NULL,
  pg2_urinePr10 char(3) default NULL,
  pg2_urineGl10 char(3) default NULL,
  pg2_BP10 varchar(8) default NULL,
  pg2_comments10 varchar(255) default NULL,
  pg2_date11 date default NULL,
  pg2_gest11 varchar(6) default NULL,
  pg2_ht11 varchar(6) default NULL,
  pg2_wt11 varchar(6) default NULL,
  pg2_presn11 varchar(6) default NULL,
  pg2_FHR11 varchar(6) default NULL,
  pg2_urinePr11 char(3) default NULL,
  pg2_urineGl11 char(3) default NULL,
  pg2_BP11 varchar(8) default NULL,
  pg2_comments11 varchar(255) default NULL,
  pg2_date12 date default NULL,
  pg2_gest12 varchar(6) default NULL,
  pg2_ht12 varchar(6) default NULL,
  pg2_wt12 varchar(6) default NULL,
  pg2_presn12 varchar(6) default NULL,
  pg2_FHR12 varchar(6) default NULL,
  pg2_urinePr12 char(3) default NULL,
  pg2_urineGl12 char(3) default NULL,
  pg2_BP12 varchar(8) default NULL,
  pg2_comments12 varchar(255) default NULL,
  pg2_date13 date default NULL,
  pg2_gest13 varchar(6) default NULL,
  pg2_ht13 varchar(6) default NULL,
  pg2_wt13 varchar(6) default NULL,
  pg2_presn13 varchar(6) default NULL,
  pg2_FHR13 varchar(6) default NULL,
  pg2_urinePr13 char(3) default NULL,
  pg2_urineGl13 char(3) default NULL,
  pg2_BP13 varchar(8) default NULL,
  pg2_comments13 varchar(255) default NULL,
  pg2_date14 date default NULL,
  pg2_gest14 varchar(6) default NULL,
  pg2_ht14 varchar(6) default NULL,
  pg2_wt14 varchar(6) default NULL,
  pg2_presn14 varchar(6) default NULL,
  pg2_FHR14 varchar(6) default NULL,
  pg2_urinePr14 char(3) default NULL,
  pg2_urineGl14 char(3) default NULL,
  pg2_BP14 varchar(8) default NULL,
  pg2_comments14 varchar(255) default NULL,
  pg2_date15 date default NULL,
  pg2_gest15 varchar(6) default NULL,
  pg2_ht15 varchar(6) default NULL,
  pg2_wt15 varchar(6) default NULL,
  pg2_presn15 varchar(6) default NULL,
  pg2_FHR15 varchar(6) default NULL,
  pg2_urinePr15 char(3) default NULL,
  pg2_urineGl15 char(3) default NULL,
  pg2_BP15 varchar(8) default NULL,
  pg2_comments15 varchar(255) default NULL,
  pg2_date16 date default NULL,
  pg2_gest16 varchar(6) default NULL,
  pg2_ht16 varchar(6) default NULL,
  pg2_wt16 varchar(6) default NULL,
  pg2_presn16 varchar(6) default NULL,
  pg2_FHR16 varchar(6) default NULL,
  pg2_urinePr16 char(3) default NULL,
  pg2_urineGl16 char(3) default NULL,
  pg2_BP16 varchar(8) default NULL,
  pg2_comments16 varchar(255) default NULL,
  pg2_date17 date default NULL,
  pg2_gest17 varchar(6) default NULL,
  pg2_ht17 varchar(6) default NULL,
  pg2_wt17 varchar(6) default NULL,
  pg2_presn17 varchar(6) default NULL,
  pg2_FHR17 varchar(6) default NULL,
  pg2_urinePr17 char(3) default NULL,
  pg2_urineGl17 char(3) default NULL,
  pg2_BP17 varchar(8) default NULL,
  pg2_comments17 varchar(255) default NULL,
  pg2_date18 date default NULL,
  pg2_gest18 varchar(6) default NULL,
  pg2_ht18 varchar(6) default NULL,
  pg2_wt18 varchar(6) default NULL,
  pg2_presn18 varchar(6) default NULL,
  pg2_FHR18 varchar(6) default NULL,
  pg2_urinePr18 char(3) default NULL,
  pg2_urineGl18 char(3) default NULL,
  pg2_BP18 varchar(8) default NULL,
  pg2_comments18 varchar(255) default NULL,
  pg3_date19 date default NULL,
  pg3_gest19 varchar(6) default NULL,
  pg3_ht19 varchar(6) default NULL,
  pg3_wt19 varchar(6) default NULL,
  pg3_presn19 varchar(6) default NULL,
  pg3_FHR19 varchar(6) default NULL,
  pg3_urinePr19 char(3) default NULL,
  pg3_urineGl19 char(3) default NULL,
  pg3_BP19 varchar(8) default NULL,
  pg3_comments19 varchar(255) default NULL,
  pg3_date20 date default NULL,
  pg3_gest20 varchar(6) default NULL,
  pg3_ht20 varchar(6) default NULL,
  pg3_wt20 varchar(6) default NULL,
  pg3_presn20 varchar(6) default NULL,
  pg3_FHR20 varchar(6) default NULL,
  pg3_urinePr20 char(3) default NULL,
  pg3_urineGl20 char(3) default NULL,
  pg3_BP20 varchar(8) default NULL,
  pg3_comments20 varchar(255) default NULL,
  pg3_date21 date default NULL,
  pg3_gest21 varchar(6) default NULL,
  pg3_ht21 varchar(6) default NULL,
  pg3_wt21 varchar(6) default NULL,
  pg3_presn21 varchar(6) default NULL,
  pg3_FHR21 varchar(6) default NULL,
  pg3_urinePr21 char(3) default NULL,
  pg3_urineGl21 char(3) default NULL,
  pg3_BP21 varchar(8) default NULL,
  pg3_comments21 varchar(255) default NULL,
  pg3_date22 date default NULL,
  pg3_gest22 varchar(6) default NULL,
  pg3_ht22 varchar(6) default NULL,
  pg3_wt22 varchar(6) default NULL,
  pg3_presn22 varchar(6) default NULL,
  pg3_FHR22 varchar(6) default NULL,
  pg3_urinePr22 char(3) default NULL,
  pg3_urineGl22 char(3) default NULL,
  pg3_BP22 varchar(8) default NULL,
  pg3_comments22 varchar(255) default NULL,
  pg3_date23 date default NULL,
  pg3_gest23 varchar(6) default NULL,
  pg3_ht23 varchar(6) default NULL,
  pg3_wt23 varchar(6) default NULL,
  pg3_presn23 varchar(6) default NULL,
  pg3_FHR23 varchar(6) default NULL,
  pg3_urinePr23 char(3) default NULL,
  pg3_urineGl23 char(3) default NULL,
  pg3_BP23 varchar(8) default NULL,
  pg3_comments23 varchar(255) default NULL,
  pg3_date24 date default NULL,
  pg3_gest24 varchar(6) default NULL,
  pg3_ht24 varchar(6) default NULL,
  pg3_wt24 varchar(6) default NULL,
  pg3_presn24 varchar(6) default NULL,
  pg3_FHR24 varchar(6) default NULL,
  pg3_urinePr24 char(3) default NULL,
  pg3_urineGl24 char(3) default NULL,
  pg3_BP24 varchar(8) default NULL,
  pg3_comments24 varchar(255) default NULL,
  pg3_date25 date default NULL,
  pg3_gest25 varchar(6) default NULL,
  pg3_ht25 varchar(6) default NULL,
  pg3_wt25 varchar(6) default NULL,
  pg3_presn25 varchar(6) default NULL,
  pg3_FHR25 varchar(6) default NULL,
  pg3_urinePr25 char(3) default NULL,
  pg3_urineGl25 char(3) default NULL,
  pg3_BP25 varchar(8) default NULL,
  pg3_comments25 varchar(255) default NULL,
  pg3_date26 date default NULL,
  pg3_gest26 varchar(6) default NULL,
  pg3_ht26 varchar(6) default NULL,
  pg3_wt26 varchar(6) default NULL,
  pg3_presn26 varchar(6) default NULL,
  pg3_FHR26 varchar(6) default NULL,
  pg3_urinePr26 char(3) default NULL,
  pg3_urineGl26 char(3) default NULL,
  pg3_BP26 varchar(8) default NULL,
  pg3_comments26 varchar(255) default NULL,
  pg3_date27 date default NULL,
  pg3_gest27 varchar(6) default NULL,
  pg3_ht27 varchar(6) default NULL,
  pg3_wt27 varchar(6) default NULL,
  pg3_presn27 varchar(6) default NULL,
  pg3_FHR27 varchar(6) default NULL,
  pg3_urinePr27 char(3) default NULL,
  pg3_urineGl27 char(3) default NULL,
  pg3_BP27 varchar(8) default NULL,
  pg3_comments27 varchar(255) default NULL,
  pg3_date28 date default NULL,
  pg3_gest28 varchar(6) default NULL,
  pg3_ht28 varchar(6) default NULL,
  pg3_wt28 varchar(6) default NULL,
  pg3_presn28 varchar(6) default NULL,
  pg3_FHR28 varchar(6) default NULL,
  pg3_urinePr28 char(3) default NULL,
  pg3_urineGl28 char(3) default NULL,
  pg3_BP28 varchar(8) default NULL,
  pg3_comments28 varchar(255) default NULL,
  pg3_date29 date default NULL,
  pg3_gest29 varchar(6) default NULL,
  pg3_ht29 varchar(6) default NULL,
  pg3_wt29 varchar(6) default NULL,
  pg3_presn29 varchar(6) default NULL,
  pg3_FHR29 varchar(6) default NULL,
  pg3_urinePr29 char(3) default NULL,
  pg3_urineGl29 char(3) default NULL,
  pg3_BP29 varchar(8) default NULL,
  pg3_comments29 varchar(255) default NULL,
  pg3_date30 date default NULL,
  pg3_gest30 varchar(6) default NULL,
  pg3_ht30 varchar(6) default NULL,
  pg3_wt30 varchar(6) default NULL,
  pg3_presn30 varchar(6) default NULL,
  pg3_FHR30 varchar(6) default NULL,
  pg3_urinePr30 char(3) default NULL,
  pg3_urineGl30 char(3) default NULL,
  pg3_BP30 varchar(8) default NULL,
  pg3_comments30 varchar(255) default NULL,
  pg3_date31 date default NULL,
  pg3_gest31 varchar(6) default NULL,
  pg3_ht31 varchar(6) default NULL,
  pg3_wt31 varchar(6) default NULL,
  pg3_presn31 varchar(6) default NULL,
  pg3_FHR31 varchar(6) default NULL,
  pg3_urinePr31 char(3) default NULL,
  pg3_urineGl31 char(3) default NULL,
  pg3_BP31 varchar(8) default NULL,
  pg3_comments31 varchar(255) default NULL,
  pg3_date32 date default NULL,
  pg3_gest32 varchar(6) default NULL,
  pg3_ht32 varchar(6) default NULL,
  pg3_wt32 varchar(6) default NULL,
  pg3_presn32 varchar(6) default NULL,
  pg3_FHR32 varchar(6) default NULL,
  pg3_urinePr32 char(3) default NULL,
  pg3_urineGl32 char(3) default NULL,
  pg3_BP32 varchar(8) default NULL,
  pg3_comments32 varchar(255) default NULL,
  pg3_date33 date default NULL,
  pg3_gest33 varchar(6) default NULL,
  pg3_ht33 varchar(6) default NULL,
  pg3_wt33 varchar(6) default NULL,
  pg3_presn33 varchar(6) default NULL,
  pg3_FHR33 varchar(6) default NULL,
  pg3_urinePr33 char(3) default NULL,
  pg3_urineGl33 char(3) default NULL,
  pg3_BP33 varchar(8) default NULL,
  pg3_comments33 varchar(255) default NULL,
  pg3_date34 date default NULL,
  pg3_gest34 varchar(6) default NULL,
  pg3_ht34 varchar(6) default NULL,
  pg3_wt34 varchar(6) default NULL,
  pg3_presn34 varchar(6) default NULL,
  pg3_FHR34 varchar(6) default NULL,
  pg3_urinePr34 char(3) default NULL,
  pg3_urineGl34 char(3) default NULL,
  pg3_BP34 varchar(8) default NULL,
  pg3_comments34 varchar(255) default NULL,
  pg3_date35 date default NULL,
  pg3_gest35 varchar(6) default NULL,
  pg3_ht35 varchar(6) default NULL,
  pg3_wt35 varchar(6) default NULL,
  pg3_presn35 varchar(6) default NULL,
  pg3_FHR35 varchar(6) default NULL,
  pg3_urinePr35 char(3) default NULL,
  pg3_urineGl35 char(3) default NULL,
  pg3_BP35 varchar(8) default NULL,
  pg3_comments35 varchar(255) default NULL,
  pg3_date36 date default NULL,
  pg3_gest36 varchar(6) default NULL,
  pg3_ht36 varchar(6) default NULL,
  pg3_wt36 varchar(6) default NULL,
  pg3_presn36 varchar(6) default NULL,
  pg3_FHR36 varchar(6) default NULL,
  pg3_urinePr36 char(3) default NULL,
  pg3_urineGl36 char(3) default NULL,
  pg3_BP36 varchar(8) default NULL,
  pg3_comments36 varchar(255) default NULL,
  pg4_date37 date default NULL,
  pg4_gest37 varchar(6) default NULL,
  pg4_ht37 varchar(6) default NULL,
  pg4_wt37 varchar(6) default NULL,
  pg4_presn37 varchar(6) default NULL,
  pg4_FHR37 varchar(6) default NULL,
  pg4_urinePr37 char(3) default NULL,
  pg4_urineGl37 char(3) default NULL,
  pg4_BP37 varchar(8) default NULL,
  pg4_comments37 varchar(255) default NULL,
  pg4_date38 date default NULL,
  pg4_gest38 varchar(6) default NULL,
  pg4_ht38 varchar(6) default NULL,
  pg4_wt38 varchar(6) default NULL,
  pg4_presn38 varchar(6) default NULL,
  pg4_FHR38 varchar(6) default NULL,
  pg4_urinePr38 char(3) default NULL,
  pg4_urineGl38 char(3) default NULL,
  pg4_BP38 varchar(8) default NULL,
  pg4_comments38 varchar(255) default NULL,
  pg4_date39 date default NULL,
  pg4_gest39 varchar(6) default NULL,
  pg4_ht39 varchar(6) default NULL,
  pg4_wt39 varchar(6) default NULL,
  pg4_presn39 varchar(6) default NULL,
  pg4_FHR39 varchar(6) default NULL,
  pg4_urinePr39 char(3) default NULL,
  pg4_urineGl39 char(3) default NULL,
  pg4_BP39 varchar(8) default NULL,
  pg4_comments39 varchar(255) default NULL,
  pg4_date40 date default NULL,
  pg4_gest40 varchar(6) default NULL,
  pg4_ht40 varchar(6) default NULL,
  pg4_wt40 varchar(6) default NULL,
  pg4_presn40 varchar(6) default NULL,
  pg4_FHR40 varchar(6) default NULL,
  pg4_urinePr40 char(3) default NULL,
  pg4_urineGl40 char(3) default NULL,
  pg4_BP40 varchar(8) default NULL,
  pg4_comments40 varchar(255) default NULL,
  pg4_date41 date default NULL,
  pg4_gest41 varchar(6) default NULL,
  pg4_ht41 varchar(6) default NULL,
  pg4_wt41 varchar(6) default NULL,
  pg4_presn41 varchar(6) default NULL,
  pg4_FHR41 varchar(6) default NULL,
  pg4_urinePr41 char(3) default NULL,
  pg4_urineGl41 char(3) default NULL,
  pg4_BP41 varchar(8) default NULL,
  pg4_comments41 varchar(255) default NULL,
  pg4_date42 date default NULL,
  pg4_gest42 varchar(6) default NULL,
  pg4_ht42 varchar(6) default NULL,
  pg4_wt42 varchar(6) default NULL,
  pg4_presn42 varchar(6) default NULL,
  pg4_FHR42 varchar(6) default NULL,
  pg4_urinePr42 char(3) default NULL,
  pg4_urineGl42 char(3) default NULL,
  pg4_BP42 varchar(8) default NULL,
  pg4_comments42 varchar(255) default NULL,
  pg4_date43 date default NULL,
  pg4_gest43 varchar(6) default NULL,
  pg4_ht43 varchar(6) default NULL,
  pg4_wt43 varchar(6) default NULL,
  pg4_presn43 varchar(6) default NULL,
  pg4_FHR43 varchar(6) default NULL,
  pg4_urinePr43 char(3) default NULL,
  pg4_urineGl43 char(3) default NULL,
  pg4_BP43 varchar(8) default NULL,
  pg4_comments43 varchar(255) default NULL,
  pg4_date44 date default NULL,
  pg4_gest44 varchar(6) default NULL,
  pg4_ht44 varchar(6) default NULL,
  pg4_wt44 varchar(6) default NULL,
  pg4_presn44 varchar(6) default NULL,
  pg4_FHR44 varchar(6) default NULL,
  pg4_urinePr44 char(3) default NULL,
  pg4_urineGl44 char(3) default NULL,
  pg4_BP44 varchar(8) default NULL,
  pg4_comments44 varchar(255) default NULL,
  pg4_date45 date default NULL,
  pg4_gest45 varchar(6) default NULL,
  pg4_ht45 varchar(6) default NULL,
  pg4_wt45 varchar(6) default NULL,
  pg4_presn45 varchar(6) default NULL,
  pg4_FHR45 varchar(6) default NULL,
  pg4_urinePr45 char(3) default NULL,
  pg4_urineGl45 char(3) default NULL,
  pg4_BP45 varchar(8) default NULL,
  pg4_comments45 varchar(255) default NULL,
  pg4_date46 date default NULL,
  pg4_gest46 varchar(6) default NULL,
  pg4_ht46 varchar(6) default NULL,
  pg4_wt46 varchar(6) default NULL,
  pg4_presn46 varchar(6) default NULL,
  pg4_FHR46 varchar(6) default NULL,
  pg4_urinePr46 char(3) default NULL,
  pg4_urineGl46 char(3) default NULL,
  pg4_BP46 varchar(8) default NULL,
  pg4_comments46 varchar(255) default NULL,
  pg4_date47 date default NULL,
  pg4_gest47 varchar(6) default NULL,
  pg4_ht47 varchar(6) default NULL,
  pg4_wt47 varchar(6) default NULL,
  pg4_presn47 varchar(6) default NULL,
  pg4_FHR47 varchar(6) default NULL,
  pg4_urinePr47 char(3) default NULL,
  pg4_urineGl47 char(3) default NULL,
  pg4_BP47 varchar(8) default NULL,
  pg4_comments47 varchar(255) default NULL,
  pg4_date48 date default NULL,
  pg4_gest48 varchar(6) default NULL,
  pg4_ht48 varchar(6) default NULL,
  pg4_wt48 varchar(6) default NULL,
  pg4_presn48 varchar(6) default NULL,
  pg4_FHR48 varchar(6) default NULL,
  pg4_urinePr48 char(3) default NULL,
  pg4_urineGl48 char(3) default NULL,
  pg4_BP48 varchar(8) default NULL,
  pg4_comments48 varchar(255) default NULL,
  pg4_date49 date default NULL,
  pg4_gest49 varchar(6) default NULL,
  pg4_ht49 varchar(6) default NULL,
  pg4_wt49 varchar(6) default NULL,
  pg4_presn49 varchar(6) default NULL,
  pg4_FHR49 varchar(6) default NULL,
  pg4_urinePr49 char(3) default NULL,
  pg4_urineGl49 char(3) default NULL,
  pg4_BP49 varchar(8) default NULL,
  pg4_comments49 varchar(255) default NULL,
  pg4_date50 date default NULL,
  pg4_gest50 varchar(6) default NULL,
  pg4_ht50 varchar(6) default NULL,
  pg4_wt50 varchar(6) default NULL,
  pg4_presn50 varchar(6) default NULL,
  pg4_FHR50 varchar(6) default NULL,
  pg4_urinePr50 char(3) default NULL,
  pg4_urineGl50 char(3) default NULL,
  pg4_BP50 varchar(8) default NULL,
  pg4_comments50 varchar(255) default NULL,
  pg4_date51 date default NULL,
  pg4_gest51 varchar(6) default NULL,
  pg4_ht51 varchar(6) default NULL,
  pg4_wt51 varchar(6) default NULL,
  pg4_presn51 varchar(6) default NULL,
  pg4_FHR51 varchar(6) default NULL,
  pg4_urinePr51 char(3) default NULL,
  pg4_urineGl51 char(3) default NULL,
  pg4_BP51 varchar(8) default NULL,
  pg4_comments51 varchar(255) default NULL,
  pg4_date52 date default NULL,
  pg4_gest52 varchar(6) default NULL,
  pg4_ht52 varchar(6) default NULL,
  pg4_wt52 varchar(6) default NULL,
  pg4_presn52 varchar(6) default NULL,
  pg4_FHR52 varchar(6) default NULL,
  pg4_urinePr52 char(3) default NULL,
  pg4_urineGl52 char(3) default NULL,
  pg4_BP52 varchar(8) default NULL,
  pg4_comments52 varchar(255) default NULL,
  pg4_date53 date default NULL,
  pg4_gest53 varchar(6) default NULL,
  pg4_ht53 varchar(6) default NULL,
  pg4_wt53 varchar(6) default NULL,
  pg4_presn53 varchar(6) default NULL,
  pg4_FHR53 varchar(6) default NULL,
  pg4_urinePr53 char(3) default NULL,
  pg4_urineGl53 char(3) default NULL,
  pg4_BP53 varchar(8) default NULL,
  pg4_comments53 varchar(255) default NULL,
  pg4_date54 date default NULL,
  pg4_gest54 varchar(6) default NULL,
  pg4_ht54 varchar(6) default NULL,
  pg4_wt54 varchar(6) default NULL,
  pg4_presn54 varchar(6) default NULL,
  pg4_FHR54 varchar(6) default NULL,
  pg4_urinePr54 char(3) default NULL,
  pg4_urineGl54 char(3) default NULL,
  pg4_BP54 varchar(8) default NULL,
  pg4_comments54 varchar(255) default NULL,
  ar2_uDate1 date,
  ar2_uGA1 varchar(10) default NULL,
  ar2_uResults1 varchar(50) default NULL,
  ar2_uDate2 date,
  ar2_uGA2 varchar(10) default NULL,
  ar2_uResults2 varchar(50) default NULL,
  ar2_uDate3 date,
  ar2_uGA3 varchar(10) default NULL,
  ar2_uResults3 varchar(50) default NULL,
  ar2_uDate4 date,
  ar2_uGA4 varchar(10) default NULL,
  ar2_uResults4 varchar(50) default NULL,
  ar2_hb varchar(10) default NULL,
  ar2_bloodGroup varchar(6) default NULL,
  ar2_rh varchar(6) default NULL,
  ar2_labABS varchar(10) default NULL,
  ar2_lab1GCT varchar(10) default NULL,
  ar2_lab2GTT varchar(10) default NULL,
  ar2_strep varchar(10) default NULL,
  ar2_exercise tinyint(1) default NULL,
  ar2_workPlan tinyint(1) default NULL,
  ar2_intercourse tinyint(1) default NULL,
  ar2_travel tinyint(1) default NULL,
  ar2_prenatal tinyint(1) default NULL,
  ar2_birth tinyint(1) default NULL,
  ar2_onCall tinyint(1) default NULL,
  ar2_preterm tinyint(1) default NULL,
  ar2_prom tinyint(1) default NULL,
  ar2_aph tinyint(1) default NULL,
  ar2_fetal tinyint(1) default NULL,
  ar2_admission tinyint(1) default NULL,
  ar2_pain tinyint(1) default NULL,
  ar2_labour tinyint(1) default NULL,
  ar2_breast tinyint(1) default NULL,
  ar2_circumcision tinyint(1) default NULL,
  ar2_dischargePlan tinyint(1) default NULL,
  ar2_car tinyint(1) default NULL,
  ar2_depression tinyint(1) default NULL,
  ar2_contraception tinyint(1) default NULL,
  ar2_postpartumCare tinyint(1) default NULL,
  pg2_signature varchar(50) default NULL,
  pg2_formDate date default NULL,
  pg2_signature2 varchar(50) default NULL,
  pg2_formDate2 date default NULL,
  pg3_signature varchar(50) default NULL,
  pg3_formDate date default NULL,
  pg3_signature2 varchar(50) default NULL,
  pg3_formDate2 date default NULL,
  pg4_signature varchar(50) default NULL,
  pg4_formDate date default NULL,
  pg4_signature2 varchar(50) default NULL,
  pg4_formDate2 date default NULL,
  
  pg1_labExtra1Name varchar(20),
  pg1_labExtra2Name varchar(20),
  pg1_labExtra3Name varchar(20),
  pg1_labExtra1Value varchar(20),
  pg1_labExtra2Value varchar(20),
  pg1_labExtra3Value varchar(20),
  pg1_commentsAR1_2 text,
  pg1_commentsAR1_3 text,
  pg1_commentsAR1_4 text,
  pg1_4ColCom tinyint(1),
  pg1_lockPage tinyint(1),
  
  pg2_labExtra1Name varchar(20),
  pg2_labExtra2Name varchar(20),
  pg2_labExtra3Name varchar(20),
  
  pg2_labExtra1Value varchar(20),
  pg2_labExtra2Value varchar(20),
  pg2_labExtra3Value varchar(20),
  
  PRIMARY KEY (ID)
) ;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `BornTransmissionLog`
--

DROP TABLE IF EXISTS `BornTransmissionLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `BornTransmissionLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `submitDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `success` tinyint(1) DEFAULT '0',
  `filename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CdsClientForm`
--

DROP TABLE IF EXISTS `CdsClientForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CdsClientForm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cdsFormVersion` varchar(16) NOT NULL,
  `providerNo` varchar(6) NOT NULL,
  `signed` tinyint(4) NOT NULL,
  `created` datetime NOT NULL,
  `facilityId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `admissionId` int(11) DEFAULT NULL,
  `initialContactDate` date DEFAULT NULL,
  `assessmentDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cdsFormVersion` (`cdsFormVersion`),
  KEY `signed` (`signed`),
  KEY `facilityId` (`facilityId`,`clientId`),
  KEY `admissionId` (`admissionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CdsClientFormData`
--

DROP TABLE IF EXISTS `CdsClientFormData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CdsClientFormData` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cdsClientFormId` int(11) NOT NULL,
  `question` varchar(64) NOT NULL,
  `answer` varchar(16) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cdsClientFormId` (`cdsClientFormId`),
  KEY `question` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CdsFormOption`
--

DROP TABLE IF EXISTS `CdsFormOption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CdsFormOption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cdsFormVersion` varchar(16) NOT NULL,
  `cdsDataCategory` varchar(16) NOT NULL,
  `cdsDataCategoryName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `CdsHospitalisationDays`
--

DROP TABLE IF EXISTS `CdsHospitalisationDays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CdsHospitalisationDays` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `clientId` int(11) NOT NULL,
  `admitted` date NOT NULL,
  `discharged` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ClientLink`
--

DROP TABLE IF EXISTS `ClientLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ClientLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facilityId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `linkType` varchar(32) NOT NULL,
  `remoteLinkId` int(11) NOT NULL,
  `linkDate` datetime NOT NULL,
  `linkProviderNo` varchar(6) NOT NULL,
  `unlinkDate` datetime DEFAULT NULL,
  `unlinkProviderNo` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facilityId` (`facilityId`),
  KEY `clientId` (`clientId`),
  KEY `linkProviderNo` (`linkProviderNo`),
  KEY `unlinkProviderNo` (`unlinkProviderNo`),
  CONSTRAINT `ClientLink_ibfk_1` FOREIGN KEY (`facilityId`) REFERENCES `Facility` (`id`),
  CONSTRAINT `ClientLink_ibfk_2` FOREIGN KEY (`clientId`) REFERENCES `demographic` (`demographic_no`),
  CONSTRAINT `ClientLink_ibfk_3` FOREIGN KEY (`linkProviderNo`) REFERENCES `provider` (`provider_no`),
  CONSTRAINT `ClientLink_ibfk_4` FOREIGN KEY (`unlinkProviderNo`) REFERENCES `provider` (`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Contact`
--

DROP TABLE IF EXISTS `Contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `address2` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(25) DEFAULT NULL,
  `country` varchar(25) DEFAULT NULL,
  `postal` varchar(25) DEFAULT NULL,
  `residencePhone` varchar(30) DEFAULT NULL,
  `cellPhone` varchar(30) DEFAULT NULL,
  `workPhone` varchar(30) DEFAULT NULL,
  `workPhoneExtension` varchar(10) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `note` text,
  `specialty` varchar(255) DEFAULT NULL,
  `cpso` varchar(10) DEFAULT NULL,
  `systemId` varchar(30) DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT NULL,
  `updateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `cpso` (`cpso`),
  KEY `systemId` (`systemId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DemographicContact`
--

DROP TABLE IF EXISTS `DemographicContact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DemographicContact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facilityId` int(11) NOT NULL,
  `creator` varchar(20) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updateDate` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `deleted` tinyint(4) DEFAULT NULL,
  `demographicNo` int(11) DEFAULT NULL,
  `contactId` varchar(100) DEFAULT NULL,
  `role` varchar(100) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `sdm` varchar(25) DEFAULT NULL,
  `ec` varchar(25) DEFAULT NULL,
  `note` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `demographicNo` (`demographicNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `DigitalSignature`
--

DROP TABLE IF EXISTS `DigitalSignature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DigitalSignature` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facilityId` int(11) NOT NULL,
  `providerNo` varchar(6) NOT NULL,
  `demographicId` int(11) NOT NULL,
  `dateSigned` datetime NOT NULL,
  `signatureImage` blob NOT NULL,
  PRIMARY KEY (`id`),
  KEY `facilityId` (`facilityId`),
  KEY `providerNo` (`providerNo`),
  KEY `demographicId` (`demographicId`),
  CONSTRAINT `DigitalSignature_ibfk_1` FOREIGN KEY (`facilityId`) REFERENCES `Facility` (`id`),
  CONSTRAINT `DigitalSignature_ibfk_2` FOREIGN KEY (`providerNo`) REFERENCES `provider` (`provider_no`),
  CONSTRAINT `DigitalSignature_ibfk_3` FOREIGN KEY (`demographicId`) REFERENCES `demographic` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Episode`
--

DROP TABLE IF EXISTS `Episode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Episode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `demographicNo` int(11) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `code` varchar(50) DEFAULT NULL,
  `codingSystem` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `lastUpdateUser` varchar(25) NOT NULL,
  `lastUpdateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Eyeform`
--

DROP TABLE IF EXISTS `Eyeform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Eyeform` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_no` int(11) DEFAULT NULL,
  `discharge` varchar(20) DEFAULT NULL,
  `stat` varchar(20) DEFAULT NULL,
  `opt` varchar(20) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EyeformConsultationReport`
--

DROP TABLE IF EXISTS `EyeformConsultationReport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EyeformConsultationReport` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `date` datetime DEFAULT NULL,
  `referralId` varchar(11) DEFAULT NULL,
  `greeting` int(11) DEFAULT NULL,
  `appointmentNo` int(11) DEFAULT NULL,
  `appointmentDate` date DEFAULT NULL,
  `appointmentTime` time DEFAULT NULL,
  `demographicNo` int(11) DEFAULT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `cc` varchar(255) DEFAULT NULL,
  `memo` varchar(255) DEFAULT NULL,
  `clinicalInfo` text,
  `currentMeds` text,
  `allergies` text,
  `providerNo` varchar(20) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `sendTo` varchar(255) DEFAULT NULL,
  `examination` text,
  `concurrentProblems` text,
  `impression` text,
  `plan` text,
  `urgency` varchar(100) DEFAULT NULL,
  `patientWillBook` int(11) DEFAULT NULL,
  `clinicNo` int(11) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eyeformconsreport_fk_siteid` (`siteId`),
  KEY `myIndex` (`demographicNo`,`providerNo`,`siteId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EyeformFollowUp`
--

DROP TABLE IF EXISTS `EyeformFollowUp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EyeformFollowUp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `appointment_no` int(11) DEFAULT NULL,
  `demographic_no` int(11) DEFAULT NULL,
  `timespan` int(11) DEFAULT NULL,
  `timeframe` varchar(25) DEFAULT NULL,
  `followup_provider` varchar(100) DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` varchar(25) DEFAULT NULL,
  `urgency` varchar(50) DEFAULT NULL,
  `comment` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EyeformMacro`
--

DROP TABLE IF EXISTS `EyeformMacro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EyeformMacro` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `label` varchar(255) NOT NULL,
  `displayOrder` int(10) NOT NULL,
  `impression` text,
  `followupNo` smallint(5) DEFAULT NULL,
  `followupUnit` varchar(50) DEFAULT NULL,
  `followupDoctor` varchar(6) DEFAULT NULL,
  `followupReason` varchar(255) DEFAULT NULL,
  `ticklerStaff` varchar(6) DEFAULT NULL,
  `billingVisitType` varchar(50) DEFAULT NULL,
  `billingVisitLocation` varchar(50) DEFAULT NULL,
  `billingCodes` text,
  `billingDxcode` varchar(50) DEFAULT NULL,
  `billingTotal` varchar(50) DEFAULT NULL,
  `billingComment` varchar(255) DEFAULT NULL,
  `billingBilltype` varchar(50) DEFAULT NULL,
  `billingPayMethod` varchar(50) DEFAULT NULL,
  `billingBillto` varchar(50) DEFAULT NULL,
  `billingRemitto` varchar(50) DEFAULT NULL,
  `billingGstBilledTotal` varchar(50) DEFAULT NULL,
  `billingPayment` varchar(50) DEFAULT NULL,
  `billingRefund` varchar(50) DEFAULT NULL,
  `billingGst` varchar(50) DEFAULT NULL,
  `testRecords` text,
  `dischargeFlag` varchar(20) DEFAULT NULL,
  `statFlag` varchar(20) DEFAULT NULL,
  `optFlag` varchar(20) DEFAULT NULL,
  `sliCode` varchar(10) DEFAULT NULL,
  `includeAdmissionDate` tinyint(1) DEFAULT NULL,
  `billingRefProv` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EyeformOcularProcedure`
--

DROP TABLE IF EXISTS `EyeformOcularProcedure`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EyeformOcularProcedure` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `demographicNo` int(11) NOT NULL,
  `provider` varchar(60) DEFAULT NULL,
  `date` date NOT NULL,
  `eye` varchar(2) NOT NULL,
  `procedureName` varchar(100) NOT NULL,
  `procedureType` varchar(30) DEFAULT NULL,
  `procedureNote` text,
  `doctor` varchar(30) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `appointmentNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EyeformProcedureBook`
--

DROP TABLE IF EXISTS `EyeformProcedureBook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EyeformProcedureBook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eyeform_id` bigint(20) DEFAULT NULL,
  `demographic_no` int(11) DEFAULT NULL,
  `appointment_no` int(11) DEFAULT NULL,
  `provider` varchar(60) DEFAULT NULL,
  `procedure_name` varchar(30) DEFAULT NULL,
  `eye` varchar(20) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `urgency` varchar(10) DEFAULT NULL,
  `comment` text,
  `date` datetime DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EyeformSpecsHistory`
--

DROP TABLE IF EXISTS `EyeformSpecsHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EyeformSpecsHistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `demographicNo` int(11) NOT NULL,
  `provider` varchar(60) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `doctor` varchar(30) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `odSph` varchar(10) DEFAULT NULL,
  `odCyl` varchar(10) DEFAULT NULL,
  `odAxis` varchar(10) DEFAULT NULL,
  `odAdd` varchar(10) DEFAULT NULL,
  `odPrism` varchar(10) DEFAULT NULL,
  `osSph` varchar(10) DEFAULT NULL,
  `osCyl` varchar(10) DEFAULT NULL,
  `osAxis` varchar(10) DEFAULT NULL,
  `osAdd` varchar(10) DEFAULT NULL,
  `osPrism` varchar(10) DEFAULT NULL,
  `updateTime` datetime DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  `appointmentNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `EyeformTestBook`
--

DROP TABLE IF EXISTS `EyeformTestBook`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `EyeformTestBook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `testname` varchar(60) DEFAULT NULL,
  `appointment_no` int(11) DEFAULT NULL,
  `demographic_no` int(11) DEFAULT NULL,
  `provider` varchar(60) DEFAULT NULL,
  `eyeform_id` bigint(20) DEFAULT NULL,
  `eye` varchar(20) DEFAULT NULL,
  `urgency` varchar(30) DEFAULT NULL,
  `comment` varchar(100) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `status` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Facility`
--

DROP TABLE IF EXISTS `Facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Facility` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(150) DEFAULT NULL,
  `contactName` varchar(255) DEFAULT NULL,
  `contactEmail` varchar(255) DEFAULT NULL,
  `contactPhone` varchar(255) DEFAULT NULL,
  `hic` tinyint(1) NOT NULL,
  `disabled` tinyint(1) NOT NULL,
  `orgId` int(11) NOT NULL,
  `sectorId` int(11) NOT NULL,
  `integratorEnabled` tinyint(1) NOT NULL,
  `integratorUrl` varchar(255) DEFAULT NULL,
  `integratorUser` varchar(255) DEFAULT NULL,
  `integratorPassword` varchar(255) DEFAULT NULL,
  `enableIntegratedReferrals` tinyint(1) NOT NULL,
  `enableHealthNumberRegistry` tinyint(1) NOT NULL,
  `allowSims` tinyint(1) unsigned NOT NULL,
  `enableDigitalSignatures` tinyint(1) NOT NULL,
  `ocanServiceOrgNumber` int(10) NOT NULL,
  `enableOcanForms` tinyint(1) NOT NULL,
  `enableAnonymous` tinyint(1) unsigned NOT NULL,
  `enableGroupNotes` tinyint(1) unsigned NOT NULL,
  `lastUpdated` datetime NOT NULL,
  `enableEncounterTime` tinyint(1) NOT NULL,
  `enableEncounterTransportationTime` tinyint(1) NOT NULL,
  `rxInteractionWarningLevel` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FaxClientLog`
--

DROP TABLE IF EXISTS `FaxClientLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FaxClientLog` (
  `faxLogId` int(9) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) DEFAULT NULL,
  `startTime` datetime DEFAULT NULL,
  `endTime` datetime DEFAULT NULL,
  `result` varchar(255) DEFAULT NULL,
  `requestId` varchar(10) DEFAULT NULL,
  `faxId` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`faxLogId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FlowSheetUserCreated`
--

DROP TABLE IF EXISTS `FlowSheetUserCreated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FlowSheetUserCreated` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(4) DEFAULT NULL,
  `dxcodeTriggers` varchar(255) DEFAULT NULL,
  `displayName` varchar(255) DEFAULT NULL,
  `warningColour` varchar(20) DEFAULT NULL,
  `recommendationColour` varchar(20) DEFAULT NULL,
  `topHTML` text,
  `archived` tinyint(1) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FlowSheetUserCreated_archived` (`archived`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Flowsheet`
--

DROP TABLE IF EXISTS `Flowsheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Flowsheet` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(25) DEFAULT NULL,
  `content` text,
  `enabled` tinyint(1) DEFAULT NULL,
  `external` tinyint(1) DEFAULT NULL,
  `createdDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `FunctionalCentre`
--

DROP TABLE IF EXISTS `FunctionalCentre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FunctionalCentre` (
  `accountId` varchar(64) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`accountId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `GroupNoteLink`
--

DROP TABLE IF EXISTS `GroupNoteLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `GroupNoteLink` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `noteId` int(10) NOT NULL,
  `demographicNo` int(10) NOT NULL,
  `anonymous` tinyint(1) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `noteId` (`noteId`),
  KEY `demographicNo` (`demographicNo`),
  KEY `anonymous` (`anonymous`),
  KEY `active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HL7HandlerMSHMapping`
--

DROP TABLE IF EXISTS `HL7HandlerMSHMapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HL7HandlerMSHMapping` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `hospital_site` varchar(255) DEFAULT NULL,
  `facility` varchar(100) DEFAULT NULL,
  `facility_name` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HRMCategory`
--

DROP TABLE IF EXISTS `HRMCategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HRMCategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(255) NOT NULL,
  `subClassNameMnemonic` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HRMDocument`
--

DROP TABLE IF EXISTS `HRMDocument`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HRMDocument` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `timeReceived` datetime DEFAULT NULL,
  `reportType` varchar(50) DEFAULT NULL,
  `reportHash` varchar(64) DEFAULT NULL,
  `reportLessTransactionInfoHash` varchar(64) DEFAULT NULL,
  `reportStatus` varchar(10) DEFAULT NULL,
  `reportFile` varchar(255) DEFAULT NULL,
  `unmatchedProviders` varchar(255) DEFAULT NULL,
  `numDuplicatesReceived` int(11) DEFAULT NULL,
  `reportDate` datetime DEFAULT NULL,
  `parentReport` int(11) DEFAULT NULL,
  `reportLessDemographicInfoHash` varchar(64) DEFAULT NULL,
  `sourceFacility` varchar(120) DEFAULT NULL,
  `hrmCategoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HRMDocumentComment`
--

DROP TABLE IF EXISTS `HRMDocumentComment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HRMDocumentComment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `providerNo` varchar(20) DEFAULT NULL,
  `hrmDocumentId` int(11) DEFAULT NULL,
  `comment` text,
  `commentTime` datetime DEFAULT NULL,
  `deleted` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HRMDocumentSubClass`
--

DROP TABLE IF EXISTS `HRMDocumentSubClass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HRMDocumentSubClass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hrmDocumentId` int(11) DEFAULT NULL,
  `subClass` varchar(50) DEFAULT NULL,
  `subClassMnemonic` varchar(50) DEFAULT NULL,
  `subClassDescription` varchar(255) DEFAULT NULL,
  `subClassDateTime` date DEFAULT NULL,
  `isActive` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HRMDocumentToDemographic`
--

DROP TABLE IF EXISTS `HRMDocumentToDemographic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HRMDocumentToDemographic` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `demographicNo` varchar(20) DEFAULT NULL,
  `hrmDocumentId` varchar(20) DEFAULT NULL,
  `timeAssigned` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HRMDocumentToProvider`
--

DROP TABLE IF EXISTS `HRMDocumentToProvider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HRMDocumentToProvider` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `providerNo` varchar(20) DEFAULT NULL,
  `hrmDocumentId` varchar(20) DEFAULT NULL,
  `signedOff` int(11) DEFAULT NULL,
  `signedOffTimestamp` datetime DEFAULT NULL,
  `viewed` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HRMProviderConfidentialityStatement`
--

DROP TABLE IF EXISTS `HRMProviderConfidentialityStatement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HRMProviderConfidentialityStatement` (
  `providerNo` varchar(20) NOT NULL DEFAULT '',
  `statement` text,
  PRIMARY KEY (`providerNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HRMSubClass`
--

DROP TABLE IF EXISTS `HRMSubClass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HRMSubClass` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `className` varchar(255) DEFAULT NULL,
  `subClassName` varchar(255) DEFAULT NULL,
  `subClassMnemonic` varchar(255) DEFAULT NULL,
  `subClassDescription` varchar(255) DEFAULT NULL,
  `sendingFacilityId` varchar(50) NOT NULL,
  `hrmCategoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `HnrDataValidation`
--

DROP TABLE IF EXISTS `HnrDataValidation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `HnrDataValidation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facilityId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `validatorProviderNo` varchar(6) NOT NULL,
  `valid` tinyint(1) NOT NULL,
  `validationType` varchar(32) NOT NULL,
  `validationCrc` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `facilityId` (`facilityId`),
  KEY `clientId` (`clientId`),
  KEY `validatorProviderNo` (`validatorProviderNo`),
  KEY `validationType` (`validationType`),
  CONSTRAINT `HnrDataValidation_ibfk_1` FOREIGN KEY (`facilityId`) REFERENCES `Facility` (`id`),
  CONSTRAINT `HnrDataValidation_ibfk_2` FOREIGN KEY (`clientId`) REFERENCES `demographic` (`demographic_no`),
  CONSTRAINT `HnrDataValidation_ibfk_3` FOREIGN KEY (`validatorProviderNo`) REFERENCES `provider` (`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IntegratorConsent`
--

DROP TABLE IF EXISTS `IntegratorConsent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IntegratorConsent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facilityId` int(11) NOT NULL,
  `demographicId` int(11) NOT NULL,
  `providerNo` varchar(6) NOT NULL,
  `createdDate` datetime NOT NULL,
  `excludeMentalHealthData` tinyint(1) NOT NULL,
  `clientConsentStatus` varchar(32) NOT NULL,
  `signatureStatus` varchar(10) NOT NULL,
  `expiry` date DEFAULT NULL,
  `digitalSignatureId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facilityId` (`facilityId`),
  KEY `demographicId` (`demographicId`),
  KEY `providerNo` (`providerNo`),
  KEY `createdDate` (`createdDate`),
  KEY `digitalSignatureId` (`digitalSignatureId`),
  CONSTRAINT `IntegratorConsent_ibfk_1` FOREIGN KEY (`facilityId`) REFERENCES `Facility` (`id`),
  CONSTRAINT `IntegratorConsent_ibfk_2` FOREIGN KEY (`demographicId`) REFERENCES `demographic` (`demographic_no`),
  CONSTRAINT `IntegratorConsent_ibfk_3` FOREIGN KEY (`providerNo`) REFERENCES `provider` (`provider_no`),
  CONSTRAINT `IntegratorConsent_ibfk_4` FOREIGN KEY (`digitalSignatureId`) REFERENCES `DigitalSignature` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IntegratorConsentComplexExitInterview`
--

DROP TABLE IF EXISTS `IntegratorConsentComplexExitInterview`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IntegratorConsentComplexExitInterview` (
  `facilityId` int(11) NOT NULL,
  `demographicId` int(11) NOT NULL,
  `spokenLanguage` varchar(64) DEFAULT NULL,
  `readLanguage` varchar(64) DEFAULT NULL,
  `education` varchar(64) DEFAULT NULL,
  `timeToReviewConsent` varchar(16) DEFAULT NULL,
  `timeToReviewConsentComments` varchar(255) DEFAULT NULL,
  `pressured` varchar(16) DEFAULT NULL,
  `pressuredComments` varchar(255) DEFAULT NULL,
  `moreInfo` varchar(16) DEFAULT NULL,
  `moreInfoComments` varchar(255) DEFAULT NULL,
  `reAskConsent` varchar(32) DEFAULT NULL,
  `reAskConsentComments` varchar(255) DEFAULT NULL,
  `additionalComments` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`facilityId`,`demographicId`),
  KEY `demographicId` (`demographicId`),
  CONSTRAINT `IntegratorConsentComplexExitInterview_ibfk_1` FOREIGN KEY (`facilityId`) REFERENCES `Facility` (`id`),
  CONSTRAINT `IntegratorConsentComplexExitInterview_ibfk_2` FOREIGN KEY (`demographicId`) REFERENCES `demographic` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IntegratorConsentShareDataMap`
--

DROP TABLE IF EXISTS `IntegratorConsentShareDataMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IntegratorConsentShareDataMap` (
  `IntegratorConsent_id` int(11) NOT NULL,
  `mapkey` int(11) NOT NULL,
  `element` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IntegratorControl`
--

DROP TABLE IF EXISTS `IntegratorControl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IntegratorControl` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facilityId` int(11) NOT NULL,
  `control` varchar(80) DEFAULT NULL,
  `execute` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IssueGroup`
--

DROP TABLE IF EXISTS `IssueGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IssueGroup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `IssueGroupIssues`
--

DROP TABLE IF EXISTS `IssueGroupIssues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IssueGroupIssues` (
  `issueGroupId` int(11) NOT NULL,
  `issue_id` int(11) NOT NULL,
  UNIQUE KEY `issueGroupId` (`issueGroupId`,`issue_id`),
  KEY `issue_id` (`issue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `MyGroupAccessRestriction`
--

DROP TABLE IF EXISTS `MyGroupAccessRestriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MyGroupAccessRestriction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `myGroupNo` varchar(50) NOT NULL,
  `providerNo` varchar(20) NOT NULL,
  `lastUpdateUser` varchar(20) DEFAULT NULL,
  `lastUpdateDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `myGroupNo` (`myGroupNo`),
  KEY `myGroupNo_2` (`myGroupNo`,`providerNo`),
  KEY `MyGroupAccessRestriction_myGroupNo_index` (`myGroupNo`),
  KEY `MyGroupAccessRestriction_myGroupNo_providerNo_index` (`myGroupNo`,`providerNo`),
  KEY `MyGroupAccessRestriction_providerNo_index` (`providerNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OcanConnexOption`
--

DROP TABLE IF EXISTS `OcanConnexOption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OcanConnexOption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `LHINCode` varchar(3) NOT NULL,
  `orgLHIN` varchar(100) NOT NULL,
  `orgName` varchar(100) NOT NULL,
  `orgNumber` varchar(5) NOT NULL,
  `programName` varchar(100) NOT NULL,
  `programNumber` varchar(5) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OcanFormOption`
--

DROP TABLE IF EXISTS `OcanFormOption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OcanFormOption` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ocanFormVersion` varchar(16) NOT NULL,
  `ocanDataCategory` varchar(100) NOT NULL,
  `ocanDataCategoryValue` varchar(100) NOT NULL,
  `ocanDataCategoryName` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OcanStaffForm`
--

DROP TABLE IF EXISTS `OcanStaffForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OcanStaffForm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assessmentId` int(11) DEFAULT NULL,
  `submissionId` int(11) DEFAULT NULL,
  `ocanFormVersion` varchar(16) NOT NULL,
  `ocanType` varchar(20) NOT NULL,
  `providerNo` varchar(6) DEFAULT NULL,
  `clientFormProviderNo` varchar(6) DEFAULT NULL,
  `signed` tinyint(4) NOT NULL,
  `created` datetime DEFAULT NULL,
  `clientFormCreated` datetime DEFAULT NULL,
  `facilityId` int(11) NOT NULL,
  `clientId` int(11) NOT NULL,
  `admissionId` int(11) DEFAULT NULL,
  `clientAge` int(11) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `addressLine1` varchar(100) DEFAULT NULL,
  `addressLine2` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `province` varchar(10) DEFAULT NULL,
  `postalCode` varchar(100) DEFAULT NULL,
  `phoneNumber` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `hcNumber` varchar(100) DEFAULT NULL,
  `hcVersion` varchar(100) DEFAULT NULL,
  `dateOfBirth` varchar(100) DEFAULT NULL,
  `clientDateOfBirth` varchar(10) DEFAULT NULL,
  `reasonForAssessment` varchar(100) DEFAULT NULL,
  `assessmentStatus` varchar(40) DEFAULT NULL,
  `startDate` date DEFAULT NULL,
  `clientStartDate` date DEFAULT NULL,
  `completionDate` date DEFAULT NULL,
  `clientCompletionDate` date DEFAULT NULL,
  `gender` varchar(10) DEFAULT NULL,
  `providerName` varchar(100) DEFAULT NULL,
  `clientFormProviderName` varchar(100) DEFAULT NULL,
  `consent` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ocanFormVersion` (`ocanFormVersion`),
  KEY `signed` (`signed`),
  KEY `facilityId` (`facilityId`,`clientId`),
  KEY `admissionId` (`admissionId`),
  KEY `clientAge` (`clientAge`),
  KEY `assessmentStatus` (`assessmentStatus`),
  KEY `startDate` (`startDate`),
  KEY `completionDate` (`completionDate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OcanStaffFormData`
--

DROP TABLE IF EXISTS `OcanStaffFormData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OcanStaffFormData` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ocanStaffFormId` int(11) NOT NULL,
  `question` varchar(64) NOT NULL,
  `answer` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ocanStaffFormId` (`ocanStaffFormId`),
  KEY `question` (`question`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `OcanSubmissionLog`
--

DROP TABLE IF EXISTS `OcanSubmissionLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OcanSubmissionLog` (
  `submissionId` int(11) NOT NULL AUTO_INCREMENT,
  `submitDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `result` varchar(255) DEFAULT NULL,
  `transactionId` varchar(100) DEFAULT NULL,
  `resultMessage` text,
  `submissionData` longtext,
  PRIMARY KEY (`submissionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PHRVerification`
--

DROP TABLE IF EXISTS `PHRVerification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PHRVerification` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `demographicNo` int(10) DEFAULT NULL,
  `phrUserName` varchar(255) DEFAULT NULL,
  `verificationLevel` varchar(100) DEFAULT NULL,
  `verificationDate` datetime DEFAULT NULL,
  `verificationBy` varchar(6) DEFAULT NULL,
  `photoId` tinyint(1) DEFAULT NULL,
  `parentGuardian` tinyint(1) DEFAULT NULL,
  `comments` text,
  `createdDate` datetime DEFAULT NULL,
  `archived` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `PHRVerification_archived` (`archived`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PageMonitor`
--

DROP TABLE IF EXISTS `PageMonitor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PageMonitor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pageName` varchar(100) NOT NULL,
  `session` varchar(100) DEFAULT NULL,
  `remoteAddr` varchar(20) DEFAULT NULL,
  `locked` tinyint(1) DEFAULT NULL,
  `updateDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `timeout` int(10) DEFAULT NULL,
  `providerNo` varchar(10) DEFAULT NULL,
  `providerName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `PrintResourceLog`
--

DROP TABLE IF EXISTS `PrintResourceLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PrintResourceLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `resourceName` varchar(100) NOT NULL,
  `resourceId` varchar(50) NOT NULL,
  `dateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `providerNo` varchar(10) DEFAULT NULL,
  `externalLocation` varchar(200) DEFAULT NULL,
  `externalMethod` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProviderPreference`
--

DROP TABLE IF EXISTS `ProviderPreference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProviderPreference` (
  `providerNo` varchar(6) NOT NULL,
  `startHour` tinyint(4) DEFAULT NULL,
  `endHour` tinyint(4) DEFAULT NULL,
  `everyMin` tinyint(4) DEFAULT NULL,
  `myGroupNo` varchar(10) DEFAULT NULL,
  `colourTemplate` varchar(10) DEFAULT NULL,
  `newTicklerWarningWindow` varchar(10) DEFAULT NULL,
  `defaultServiceType` varchar(10) DEFAULT NULL,
  `defaultCaisiPmm` varchar(10) DEFAULT NULL,
  `defaultNewOscarCme` varchar(10) DEFAULT NULL,
  `printQrCodeOnPrescriptions` tinyint(4) NOT NULL,
  `lastUpdated` datetime NOT NULL,
  `appointmentScreenLinkNameDisplayLength` int(11) NOT NULL,
  `defaultDoNotDeleteBilling` tinyint(1) NOT NULL,
  `defaultDxCode` varchar(4) DEFAULT NULL,
  `eRxEnabled` tinyint(1) NOT NULL,
  `eRx_SSO_URL` varchar(128) DEFAULT NULL,
  `eRxUsername` varchar(32) DEFAULT NULL,
  `eRxPassword` varchar(64) DEFAULT NULL,
  `eRxFacility` varchar(32) DEFAULT NULL,
  `eRxTrainingMode` tinyint(1) NOT NULL,
  `encryptedMyOscarPassword` varbinary(255) DEFAULT NULL,
  `printDateOnRx` tinyint(1) DEFAULT '0',
  `printPharmacyOnRx` tinyint(1) DEFAULT '0',
  `billingRefBoxDefaultChecked` tinyint(1) DEFAULT '0',
  `useBillingProviderFromPreviousBill` tinyint(1) DEFAULT '0',
  `billingVisitTypeDefault` varchar(60) NOT NULL,
  `billingVisitLocationDefault` varchar(15) NOT NULL,
  `billingSiteDefault` int(11) DEFAULT NULL,
  `billingProviderDefault` varchar(60) NOT NULL,
  PRIMARY KEY (`providerNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProviderPreferenceAppointmentScreenEForm`
--

DROP TABLE IF EXISTS `ProviderPreferenceAppointmentScreenEForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProviderPreferenceAppointmentScreenEForm` (
  `providerNo` varchar(6) NOT NULL,
  `appointmentScreenEForm` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProviderPreferenceAppointmentScreenForm`
--

DROP TABLE IF EXISTS `ProviderPreferenceAppointmentScreenForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProviderPreferenceAppointmentScreenForm` (
  `providerNo` varchar(6) NOT NULL,
  `appointmentScreenForm` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ProviderPreferenceAppointmentScreenQuickLink`
--

DROP TABLE IF EXISTS `ProviderPreferenceAppointmentScreenQuickLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ProviderPreferenceAppointmentScreenQuickLink` (
  `providerNo` varchar(6) NOT NULL,
  `name` varchar(64) NOT NULL,
  `url` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RemoteDataLog`
--

DROP TABLE IF EXISTS `RemoteDataLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RemoteDataLog` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `providerNo` varchar(255) NOT NULL,
  `actionDate` datetime NOT NULL,
  `action` varchar(32) NOT NULL,
  `documentId` varchar(255) NOT NULL,
  `documentContents` blob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RemoteIntegratedDataCopy`
--

DROP TABLE IF EXISTS `RemoteIntegratedDataCopy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RemoteIntegratedDataCopy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `datatype` varchar(255) DEFAULT NULL,
  `data` longtext,
  `lastUpdateDate` datetime DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL,
  `facilityId` int(11) DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `archived` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `RIDopy_demo_dataT_fac_arch` (`demographic_no`,`datatype`,`facilityId`,`archived`),
  KEY `RIDopy_demo_dataT_sig_fac_arch` (`demographic_no`,`datatype`(165),`signature`(165),`facilityId`,`archived`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `RemoteReferral`
--

DROP TABLE IF EXISTS `RemoteReferral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RemoteReferral` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facilityId` int(11) NOT NULL,
  `demographicId` int(11) NOT NULL,
  `referringProviderNo` varchar(6) NOT NULL,
  `referredToFacilityName` varchar(255) NOT NULL,
  `referredToProgramName` varchar(255) NOT NULL,
  `referalDate` datetime NOT NULL,
  `reasonForReferral` varchar(255) DEFAULT NULL,
  `presentingProblem` varchar(255) DEFAULT NULL,
  `createDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `facilityId` (`facilityId`),
  KEY `demographicId` (`demographicId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SecurityToken`
--

DROP TABLE IF EXISTS `SecurityToken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SecurityToken` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `token` varchar(100) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `expiry` datetime NOT NULL,
  `data` varchar(255) DEFAULT NULL,
  `providerNo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SentToPHRTracking`
--

DROP TABLE IF EXISTS `SentToPHRTracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SentToPHRTracking` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `demographicNo` int(10) NOT NULL,
  `objectName` varchar(60) NOT NULL,
  `sentDatetime` datetime NOT NULL,
  `sentToServer` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `demographicNo` (`demographicNo`,`objectName`,`sentToServer`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `SystemMessage`
--

DROP TABLE IF EXISTS `SystemMessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SystemMessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `creationDate` datetime NOT NULL,
  `expiryDate` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `Vacancy`
--

DROP TABLE IF EXISTS `Vacancy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Vacancy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `templateId` int(11) NOT NULL,
  `status` varchar(24) NOT NULL,
  `dateClosed` timestamp NULL DEFAULT NULL,
  `reasonClosed` varchar(255) DEFAULT NULL,
  `WL_PROGRAM_ID` int(11) NOT NULL,
  `DATE_CREATE` date NOT NULL,
  `emailNotificationAddressesCsv` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `access_type`
--

DROP TABLE IF EXISTS `access_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `access_type` (
  `access_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`access_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `admission`
--

DROP TABLE IF EXISTS `admission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admission` (
  `am_id` bigint(11) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(11) NOT NULL DEFAULT '0',
  `program_id` bigint(11) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '0',
  `admission_date` datetime DEFAULT NULL,
  `admission_from_transfer` tinyint(1) NOT NULL,
  `admission_notes` text,
  `temp_admission` char(1) DEFAULT NULL,
  `discharge_date` datetime DEFAULT NULL,
  `discharge_from_transfer` tinyint(1) NOT NULL,
  `discharge_notes` text,
  `temp_admit_discharge` char(1) DEFAULT NULL,
  `admission_status` varchar(24) DEFAULT NULL,
  `team_id` int(10) DEFAULT NULL,
  `temporary_admission_flag` tinyint(1) DEFAULT NULL,
  `radioDischargeReason` varchar(10) DEFAULT '0',
  `clientstatus_id` bigint(20) DEFAULT '0',
  `automatic_discharge` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`am_id`),
  KEY `FK1A21809DAA8624B` (`team_id`),
  KEY `program_id` (`program_id`),
  KEY `client_id` (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `agency`
--

DROP TABLE IF EXISTS `agency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agency` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `intake_quick` int(10) unsigned NOT NULL DEFAULT '1',
  `intake_quick_state` char(2) NOT NULL DEFAULT 'HS',
  `intake_indepth` int(10) unsigned DEFAULT '2',
  `intake_indepth_state` char(2) NOT NULL DEFAULT 'HS',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `allergies`
--

DROP TABLE IF EXISTS `allergies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allergies` (
  `allergyid` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `entry_date` date DEFAULT NULL,
  `DESCRIPTION` varchar(50) NOT NULL DEFAULT '',
  `HICL_SEQNO` int(6) DEFAULT NULL,
  `HIC_SEQNO` int(6) DEFAULT NULL,
  `AGCSP` int(6) DEFAULT NULL,
  `AGCCS` int(6) DEFAULT NULL,
  `TYPECODE` tinyint(4) NOT NULL DEFAULT '0',
  `reaction` text,
  `drugref_id` varchar(100) DEFAULT NULL,
  `archived` char(1) DEFAULT '0',
  `start_date` date DEFAULT NULL,
  `age_of_onset` char(4) DEFAULT '0',
  `severity_of_reaction` char(1) DEFAULT '0',
  `onset_of_reaction` char(1) DEFAULT '0',
  `regional_identifier` varchar(100) DEFAULT NULL,
  `life_stage` char(1) DEFAULT NULL,
  `position` int(10) NOT NULL,
  `lastUpdateDate` datetime NOT NULL,
  `providerNo` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`allergyid`),
  KEY `allergies_demographic_no_index` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_lookuptable`
--

DROP TABLE IF EXISTS `app_lookuptable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_lookuptable` (
  `tableid` varchar(32) NOT NULL,
  `moduleid` varchar(5) DEFAULT NULL,
  `table_name` varchar(32) DEFAULT NULL,
  `description` varchar(80) DEFAULT NULL,
  `istree` tinyint(1) DEFAULT NULL,
  `treecode_length` int(10) DEFAULT NULL,
  `activeyn` tinyint(1) DEFAULT NULL,
  `readonly` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`tableid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_lookuptable_fields`
--

DROP TABLE IF EXISTS `app_lookuptable_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_lookuptable_fields` (
  `tableid` varchar(10) NOT NULL,
  `fieldname` varchar(30) NOT NULL,
  `fielddesc` varchar(40) DEFAULT NULL,
  `edityn` varchar(1) DEFAULT NULL,
  `fieldtype` varchar(1) DEFAULT NULL,
  `lookuptable` varchar(6) DEFAULT NULL,
  `fieldsql` varchar(32) DEFAULT NULL,
  `fieldindex` int(10) DEFAULT NULL,
  `uniqueyn` int(10) DEFAULT NULL,
  `genericidx` int(10) DEFAULT NULL,
  `autoyn` tinyint(1) DEFAULT NULL,
  `fieldlength` int(10) DEFAULT NULL,
  PRIMARY KEY (`tableid`,`fieldname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `app_module`
--

DROP TABLE IF EXISTS `app_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_module` (
  `module_id` int(10) NOT NULL,
  `description` varchar(128) NOT NULL,
  PRIMARY KEY (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment` (
  `appointment_no` int(12) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `appointment_date` date NOT NULL DEFAULT '0001-01-01',
  `start_time` time NOT NULL DEFAULT '00:00:00',
  `end_time` time NOT NULL DEFAULT '00:00:00',
  `name` varchar(50) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT NULL,
  `program_id` int(11) DEFAULT '0',
  `notes` varchar(255) DEFAULT NULL,
  `reason` varchar(80) DEFAULT NULL,
  `site` int(11) DEFAULT NULL,
  `resources` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `style` varchar(10) DEFAULT NULL,
  `billing` varchar(10) DEFAULT NULL,
  `status` char(2) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `imported_status` varchar(20) DEFAULT NULL,
  `createdatetime` datetime DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `lastupdateuser` varchar(6) DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  `urgency` varchar(30) DEFAULT NULL,
  `creatorSecurityId` int(11) DEFAULT NULL,
  `bookingSource` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`appointment_no`),
  KEY `appointment_date` (`appointment_date`,`start_time`,`demographic_no`),
  KEY `demographic_no` (`demographic_no`),
  KEY `location` (`site`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentArchive`
--

DROP TABLE IF EXISTS `appointmentArchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointmentArchive` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `appointment_no` int(12) DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  `notes` varchar(80) DEFAULT NULL,
  `reason` varchar(80) DEFAULT NULL,
  `location` varchar(30) DEFAULT NULL,
  `resources` varchar(255) DEFAULT NULL,
  `type` varchar(10) DEFAULT NULL,
  `style` varchar(10) DEFAULT NULL,
  `billing` varchar(10) DEFAULT NULL,
  `status` char(2) DEFAULT NULL,
  `imported_status` varchar(20) DEFAULT NULL,
  `createdatetime` datetime DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `lastupdateuser` varchar(6) DEFAULT NULL,
  `remarks` varchar(50) DEFAULT NULL,
  `urgency` varchar(30) DEFAULT NULL,
  `creatorSecurityId` int(11) DEFAULT NULL,
  `bookingSource` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointmentType`
--

DROP TABLE IF EXISTS `appointmentType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointmentType` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `notes` varchar(80) DEFAULT NULL,
  `reason` varchar(80) DEFAULT NULL,
  `site` int(11) DEFAULT NULL,
  `resources` varchar(10) DEFAULT NULL,
  `duration` int(12) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `appointment_status`
--

DROP TABLE IF EXISTS `appointment_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(2) NOT NULL,
  `description` char(30) NOT NULL DEFAULT 'no description',
  `color` char(7) NOT NULL DEFAULT '#cccccc',
  `icon` char(30) NOT NULL DEFAULT '''''',
  `active` int(1) NOT NULL DEFAULT '1',
  `editable` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batchEligibility`
--

DROP TABLE IF EXISTS `batchEligibility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batchEligibility` (
  `responseCode` int(9) NOT NULL,
  `MOHResponse` varchar(100) NOT NULL,
  `reason` varchar(255) NOT NULL,
  PRIMARY KEY (`responseCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `batch_billing`
--

DROP TABLE IF EXISTS `batch_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch_billing` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `billing_provider_no` varchar(6) DEFAULT NULL,
  `service_code` varchar(10) DEFAULT NULL,
  `dxcode` varchar(5) DEFAULT NULL,
  `billing_amount` varchar(10) DEFAULT NULL,
  `lastbilled_date` date DEFAULT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `creator` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bed`
--

DROP TABLE IF EXISTS `bed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed` (
  `bed_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `bed_type_id` int(10) unsigned NOT NULL DEFAULT '1',
  `room_id` int(10) unsigned DEFAULT NULL,
  `facility_id` int(10) unsigned NOT NULL DEFAULT '0',
  `room_start` date NOT NULL,
  `team_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `active` tinyint(1) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`bed_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bed_check_time`
--

DROP TABLE IF EXISTS `bed_check_time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_check_time` (
  `bed_check_time_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `program_id` int(10) unsigned NOT NULL,
  `bed_check_time` time NOT NULL,
  PRIMARY KEY (`bed_check_time_id`),
  UNIQUE KEY `idx_program_time` (`program_id`,`bed_check_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bed_demographic`
--

DROP TABLE IF EXISTS `bed_demographic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_demographic` (
  `bed_id` int(10) unsigned NOT NULL,
  `demographic_no` int(10) unsigned NOT NULL,
  `bed_demographic_status_id` int(10) unsigned NOT NULL DEFAULT '1',
  `provider_no` varchar(6) NOT NULL,
  `late_pass` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `reservation_start` date NOT NULL,
  `reservation_end` date NOT NULL,
  PRIMARY KEY (`bed_id`,`demographic_no`),
  UNIQUE KEY `idx_bed` (`bed_id`),
  UNIQUE KEY `idx_demographic` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bed_demographic_historical`
--

DROP TABLE IF EXISTS `bed_demographic_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_demographic_historical` (
  `bed_id` int(10) unsigned NOT NULL,
  `demographic_no` int(10) unsigned NOT NULL,
  `usage_start` date NOT NULL,
  `usage_end` date NOT NULL,
  PRIMARY KEY (`bed_id`,`demographic_no`,`usage_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bed_demographic_status`
--

DROP TABLE IF EXISTS `bed_demographic_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_demographic_status` (
  `bed_demographic_status_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `duration` int(10) unsigned NOT NULL DEFAULT '0',
  `dflt` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bed_demographic_status_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bed_type`
--

DROP TABLE IF EXISTS `bed_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed_type` (
  `bed_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `dflt` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`bed_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billactivity`
--

DROP TABLE IF EXISTS `billactivity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billactivity` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `monthCode` char(1) DEFAULT NULL,
  `batchcount` int(3) DEFAULT NULL,
  `htmlfilename` varchar(50) DEFAULT NULL,
  `ohipfilename` varchar(50) DEFAULT NULL,
  `providerohipno` varchar(6) DEFAULT NULL,
  `groupno` varchar(6) DEFAULT NULL,
  `creator` varchar(6) DEFAULT NULL,
  `htmlcontext` mediumtext,
  `ohipcontext` mediumtext,
  `claimrecord` varchar(10) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `total` varchar(20) DEFAULT NULL,
  `sentdate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billcenter`
--

DROP TABLE IF EXISTS `billcenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billcenter` (
  `billcenter_code` char(2) NOT NULL DEFAULT '',
  `billcenter_desc` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing`
--

DROP TABLE IF EXISTS `billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing` (
  `billing_no` int(10) NOT NULL AUTO_INCREMENT,
  `clinic_no` int(10) NOT NULL DEFAULT '0',
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `appointment_no` int(12) DEFAULT NULL,
  `organization_spec_code` varchar(6) DEFAULT NULL,
  `demographic_name` varchar(60) DEFAULT NULL,
  `hin` varchar(12) DEFAULT NULL,
  `update_date` date DEFAULT NULL,
  `update_time` time DEFAULT NULL,
  `billing_date` date DEFAULT NULL,
  `billing_time` time DEFAULT NULL,
  `clinic_ref_code` varchar(10) DEFAULT NULL,
  `content` text,
  `total` varchar(6) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `dob` varchar(8) DEFAULT NULL,
  `visitdate` date DEFAULT NULL,
  `visittype` char(2) DEFAULT NULL,
  `provider_ohip_no` varchar(20) DEFAULT NULL,
  `provider_rma_no` varchar(20) DEFAULT NULL,
  `apptProvider_no` varchar(6) DEFAULT NULL,
  `asstProvider_no` varchar(6) DEFAULT NULL,
  `creator` varchar(6) DEFAULT NULL,
  `billingtype` varchar(4) DEFAULT 'MSP',
  PRIMARY KEY (`billing_no`),
  KEY `appointment_no` (`appointment_no`,`demographic_no`),
  KEY `demographic_no` (`demographic_no`),
  KEY `billing_date` (`billing_date`),
  KEY `provider_no` (`provider_no`),
  KEY `provider_ohip_no` (`provider_ohip_no`),
  KEY `apptProvider_no` (`apptProvider_no`),
  KEY `creator` (`creator`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_defaults`
--

DROP TABLE IF EXISTS `billing_defaults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_defaults` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` int(6) NOT NULL,
  `visit_type_no` varchar(10) DEFAULT NULL,
  `location_id` int(11) DEFAULT NULL,
  `sli_code` varchar(4) DEFAULT NULL,
  `billing_form` varchar(10) DEFAULT NULL,
  `priority` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_3rdPartyAddress`
--

DROP TABLE IF EXISTS `billing_on_3rdPartyAddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_3rdPartyAddress` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `attention` varchar(100) NOT NULL DEFAULT '',
  `company_name` varchar(100) NOT NULL DEFAULT '',
  `address` varchar(200) NOT NULL DEFAULT '',
  `city` varchar(200) NOT NULL DEFAULT '',
  `province` varchar(10) NOT NULL DEFAULT '',
  `postcode` varchar(10) NOT NULL DEFAULT '',
  `telephone` varchar(15) NOT NULL DEFAULT '',
  `fax` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_cheader1`
--

DROP TABLE IF EXISTS `billing_on_cheader1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_cheader1` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `header_id` int(11) NOT NULL,
  `transc_id` char(2) DEFAULT 'HE',
  `rec_id` char(1) DEFAULT 'H',
  `hin` char(10) DEFAULT NULL,
  `ver` char(2) DEFAULT '',
  `dob` char(8) DEFAULT NULL,
  `pay_program` char(3) DEFAULT 'HCP',
  `payee` char(1) DEFAULT 'P',
  `ref_num` varchar(6) DEFAULT NULL,
  `facilty_num` varchar(4) DEFAULT NULL,
  `admission_date` varchar(10) DEFAULT NULL,
  `ref_lab_num` varchar(4) DEFAULT NULL,
  `man_review` char(1) DEFAULT NULL,
  `location` varchar(4) DEFAULT NULL,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `appointment_no` int(12) DEFAULT NULL,
  `demographic_name` varchar(60) DEFAULT NULL,
  `sex` char(1) DEFAULT '1',
  `province` char(2) DEFAULT 'ON',
  `billing_date` date DEFAULT NULL,
  `billing_time` time DEFAULT NULL,
  `total` varchar(7) DEFAULT NULL,
  `paid` varchar(7) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `comment1` varchar(255) DEFAULT NULL,
  `visittype` char(2) DEFAULT NULL,
  `provider_ohip_no` varchar(20) DEFAULT NULL,
  `provider_rma_no` varchar(20) DEFAULT NULL,
  `apptProvider_no` varchar(6) DEFAULT NULL,
  `asstProvider_no` varchar(6) DEFAULT NULL,
  `creator` varchar(6) DEFAULT NULL,
  `timestamp1` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `site` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointment_no` (`appointment_no`,`demographic_no`),
  KEY `demographic_no` (`demographic_no`),
  KEY `billing_date` (`billing_date`),
  KEY `provider_no` (`provider_no`),
  KEY `provider_ohip_no` (`provider_ohip_no`),
  KEY `apptProvider_no` (`apptProvider_no`),
  KEY `creator` (`creator`),
  KEY `clinic` (`site`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_cheader2`
--

DROP TABLE IF EXISTS `billing_on_cheader2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_cheader2` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `ch1_id` int(12) NOT NULL,
  `transc_id` char(2) DEFAULT 'HE',
  `rec_id` char(1) DEFAULT 'R',
  `hin` char(12) DEFAULT NULL,
  `last_name` char(9) DEFAULT '',
  `first_name` char(5) DEFAULT NULL,
  `sex` char(1) DEFAULT '1',
  `province` char(2) DEFAULT 'AB',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ch1_id` (`ch1_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_diskname`
--

DROP TABLE IF EXISTS `billing_on_diskname`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_diskname` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `monthCode` char(1) DEFAULT '',
  `batchcount` int(3) DEFAULT NULL,
  `ohipfilename` varchar(50) DEFAULT NULL,
  `groupno` varchar(6) DEFAULT NULL,
  `creator` char(6) DEFAULT NULL,
  `claimrecord` varchar(10) DEFAULT NULL,
  `createdatetime` datetime DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `total` varchar(20) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_eareport`
--

DROP TABLE IF EXISTS `billing_on_eareport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_eareport` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `providerohip_no` varchar(6) DEFAULT NULL,
  `group_no` varchar(6) DEFAULT '0000',
  `specialty` char(2) DEFAULT '00',
  `process_date` date DEFAULT NULL,
  `hin` varchar(12) DEFAULT NULL,
  `ver` char(2) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `billing_no` int(6) DEFAULT NULL,
  `ref_no` varchar(6) DEFAULT NULL,
  `facility` varchar(4) DEFAULT NULL,
  `admitted_date` varchar(8) DEFAULT NULL,
  `claim_error` varchar(20) DEFAULT NULL,
  `code` varchar(5) DEFAULT NULL,
  `fee` varchar(10) DEFAULT NULL,
  `unit` varchar(2) DEFAULT NULL,
  `code_date` date DEFAULT NULL,
  `dx` varchar(5) DEFAULT NULL,
  `exp` varchar(60) DEFAULT NULL,
  `code_error` varchar(20) DEFAULT NULL,
  `report_name` varchar(20) DEFAULT '',
  `status` char(1) DEFAULT 'N',
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `providerohip_no` (`providerohip_no`),
  KEY `code_date` (`code_date`),
  KEY `process_date` (`process_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_errorCode`
--

DROP TABLE IF EXISTS `billing_on_errorCode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_errorCode` (
  `code` varchar(5) NOT NULL,
  `description` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_ext`
--

DROP TABLE IF EXISTS `billing_on_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_ext` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `billing_no` int(6) DEFAULT NULL,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `key_val` varchar(50) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `status` char(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `key_val` (`key_val`),
  KEY `billing_no` (`billing_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_favourite`
--

DROP TABLE IF EXISTS `billing_on_favourite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_favourite` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) DEFAULT '',
  `service_dx` varchar(255) DEFAULT '',
  `provider_no` varchar(6) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_filename`
--

DROP TABLE IF EXISTS `billing_on_filename`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_filename` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disk_id` int(11) NOT NULL,
  `htmlfilename` varchar(50) DEFAULT NULL,
  `providerohipno` varchar(6) DEFAULT NULL,
  `providerno` char(6) NOT NULL,
  `claimrecord` varchar(10) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `total` varchar(20) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_header`
--

DROP TABLE IF EXISTS `billing_on_header`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_header` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `disk_id` int(11) NOT NULL,
  `transc_id` char(2) DEFAULT 'HE',
  `rec_id` char(1) DEFAULT 'B',
  `spec_id` char(3) DEFAULT 'V03',
  `moh_office` char(1) DEFAULT '',
  `batch_id` varchar(12) DEFAULT '',
  `operator` varchar(6) DEFAULT '',
  `group_num` char(4) DEFAULT '0000',
  `provider_reg_num` varchar(6) DEFAULT '',
  `specialty` char(2) DEFAULT '00',
  `h_count` varchar(4) DEFAULT '0000',
  `r_count` varchar(4) DEFAULT '0000',
  `t_count` varchar(5) DEFAULT '00000',
  `batch_date` date DEFAULT NULL,
  `createdatetime` datetime DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `creator` varchar(6) DEFAULT '',
  `action` varchar(60) DEFAULT '',
  `comment` varchar(200) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_item`
--

DROP TABLE IF EXISTS `billing_on_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_item` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `ch1_id` int(12) NOT NULL,
  `transc_id` char(2) DEFAULT 'HE',
  `rec_id` char(1) DEFAULT 'T',
  `service_code` char(20) DEFAULT NULL,
  `fee` varchar(7) DEFAULT '',
  `ser_num` char(2) DEFAULT '01',
  `service_date` date DEFAULT NULL,
  `dx` char(4) DEFAULT '',
  `dx1` char(4) DEFAULT '',
  `dx2` char(4) DEFAULT '',
  `status` char(1) DEFAULT NULL,
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `ch1_id` (`ch1_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_payment`
--

DROP TABLE IF EXISTS `billing_on_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_payment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ch1_id` int(11) DEFAULT NULL,
  `payment` decimal(10,2) DEFAULT NULL,
  `paymentTypeId` int(11) DEFAULT NULL,
  `paymentDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billing_on_payment_ch1_id_index` (`ch1_id`),
  KEY `billing_on_payment_paymentTypeId_index` (`paymentTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_proc`
--

DROP TABLE IF EXISTS `billing_on_proc`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_proc` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creator` varchar(6) DEFAULT NULL,
  `action` varchar(60) DEFAULT '',
  `comment` varchar(200) DEFAULT '',
  `object` varchar(60) DEFAULT '',
  `createdatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_on_repo`
--

DROP TABLE IF EXISTS `billing_on_repo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_on_repo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `h_id` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `content` text,
  `createdatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billing_payment_type`
--

DROP TABLE IF EXISTS `billing_payment_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billing_payment_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payment_type` varchar(25) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billingdetail`
--

DROP TABLE IF EXISTS `billingdetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billingdetail` (
  `billing_dt_no` int(10) NOT NULL AUTO_INCREMENT,
  `billing_no` int(10) NOT NULL DEFAULT '0',
  `service_code` varchar(5) DEFAULT NULL,
  `service_desc` varchar(255) DEFAULT NULL,
  `billing_amount` varchar(6) DEFAULT NULL,
  `diagnostic_code` char(3) DEFAULT NULL,
  `appointment_date` date DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `billingunit` char(2) DEFAULT NULL,
  PRIMARY KEY (`billing_dt_no`),
  KEY `billingno` (`billing_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billinginr`
--

DROP TABLE IF EXISTS `billinginr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billinginr` (
  `billinginr_no` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `demographic_name` varchar(60) NOT NULL DEFAULT '',
  `hin` varchar(12) DEFAULT NULL,
  `dob` varchar(8) DEFAULT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `provider_ohip_no` varchar(20) DEFAULT NULL,
  `provider_rma_no` varchar(20) DEFAULT NULL,
  `creator` varchar(6) DEFAULT NULL,
  `diagnostic_code` char(3) DEFAULT NULL,
  `service_code` varchar(6) DEFAULT NULL,
  `service_desc` varchar(255) DEFAULT NULL,
  `billing_amount` varchar(6) DEFAULT NULL,
  `billing_unit` char(1) DEFAULT NULL,
  `createdatetime` datetime NOT NULL DEFAULT '0001-01-01 00:00:00',
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`billinginr_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billingperclimit`
--

DROP TABLE IF EXISTS `billingperclimit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billingperclimit` (
  `service_code` varchar(10) NOT NULL,
  `min` varchar(8) DEFAULT '0',
  `max` varchar(8) DEFAULT '0',
  `effective_date` date DEFAULT '1970-01-01',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billingreferral`
--

DROP TABLE IF EXISTS `billingreferral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billingreferral` (
  `billingreferral_no` int(10) NOT NULL AUTO_INCREMENT,
  `referral_no` varchar(6) NOT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `specialty` varchar(30) DEFAULT NULL,
  `address1` varchar(50) DEFAULT NULL,
  `address2` varchar(50) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `province` varchar(30) DEFAULT NULL,
  `country` varchar(30) DEFAULT NULL,
  `postal` varchar(10) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `fax` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`billingreferral_no`),
  KEY `referral_no` (`referral_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `billingservice`
--

DROP TABLE IF EXISTS `billingservice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `billingservice` (
  `billingservice_no` int(10) NOT NULL AUTO_INCREMENT,
  `service_compositecode` varchar(30) DEFAULT NULL,
  `service_code` varchar(10) DEFAULT NULL,
  `description` text,
  `value` varchar(8) DEFAULT NULL,
  `percentage` varchar(8) DEFAULT NULL,
  `billingservice_date` date DEFAULT NULL,
  `specialty` varchar(15) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  `anaesthesia` char(2) DEFAULT NULL,
  `termination_date` date DEFAULT '9999-12-31',
  `displaystyle` int(10) DEFAULT NULL,
  `sliFlag` tinyint(1) NOT NULL,
  `gstFlag` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`billingservice_no`),
  KEY `billingservice_service_code_index` (`service_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caisi_form`
--

DROP TABLE IF EXISTS `caisi_form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caisi_form` (
  `form_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `facilityId` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `surveyData` text,
  `status` smallint(6) DEFAULT NULL,
  `version` bigint(20) DEFAULT '0',
  PRIMARY KEY (`form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caisi_form_data`
--

DROP TABLE IF EXISTS `caisi_form_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caisi_form_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `instance_id` bigint(20) DEFAULT NULL,
  `page_number` bigint(20) DEFAULT NULL,
  `section_id` bigint(20) DEFAULT NULL,
  `question_id` bigint(20) DEFAULT NULL,
  `value` text,
  `data_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC253B2E74497F4E` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caisi_form_data_tmpsave`
--

DROP TABLE IF EXISTS `caisi_form_data_tmpsave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caisi_form_data_tmpsave` (
  `tmp_form_data_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tmp_instance_id` bigint(20) DEFAULT NULL,
  `page_number` bigint(20) DEFAULT NULL,
  `section_id` bigint(20) DEFAULT NULL,
  `question_id` bigint(20) DEFAULT NULL,
  `value` text,
  `data_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tmp_form_data_id`),
  KEY `caisi_form_data_tmpsave_key1` (`tmp_instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caisi_form_instance`
--

DROP TABLE IF EXISTS `caisi_form_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caisi_form_instance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `form_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caisi_form_instance_tmpsave`
--

DROP TABLE IF EXISTS `caisi_form_instance_tmpsave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caisi_form_instance_tmpsave` (
  `tmp_instance_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `instance_id` bigint(20) NOT NULL,
  `form_id` bigint(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`tmp_instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caisi_form_question`
--

DROP TABLE IF EXISTS `caisi_form_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caisi_form_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `page` bigint(20) DEFAULT NULL,
  `section` bigint(20) DEFAULT NULL,
  `question` bigint(20) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `form_id` bigint(20) DEFAULT NULL,
  `form_question_id` bigint(20) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `caisi_role`
--

DROP TABLE IF EXISTS `caisi_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `caisi_role` (
  `role_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `userDefined` tinyint(4) NOT NULL,
  `oscar_name` varchar(255) NOT NULL DEFAULT '',
  `update_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `casemgmt_cpp`
--

DROP TABLE IF EXISTS `casemgmt_cpp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casemgmt_cpp` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` varchar(10) NOT NULL DEFAULT '',
  `provider_no` varchar(6) NOT NULL,
  `socialHistory` text,
  `familyHistory` text,
  `medicalHistory` text,
  `ongoingConcerns` text,
  `reminders` text,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `primaryPhysician` varchar(255) DEFAULT NULL,
  `primaryCounsellor` varchar(255) DEFAULT NULL,
  `otherFileNumber` varchar(100) DEFAULT NULL,
  `otherSupportSystems` text,
  `pastMedications` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `casemgmt_issue`
--

DROP TABLE IF EXISTS `casemgmt_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casemgmt_issue` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` varchar(20) NOT NULL DEFAULT '',
  `issue_id` int(10) NOT NULL DEFAULT '0',
  `acute` tinyint(1) NOT NULL DEFAULT '0',
  `certain` tinyint(1) NOT NULL DEFAULT '0',
  `major` tinyint(1) NOT NULL DEFAULT '0',
  `resolved` tinyint(1) NOT NULL DEFAULT '0',
  `program_id` int(11) DEFAULT NULL,
  `type` varchar(100) NOT NULL DEFAULT '',
  `update_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  KEY `FK718D130B49CFB32F` (`issue_id`),
  KEY `casemgmt_issue_demographic_no_index` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `casemgmt_issue_notes`
--

DROP TABLE IF EXISTS `casemgmt_issue_notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casemgmt_issue_notes` (
  `id` int(10) NOT NULL DEFAULT '0',
  `note_id` int(10) NOT NULL DEFAULT '0',
  KEY `id` (`id`),
  KEY `note_id` (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `casemgmt_note`
--

DROP TABLE IF EXISTS `casemgmt_note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casemgmt_note` (
  `note_id` int(10) NOT NULL AUTO_INCREMENT,
  `update_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `observation_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(20) NOT NULL DEFAULT '',
  `note` mediumtext NOT NULL,
  `signed` tinyint(1) NOT NULL DEFAULT '0',
  `include_issue_innote` tinyint(1) NOT NULL DEFAULT '0',
  `signing_provider_no` varchar(20) NOT NULL DEFAULT '',
  `encounter_type` varchar(100) NOT NULL DEFAULT '',
  `billing_code` varchar(100) NOT NULL DEFAULT '',
  `program_no` varchar(20) NOT NULL DEFAULT '',
  `reporter_caisi_role` varchar(20) NOT NULL DEFAULT '',
  `reporter_program_team` varchar(20) NOT NULL DEFAULT '',
  `history` mediumtext NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `locked` char(1) DEFAULT NULL,
  `archived` tinyint(1) DEFAULT '0',
  `position` int(10) DEFAULT '0',
  `uuid` char(36) DEFAULT NULL,
  `appointmentNo` int(11) DEFAULT NULL,
  `hourOfEncounterTime` int(11) DEFAULT NULL,
  `minuteOfEncounterTime` int(11) DEFAULT NULL,
  `hourOfEncTransportationTime` int(11) DEFAULT NULL,
  `minuteOfEncTransportationTime` int(11) DEFAULT NULL,
  PRIMARY KEY (`note_id`),
  KEY `FKA8D537806CCA0FC` (`provider_no`),
  KEY `demographic_no` (`demographic_no`),
  KEY `uuid` (`uuid`),
  KEY `program_no` (`program_no`),
  KEY `observation_date` (`observation_date`),
  KEY `casemgmt_note_appointmentNo_index` (`appointmentNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `casemgmt_note_ext`
--

DROP TABLE IF EXISTS `casemgmt_note_ext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casemgmt_note_ext` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `note_id` int(10) NOT NULL,
  `key_val` varchar(64) NOT NULL,
  `value` text,
  `date_value` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `casemgmt_note_ext_note_id_index` (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `casemgmt_note_link`
--

DROP TABLE IF EXISTS `casemgmt_note_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casemgmt_note_link` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `table_name` int(6) NOT NULL,
  `table_id` int(10) NOT NULL,
  `note_id` int(10) NOT NULL,
  `other_id` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `casemgmt_note_link_note_id_index` (`note_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `casemgmt_tmpsave`
--

DROP TABLE IF EXISTS `casemgmt_tmpsave`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `casemgmt_tmpsave` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `demographic_no` bigint(20) DEFAULT NULL,
  `provider_no` varchar(255) DEFAULT NULL,
  `program_id` bigint(20) DEFAULT NULL,
  `note` text,
  `update_date` datetime DEFAULT NULL,
  `note_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_image`
--

DROP TABLE IF EXISTS `client_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_image` (
  `image_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(11) DEFAULT NULL,
  `image_type` varchar(255) DEFAULT NULL,
  `image_data` longtext,
  `update_date` datetime DEFAULT NULL,
  `contents` longblob,
  PRIMARY KEY (`image_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `client_referral`
--

DROP TABLE IF EXISTS `client_referral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_referral` (
  `referral_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL DEFAULT '0',
  `facility_id` int(11) NOT NULL DEFAULT '0',
  `referral_date` datetime DEFAULT NULL,
  `provider_no` varchar(6) NOT NULL,
  `notes` text,
  `program_id` bigint(20) NOT NULL DEFAULT '0',
  `status` varchar(30) DEFAULT NULL,
  `completion_notes` text,
  `temporary_admission_flag` tinyint(1) DEFAULT NULL,
  `completion_date` datetime DEFAULT NULL,
  `present_problems` text,
  `radioRejectionReason` varchar(10) DEFAULT '0',
  PRIMARY KEY (`referral_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinic`
--

DROP TABLE IF EXISTS `clinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinic` (
  `clinic_no` int(10) NOT NULL AUTO_INCREMENT,
  `clinic_name` varchar(100) DEFAULT NULL,
  `clinic_address` varchar(60) DEFAULT '',
  `clinic_city` varchar(40) DEFAULT '',
  `clinic_postal` varchar(15) DEFAULT '',
  `clinic_phone` varchar(50) DEFAULT NULL,
  `clinic_fax` varchar(20) DEFAULT '',
  `clinic_location_code` varchar(10) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `clinic_province` varchar(40) DEFAULT NULL,
  `clinic_delim_phone` text,
  `clinic_delim_fax` text,
  PRIMARY KEY (`clinic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinic_location`
--

DROP TABLE IF EXISTS `clinic_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinic_location` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `clinic_location_no` varchar(15) NOT NULL DEFAULT '',
  `clinic_no` int(10) NOT NULL DEFAULT '0',
  `clinic_location_name` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clinic_nbr`
--

DROP TABLE IF EXISTS `clinic_nbr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clinic_nbr` (
  `nbr_id` int(11) NOT NULL AUTO_INCREMENT,
  `nbr_value` varchar(11) NOT NULL,
  `nbr_string` text,
  `nbr_status` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`nbr_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config_Immunization`
--

DROP TABLE IF EXISTS `config_Immunization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config_Immunization` (
  `setId` int(10) NOT NULL AUTO_INCREMENT,
  `setName` varchar(255) DEFAULT NULL,
  `setXmlDoc` text,
  `createDate` date DEFAULT NULL,
  `providerNo` varchar(6) DEFAULT NULL,
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`setId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consultationRequestExt`
--

DROP TABLE IF EXISTS `consultationRequestExt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationRequestExt` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `requestId` int(10) NOT NULL,
  `name` varchar(100) NOT NULL,
  `value` text NOT NULL,
  `dateCreated` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `requestId` (`requestId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consultationRequests`
--

DROP TABLE IF EXISTS `consultationRequests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationRequests` (
  `referalDate` date DEFAULT NULL,
  `serviceId` int(10) DEFAULT NULL,
  `specId` int(10) DEFAULT NULL,
  `appointmentDate` date DEFAULT NULL,
  `appointmentTime` time DEFAULT NULL,
  `reason` text,
  `clinicalInfo` text,
  `currentMeds` text,
  `allergies` text,
  `providerNo` varchar(6) DEFAULT NULL,
  `demographicNo` int(10) DEFAULT NULL,
  `status` char(2) DEFAULT NULL,
  `statusText` text,
  `sendTo` varchar(20) DEFAULT NULL,
  `requestId` int(10) NOT NULL AUTO_INCREMENT,
  `concurrentProblems` text,
  `urgency` char(2) DEFAULT NULL,
  `patientWillBook` tinyint(1) DEFAULT NULL,
  `followUpDate` datetime DEFAULT NULL,
  `site_no` int(11) DEFAULT NULL,
  `signature_img` varchar(20) DEFAULT NULL,
  `letterheadName` varchar(20) DEFAULT NULL,
  `letterheadAddress` text,
  `letterheadPhone` varchar(50) DEFAULT NULL,
  `letterheadFax` varchar(50) DEFAULT NULL,
  `site_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`requestId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consultationServices`
--

DROP TABLE IF EXISTS `consultationServices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultationServices` (
  `serviceId` int(10) NOT NULL AUTO_INCREMENT,
  `serviceDesc` varchar(255) DEFAULT NULL,
  `active` char(2) DEFAULT NULL,
  PRIMARY KEY (`serviceId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `consultdocs`
--

DROP TABLE IF EXISTS `consultdocs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consultdocs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `requestId` int(10) NOT NULL,
  `document_no` int(10) NOT NULL,
  `doctype` char(1) NOT NULL,
  `deleted` char(1) DEFAULT NULL,
  `attach_date` date DEFAULT NULL,
  `provider_no` varchar(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `country_codes`
--

DROP TABLE IF EXISTS `country_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country_codes` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `country_name` varchar(255) DEFAULT NULL,
  `country_id` char(4) DEFAULT NULL,
  `c_locale` char(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `country_id` (`country_id`),
  KEY `c_locale` (`c_locale`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cr_cert`
--

DROP TABLE IF EXISTS `cr_cert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cr_cert` (
  `cert_id` varchar(37) NOT NULL DEFAULT '',
  `user_specific` tinyint(1) DEFAULT NULL,
  `static_ip` tinyint(1) DEFAULT NULL,
  `unassigned` tinyint(1) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `machine_id` varchar(37) DEFAULT NULL,
  `verification_needed` tinyint(1) DEFAULT NULL,
  `usage_times_before_reverify` int(11) DEFAULT NULL,
  `policy_id` varchar(37) DEFAULT NULL,
  `created_timestamp` datetime DEFAULT NULL,
  `last_changed` datetime DEFAULT NULL,
  `signature` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`cert_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cr_machine`
--

DROP TABLE IF EXISTS `cr_machine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cr_machine` (
  `machine_id` varchar(37) NOT NULL DEFAULT '',
  `ip` varchar(15) DEFAULT NULL,
  `machine_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`machine_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cr_policy`
--

DROP TABLE IF EXISTS `cr_policy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cr_policy` (
  `policy_id` varchar(37) NOT NULL DEFAULT '',
  `static_ip` tinyint(1) DEFAULT NULL,
  `ip` varchar(15) DEFAULT NULL,
  `remote_access` tinyint(1) DEFAULT NULL,
  `generate_super_certs` tinyint(1) DEFAULT NULL,
  `administrate_policies` tinyint(1) DEFAULT NULL,
  `administrate_questions` tinyint(1) DEFAULT NULL,
  `remove_bans` tinyint(1) DEFAULT NULL,
  `user_id` varchar(64) DEFAULT NULL,
  `role_id` varchar(37) DEFAULT NULL,
  `priority` int(11) DEFAULT NULL,
  `usage_times_before_reverify` int(11) DEFAULT NULL,
  `max_time_between_usage` int(11) DEFAULT NULL,
  `expire_cookie` int(11) DEFAULT NULL,
  `ip_filter` varchar(128) DEFAULT NULL,
  `certs_max` int(11) DEFAULT NULL,
  `certs_current` int(11) DEFAULT NULL,
  `default_answer` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`policy_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cr_securityquestion`
--

DROP TABLE IF EXISTS `cr_securityquestion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cr_securityquestion` (
  `question_id` varchar(37) NOT NULL DEFAULT '',
  `user_id` varchar(128) DEFAULT NULL,
  `question` varchar(255) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cr_user`
--

DROP TABLE IF EXISTS `cr_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cr_user` (
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `password_digest` varchar(128) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  `lockedout` tinyint(1) DEFAULT NULL,
  `password_expired` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cr_userrole`
--

DROP TABLE IF EXISTS `cr_userrole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cr_userrole` (
  `user_id` varchar(64) NOT NULL DEFAULT '',
  `user_role` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`user_id`,`user_role`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `criteria`
--

DROP TABLE IF EXISTS `criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `criteria` (
  `CRITERIA_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CRITERIA_TYPE_ID` int(11) NOT NULL,
  `CRITERIA_VALUE` varchar(255) DEFAULT NULL,
  `RANGE_START_VALUE` int(11) DEFAULT NULL,
  `RANGE_END_VALUE` int(11) DEFAULT NULL,
  `TEMPLATE_ID` int(11) DEFAULT NULL,
  `VACANCY_ID` int(11) DEFAULT NULL,
  `MATCH_SCORE_WEIGHT` double NOT NULL,
  `CAN_BE_ADHOC` tinyint(1) NOT NULL,
  PRIMARY KEY (`CRITERIA_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `criteria_selection_option`
--

DROP TABLE IF EXISTS `criteria_selection_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `criteria_selection_option` (
  `SELECT_OPTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CRITERIA_ID` int(11) NOT NULL,
  `OPTION_VALUE` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`SELECT_OPTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `criteria_type`
--

DROP TABLE IF EXISTS `criteria_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `criteria_type` (
  `CRITERIA_TYPE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `FIELD_NAME` varchar(128) NOT NULL,
  `FIELD_TYPE` varchar(128) NOT NULL,
  `DEFAULT_VALUE` varchar(255) DEFAULT NULL,
  `ACTIVE` tinyint(1) NOT NULL,
  `WL_PROGRAM_ID` int(11) DEFAULT NULL,
  `CAN_BE_ADHOC` tinyint(1) NOT NULL,
  PRIMARY KEY (`CRITERIA_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `criteria_type_option`
--

DROP TABLE IF EXISTS `criteria_type_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `criteria_type_option` (
  `OPTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CRITERIA_TYPE_ID` int(11) NOT NULL,
  `DISPLAY_ORDER_NUMBER` int(11) NOT NULL,
  `OPTION_LABEL` varchar(128) NOT NULL,
  `OPTION_VALUE` varchar(255) DEFAULT NULL,
  `RANGE_START_VALUE` int(11) DEFAULT NULL,
  `RANGE_END_VALUE` int(11) DEFAULT NULL,
  PRIMARY KEY (`OPTION_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `cssStyles`
--

DROP TABLE IF EXISTS `cssStyles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cssStyles` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `style` text,
  `status` char(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctl_billingservice`
--

DROP TABLE IF EXISTS `ctl_billingservice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctl_billingservice` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `servicetype_name` varchar(150) DEFAULT NULL,
  `servicetype` varchar(10) DEFAULT NULL,
  `service_code` varchar(10) DEFAULT NULL,
  `service_group_name` varchar(30) DEFAULT NULL,
  `service_group` varchar(30) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `service_order` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctl_billingservice_premium`
--

DROP TABLE IF EXISTS `ctl_billingservice_premium`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctl_billingservice_premium` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `servicetype_name` varchar(150) DEFAULT '',
  `service_code` varchar(10) DEFAULT '',
  `status` char(1) DEFAULT '',
  `update_date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctl_billingtype`
--

DROP TABLE IF EXISTS `ctl_billingtype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctl_billingtype` (
  `servicetype` varchar(10) NOT NULL,
  `billtype` varchar(5) NOT NULL,
  PRIMARY KEY (`servicetype`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctl_diagcode`
--

DROP TABLE IF EXISTS `ctl_diagcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctl_diagcode` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `servicetype` varchar(10) DEFAULT NULL,
  `diagnostic_code` varchar(5) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctl_doc_class`
--

DROP TABLE IF EXISTS `ctl_doc_class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctl_doc_class` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `reportclass` varchar(60) NOT NULL,
  `subclass` varchar(60) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctl_doctype`
--

DROP TABLE IF EXISTS `ctl_doctype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctl_doctype` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `module` varchar(30) NOT NULL DEFAULT '',
  `doctype` varchar(60) NOT NULL DEFAULT '',
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctl_document`
--

DROP TABLE IF EXISTS `ctl_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctl_document` (
  `module` varchar(30) NOT NULL DEFAULT '',
  `module_id` int(6) NOT NULL DEFAULT '0',
  `document_no` int(6) NOT NULL DEFAULT '0',
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`module_id`,`module`,`document_no`),
  KEY `module` (`module`),
  KEY `document_no` (`document_no`),
  KEY `ctl_document_module_index` (`module`),
  KEY `ctl_document_document_no_index` (`document_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctl_frequency`
--

DROP TABLE IF EXISTS `ctl_frequency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctl_frequency` (
  `freqid` tinyint(4) NOT NULL AUTO_INCREMENT,
  `freqcode` varchar(8) NOT NULL DEFAULT '',
  `dailymin` varchar(5) NOT NULL DEFAULT '0',
  `dailymax` varchar(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`freqid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ctl_specialinstructions`
--

DROP TABLE IF EXISTS `ctl_specialinstructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ctl_specialinstructions` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `description` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_filter`
--

DROP TABLE IF EXISTS `custom_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_filter` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `start_date` date NOT NULL DEFAULT '0000-00-00',
  `end_date` date NOT NULL DEFAULT '0000-00-00',
  `status` char(1) NOT NULL DEFAULT '',
  `priority` varchar(20) NOT NULL DEFAULT '',
  `demographic_no` varchar(20) NOT NULL DEFAULT '',
  `programId` varchar(10) DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `shortcut` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_filter_assignees`
--

DROP TABLE IF EXISTS `custom_filter_assignees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_filter_assignees` (
  `filter_id` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `custom_filter_providers`
--

DROP TABLE IF EXISTS `custom_filter_providers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `custom_filter_providers` (
  `filter_id` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataExport`
--

DROP TABLE IF EXISTS `dataExport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataExport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(255) DEFAULT NULL,
  `daterun` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `contactLName` varchar(255) DEFAULT NULL,
  `contactFName` varchar(255) DEFAULT NULL,
  `contactPhone` varchar(255) DEFAULT NULL,
  `contactEmail` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `default_role_access`
--

DROP TABLE IF EXISTS `default_role_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_role_access` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL DEFAULT '0',
  `access_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographic`
--

DROP TABLE IF EXISTS `demographic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographic` (
  `demographic_no` int(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(10) DEFAULT NULL,
  `last_name` varchar(30) NOT NULL DEFAULT '',
  `first_name` varchar(30) NOT NULL DEFAULT '',
  `address` varchar(60) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `province` varchar(20) DEFAULT NULL,
  `postal` varchar(9) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `myOscarUserName` varchar(255) DEFAULT NULL,
  `year_of_birth` varchar(4) DEFAULT NULL,
  `month_of_birth` char(2) DEFAULT NULL,
  `date_of_birth` char(2) DEFAULT NULL,
  `hin` varchar(20) DEFAULT NULL,
  `ver` char(3) DEFAULT NULL,
  `roster_status` varchar(20) DEFAULT NULL,
  `roster_date` date DEFAULT NULL,
  `roster_termination_date` date DEFAULT NULL,
  `roster_termination_reason` varchar(2) DEFAULT NULL,
  `patient_status` varchar(20) DEFAULT NULL,
  `patient_status_date` date DEFAULT NULL,
  `date_joined` date DEFAULT NULL,
  `chart_no` varchar(10) DEFAULT NULL,
  `official_lang` varchar(60) DEFAULT NULL,
  `spoken_lang` varchar(60) DEFAULT NULL,
  `provider_no` varchar(250) DEFAULT NULL,
  `sex` char(1) NOT NULL DEFAULT '',
  `end_date` date DEFAULT NULL,
  `eff_date` date DEFAULT NULL,
  `pcn_indicator` varchar(20) DEFAULT NULL,
  `hc_type` varchar(20) DEFAULT NULL,
  `hc_renew_date` date DEFAULT NULL,
  `family_doctor` varchar(80) DEFAULT NULL,
  `alias` varchar(70) DEFAULT NULL,
  `previousAddress` varchar(255) DEFAULT NULL,
  `children` varchar(255) DEFAULT NULL,
  `sourceOfIncome` varchar(255) DEFAULT NULL,
  `citizenship` varchar(40) DEFAULT NULL,
  `sin` varchar(15) DEFAULT NULL,
  `country_of_origin` char(4) DEFAULT NULL,
  `newsletter` varchar(32) DEFAULT NULL,
  `anonymous` varchar(32) DEFAULT NULL,
  `lastUpdateUser` varchar(6) DEFAULT NULL,
  `lastUpdateDate` date DEFAULT NULL,
  PRIMARY KEY (`demographic_no`),
  UNIQUE KEY `myOscarUserName` (`myOscarUserName`),
  KEY `hin` (`hin`),
  KEY `name` (`last_name`,`first_name`),
  KEY `country_of_origin` (`country_of_origin`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographicArchive`
--

DROP TABLE IF EXISTS `demographicArchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographicArchive` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `title` varchar(10) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `address` varchar(60) DEFAULT NULL,
  `city` varchar(20) DEFAULT NULL,
  `province` varchar(20) DEFAULT NULL,
  `postal` varchar(9) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `myOscarUserName` varchar(255) DEFAULT NULL,
  `year_of_birth` varchar(4) DEFAULT NULL,
  `month_of_birth` char(2) DEFAULT NULL,
  `date_of_birth` char(2) DEFAULT NULL,
  `hin` varchar(20) DEFAULT NULL,
  `ver` char(3) DEFAULT NULL,
  `roster_status` varchar(20) DEFAULT NULL,
  `roster_date` date DEFAULT NULL,
  `roster_termination_date` date DEFAULT NULL,
  `roster_termination_reason` varchar(2) DEFAULT NULL,
  `patient_status` varchar(20) DEFAULT NULL,
  `patient_status_date` date DEFAULT NULL,
  `date_joined` date DEFAULT NULL,
  `chart_no` varchar(10) DEFAULT NULL,
  `official_lang` varchar(60) DEFAULT NULL,
  `spoken_lang` varchar(60) DEFAULT NULL,
  `provider_no` varchar(250) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `eff_date` date DEFAULT NULL,
  `pcn_indicator` varchar(20) DEFAULT NULL,
  `hc_type` varchar(20) DEFAULT NULL,
  `hc_renew_date` date DEFAULT NULL,
  `family_doctor` varchar(80) DEFAULT NULL,
  `alias` varchar(70) DEFAULT NULL,
  `previousAddress` varchar(255) DEFAULT NULL,
  `children` varchar(255) DEFAULT NULL,
  `sourceOfIncome` varchar(255) DEFAULT NULL,
  `citizenship` varchar(40) DEFAULT NULL,
  `sin` varchar(15) DEFAULT NULL,
  `country_of_origin` char(4) DEFAULT NULL,
  `newsletter` varchar(32) DEFAULT NULL,
  `anonymous` varchar(32) DEFAULT NULL,
  `lastUpdateUser` varchar(6) DEFAULT NULL,
  `lastUpdateDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographicExt`
--

DROP TABLE IF EXISTS `demographicExt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographicExt` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `key_val` varchar(64) DEFAULT NULL,
  `value` text,
  `date_time` datetime DEFAULT NULL,
  `hidden` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `demographic_no` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographicPharmacy`
--

DROP TABLE IF EXISTS `demographicPharmacy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographicPharmacy` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `pharmacyID` int(10) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT NULL,
  `status` char(1) DEFAULT '1',
  `addDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographicQueryFavourites`
--

DROP TABLE IF EXISTS `demographicQueryFavourites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographicQueryFavourites` (
  `favId` int(9) NOT NULL AUTO_INCREMENT,
  `selects` text,
  `age` varchar(255) DEFAULT NULL,
  `startYear` varchar(8) DEFAULT NULL,
  `endYear` varchar(8) DEFAULT NULL,
  `firstName` varchar(255) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  `rosterStatus` text,
  `sex` varchar(10) DEFAULT NULL,
  `providerNo` text,
  `patientStatus` text,
  `queryName` varchar(255) DEFAULT NULL,
  `archived` char(1) DEFAULT NULL,
  PRIMARY KEY (`favId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographicSets`
--

DROP TABLE IF EXISTS `demographicSets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographicSets` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `set_name` varchar(20) DEFAULT NULL,
  `eligibility` char(1) DEFAULT NULL,
  `archive` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographic_merged`
--

DROP TABLE IF EXISTS `demographic_merged`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographic_merged` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `merged_to` int(10) NOT NULL,
  `deleted` int(1) NOT NULL DEFAULT '0',
  `lastUpdateUser` varchar(6) DEFAULT NULL,
  `lastUpdateDate` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `dem_merged` (`demographic_no`,`merged_to`,`deleted`),
  KEY `dem_merged_dem` (`demographic_no`,`deleted`),
  KEY `dem_merged_merge` (`merged_to`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographicaccessory`
--

DROP TABLE IF EXISTS `demographicaccessory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographicaccessory` (
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `content` text,
  PRIMARY KEY (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographiccust`
--

DROP TABLE IF EXISTS `demographiccust`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographiccust` (
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `cust1` varchar(255) DEFAULT NULL,
  `cust2` varchar(255) DEFAULT NULL,
  `cust3` varchar(255) DEFAULT NULL,
  `cust4` varchar(255) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`demographic_no`),
  KEY `cust1` (`cust1`),
  KEY `cust2` (`cust2`),
  KEY `cust3` (`cust3`),
  KEY `cust4` (`cust4`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `demographicstudy`
--

DROP TABLE IF EXISTS `demographicstudy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `demographicstudy` (
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `study_no` int(3) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`demographic_no`,`study_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `desannualreviewplan`
--

DROP TABLE IF EXISTS `desannualreviewplan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `desannualreviewplan` (
  `des_no` int(10) NOT NULL AUTO_INCREMENT,
  `des_date` date NOT NULL DEFAULT '0001-01-01',
  `des_time` time NOT NULL DEFAULT '00:00:00',
  `demographic_no` int(10) DEFAULT '0',
  `form_no` int(10) DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `risk_content` text,
  `checklist_content` text,
  PRIMARY KEY (`des_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `desaprisk`
--

DROP TABLE IF EXISTS `desaprisk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `desaprisk` (
  `desaprisk_no` int(10) NOT NULL AUTO_INCREMENT,
  `desaprisk_date` date NOT NULL DEFAULT '0001-01-01',
  `desaprisk_time` time NOT NULL DEFAULT '00:00:00',
  `demographic_no` int(10) DEFAULT '0',
  `form_no` int(10) DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `risk_content` text,
  `checklist_content` text,
  PRIMARY KEY (`desaprisk_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diagnosticcode`
--

DROP TABLE IF EXISTS `diagnosticcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diagnosticcode` (
  `diagnosticcode_no` int(5) NOT NULL AUTO_INCREMENT,
  `diagnostic_code` varchar(5) NOT NULL DEFAULT '',
  `description` text,
  `status` char(1) DEFAULT NULL,
  `region` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`diagnosticcode_no`),
  KEY `diagnosticcode_diagnostic_code_index` (`diagnostic_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `diseases`
--

DROP TABLE IF EXISTS `diseases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `diseases` (
  `diseaseid` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `ICD9_E` char(6) NOT NULL DEFAULT '',
  `entry_date` date DEFAULT NULL,
  PRIMARY KEY (`diseaseid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doc_category`
--

DROP TABLE IF EXISTS `doc_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_category` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `category` varchar(40) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `testmark` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`cat_id`),
  KEY `parent_id` (`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `doc_manager`
--

DROP TABLE IF EXISTS `doc_manager`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doc_manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `doc_path` varchar(100) DEFAULT NULL,
  `demographic_no` int(11) NOT NULL,
  `primary_provider_no` varchar(6) NOT NULL,
  `reviewed_flag` tinyint(1) NOT NULL,
  `upload_from_id` int(11) DEFAULT NULL,
  `tickler_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_doc_manager` (`category_id`),
  CONSTRAINT `doc_manager_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `doc_category` (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document`
--

DROP TABLE IF EXISTS `document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document` (
  `document_no` int(11) NOT NULL AUTO_INCREMENT,
  `doctype` varchar(60) DEFAULT NULL,
  `docClass` varchar(60) DEFAULT NULL,
  `docSubClass` varchar(60) DEFAULT NULL,
  `docdesc` varchar(255) NOT NULL DEFAULT '',
  `docxml` text,
  `docfilename` varchar(255) NOT NULL DEFAULT '',
  `doccreator` varchar(30) NOT NULL DEFAULT '',
  `responsible` varchar(30) NOT NULL DEFAULT '',
  `source` varchar(60) DEFAULT NULL,
  `sourceFacility` varchar(120) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT '',
  `contenttype` varchar(60) NOT NULL DEFAULT '',
  `public1` int(1) NOT NULL DEFAULT '0',
  `observationdate` date DEFAULT NULL,
  `reviewer` varchar(30) DEFAULT '',
  `reviewdatetime` datetime DEFAULT NULL,
  `number_of_pages` int(6) NOT NULL DEFAULT '0',
  `appointment_no` int(11) DEFAULT NULL,
  PRIMARY KEY (`document_no`),
  KEY `document_appointment_no_index` (`appointment_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `document_storage`
--

DROP TABLE IF EXISTS `document_storage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `document_storage` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `documentNo` int(10) DEFAULT NULL,
  `fileContents` mediumblob,
  `uploadDate` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drugReason`
--

DROP TABLE IF EXISTS `drugReason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drugReason` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `drugId` int(10) NOT NULL,
  `codingSystem` varchar(255) DEFAULT NULL,
  `code` varchar(255) DEFAULT NULL,
  `comments` text,
  `primaryReasonFlag` tinyint(1) NOT NULL,
  `archivedFlag` tinyint(1) NOT NULL,
  `archivedReason` text,
  `demographicNo` int(10) NOT NULL,
  `providerNo` varchar(6) NOT NULL,
  `dateCoded` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drugId` (`drugId`),
  KEY `archivedFlag` (`archivedFlag`),
  KEY `codingSystem` (`codingSystem`(30),`code`(30))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `drugs`
--

DROP TABLE IF EXISTS `drugs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `drugs` (
  `drugid` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `rx_date` date NOT NULL DEFAULT '0001-01-01',
  `end_date` date NOT NULL DEFAULT '0001-01-01',
  `written_date` date DEFAULT '0001-01-01',
  `pickup_datetime` datetime DEFAULT NULL,
  `BN` varchar(255) DEFAULT '',
  `GCN_SEQNO` decimal(10,0) NOT NULL DEFAULT '0',
  `customName` varchar(60) DEFAULT NULL,
  `takemin` float DEFAULT NULL,
  `takemax` float DEFAULT NULL,
  `freqcode` varchar(6) DEFAULT NULL,
  `duration` varchar(4) DEFAULT NULL,
  `durunit` char(1) DEFAULT NULL,
  `quantity` varchar(20) DEFAULT NULL,
  `repeat` tinyint(4) DEFAULT NULL,
  `last_refill_date` date DEFAULT NULL,
  `nosubs` tinyint(1) NOT NULL DEFAULT '0',
  `prn` tinyint(1) NOT NULL DEFAULT '0',
  `special` text,
  `special_instruction` text,
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `GN` varchar(255) DEFAULT NULL,
  `ATC` varchar(20) DEFAULT NULL,
  `script_no` int(10) DEFAULT NULL,
  `regional_identifier` varchar(100) DEFAULT NULL,
  `unit` varchar(5) DEFAULT 'tab',
  `method` varchar(5) DEFAULT 'Take',
  `route` varchar(5) DEFAULT 'PO',
  `drug_form` varchar(50) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `dosage` text,
  `custom_instructions` tinyint(1) DEFAULT '0',
  `unitName` varchar(10) DEFAULT NULL,
  `custom_note` tinyint(1) DEFAULT NULL,
  `long_term` tinyint(1) DEFAULT NULL,
  `non_authoritative` tinyint(1) DEFAULT NULL,
  `past_med` tinyint(1) DEFAULT NULL,
  `patient_compliance` tinyint(1) DEFAULT NULL,
  `outside_provider_name` varchar(100) DEFAULT NULL,
  `outside_provider_ohip` varchar(20) DEFAULT NULL,
  `archived_reason` varchar(100) DEFAULT '',
  `archived_date` datetime DEFAULT NULL,
  `hide_from_drug_profile` tinyint(1) DEFAULT '0',
  `eTreatmentType` varchar(20) DEFAULT NULL,
  `rxStatus` varchar(20) DEFAULT NULL,
  `dispense_interval` int(10) DEFAULT NULL,
  `refill_duration` int(10) DEFAULT NULL,
  `refill_quantity` int(10) DEFAULT NULL,
  `hide_cpp` tinyint(1) DEFAULT NULL,
  `position` int(10) NOT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `start_date_unknown` tinyint(1) DEFAULT NULL,
  `lastUpdateDate` datetime NOT NULL,
  PRIMARY KEY (`drugid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dsGuidelineProviderMap`
--

DROP TABLE IF EXISTS `dsGuidelineProviderMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dsGuidelineProviderMap` (
  `mapid` int(11) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(11) NOT NULL,
  `guideline_uuid` varchar(60) NOT NULL,
  PRIMARY KEY (`mapid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dsGuidelines`
--

DROP TABLE IF EXISTS `dsGuidelines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dsGuidelines` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uuid` varchar(60) NOT NULL,
  `title` varchar(100) NOT NULL,
  `version` int(11) DEFAULT NULL,
  `author` varchar(60) NOT NULL,
  `xml` text,
  `source` varchar(60) NOT NULL,
  `engine` varchar(60) NOT NULL,
  `dateStart` datetime DEFAULT NULL,
  `dateDecomissioned` datetime DEFAULT NULL,
  `status` varchar(1) DEFAULT 'A',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dx_associations`
--

DROP TABLE IF EXISTS `dx_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dx_associations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dx_codetype` varchar(50) NOT NULL,
  `dx_code` varchar(50) NOT NULL,
  `codetype` varchar(50) NOT NULL,
  `code` varchar(50) NOT NULL,
  `update_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dxresearch`
--

DROP TABLE IF EXISTS `dxresearch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dxresearch` (
  `dxresearch_no` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT '0',
  `start_date` date DEFAULT '0001-01-01',
  `update_date` date DEFAULT '0001-01-01',
  `status` char(1) DEFAULT 'A',
  `dxresearch_code` varchar(10) DEFAULT '',
  `coding_system` varchar(20) DEFAULT NULL,
  `association` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`dxresearch_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eChart`
--

DROP TABLE IF EXISTS `eChart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eChart` (
  `eChartId` int(15) NOT NULL AUTO_INCREMENT,
  `timeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `demographicNo` int(10) NOT NULL DEFAULT '0',
  `providerNo` varchar(6) NOT NULL DEFAULT '',
  `subject` varchar(128) DEFAULT NULL,
  `socialHistory` text,
  `familyHistory` text,
  `medicalHistory` text,
  `ongoingConcerns` text,
  `reminders` text,
  `encounter` text,
  PRIMARY KEY (`eChartId`),
  KEY `demographicno` (`demographicNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 MAX_ROWS=200000000 AVG_ROW_LENGTH=9000;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eform`
--

DROP TABLE IF EXISTS `eform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eform` (
  `fid` int(8) NOT NULL AUTO_INCREMENT,
  `form_name` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `form_date` date DEFAULT NULL,
  `form_time` time DEFAULT NULL,
  `form_creator` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `form_html` mediumtext,
  `patient_independent` tinyint(1) DEFAULT NULL,
  `roleType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`fid`),
  UNIQUE KEY `id` (`fid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eform_data`
--

DROP TABLE IF EXISTS `eform_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eform_data` (
  `fdid` int(8) NOT NULL AUTO_INCREMENT,
  `fid` int(8) NOT NULL DEFAULT '0',
  `form_name` varchar(255) DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `form_date` date DEFAULT NULL,
  `form_time` time DEFAULT NULL,
  `form_provider` varchar(255) DEFAULT NULL,
  `form_data` mediumtext,
  `patient_independent` tinyint(1) NOT NULL,
  `roleType` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`fdid`),
  UNIQUE KEY `id` (`fdid`),
  KEY `idx_eform_data_demographic_no` (`demographic_no`),
  KEY `idx_eform_data_status` (`status`),
  KEY `idx_eform_data_from_date` (`form_date`),
  KEY `idx_eform_data_form_name` (`form_name`),
  KEY `idx_eform_data_subject` (`subject`),
  KEY `idx_eform_data_fid` (`fid`),
  KEY `idx_eform_data_form_provider` (`form_provider`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eform_groups`
--

DROP TABLE IF EXISTS `eform_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eform_groups` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `fid` int(8) NOT NULL DEFAULT '0',
  `group_name` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eform_values`
--

DROP TABLE IF EXISTS `eform_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eform_values` (
  `id` int(16) NOT NULL AUTO_INCREMENT,
  `fdid` int(8) DEFAULT NULL,
  `fid` int(8) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT '0',
  `var_name` varchar(30) NOT NULL DEFAULT '',
  `var_value` text,
  PRIMARY KEY (`id`),
  KEY `eform_values_varname_varvalue` (`var_name`,`var_value`(30))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter` (
  `encounter_no` int(12) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `encounter_date` date NOT NULL DEFAULT '0001-01-01',
  `encounter_time` time NOT NULL DEFAULT '00:00:00',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `subject` varchar(100) DEFAULT NULL,
  `content` text,
  `encounterattachment` text,
  PRIMARY KEY (`encounter_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encounterForm`
--

DROP TABLE IF EXISTS `encounterForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounterForm` (
  `form_name` varchar(30) NOT NULL DEFAULT '',
  `form_value` varchar(255) NOT NULL DEFAULT '',
  `form_table` varchar(50) NOT NULL DEFAULT '',
  `hidden` int(5) NOT NULL DEFAULT '0',
  PRIMARY KEY (`form_value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encounterWindow`
--

DROP TABLE IF EXISTS `encounterWindow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounterWindow` (
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `rowOneSize` int(10) NOT NULL DEFAULT '60',
  `rowTwoSize` int(10) NOT NULL DEFAULT '60',
  `presBoxSize` int(10) NOT NULL DEFAULT '30',
  `rowThreeSize` int(10) NOT NULL DEFAULT '378',
  PRIMARY KEY (`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `encountertemplate`
--

DROP TABLE IF EXISTS `encountertemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encountertemplate` (
  `encountertemplate_name` varchar(50) NOT NULL DEFAULT '',
  `createdatetime` datetime DEFAULT NULL,
  `encountertemplate_value` text,
  `creator` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`encountertemplate_name`),
  KEY `encountertemplate_url` (`createdatetime`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eyeform_macro_billing`
--

DROP TABLE IF EXISTS `eyeform_macro_billing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eyeform_macro_billing` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `macroId` int(11) DEFAULT NULL,
  `billingServiceCode` varchar(50) DEFAULT NULL,
  `multiplier` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eyeform_macro_def`
--

DROP TABLE IF EXISTS `eyeform_macro_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eyeform_macro_def` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `macroName` varchar(255) DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  `copyFromLastImpression` tinyint(1) DEFAULT NULL,
  `impressionText` text,
  `planText` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `facility_message`
--

DROP TABLE IF EXISTS `facility_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `facility_message` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `message` text NOT NULL,
  `creation_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `expiry_date` datetime NOT NULL DEFAULT '1900-01-01 00:00:00',
  `facility_id` int(11) DEFAULT NULL,
  `facility_name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favorites`
--

DROP TABLE IF EXISTS `favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favorites` (
  `favoriteid` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `favoritename` varchar(50) NOT NULL DEFAULT '',
  `BN` varchar(30) DEFAULT NULL,
  `GCN_SEQNO` decimal(10,0) NOT NULL DEFAULT '0',
  `customName` varchar(60) DEFAULT NULL,
  `takemin` float DEFAULT NULL,
  `takemax` float DEFAULT NULL,
  `freqcode` varchar(6) DEFAULT NULL,
  `duration` varchar(4) DEFAULT NULL,
  `durunit` char(1) DEFAULT NULL,
  `quantity` varchar(20) DEFAULT NULL,
  `repeat` tinyint(4) DEFAULT NULL,
  `nosubs` tinyint(1) NOT NULL DEFAULT '0',
  `prn` tinyint(1) NOT NULL DEFAULT '0',
  `special` varchar(255) NOT NULL DEFAULT '',
  `GN` varchar(255) DEFAULT NULL,
  `ATC` varchar(255) DEFAULT NULL,
  `regional_identifier` varchar(100) DEFAULT NULL,
  `unit` varchar(5) DEFAULT 'tab',
  `method` varchar(5) DEFAULT 'Take',
  `route` varchar(5) DEFAULT 'PO',
  `drug_form` varchar(50) DEFAULT NULL,
  `dosage` text,
  `custom_instructions` tinyint(1) DEFAULT '0',
  `unitName` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`favoriteid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `favoritesprivilege`
--

DROP TABLE IF EXISTS `favoritesprivilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `favoritesprivilege` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) DEFAULT NULL,
  `opentopublic` tinyint(1) DEFAULT NULL,
  `writeable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `fileUploadCheck`
--

DROP TABLE IF EXISTS `fileUploadCheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `fileUploadCheck` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `filename` varchar(255) NOT NULL DEFAULT '',
  `md5sum` varchar(255) DEFAULT NULL,
  `date_time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flowsheet_customization`
--

DROP TABLE IF EXISTS `flowsheet_customization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flowsheet_customization` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `flowsheet` varchar(40) DEFAULT NULL,
  `action` varchar(10) DEFAULT NULL,
  `measurement` varchar(255) DEFAULT NULL,
  `payload` text,
  `provider_no` varchar(6) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `archived` char(1) DEFAULT '0',
  `archived_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flowsheet_drug`
--

DROP TABLE IF EXISTS `flowsheet_drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flowsheet_drug` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `flowsheet` varchar(40) DEFAULT NULL,
  `atc_code` varchar(40) DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `archived` char(1) DEFAULT '0',
  `archived_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `flowsheet_dx`
--

DROP TABLE IF EXISTS `flowsheet_dx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flowsheet_dx` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `flowsheet` varchar(40) DEFAULT NULL,
  `dx_code` varchar(40) DEFAULT NULL,
  `dx_code_type` varchar(40) DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `archived` char(1) DEFAULT '0',
  `archived_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form`
--

DROP TABLE IF EXISTS `form`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form` (
  `form_no` int(12) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `form_date` date NOT NULL DEFAULT '0001-01-01',
  `form_time` time NOT NULL DEFAULT '00:00:00',
  `form_name` varchar(50) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`form_no`),
  KEY `form_select` (`demographic_no`,`form_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form2MinWalk`
--

DROP TABLE IF EXISTS `form2MinWalk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form2MinWalk` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `distance` varchar(255) DEFAULT NULL,
  `Q1tried` tinyint(1) DEFAULT NULL,
  `Q1FullTandem3To9` tinyint(1) DEFAULT NULL,
  `Q1SideBySide10` tinyint(1) DEFAULT NULL,
  `Q1FullTandem10` tinyint(1) DEFAULT NULL,
  `Q1SemiTandem10` tinyint(1) DEFAULT NULL,
  `Q1Cmt` varchar(255) DEFAULT NULL,
  `Q2time1` varchar(255) DEFAULT NULL,
  `Q2time2` varchar(255) DEFAULT NULL,
  `Q2Cmt` varchar(255) DEFAULT NULL,
  `Q3Unable` tinyint(1) DEFAULT NULL,
  `Q3From11To13s` tinyint(1) DEFAULT NULL,
  `Q3LessThan16s` tinyint(1) DEFAULT NULL,
  `Q3LessThan11s` tinyint(1) DEFAULT NULL,
  `Q3From13To16s` tinyint(1) DEFAULT NULL,
  `Q3Cmt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formAR`
--

DROP TABLE IF EXISTS `formAR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formAR` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_lastVisited` char(3) DEFAULT NULL,
  `c_pName` varchar(60) DEFAULT NULL,
  `c_address` varchar(80) DEFAULT NULL,
  `pg1_dateOfBirth` date DEFAULT NULL,
  `pg1_age` char(2) DEFAULT NULL,
  `pg1_msSingle` tinyint(1) DEFAULT NULL,
  `pg1_msCommonLaw` tinyint(1) DEFAULT NULL,
  `pg1_msMarried` tinyint(1) DEFAULT NULL,
  `pg1_eduLevel` varchar(25) DEFAULT NULL,
  `pg1_occupation` varchar(25) DEFAULT NULL,
  `pg1_language` varchar(25) DEFAULT NULL,
  `pg1_homePhone` varchar(20) DEFAULT NULL,
  `pg1_workPhone` varchar(20) DEFAULT NULL,
  `pg1_partnerName` varchar(50) DEFAULT NULL,
  `pg1_partnerAge` char(2) DEFAULT NULL,
  `pg1_partnerOccupation` varchar(25) DEFAULT NULL,
  `pg1_baObs` tinyint(1) DEFAULT NULL,
  `pg1_baFP` tinyint(1) DEFAULT NULL,
  `pg1_baMidwife` tinyint(1) DEFAULT NULL,
  `c_ba` varchar(25) DEFAULT NULL,
  `pg1_famPhys` varchar(100) DEFAULT NULL,
  `pg1_ncPed` tinyint(1) DEFAULT NULL,
  `pg1_ncFP` tinyint(1) DEFAULT NULL,
  `pg1_ncMidwife` tinyint(1) DEFAULT NULL,
  `c_nc` varchar(25) DEFAULT NULL,
  `pg1_ethnicBg` varchar(100) DEFAULT NULL,
  `pg1_vbac` tinyint(1) DEFAULT NULL,
  `pg1_repeatCS` tinyint(1) DEFAULT NULL,
  `c_allergies` text,
  `c_meds` text,
  `pg1_menLMP` varchar(10) DEFAULT NULL,
  `pg1_menCycle` varchar(7) DEFAULT NULL,
  `pg1_menReg` tinyint(1) DEFAULT NULL,
  `pg1_menEDB` varchar(10) DEFAULT NULL,
  `pg1_iud` tinyint(1) DEFAULT NULL,
  `pg1_hormone` tinyint(1) DEFAULT NULL,
  `pg1_hormoneType` varchar(25) DEFAULT NULL,
  `pg1_otherAR1` tinyint(1) DEFAULT NULL,
  `pg1_otherAR1Name` varchar(25) DEFAULT NULL,
  `pg1_lastUsed` varchar(10) DEFAULT NULL,
  `c_finalEDB` date DEFAULT NULL,
  `c_gravida` varchar(5) DEFAULT NULL,
  `c_term` varchar(5) DEFAULT NULL,
  `c_prem` varchar(5) DEFAULT NULL,
  `pg1_ectopic` tinyint(1) DEFAULT NULL,
  `pg1_ectopicBox` char(2) DEFAULT NULL,
  `pg1_termination` tinyint(1) DEFAULT NULL,
  `pg1_terminationBox` char(2) DEFAULT NULL,
  `pg1_spontaneous` tinyint(1) DEFAULT NULL,
  `pg1_spontaneousBox` char(2) DEFAULT NULL,
  `pg1_stillborn` tinyint(1) DEFAULT NULL,
  `pg1_stillbornBox` char(2) DEFAULT NULL,
  `c_living` varchar(10) DEFAULT NULL,
  `pg1_multi` varchar(10) DEFAULT NULL,
  `pg1_year1` varchar(10) DEFAULT NULL,
  `pg1_sex1` char(1) DEFAULT NULL,
  `pg1_oh_gest1` varchar(5) DEFAULT NULL,
  `pg1_weight1` varchar(6) DEFAULT NULL,
  `pg1_length1` varchar(6) DEFAULT NULL,
  `pg1_place1` varchar(20) DEFAULT NULL,
  `pg1_svb1` tinyint(1) DEFAULT NULL,
  `pg1_cs1` tinyint(1) DEFAULT NULL,
  `pg1_ass1` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments1` varchar(80) DEFAULT NULL,
  `pg1_year2` varchar(10) DEFAULT NULL,
  `pg1_sex2` char(1) DEFAULT NULL,
  `pg1_oh_gest2` varchar(5) DEFAULT NULL,
  `pg1_weight2` varchar(6) DEFAULT NULL,
  `pg1_length2` varchar(6) DEFAULT NULL,
  `pg1_place2` varchar(20) DEFAULT NULL,
  `pg1_svb2` tinyint(1) DEFAULT NULL,
  `pg1_cs2` tinyint(1) DEFAULT NULL,
  `pg1_ass2` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments2` varchar(80) DEFAULT NULL,
  `pg1_year3` varchar(10) DEFAULT NULL,
  `pg1_sex3` char(1) DEFAULT NULL,
  `pg1_oh_gest3` varchar(5) DEFAULT NULL,
  `pg1_weight3` varchar(6) DEFAULT NULL,
  `pg1_length3` varchar(6) DEFAULT NULL,
  `pg1_place3` varchar(20) DEFAULT NULL,
  `pg1_svb3` tinyint(1) DEFAULT NULL,
  `pg1_cs3` tinyint(1) DEFAULT NULL,
  `pg1_ass3` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments3` varchar(80) DEFAULT NULL,
  `pg1_year4` varchar(10) DEFAULT NULL,
  `pg1_sex4` char(1) DEFAULT NULL,
  `pg1_oh_gest4` varchar(5) DEFAULT NULL,
  `pg1_weight4` varchar(6) DEFAULT NULL,
  `pg1_length4` varchar(6) DEFAULT NULL,
  `pg1_place4` varchar(20) DEFAULT NULL,
  `pg1_svb4` tinyint(1) DEFAULT NULL,
  `pg1_cs4` tinyint(1) DEFAULT NULL,
  `pg1_ass4` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments4` varchar(80) DEFAULT NULL,
  `pg1_year5` varchar(10) DEFAULT NULL,
  `pg1_sex5` char(1) DEFAULT NULL,
  `pg1_oh_gest5` varchar(5) DEFAULT NULL,
  `pg1_weight5` varchar(6) DEFAULT NULL,
  `pg1_length5` varchar(6) DEFAULT NULL,
  `pg1_place5` varchar(20) DEFAULT NULL,
  `pg1_svb5` tinyint(1) DEFAULT NULL,
  `pg1_cs5` tinyint(1) DEFAULT NULL,
  `pg1_ass5` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments5` varchar(80) DEFAULT NULL,
  `pg1_year6` varchar(10) DEFAULT NULL,
  `pg1_sex6` char(1) DEFAULT NULL,
  `pg1_oh_gest6` varchar(5) DEFAULT NULL,
  `pg1_weight6` varchar(6) DEFAULT NULL,
  `pg1_length6` varchar(6) DEFAULT NULL,
  `pg1_place6` varchar(20) DEFAULT NULL,
  `pg1_svb6` tinyint(1) DEFAULT NULL,
  `pg1_cs6` tinyint(1) DEFAULT NULL,
  `pg1_ass6` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments6` varchar(80) DEFAULT NULL,
  `pg1_cp1` tinyint(1) DEFAULT NULL,
  `pg1_cp2` tinyint(1) DEFAULT NULL,
  `pg1_cp3` tinyint(1) DEFAULT NULL,
  `pg1_box3` char(3) DEFAULT NULL,
  `pg1_cp4` tinyint(1) DEFAULT NULL,
  `pg1_cp5` tinyint(1) DEFAULT NULL,
  `pg1_box5` char(3) DEFAULT NULL,
  `pg1_cp6` tinyint(1) DEFAULT NULL,
  `pg1_cp7` tinyint(1) DEFAULT NULL,
  `pg1_cp8` tinyint(1) DEFAULT NULL,
  `pg1_naFolic` tinyint(1) DEFAULT NULL,
  `pg1_naMilk` tinyint(1) DEFAULT NULL,
  `pg1_naDietBal` tinyint(1) DEFAULT NULL,
  `pg1_naDietRes` tinyint(1) DEFAULT NULL,
  `pg1_naRef` tinyint(1) DEFAULT NULL,
  `pg1_yes9` tinyint(1) DEFAULT NULL,
  `pg1_no9` tinyint(1) DEFAULT NULL,
  `pg1_yes10` tinyint(1) DEFAULT NULL,
  `pg1_no10` tinyint(1) DEFAULT NULL,
  `pg1_yes11` tinyint(1) DEFAULT NULL,
  `pg1_no11` tinyint(1) DEFAULT NULL,
  `pg1_yes12` tinyint(1) DEFAULT NULL,
  `pg1_no12` tinyint(1) DEFAULT NULL,
  `pg1_yes13` tinyint(1) DEFAULT NULL,
  `pg1_no13` tinyint(1) DEFAULT NULL,
  `pg1_yes14` tinyint(1) DEFAULT NULL,
  `pg1_no14` tinyint(1) DEFAULT NULL,
  `pg1_yes15` tinyint(1) DEFAULT NULL,
  `pg1_no15` tinyint(1) DEFAULT NULL,
  `pg1_yes16` tinyint(1) DEFAULT NULL,
  `pg1_no16` tinyint(1) DEFAULT NULL,
  `pg1_yes17` tinyint(1) DEFAULT NULL,
  `pg1_no17` tinyint(1) DEFAULT NULL,
  `pg1_yes18` tinyint(1) DEFAULT NULL,
  `pg1_no18` tinyint(1) DEFAULT NULL,
  `pg1_yes19` tinyint(1) DEFAULT NULL,
  `pg1_no19` tinyint(1) DEFAULT NULL,
  `pg1_yes20` tinyint(1) DEFAULT NULL,
  `pg1_no20` tinyint(1) DEFAULT NULL,
  `pg1_yes21` tinyint(1) DEFAULT NULL,
  `pg1_no21` tinyint(1) DEFAULT NULL,
  `pg1_yes22` tinyint(1) DEFAULT NULL,
  `pg1_no22` tinyint(1) DEFAULT NULL,
  `pg1_yes23` tinyint(1) DEFAULT NULL,
  `pg1_no23` tinyint(1) DEFAULT NULL,
  `pg1_yes24` tinyint(1) DEFAULT NULL,
  `pg1_no24` tinyint(1) DEFAULT NULL,
  `pg1_yes25` tinyint(1) DEFAULT NULL,
  `pg1_no25` tinyint(1) DEFAULT NULL,
  `pg1_box25` varchar(25) DEFAULT NULL,
  `pg1_yes26` tinyint(1) DEFAULT NULL,
  `pg1_no26` tinyint(1) DEFAULT NULL,
  `pg1_yes27` tinyint(1) DEFAULT NULL,
  `pg1_no27` tinyint(1) DEFAULT NULL,
  `pg1_yes28` tinyint(1) DEFAULT NULL,
  `pg1_no28` tinyint(1) DEFAULT NULL,
  `pg1_yes29` tinyint(1) DEFAULT NULL,
  `pg1_no29` tinyint(1) DEFAULT NULL,
  `pg1_yes30` tinyint(1) DEFAULT NULL,
  `pg1_no30` tinyint(1) DEFAULT NULL,
  `pg1_yes31` tinyint(1) DEFAULT NULL,
  `pg1_no31` tinyint(1) DEFAULT NULL,
  `pg1_yes32` tinyint(1) DEFAULT NULL,
  `pg1_no32` tinyint(1) DEFAULT NULL,
  `pg1_yes33` tinyint(1) DEFAULT NULL,
  `pg1_no33` tinyint(1) DEFAULT NULL,
  `pg1_yes34` tinyint(1) DEFAULT NULL,
  `pg1_no34` tinyint(1) DEFAULT NULL,
  `pg1_yes35` tinyint(1) DEFAULT NULL,
  `pg1_no35` tinyint(1) DEFAULT NULL,
  `pg1_yes36` tinyint(1) DEFAULT NULL,
  `pg1_no36` tinyint(1) DEFAULT NULL,
  `pg1_yes37off` tinyint(1) DEFAULT NULL,
  `pg1_no37off` tinyint(1) DEFAULT NULL,
  `pg1_yes37acc` tinyint(1) DEFAULT NULL,
  `pg1_no37acc` tinyint(1) DEFAULT NULL,
  `pg1_idt38` tinyint(1) DEFAULT NULL,
  `pg1_idt39` tinyint(1) DEFAULT NULL,
  `pg1_idt40` tinyint(1) DEFAULT NULL,
  `pg1_idt41` tinyint(1) DEFAULT NULL,
  `pg1_idt42` tinyint(1) DEFAULT NULL,
  `pg1_box42` varchar(20) DEFAULT NULL,
  `pg1_pdt43` tinyint(1) DEFAULT NULL,
  `pg1_pdt44` tinyint(1) DEFAULT NULL,
  `pg1_pdt45` tinyint(1) DEFAULT NULL,
  `pg1_pdt46` tinyint(1) DEFAULT NULL,
  `pg1_pdt47` tinyint(1) DEFAULT NULL,
  `pg1_pdt48` tinyint(1) DEFAULT NULL,
  `c_riskFactors` text,
  `pg1_ht` varchar(6) DEFAULT NULL,
  `pg1_wt` varchar(6) DEFAULT NULL,
  `c_ppWt` varchar(6) DEFAULT NULL,
  `pg1_BP` varchar(10) DEFAULT NULL,
  `pg1_head` tinyint(1) DEFAULT NULL,
  `pg1_thyroid` tinyint(1) DEFAULT NULL,
  `pg1_chest` tinyint(1) DEFAULT NULL,
  `pg1_breasts` tinyint(1) DEFAULT NULL,
  `pg1_cardio` tinyint(1) DEFAULT NULL,
  `pg1_abdomen` tinyint(1) DEFAULT NULL,
  `pg1_vari` tinyint(1) DEFAULT NULL,
  `pg1_neuro` tinyint(1) DEFAULT NULL,
  `pg1_pelvic` tinyint(1) DEFAULT NULL,
  `pg1_extGen` tinyint(1) DEFAULT NULL,
  `pg1_cervix` tinyint(1) DEFAULT NULL,
  `pg1_uterus` tinyint(1) DEFAULT NULL,
  `pg1_uterusBox` char(3) DEFAULT NULL,
  `pg1_adnexa` tinyint(1) DEFAULT NULL,
  `pg1_commentsAR1` text,
  `ar2_etss` varchar(10) DEFAULT NULL,
  `ar2_hb` varchar(10) DEFAULT NULL,
  `ar2_mcv` varchar(10) DEFAULT NULL,
  `ar2_mss` varchar(10) DEFAULT NULL,
  `ar2_rubella` varchar(5) DEFAULT NULL,
  `ar2_hbs` varchar(6) DEFAULT NULL,
  `ar2_vdrl` varchar(6) DEFAULT NULL,
  `ar2_bloodGroup` varchar(6) DEFAULT NULL,
  `ar2_rh` varchar(6) DEFAULT NULL,
  `ar2_antibodies` varchar(6) DEFAULT NULL,
  `ar2_rhIG` varchar(6) DEFAULT NULL,
  `pg2_date1` date DEFAULT NULL,
  `pg2_gest1` varchar(6) DEFAULT NULL,
  `pg2_ht1` varchar(6) DEFAULT NULL,
  `pg2_wt1` varchar(6) DEFAULT NULL,
  `pg2_presn1` varchar(6) DEFAULT NULL,
  `pg2_FHR1` varchar(6) DEFAULT NULL,
  `pg2_urinePr1` char(3) DEFAULT NULL,
  `pg2_urineGl1` char(3) DEFAULT NULL,
  `pg2_BP1` varchar(8) DEFAULT NULL,
  `pg2_comments1` varchar(255) DEFAULT NULL,
  `pg2_cig1` char(3) DEFAULT NULL,
  `pg2_date2` date DEFAULT NULL,
  `pg2_gest2` varchar(6) DEFAULT NULL,
  `pg2_ht2` varchar(6) DEFAULT NULL,
  `pg2_wt2` varchar(6) DEFAULT NULL,
  `pg2_presn2` varchar(6) DEFAULT NULL,
  `pg2_FHR2` varchar(6) DEFAULT NULL,
  `pg2_urinePr2` char(3) DEFAULT NULL,
  `pg2_urineGl2` char(3) DEFAULT NULL,
  `pg2_BP2` varchar(8) DEFAULT NULL,
  `pg2_comments2` varchar(255) DEFAULT NULL,
  `pg2_cig2` char(3) DEFAULT NULL,
  `pg2_date3` date DEFAULT NULL,
  `pg2_gest3` varchar(6) DEFAULT NULL,
  `pg2_ht3` varchar(6) DEFAULT NULL,
  `pg2_wt3` varchar(6) DEFAULT NULL,
  `pg2_presn3` varchar(6) DEFAULT NULL,
  `pg2_FHR3` varchar(6) DEFAULT NULL,
  `pg2_urinePr3` char(3) DEFAULT NULL,
  `pg2_urineGl3` char(3) DEFAULT NULL,
  `pg2_BP3` varchar(8) DEFAULT NULL,
  `pg2_comments3` varchar(255) DEFAULT NULL,
  `pg2_cig3` char(3) DEFAULT NULL,
  `pg2_date4` date DEFAULT NULL,
  `pg2_gest4` varchar(6) DEFAULT NULL,
  `pg2_ht4` varchar(6) DEFAULT NULL,
  `pg2_wt4` varchar(6) DEFAULT NULL,
  `pg2_presn4` varchar(6) DEFAULT NULL,
  `pg2_FHR4` varchar(6) DEFAULT NULL,
  `pg2_urinePr4` char(3) DEFAULT NULL,
  `pg2_urineGl4` char(3) DEFAULT NULL,
  `pg2_BP4` varchar(8) DEFAULT NULL,
  `pg2_comments4` varchar(255) DEFAULT NULL,
  `pg2_cig4` char(3) DEFAULT NULL,
  `pg2_date5` date DEFAULT NULL,
  `pg2_gest5` varchar(6) DEFAULT NULL,
  `pg2_ht5` varchar(6) DEFAULT NULL,
  `pg2_wt5` varchar(6) DEFAULT NULL,
  `pg2_presn5` varchar(6) DEFAULT NULL,
  `pg2_FHR5` varchar(6) DEFAULT NULL,
  `pg2_urinePr5` char(3) DEFAULT NULL,
  `pg2_urineGl5` char(3) DEFAULT NULL,
  `pg2_BP5` varchar(8) DEFAULT NULL,
  `pg2_comments5` varchar(255) DEFAULT NULL,
  `pg2_cig5` char(3) DEFAULT NULL,
  `pg2_date6` date DEFAULT NULL,
  `pg2_gest6` varchar(6) DEFAULT NULL,
  `pg2_ht6` varchar(6) DEFAULT NULL,
  `pg2_wt6` varchar(6) DEFAULT NULL,
  `pg2_presn6` varchar(6) DEFAULT NULL,
  `pg2_FHR6` varchar(6) DEFAULT NULL,
  `pg2_urinePr6` char(3) DEFAULT NULL,
  `pg2_urineGl6` char(3) DEFAULT NULL,
  `pg2_BP6` varchar(8) DEFAULT NULL,
  `pg2_comments6` varchar(255) DEFAULT NULL,
  `pg2_cig6` char(3) DEFAULT NULL,
  `pg2_date7` date DEFAULT NULL,
  `pg2_gest7` varchar(6) DEFAULT NULL,
  `pg2_ht7` varchar(6) DEFAULT NULL,
  `pg2_wt7` varchar(6) DEFAULT NULL,
  `pg2_presn7` varchar(6) DEFAULT NULL,
  `pg2_FHR7` varchar(6) DEFAULT NULL,
  `pg2_urinePr7` char(3) DEFAULT NULL,
  `pg2_urineGl7` char(3) DEFAULT NULL,
  `pg2_BP7` varchar(8) DEFAULT NULL,
  `pg2_comments7` varchar(255) DEFAULT NULL,
  `pg2_cig7` char(3) DEFAULT NULL,
  `pg2_date8` date DEFAULT NULL,
  `pg2_gest8` varchar(6) DEFAULT NULL,
  `pg2_ht8` varchar(6) DEFAULT NULL,
  `pg2_wt8` varchar(6) DEFAULT NULL,
  `pg2_presn8` varchar(6) DEFAULT NULL,
  `pg2_FHR8` varchar(6) DEFAULT NULL,
  `pg2_urinePr8` char(3) DEFAULT NULL,
  `pg2_urineGl8` char(3) DEFAULT NULL,
  `pg2_BP8` varchar(8) DEFAULT NULL,
  `pg2_comments8` varchar(255) DEFAULT NULL,
  `pg2_cig8` char(3) DEFAULT NULL,
  `pg2_date9` date DEFAULT NULL,
  `pg2_gest9` varchar(6) DEFAULT NULL,
  `pg2_ht9` varchar(6) DEFAULT NULL,
  `pg2_wt9` varchar(6) DEFAULT NULL,
  `pg2_presn9` varchar(6) DEFAULT NULL,
  `pg2_FHR9` varchar(6) DEFAULT NULL,
  `pg2_urinePr9` char(3) DEFAULT NULL,
  `pg2_urineGl9` char(3) DEFAULT NULL,
  `pg2_BP9` varchar(8) DEFAULT NULL,
  `pg2_comments9` varchar(255) DEFAULT NULL,
  `pg2_cig9` char(3) DEFAULT NULL,
  `pg2_date10` date DEFAULT NULL,
  `pg2_gest10` varchar(6) DEFAULT NULL,
  `pg2_ht10` varchar(6) DEFAULT NULL,
  `pg2_wt10` varchar(6) DEFAULT NULL,
  `pg2_presn10` varchar(6) DEFAULT NULL,
  `pg2_FHR10` varchar(6) DEFAULT NULL,
  `pg2_urinePr10` char(3) DEFAULT NULL,
  `pg2_urineGl10` char(3) DEFAULT NULL,
  `pg2_BP10` varchar(8) DEFAULT NULL,
  `pg2_comments10` varchar(255) DEFAULT NULL,
  `pg2_cig10` char(3) DEFAULT NULL,
  `pg2_date11` date DEFAULT NULL,
  `pg2_gest11` varchar(6) DEFAULT NULL,
  `pg2_ht11` varchar(6) DEFAULT NULL,
  `pg2_wt11` varchar(6) DEFAULT NULL,
  `pg2_presn11` varchar(6) DEFAULT NULL,
  `pg2_FHR11` varchar(6) DEFAULT NULL,
  `pg2_urinePr11` char(3) DEFAULT NULL,
  `pg2_urineGl11` char(3) DEFAULT NULL,
  `pg2_BP11` varchar(8) DEFAULT NULL,
  `pg2_comments11` varchar(255) DEFAULT NULL,
  `pg2_cig11` char(3) DEFAULT NULL,
  `pg2_date12` date DEFAULT NULL,
  `pg2_gest12` varchar(6) DEFAULT NULL,
  `pg2_ht12` varchar(6) DEFAULT NULL,
  `pg2_wt12` varchar(6) DEFAULT NULL,
  `pg2_presn12` varchar(6) DEFAULT NULL,
  `pg2_FHR12` varchar(6) DEFAULT NULL,
  `pg2_urinePr12` char(3) DEFAULT NULL,
  `pg2_urineGl12` char(3) DEFAULT NULL,
  `pg2_BP12` varchar(8) DEFAULT NULL,
  `pg2_comments12` varchar(255) DEFAULT NULL,
  `pg2_cig12` char(3) DEFAULT NULL,
  `pg2_date13` date DEFAULT NULL,
  `pg2_gest13` varchar(6) DEFAULT NULL,
  `pg2_ht13` varchar(6) DEFAULT NULL,
  `pg2_wt13` varchar(6) DEFAULT NULL,
  `pg2_presn13` varchar(6) DEFAULT NULL,
  `pg2_FHR13` varchar(6) DEFAULT NULL,
  `pg2_urinePr13` char(3) DEFAULT NULL,
  `pg2_urineGl13` char(3) DEFAULT NULL,
  `pg2_BP13` varchar(8) DEFAULT NULL,
  `pg2_comments13` varchar(255) DEFAULT NULL,
  `pg2_cig13` char(3) DEFAULT NULL,
  `pg2_date14` date DEFAULT NULL,
  `pg2_gest14` varchar(6) DEFAULT NULL,
  `pg2_ht14` varchar(6) DEFAULT NULL,
  `pg2_wt14` varchar(6) DEFAULT NULL,
  `pg2_presn14` varchar(6) DEFAULT NULL,
  `pg2_FHR14` varchar(6) DEFAULT NULL,
  `pg2_urinePr14` char(3) DEFAULT NULL,
  `pg2_urineGl14` char(3) DEFAULT NULL,
  `pg2_BP14` varchar(8) DEFAULT NULL,
  `pg2_comments14` varchar(255) DEFAULT NULL,
  `pg2_cig14` char(3) DEFAULT NULL,
  `pg2_date15` date DEFAULT NULL,
  `pg2_gest15` varchar(6) DEFAULT NULL,
  `pg2_ht15` varchar(6) DEFAULT NULL,
  `pg2_wt15` varchar(6) DEFAULT NULL,
  `pg2_presn15` varchar(6) DEFAULT NULL,
  `pg2_FHR15` varchar(6) DEFAULT NULL,
  `pg2_urinePr15` char(3) DEFAULT NULL,
  `pg2_urineGl15` char(3) DEFAULT NULL,
  `pg2_BP15` varchar(8) DEFAULT NULL,
  `pg2_comments15` varchar(255) DEFAULT NULL,
  `pg2_cig15` char(3) DEFAULT NULL,
  `pg2_date16` date DEFAULT NULL,
  `pg2_gest16` varchar(6) DEFAULT NULL,
  `pg2_ht16` varchar(6) DEFAULT NULL,
  `pg2_wt16` varchar(6) DEFAULT NULL,
  `pg2_presn16` varchar(6) DEFAULT NULL,
  `pg2_FHR16` varchar(6) DEFAULT NULL,
  `pg2_urinePr16` char(3) DEFAULT NULL,
  `pg2_urineGl16` char(3) DEFAULT NULL,
  `pg2_BP16` varchar(8) DEFAULT NULL,
  `pg2_comments16` varchar(255) DEFAULT NULL,
  `pg2_cig16` char(3) DEFAULT NULL,
  `pg2_date17` date DEFAULT NULL,
  `pg2_gest17` varchar(6) DEFAULT NULL,
  `pg2_ht17` varchar(6) DEFAULT NULL,
  `pg2_wt17` varchar(6) DEFAULT NULL,
  `pg2_presn17` varchar(6) DEFAULT NULL,
  `pg2_FHR17` varchar(6) DEFAULT NULL,
  `pg2_urinePr17` char(3) DEFAULT NULL,
  `pg2_urineGl17` char(3) DEFAULT NULL,
  `pg2_BP17` varchar(8) DEFAULT NULL,
  `pg2_comments17` varchar(255) DEFAULT NULL,
  `pg2_cig17` char(3) DEFAULT NULL,
  `pg3_date18` date DEFAULT NULL,
  `pg3_gest18` varchar(6) DEFAULT NULL,
  `pg3_ht18` varchar(6) DEFAULT NULL,
  `pg3_wt18` varchar(6) DEFAULT NULL,
  `pg3_presn18` varchar(6) DEFAULT NULL,
  `pg3_FHR18` varchar(6) DEFAULT NULL,
  `pg3_urinePr18` char(3) DEFAULT NULL,
  `pg3_urineGl18` char(3) DEFAULT NULL,
  `pg3_BP18` varchar(8) DEFAULT NULL,
  `pg3_comments18` varchar(255) DEFAULT NULL,
  `pg3_cig18` char(3) DEFAULT NULL,
  `pg3_date19` date DEFAULT NULL,
  `pg3_gest19` varchar(6) DEFAULT NULL,
  `pg3_ht19` varchar(6) DEFAULT NULL,
  `pg3_wt19` varchar(6) DEFAULT NULL,
  `pg3_presn19` varchar(6) DEFAULT NULL,
  `pg3_FHR19` varchar(6) DEFAULT NULL,
  `pg3_urinePr19` char(3) DEFAULT NULL,
  `pg3_urineGl19` char(3) DEFAULT NULL,
  `pg3_BP19` varchar(8) DEFAULT NULL,
  `pg3_comments19` varchar(255) DEFAULT NULL,
  `pg3_cig19` char(3) DEFAULT NULL,
  `pg3_date20` date DEFAULT NULL,
  `pg3_gest20` varchar(6) DEFAULT NULL,
  `pg3_ht20` varchar(6) DEFAULT NULL,
  `pg3_wt20` varchar(6) DEFAULT NULL,
  `pg3_presn20` varchar(6) DEFAULT NULL,
  `pg3_FHR20` varchar(6) DEFAULT NULL,
  `pg3_urinePr20` char(3) DEFAULT NULL,
  `pg3_urineGl20` char(3) DEFAULT NULL,
  `pg3_BP20` varchar(8) DEFAULT NULL,
  `pg3_comments20` varchar(255) DEFAULT NULL,
  `pg3_cig20` char(3) DEFAULT NULL,
  `pg3_date21` date DEFAULT NULL,
  `pg3_gest21` varchar(6) DEFAULT NULL,
  `pg3_ht21` varchar(6) DEFAULT NULL,
  `pg3_wt21` varchar(6) DEFAULT NULL,
  `pg3_presn21` varchar(6) DEFAULT NULL,
  `pg3_FHR21` varchar(6) DEFAULT NULL,
  `pg3_urinePr21` char(3) DEFAULT NULL,
  `pg3_urineGl21` char(3) DEFAULT NULL,
  `pg3_BP21` varchar(8) DEFAULT NULL,
  `pg3_comments21` varchar(255) DEFAULT NULL,
  `pg3_cig21` char(3) DEFAULT NULL,
  `pg3_date22` date DEFAULT NULL,
  `pg3_gest22` varchar(6) DEFAULT NULL,
  `pg3_ht22` varchar(6) DEFAULT NULL,
  `pg3_wt22` varchar(6) DEFAULT NULL,
  `pg3_presn22` varchar(6) DEFAULT NULL,
  `pg3_FHR22` varchar(6) DEFAULT NULL,
  `pg3_urinePr22` char(3) DEFAULT NULL,
  `pg3_urineGl22` char(3) DEFAULT NULL,
  `pg3_BP22` varchar(8) DEFAULT NULL,
  `pg3_comments22` varchar(255) DEFAULT NULL,
  `pg3_cig22` char(3) DEFAULT NULL,
  `pg3_date23` date DEFAULT NULL,
  `pg3_gest23` varchar(6) DEFAULT NULL,
  `pg3_ht23` varchar(6) DEFAULT NULL,
  `pg3_wt23` varchar(6) DEFAULT NULL,
  `pg3_presn23` varchar(6) DEFAULT NULL,
  `pg3_FHR23` varchar(6) DEFAULT NULL,
  `pg3_urinePr23` char(3) DEFAULT NULL,
  `pg3_urineGl23` char(3) DEFAULT NULL,
  `pg3_BP23` varchar(8) DEFAULT NULL,
  `pg3_comments23` varchar(255) DEFAULT NULL,
  `pg3_cig23` char(3) DEFAULT NULL,
  `pg3_date24` date DEFAULT NULL,
  `pg3_gest24` varchar(6) DEFAULT NULL,
  `pg3_ht24` varchar(6) DEFAULT NULL,
  `pg3_wt24` varchar(6) DEFAULT NULL,
  `pg3_presn24` varchar(6) DEFAULT NULL,
  `pg3_FHR24` varchar(6) DEFAULT NULL,
  `pg3_urinePr24` char(3) DEFAULT NULL,
  `pg3_urineGl24` char(3) DEFAULT NULL,
  `pg3_BP24` varchar(8) DEFAULT NULL,
  `pg3_comments24` varchar(255) DEFAULT NULL,
  `pg3_cig24` char(3) DEFAULT NULL,
  `pg3_date25` date DEFAULT NULL,
  `pg3_gest25` varchar(6) DEFAULT NULL,
  `pg3_ht25` varchar(6) DEFAULT NULL,
  `pg3_wt25` varchar(6) DEFAULT NULL,
  `pg3_presn25` varchar(6) DEFAULT NULL,
  `pg3_FHR25` varchar(6) DEFAULT NULL,
  `pg3_urinePr25` char(3) DEFAULT NULL,
  `pg3_urineGl25` char(3) DEFAULT NULL,
  `pg3_BP25` varchar(8) DEFAULT NULL,
  `pg3_comments25` varchar(255) DEFAULT NULL,
  `pg3_cig25` char(3) DEFAULT NULL,
  `pg3_date26` date DEFAULT NULL,
  `pg3_gest26` varchar(6) DEFAULT NULL,
  `pg3_ht26` varchar(6) DEFAULT NULL,
  `pg3_wt26` varchar(6) DEFAULT NULL,
  `pg3_presn26` varchar(6) DEFAULT NULL,
  `pg3_FHR26` varchar(6) DEFAULT NULL,
  `pg3_urinePr26` char(3) DEFAULT NULL,
  `pg3_urineGl26` char(3) DEFAULT NULL,
  `pg3_BP26` varchar(8) DEFAULT NULL,
  `pg3_comments26` varchar(255) DEFAULT NULL,
  `pg3_cig26` char(3) DEFAULT NULL,
  `pg3_date27` date DEFAULT NULL,
  `pg3_gest27` varchar(6) DEFAULT NULL,
  `pg3_ht27` varchar(6) DEFAULT NULL,
  `pg3_wt27` varchar(6) DEFAULT NULL,
  `pg3_presn27` varchar(6) DEFAULT NULL,
  `pg3_FHR27` varchar(6) DEFAULT NULL,
  `pg3_urinePr27` char(3) DEFAULT NULL,
  `pg3_urineGl27` char(3) DEFAULT NULL,
  `pg3_BP27` varchar(8) DEFAULT NULL,
  `pg3_comments27` varchar(255) DEFAULT NULL,
  `pg3_cig27` char(3) DEFAULT NULL,
  `pg3_date28` date DEFAULT NULL,
  `pg3_gest28` varchar(6) DEFAULT NULL,
  `pg3_ht28` varchar(6) DEFAULT NULL,
  `pg3_wt28` varchar(6) DEFAULT NULL,
  `pg3_presn28` varchar(6) DEFAULT NULL,
  `pg3_FHR28` varchar(6) DEFAULT NULL,
  `pg3_urinePr28` char(3) DEFAULT NULL,
  `pg3_urineGl28` char(3) DEFAULT NULL,
  `pg3_BP28` varchar(8) DEFAULT NULL,
  `pg3_comments28` varchar(255) DEFAULT NULL,
  `pg3_cig28` char(3) DEFAULT NULL,
  `pg3_date29` date DEFAULT NULL,
  `pg3_gest29` varchar(6) DEFAULT NULL,
  `pg3_ht29` varchar(6) DEFAULT NULL,
  `pg3_wt29` varchar(6) DEFAULT NULL,
  `pg3_presn29` varchar(6) DEFAULT NULL,
  `pg3_FHR29` varchar(6) DEFAULT NULL,
  `pg3_urinePr29` char(3) DEFAULT NULL,
  `pg3_urineGl29` char(3) DEFAULT NULL,
  `pg3_BP29` varchar(8) DEFAULT NULL,
  `pg3_comments29` varchar(255) DEFAULT NULL,
  `pg3_cig29` char(3) DEFAULT NULL,
  `pg3_date30` date DEFAULT NULL,
  `pg3_gest30` varchar(6) DEFAULT NULL,
  `pg3_ht30` varchar(6) DEFAULT NULL,
  `pg3_wt30` varchar(6) DEFAULT NULL,
  `pg3_presn30` varchar(6) DEFAULT NULL,
  `pg3_FHR30` varchar(6) DEFAULT NULL,
  `pg3_urinePr30` char(3) DEFAULT NULL,
  `pg3_urineGl30` char(3) DEFAULT NULL,
  `pg3_BP30` varchar(8) DEFAULT NULL,
  `pg3_comments30` varchar(255) DEFAULT NULL,
  `pg3_cig30` char(3) DEFAULT NULL,
  `pg3_date31` date DEFAULT NULL,
  `pg3_gest31` varchar(6) DEFAULT NULL,
  `pg3_ht31` varchar(6) DEFAULT NULL,
  `pg3_wt31` varchar(6) DEFAULT NULL,
  `pg3_presn31` varchar(6) DEFAULT NULL,
  `pg3_FHR31` varchar(6) DEFAULT NULL,
  `pg3_urinePr31` char(3) DEFAULT NULL,
  `pg3_urineGl31` char(3) DEFAULT NULL,
  `pg3_BP31` varchar(8) DEFAULT NULL,
  `pg3_comments31` varchar(255) DEFAULT NULL,
  `pg3_cig31` char(3) DEFAULT NULL,
  `pg3_date32` date DEFAULT NULL,
  `pg3_gest32` varchar(6) DEFAULT NULL,
  `pg3_ht32` varchar(6) DEFAULT NULL,
  `pg3_wt32` varchar(6) DEFAULT NULL,
  `pg3_presn32` varchar(6) DEFAULT NULL,
  `pg3_FHR32` varchar(6) DEFAULT NULL,
  `pg3_urinePr32` char(3) DEFAULT NULL,
  `pg3_urineGl32` char(3) DEFAULT NULL,
  `pg3_BP32` varchar(8) DEFAULT NULL,
  `pg3_comments32` varchar(255) DEFAULT NULL,
  `pg3_cig32` char(3) DEFAULT NULL,
  `pg3_date33` date DEFAULT NULL,
  `pg3_gest33` varchar(6) DEFAULT NULL,
  `pg3_ht33` varchar(6) DEFAULT NULL,
  `pg3_wt33` varchar(6) DEFAULT NULL,
  `pg3_presn33` varchar(6) DEFAULT NULL,
  `pg3_FHR33` varchar(6) DEFAULT NULL,
  `pg3_urinePr33` char(3) DEFAULT NULL,
  `pg3_urineGl33` char(3) DEFAULT NULL,
  `pg3_BP33` varchar(8) DEFAULT NULL,
  `pg3_comments33` varchar(255) DEFAULT NULL,
  `pg3_cig33` char(3) DEFAULT NULL,
  `pg3_date34` date DEFAULT NULL,
  `pg3_gest34` varchar(6) DEFAULT NULL,
  `pg3_ht34` varchar(6) DEFAULT NULL,
  `pg3_wt34` varchar(6) DEFAULT NULL,
  `pg3_presn34` varchar(6) DEFAULT NULL,
  `pg3_FHR34` varchar(6) DEFAULT NULL,
  `pg3_urinePr34` char(3) DEFAULT NULL,
  `pg3_urineGl34` char(3) DEFAULT NULL,
  `pg3_BP34` varchar(8) DEFAULT NULL,
  `pg3_comments34` varchar(255) DEFAULT NULL,
  `pg3_cig34` char(3) DEFAULT NULL,
  `ar2_obstetrician` tinyint(1) DEFAULT NULL,
  `ar2_pediatrician` tinyint(1) DEFAULT NULL,
  `ar2_anesthesiologist` tinyint(1) DEFAULT NULL,
  `ar2_socialWorker` tinyint(1) DEFAULT NULL,
  `ar2_dietician` tinyint(1) DEFAULT NULL,
  `ar2_otherAR2` tinyint(1) DEFAULT NULL,
  `ar2_otherBox` varchar(35) DEFAULT NULL,
  `ar2_drugUse` tinyint(1) DEFAULT NULL,
  `ar2_smoking` tinyint(1) DEFAULT NULL,
  `ar2_alcohol` tinyint(1) DEFAULT NULL,
  `ar2_exercise` tinyint(1) DEFAULT NULL,
  `ar2_workPlan` tinyint(1) DEFAULT NULL,
  `ar2_intercourse` tinyint(1) DEFAULT NULL,
  `ar2_dental` tinyint(1) DEFAULT NULL,
  `ar2_travel` tinyint(1) DEFAULT NULL,
  `ar2_prenatal` tinyint(1) DEFAULT NULL,
  `ar2_breast` tinyint(1) DEFAULT NULL,
  `ar2_birth` tinyint(1) DEFAULT NULL,
  `ar2_preterm` tinyint(1) DEFAULT NULL,
  `ar2_prom` tinyint(1) DEFAULT NULL,
  `ar2_fetal` tinyint(1) DEFAULT NULL,
  `ar2_admission` tinyint(1) DEFAULT NULL,
  `ar2_labour` tinyint(1) DEFAULT NULL,
  `ar2_pain` tinyint(1) DEFAULT NULL,
  `ar2_depression` tinyint(1) DEFAULT NULL,
  `ar2_circumcision` tinyint(1) DEFAULT NULL,
  `ar2_car` tinyint(1) DEFAULT NULL,
  `ar2_contraception` tinyint(1) DEFAULT NULL,
  `ar2_onCall` tinyint(1) DEFAULT NULL,
  `ar2_uDate1` varchar(10) DEFAULT NULL,
  `ar2_uGA1` varchar(10) DEFAULT NULL,
  `ar2_uResults1` varchar(25) DEFAULT NULL,
  `ar2_uDate2` varchar(10) DEFAULT NULL,
  `ar2_uGA2` varchar(10) DEFAULT NULL,
  `ar2_uResults2` varchar(25) DEFAULT NULL,
  `ar2_uDate3` varchar(10) DEFAULT NULL,
  `ar2_uGA3` varchar(10) DEFAULT NULL,
  `ar2_uResults3` varchar(25) DEFAULT NULL,
  `ar2_uDate4` varchar(10) DEFAULT NULL,
  `ar2_uGA4` varchar(10) DEFAULT NULL,
  `ar2_uResults4` varchar(25) DEFAULT NULL,
  `ar2_pap` varchar(20) DEFAULT NULL,
  `ar2_commentsAR2` text,
  `ar2_chlamydia` varchar(10) DEFAULT NULL,
  `ar2_hiv` varchar(10) DEFAULT NULL,
  `ar2_vaginosis` varchar(10) DEFAULT NULL,
  `ar2_strep` varchar(10) DEFAULT NULL,
  `ar2_urineCulture` varchar(10) DEFAULT NULL,
  `ar2_sickleDex` varchar(10) DEFAULT NULL,
  `ar2_electro` varchar(10) DEFAULT NULL,
  `ar2_amnio` varchar(10) DEFAULT NULL,
  `ar2_glucose` varchar(10) DEFAULT NULL,
  `ar2_otherAR2Name` varchar(20) DEFAULT NULL,
  `ar2_otherResult` varchar(10) DEFAULT NULL,
  `ar2_psych` varchar(25) DEFAULT NULL,
  `pg1_signature` varchar(50) DEFAULT NULL,
  `pg2_signature` varchar(50) DEFAULT NULL,
  `pg3_signature` varchar(50) DEFAULT NULL,
  `pg1_formDate` date DEFAULT NULL,
  `pg2_formDate` date DEFAULT NULL,
  `pg3_formDate` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formAdf`
--

DROP TABLE IF EXISTS `formAdf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formAdf` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_patientname` varchar(60) DEFAULT NULL,
  `residentno` varchar(20) DEFAULT NULL,
  `c_physician` varchar(60) DEFAULT NULL,
  `c_address` varchar(80) DEFAULT NULL,
  `c_phone` varchar(20) DEFAULT NULL,
  `cComplait` text,
  `histPresIll` text,
  `childhood` varchar(80) DEFAULT NULL,
  `adult` varchar(80) DEFAULT NULL,
  `operations` varchar(80) DEFAULT NULL,
  `injuries` varchar(80) DEFAULT NULL,
  `mentalIll` varchar(80) DEFAULT NULL,
  `familyHist` text,
  `socialHist` text,
  `general` varchar(80) DEFAULT NULL,
  `histSkin` varchar(80) DEFAULT NULL,
  `headNeck` varchar(80) DEFAULT NULL,
  `respiratory` varchar(80) DEFAULT NULL,
  `cardiovascular` varchar(80) DEFAULT NULL,
  `gi` varchar(80) DEFAULT NULL,
  `gu` varchar(80) DEFAULT NULL,
  `cns` varchar(80) DEFAULT NULL,
  `histExtremities` varchar(80) DEFAULT NULL,
  `allergies` text,
  `sensitivityDrug` text,
  `currentMedication` text,
  `temp` varchar(80) DEFAULT NULL,
  `pulse` varchar(80) DEFAULT NULL,
  `resp` varchar(80) DEFAULT NULL,
  `bp` varchar(80) DEFAULT NULL,
  `height` varchar(80) DEFAULT NULL,
  `weight` varchar(80) DEFAULT NULL,
  `physicalCondition` text,
  `mentalCondition` text,
  `skin` varchar(80) DEFAULT NULL,
  `eyes` varchar(80) DEFAULT NULL,
  `ears` varchar(80) DEFAULT NULL,
  `nose` varchar(80) DEFAULT NULL,
  `mouthTeeth` varchar(80) DEFAULT NULL,
  `throat` varchar(80) DEFAULT NULL,
  `neck` varchar(80) DEFAULT NULL,
  `chest` varchar(80) DEFAULT NULL,
  `heart` varchar(80) DEFAULT NULL,
  `abdomen` varchar(80) DEFAULT NULL,
  `genitalia` varchar(80) DEFAULT NULL,
  `lymphatics` varchar(80) DEFAULT NULL,
  `bloodVessels` varchar(80) DEFAULT NULL,
  `locomotor` varchar(80) DEFAULT NULL,
  `extremities` varchar(80) DEFAULT NULL,
  `rectal` varchar(80) DEFAULT NULL,
  `vaginal` varchar(80) DEFAULT NULL,
  `neurological` varchar(80) DEFAULT NULL,
  `behaviorProblem` text,
  `functionalLimitation` text,
  `diagnoses` text,
  `sigDate` date DEFAULT NULL,
  `signature` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formAdfV2`
--

DROP TABLE IF EXISTS `formAdfV2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formAdfV2` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_patientname` varchar(60) DEFAULT NULL,
  `sendFacility` varchar(80) DEFAULT NULL,
  `poaSdm` varchar(80) DEFAULT NULL,
  `capTreatDecY` tinyint(1) DEFAULT NULL,
  `capTreatDecN` tinyint(1) DEFAULT NULL,
  `advDirective` varchar(100) DEFAULT NULL,
  `actProblem` text,
  `inactProblem` text,
  `courseOverYear` text,
  `medications` text,
  `allergy` varchar(255) DEFAULT NULL,
  `diet` varchar(255) DEFAULT NULL,
  `influDate` date DEFAULT NULL,
  `pneuDate` date DEFAULT NULL,
  `mantDateRes` varchar(50) DEFAULT NULL,
  `immuOthers` varchar(50) DEFAULT NULL,
  `pertLabInvest` text,
  `communication` varchar(100) DEFAULT NULL,
  `appetDysphWeight` varchar(100) DEFAULT NULL,
  `sleepEnergy` varchar(100) DEFAULT NULL,
  `depreSymptom` varchar(100) DEFAULT NULL,
  `problemBehav` varchar(100) DEFAULT NULL,
  `funcStatus` varchar(100) DEFAULT NULL,
  `fallFracture` varchar(100) DEFAULT NULL,
  `pain` varchar(100) DEFAULT NULL,
  `continence` varchar(100) DEFAULT NULL,
  `sysSkin` varchar(100) DEFAULT NULL,
  `socialSupp` varchar(100) DEFAULT NULL,
  `sysOther` varchar(100) DEFAULT NULL,
  `phyWeight` varchar(10) DEFAULT NULL,
  `phyHeight` varchar(10) DEFAULT NULL,
  `phyBPlying` varchar(16) DEFAULT NULL,
  `phyBPStanding` varchar(16) DEFAULT NULL,
  `phyGenAppear` varchar(100) DEFAULT NULL,
  `phyEyes` varchar(50) DEFAULT NULL,
  `phyEars` varchar(50) DEFAULT NULL,
  `phyOralHygeine` varchar(50) DEFAULT NULL,
  `phyBreast` varchar(50) DEFAULT NULL,
  `phyCardHeartSound` varchar(30) DEFAULT NULL,
  `phyPeriPulse` varchar(30) DEFAULT NULL,
  `phyOther` varchar(30) DEFAULT NULL,
  `phyRespiratory` varchar(100) DEFAULT NULL,
  `phyNeurological` varchar(30) DEFAULT NULL,
  `phyReflexes` varchar(30) DEFAULT NULL,
  `phyBabinski` varchar(30) DEFAULT NULL,
  `phyPower` varchar(30) DEFAULT NULL,
  `phyTone` varchar(30) DEFAULT NULL,
  `phyPowerOther` varchar(30) DEFAULT NULL,
  `phyMMSE` varchar(20) DEFAULT NULL,
  `phyComment` varchar(80) DEFAULT NULL,
  `phySkin` varchar(100) DEFAULT NULL,
  `phyAbdomen` varchar(80) DEFAULT NULL,
  `highRiskProb1` varchar(80) DEFAULT NULL,
  `investPlanCare1` varchar(80) DEFAULT NULL,
  `highRiskProb2` varchar(80) DEFAULT NULL,
  `investPlanCare2` varchar(80) DEFAULT NULL,
  `highRiskProb3` varchar(80) DEFAULT NULL,
  `investPlanCare3` varchar(80) DEFAULT NULL,
  `highRiskProb4` varchar(80) DEFAULT NULL,
  `investPlanCare4` varchar(80) DEFAULT NULL,
  `sigDate` date DEFAULT NULL,
  `signature` varchar(60) DEFAULT NULL,
  `sigName` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formAlpha`
--

DROP TABLE IF EXISTS `formAlpha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formAlpha` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pName` varchar(60) DEFAULT NULL,
  `socialSupport` text,
  `lifeEvents` text,
  `coupleRelationship` text,
  `prenatalCare` text,
  `prenatalEducation` text,
  `feelingsRePregnancy` text,
  `relationshipParents` text,
  `selfEsteem` text,
  `psychHistory` text,
  `depression` text,
  `alcoholDrugAbuse` text,
  `abuse` text,
  `womanAbuse` text,
  `childAbuse` text,
  `childDiscipline` text,
  `provCounselling` tinyint(1) DEFAULT NULL,
  `homecare` tinyint(1) DEFAULT NULL,
  `assaultedWomen` tinyint(1) DEFAULT NULL,
  `addAppts` tinyint(1) DEFAULT NULL,
  `parentingClasses` tinyint(1) DEFAULT NULL,
  `legalAdvice` tinyint(1) DEFAULT NULL,
  `postpartumAppts` tinyint(1) DEFAULT NULL,
  `addictPrograms` tinyint(1) DEFAULT NULL,
  `cas` tinyint(1) DEFAULT NULL,
  `babyVisits` tinyint(1) DEFAULT NULL,
  `quitSmoking` tinyint(1) DEFAULT NULL,
  `other1` tinyint(1) DEFAULT NULL,
  `other1Name` varchar(30) DEFAULT NULL,
  `publicHealth` tinyint(1) DEFAULT NULL,
  `socialWorker` tinyint(1) DEFAULT NULL,
  `other2` tinyint(1) DEFAULT NULL,
  `other2Name` varchar(30) DEFAULT NULL,
  `prenatalEdu` tinyint(1) DEFAULT NULL,
  `psych` tinyint(1) DEFAULT NULL,
  `other3` tinyint(1) DEFAULT NULL,
  `other3Name` varchar(30) DEFAULT NULL,
  `nutritionist` tinyint(1) DEFAULT NULL,
  `therapist` tinyint(1) DEFAULT NULL,
  `other4` tinyint(1) DEFAULT NULL,
  `other4Name` varchar(30) DEFAULT NULL,
  `resources` tinyint(1) DEFAULT NULL,
  `comments` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formAnnual`
--

DROP TABLE IF EXISTS `formAnnual`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formAnnual` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pName` varchar(60) DEFAULT NULL,
  `age` char(3) DEFAULT NULL,
  `formDate` date DEFAULT NULL,
  `currentConcerns` text,
  `currentConcernsNo` tinyint(1) DEFAULT NULL,
  `currentConcernsYes` tinyint(1) DEFAULT NULL,
  `headN` tinyint(1) DEFAULT NULL,
  `headAbN` tinyint(1) DEFAULT NULL,
  `head` varchar(30) DEFAULT NULL,
  `respN` tinyint(1) DEFAULT NULL,
  `respAbN` tinyint(1) DEFAULT NULL,
  `resp` varchar(30) DEFAULT NULL,
  `cardioN` tinyint(1) DEFAULT NULL,
  `cardioAbN` tinyint(1) DEFAULT NULL,
  `cardio` varchar(30) DEFAULT NULL,
  `giN` tinyint(1) DEFAULT NULL,
  `giAbN` tinyint(1) DEFAULT NULL,
  `gi` varchar(30) DEFAULT NULL,
  `guN` tinyint(1) DEFAULT NULL,
  `guAbN` tinyint(1) DEFAULT NULL,
  `gu` varchar(30) DEFAULT NULL,
  `noGtpalRevisions` tinyint(1) DEFAULT NULL,
  `yesGtpalRevisions` tinyint(1) DEFAULT NULL,
  `frontSheet` tinyint(1) DEFAULT NULL,
  `lmp` date DEFAULT NULL,
  `menopause` char(3) DEFAULT NULL,
  `papSmearsN` tinyint(1) DEFAULT NULL,
  `papSmearsAbN` tinyint(1) DEFAULT NULL,
  `papSmears` varchar(30) DEFAULT NULL,
  `skinN` tinyint(1) DEFAULT NULL,
  `skinAbN` tinyint(1) DEFAULT NULL,
  `skin` varchar(30) DEFAULT NULL,
  `mskN` tinyint(1) DEFAULT NULL,
  `mskAbN` tinyint(1) DEFAULT NULL,
  `msk` varchar(30) DEFAULT NULL,
  `endocrinN` tinyint(1) DEFAULT NULL,
  `endocrinAbN` tinyint(1) DEFAULT NULL,
  `endocrin` varchar(30) DEFAULT NULL,
  `otherN` tinyint(1) DEFAULT NULL,
  `otherAbN` tinyint(1) DEFAULT NULL,
  `other` varchar(255) DEFAULT NULL,
  `drugs` tinyint(1) DEFAULT NULL,
  `medSheet` tinyint(1) DEFAULT NULL,
  `allergies` tinyint(1) DEFAULT NULL,
  `frontSheet1` tinyint(1) DEFAULT NULL,
  `familyHistory` tinyint(1) DEFAULT NULL,
  `frontSheet2` tinyint(1) DEFAULT NULL,
  `smokingNo` tinyint(1) DEFAULT NULL,
  `smokingYes` tinyint(1) DEFAULT NULL,
  `smoking` varchar(30) DEFAULT NULL,
  `sexualityNo` tinyint(1) DEFAULT NULL,
  `sexualityYes` tinyint(1) DEFAULT NULL,
  `sexuality` varchar(30) DEFAULT NULL,
  `alcoholNo` tinyint(1) DEFAULT NULL,
  `alcoholYes` tinyint(1) DEFAULT NULL,
  `alcohol` varchar(30) DEFAULT NULL,
  `occupationalNo` tinyint(1) DEFAULT NULL,
  `occupationalYes` tinyint(1) DEFAULT NULL,
  `occupational` varchar(30) DEFAULT NULL,
  `otcNo` tinyint(1) DEFAULT NULL,
  `otcYes` tinyint(1) DEFAULT NULL,
  `otc` varchar(30) DEFAULT NULL,
  `drivingNo` tinyint(1) DEFAULT NULL,
  `drivingYes` tinyint(1) DEFAULT NULL,
  `driving` varchar(30) DEFAULT NULL,
  `exerciseNo` tinyint(1) DEFAULT NULL,
  `exerciseYes` tinyint(1) DEFAULT NULL,
  `exercise` varchar(30) DEFAULT NULL,
  `travelNo` tinyint(1) DEFAULT NULL,
  `travelYes` tinyint(1) DEFAULT NULL,
  `travel` varchar(30) DEFAULT NULL,
  `nutritionNo` tinyint(1) DEFAULT NULL,
  `nutritionYes` tinyint(1) DEFAULT NULL,
  `nutrition` varchar(30) DEFAULT NULL,
  `otherNo` tinyint(1) DEFAULT NULL,
  `otherYes` tinyint(1) DEFAULT NULL,
  `otherLifestyle` varchar(255) DEFAULT NULL,
  `dentalNo` tinyint(1) DEFAULT NULL,
  `dentalYes` tinyint(1) DEFAULT NULL,
  `dental` varchar(30) DEFAULT NULL,
  `relationshipNo` tinyint(1) DEFAULT NULL,
  `relationshipYes` tinyint(1) DEFAULT NULL,
  `relationship` varchar(150) DEFAULT NULL,
  `mammogram` tinyint(1) DEFAULT NULL,
  `rectal` tinyint(1) DEFAULT NULL,
  `breast` tinyint(1) DEFAULT NULL,
  `maleCardiac` tinyint(1) DEFAULT NULL,
  `pap` tinyint(1) DEFAULT NULL,
  `maleImmunization` tinyint(1) DEFAULT NULL,
  `femaleImmunization` tinyint(1) DEFAULT NULL,
  `maleOther1c` tinyint(1) DEFAULT NULL,
  `maleOther1` varchar(30) DEFAULT NULL,
  `precontraceptive` tinyint(1) DEFAULT NULL,
  `maleOther2c` tinyint(1) DEFAULT NULL,
  `maleOther2` varchar(30) DEFAULT NULL,
  `femaleCardiac` tinyint(1) DEFAULT NULL,
  `osteoporosis` tinyint(1) DEFAULT NULL,
  `femaleOther1c` tinyint(1) DEFAULT NULL,
  `femaleOther1` varchar(30) DEFAULT NULL,
  `femaleOther2c` tinyint(1) DEFAULT NULL,
  `femaleOther2` varchar(30) DEFAULT NULL,
  `bprTop` char(3) DEFAULT NULL,
  `bprBottom` char(3) DEFAULT NULL,
  `pulse` varchar(10) DEFAULT NULL,
  `height` varchar(4) DEFAULT NULL,
  `weight` varchar(4) DEFAULT NULL,
  `bplTop` char(3) DEFAULT NULL,
  `bplBottom` char(3) DEFAULT NULL,
  `rhythm` varchar(10) DEFAULT NULL,
  `urine` varchar(30) DEFAULT NULL,
  `physicalSigns` text,
  `assessment` text,
  `plan` text,
  `signature` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formAnnualV2`
--

DROP TABLE IF EXISTS `formAnnualV2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formAnnualV2` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pName` varchar(60) DEFAULT NULL,
  `age` char(3) DEFAULT NULL,
  `formDate` date DEFAULT NULL,
  `pmhxPshxUpdated` tinyint(1) DEFAULT NULL,
  `famHxUpdated` tinyint(1) DEFAULT NULL,
  `socHxUpdated` tinyint(1) DEFAULT NULL,
  `allergiesUpdated` tinyint(1) DEFAULT NULL,
  `medicationsUpdated` tinyint(1) DEFAULT NULL,
  `weight` varchar(4) DEFAULT NULL,
  `height` varchar(4) DEFAULT NULL,
  `waist` varchar(4) DEFAULT NULL,
  `lmp` date DEFAULT NULL,
  `BP` varchar(7) DEFAULT NULL,
  `smokingNo` tinyint(1) DEFAULT NULL,
  `smokingYes` tinyint(1) DEFAULT NULL,
  `smoking` varchar(100) DEFAULT NULL,
  `etohNo` tinyint(1) DEFAULT NULL,
  `etohYes` tinyint(1) DEFAULT NULL,
  `etoh` varchar(100) DEFAULT NULL,
  `caffineNo` tinyint(1) DEFAULT NULL,
  `caffineYes` tinyint(1) DEFAULT NULL,
  `caffine` varchar(100) DEFAULT NULL,
  `otcNo` tinyint(1) DEFAULT NULL,
  `otcYes` tinyint(1) DEFAULT NULL,
  `otc` varchar(100) DEFAULT NULL,
  `exerciseNo` tinyint(1) DEFAULT NULL,
  `exerciseYes` tinyint(1) DEFAULT NULL,
  `exercise` varchar(100) DEFAULT NULL,
  `nutritionNo` tinyint(1) DEFAULT NULL,
  `nutritionYes` tinyint(1) DEFAULT NULL,
  `nutrition` varchar(100) DEFAULT NULL,
  `dentalNo` tinyint(1) DEFAULT NULL,
  `dentalYes` tinyint(1) DEFAULT NULL,
  `dental` varchar(100) DEFAULT NULL,
  `occupationalNo` tinyint(1) DEFAULT NULL,
  `occupationalYes` tinyint(1) DEFAULT NULL,
  `occupational` varchar(100) DEFAULT NULL,
  `travelNo` tinyint(1) DEFAULT NULL,
  `travelYes` tinyint(1) DEFAULT NULL,
  `travel` varchar(100) DEFAULT NULL,
  `sexualityNo` tinyint(1) DEFAULT NULL,
  `sexualityYes` tinyint(1) DEFAULT NULL,
  `sexuality` varchar(100) DEFAULT NULL,
  `generalN` tinyint(1) DEFAULT NULL,
  `generalAbN` tinyint(1) DEFAULT NULL,
  `general` varchar(100) DEFAULT NULL,
  `headN` tinyint(1) DEFAULT NULL,
  `headAbN` tinyint(1) DEFAULT NULL,
  `head` varchar(100) DEFAULT NULL,
  `chestN` tinyint(1) DEFAULT NULL,
  `chestAbN` tinyint(1) DEFAULT NULL,
  `chest` varchar(100) DEFAULT NULL,
  `cvsN` tinyint(1) DEFAULT NULL,
  `cvsAbN` tinyint(1) DEFAULT NULL,
  `cvs` varchar(100) DEFAULT NULL,
  `giN` tinyint(1) DEFAULT NULL,
  `giAbN` tinyint(1) DEFAULT NULL,
  `gi` varchar(100) DEFAULT NULL,
  `guN` tinyint(1) DEFAULT NULL,
  `guAbN` tinyint(1) DEFAULT NULL,
  `gu` varchar(100) DEFAULT NULL,
  `cnsN` tinyint(1) DEFAULT NULL,
  `cnsAbN` tinyint(1) DEFAULT NULL,
  `cns` varchar(100) DEFAULT NULL,
  `mskN` tinyint(1) DEFAULT NULL,
  `mskAbN` tinyint(1) DEFAULT NULL,
  `msk` varchar(100) DEFAULT NULL,
  `skinN` tinyint(1) DEFAULT NULL,
  `skinAbN` tinyint(1) DEFAULT NULL,
  `skin` varchar(100) DEFAULT NULL,
  `moodN` tinyint(1) DEFAULT NULL,
  `moodAbN` tinyint(1) DEFAULT NULL,
  `mood` varchar(100) DEFAULT NULL,
  `otherN` tinyint(1) DEFAULT NULL,
  `otherAbN` tinyint(1) DEFAULT NULL,
  `other` text,
  `eyesN` tinyint(1) DEFAULT NULL,
  `eyesAbN` tinyint(1) DEFAULT NULL,
  `eyes` varchar(100) DEFAULT NULL,
  `earsN` tinyint(1) DEFAULT NULL,
  `earsAbN` tinyint(1) DEFAULT NULL,
  `ears` varchar(100) DEFAULT NULL,
  `oropharynxN` tinyint(1) DEFAULT NULL,
  `oropharynxAbN` tinyint(1) DEFAULT NULL,
  `oropharynx` varchar(100) DEFAULT NULL,
  `thyroidN` tinyint(1) DEFAULT NULL,
  `thyroidAbN` tinyint(1) DEFAULT NULL,
  `thyroid` varchar(100) DEFAULT NULL,
  `lnodesN` tinyint(1) DEFAULT NULL,
  `lnodesAbN` tinyint(1) DEFAULT NULL,
  `lnodes` varchar(100) DEFAULT NULL,
  `clearN` tinyint(1) DEFAULT NULL,
  `clearAbN` tinyint(1) DEFAULT NULL,
  `clear` varchar(100) DEFAULT NULL,
  `bilatN` tinyint(1) DEFAULT NULL,
  `bilatAbN` tinyint(1) DEFAULT NULL,
  `bilat` varchar(100) DEFAULT NULL,
  `wheezesN` tinyint(1) DEFAULT NULL,
  `wheezesAbN` tinyint(1) DEFAULT NULL,
  `wheezes` varchar(100) DEFAULT NULL,
  `cracklesN` tinyint(1) DEFAULT NULL,
  `cracklesAbN` tinyint(1) DEFAULT NULL,
  `crackles` varchar(100) DEFAULT NULL,
  `chestOther` varchar(100) DEFAULT NULL,
  `s1s2N` tinyint(1) DEFAULT NULL,
  `s1s2AbN` tinyint(1) DEFAULT NULL,
  `s1s2` varchar(100) DEFAULT NULL,
  `murmurN` tinyint(1) DEFAULT NULL,
  `murmurAbN` tinyint(1) DEFAULT NULL,
  `murmur` varchar(100) DEFAULT NULL,
  `periphPulseN` tinyint(1) DEFAULT NULL,
  `periphPulseAbN` tinyint(1) DEFAULT NULL,
  `periphPulse` varchar(100) DEFAULT NULL,
  `edemaN` tinyint(1) DEFAULT NULL,
  `edemaAbN` tinyint(1) DEFAULT NULL,
  `edema` varchar(100) DEFAULT NULL,
  `jvpN` tinyint(1) DEFAULT NULL,
  `jvpAbN` tinyint(1) DEFAULT NULL,
  `jvp` varchar(100) DEFAULT NULL,
  `rhythmN` tinyint(1) DEFAULT NULL,
  `rhythmAbN` tinyint(1) DEFAULT NULL,
  `rhythm` varchar(100) DEFAULT NULL,
  `chestbpN` tinyint(1) DEFAULT NULL,
  `chestbpAbN` tinyint(1) DEFAULT NULL,
  `chestbp` varchar(100) DEFAULT NULL,
  `cvsOther` varchar(100) DEFAULT NULL,
  `breastLeftN` tinyint(1) DEFAULT NULL,
  `breastLeftAbN` tinyint(1) DEFAULT NULL,
  `breastLeft` varchar(100) DEFAULT NULL,
  `breastRightN` tinyint(1) DEFAULT NULL,
  `breastRightAbN` tinyint(1) DEFAULT NULL,
  `breastRight` varchar(100) DEFAULT NULL,
  `softN` tinyint(1) DEFAULT NULL,
  `softAbN` tinyint(1) DEFAULT NULL,
  `soft` varchar(100) DEFAULT NULL,
  `tenderN` tinyint(1) DEFAULT NULL,
  `tenderAbN` tinyint(1) DEFAULT NULL,
  `tender` varchar(100) DEFAULT NULL,
  `bsN` tinyint(1) DEFAULT NULL,
  `bsAbN` tinyint(1) DEFAULT NULL,
  `bs` varchar(100) DEFAULT NULL,
  `hepatomegN` tinyint(1) DEFAULT NULL,
  `hepatomegAbN` tinyint(1) DEFAULT NULL,
  `hepatomeg` varchar(100) DEFAULT NULL,
  `splenomegN` tinyint(1) DEFAULT NULL,
  `splenomegAbN` tinyint(1) DEFAULT NULL,
  `splenomeg` varchar(100) DEFAULT NULL,
  `massesN` tinyint(1) DEFAULT NULL,
  `massesAbN` tinyint(1) DEFAULT NULL,
  `masses` varchar(100) DEFAULT NULL,
  `rectalN` tinyint(1) DEFAULT NULL,
  `rectalAbN` tinyint(1) DEFAULT NULL,
  `rectal` varchar(100) DEFAULT NULL,
  `cxN` tinyint(1) DEFAULT NULL,
  `cxAbN` tinyint(1) DEFAULT NULL,
  `cx` varchar(100) DEFAULT NULL,
  `bimanualN` tinyint(1) DEFAULT NULL,
  `bimanualAbN` tinyint(1) DEFAULT NULL,
  `bimanual` varchar(100) DEFAULT NULL,
  `adnexaN` tinyint(1) DEFAULT NULL,
  `adnexaAbN` tinyint(1) DEFAULT NULL,
  `adnexa` varchar(100) DEFAULT NULL,
  `papN` tinyint(1) DEFAULT NULL,
  `papAbN` tinyint(1) DEFAULT NULL,
  `pap` varchar(100) DEFAULT NULL,
  `exammskN` tinyint(1) DEFAULT NULL,
  `exammskAbN` tinyint(1) DEFAULT NULL,
  `exammsk` varchar(100) DEFAULT NULL,
  `examskinN` tinyint(1) DEFAULT NULL,
  `examskinAbN` tinyint(1) DEFAULT NULL,
  `examskin` varchar(100) DEFAULT NULL,
  `examcnsN` tinyint(1) DEFAULT NULL,
  `examcnsAbN` tinyint(1) DEFAULT NULL,
  `examcns` text,
  `impressionPlan` text,
  `toDoSexualHealth` text,
  `toDoObesity` text,
  `toDoCholesterol` text,
  `toDoOsteoporosis` text,
  `toDoPAPs` text,
  `toDoMammogram` text,
  `toDoColorectal` text,
  `toDoElderly` text,
  `immunizationtd` tinyint(1) DEFAULT NULL,
  `immunizationPneumovax` tinyint(1) DEFAULT NULL,
  `immunizationFlu` tinyint(1) DEFAULT NULL,
  `immunizationMenjugate` tinyint(1) DEFAULT NULL,
  `toDoImmunization` text,
  `signature` varchar(60) DEFAULT NULL,
  `examGenitaliaN` tinyint(1) DEFAULT NULL,
  `examGenitaliaAbN` tinyint(1) DEFAULT NULL,
  `examGenitalia` varchar(100) DEFAULT NULL,
  `toDoProstateCancer` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formBCHP`
--

DROP TABLE IF EXISTS `formBCHP`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formBCHP` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(11) DEFAULT NULL,
  `provider_no` int(11) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `c_lastVisited` char(3) DEFAULT NULL,
  `pg1_formDate` date DEFAULT NULL,
  `pg1_patientName` varchar(40) DEFAULT NULL,
  `pg1_phn` varchar(20) DEFAULT NULL,
  `pg1_phone` varchar(15) DEFAULT NULL,
  `pg1_emergContact` varchar(40) DEFAULT NULL,
  `pg1_emergContactPhone` varchar(15) DEFAULT NULL,
  `pg1_allergies` varchar(90) DEFAULT NULL,
  `pg1_md` varchar(40) DEFAULT NULL,
  `pg1_msp` varchar(9) DEFAULT NULL,
  `pg1_mdPhone` varchar(15) DEFAULT NULL,
  `pg1_livingWillY` tinyint(1) DEFAULT NULL,
  `pg1_livingWillN` tinyint(1) DEFAULT NULL,
  `pg1_diabetes` tinyint(1) DEFAULT NULL,
  `pg1_atrialFib` tinyint(1) DEFAULT NULL,
  `pg1_coronary` tinyint(1) DEFAULT NULL,
  `pg1_highBP` tinyint(1) DEFAULT NULL,
  `pg1_chf` tinyint(1) DEFAULT NULL,
  `pg1_stroke` tinyint(1) DEFAULT NULL,
  `pg1_kidneyDisease` tinyint(1) DEFAULT NULL,
  `pg1_lowGFR` varchar(10) DEFAULT NULL,
  `pg1_asthma` tinyint(1) DEFAULT NULL,
  `pg1_copd` tinyint(1) DEFAULT NULL,
  `pg1_co2retainer` tinyint(1) DEFAULT NULL,
  `pg1_cancer` tinyint(1) DEFAULT NULL,
  `pg1_cancerSpec` varchar(40) DEFAULT NULL,
  `pg1_other` tinyint(1) DEFAULT NULL,
  `pg1_otherSpec` varchar(90) DEFAULT NULL,
  `pg1_majorSurg` tinyint(1) DEFAULT NULL,
  `pg1_majorSurgSpec` varchar(80) DEFAULT NULL,
  `pg1_date1` date DEFAULT NULL,
  `pg1_medName1` varchar(30) DEFAULT NULL,
  `pg1_dose1` varchar(10) DEFAULT NULL,
  `pg1_howOften1` varchar(10) DEFAULT NULL,
  `pg1_reason1` varchar(20) DEFAULT NULL,
  `pg1_date2` date DEFAULT NULL,
  `pg1_medName2` varchar(30) DEFAULT NULL,
  `pg1_dose2` varchar(10) DEFAULT NULL,
  `pg1_howOften2` varchar(10) DEFAULT NULL,
  `pg1_reason2` varchar(20) DEFAULT NULL,
  `pg1_date3` date DEFAULT NULL,
  `pg1_medName3` varchar(30) DEFAULT NULL,
  `pg1_dose3` varchar(10) DEFAULT NULL,
  `pg1_howOften3` varchar(10) DEFAULT NULL,
  `pg1_reason3` varchar(20) DEFAULT NULL,
  `pg1_date4` date DEFAULT NULL,
  `pg1_medName4` varchar(30) DEFAULT NULL,
  `pg1_dose4` varchar(10) DEFAULT NULL,
  `pg1_howOften4` varchar(10) DEFAULT NULL,
  `pg1_reason4` varchar(20) DEFAULT NULL,
  `pg1_date5` date DEFAULT NULL,
  `pg1_medName5` varchar(30) DEFAULT NULL,
  `pg1_dose5` varchar(10) DEFAULT NULL,
  `pg1_howOften5` varchar(10) DEFAULT NULL,
  `pg1_reason5` varchar(20) DEFAULT NULL,
  `pg1_date6` date DEFAULT NULL,
  `pg1_medName6` varchar(30) DEFAULT NULL,
  `pg1_dose6` varchar(10) DEFAULT NULL,
  `pg1_howOften6` varchar(10) DEFAULT NULL,
  `pg1_reason6` varchar(20) DEFAULT NULL,
  `pg1_date7` date DEFAULT NULL,
  `pg1_medName7` varchar(30) DEFAULT NULL,
  `pg1_dose7` varchar(10) DEFAULT NULL,
  `pg1_howOften7` varchar(10) DEFAULT NULL,
  `pg1_reason7` varchar(20) DEFAULT NULL,
  `pg1_date8` date DEFAULT NULL,
  `pg1_medName8` varchar(30) DEFAULT NULL,
  `pg1_dose8` varchar(10) DEFAULT NULL,
  `pg1_howOften8` varchar(10) DEFAULT NULL,
  `pg1_reason8` varchar(20) DEFAULT NULL,
  `pg1_date9` date DEFAULT NULL,
  `pg1_medName9` varchar(30) DEFAULT NULL,
  `pg1_dose9` varchar(10) DEFAULT NULL,
  `pg1_howOften9` varchar(10) DEFAULT NULL,
  `pg1_reason9` varchar(20) DEFAULT NULL,
  `pg1_date10` date DEFAULT NULL,
  `pg1_medName10` varchar(30) DEFAULT NULL,
  `pg1_dose10` varchar(10) DEFAULT NULL,
  `pg1_howOften10` varchar(10) DEFAULT NULL,
  `pg1_reason10` varchar(20) DEFAULT NULL,
  `pg1_date11` date DEFAULT NULL,
  `pg1_medName11` varchar(30) DEFAULT NULL,
  `pg1_dose11` varchar(10) DEFAULT NULL,
  `pg1_howOften11` varchar(10) DEFAULT NULL,
  `pg1_reason11` varchar(20) DEFAULT NULL,
  `pg1_date12` date DEFAULT NULL,
  `pg1_medName12` varchar(30) DEFAULT NULL,
  `pg1_dose12` varchar(10) DEFAULT NULL,
  `pg1_howOften12` varchar(10) DEFAULT NULL,
  `pg1_reason12` varchar(20) DEFAULT NULL,
  `pg1_date13` date DEFAULT NULL,
  `pg1_medName13` varchar(30) DEFAULT NULL,
  `pg1_dose13` varchar(10) DEFAULT NULL,
  `pg1_howOften13` varchar(10) DEFAULT NULL,
  `pg1_reason13` varchar(20) DEFAULT NULL,
  `pg1_date14` date DEFAULT NULL,
  `pg1_medName14` varchar(30) DEFAULT NULL,
  `pg1_dose14` varchar(10) DEFAULT NULL,
  `pg1_howOften14` varchar(10) DEFAULT NULL,
  `pg1_reason14` varchar(20) DEFAULT NULL,
  `pg1_fluDate1` date DEFAULT NULL,
  `pg1_fluDate2` date DEFAULT NULL,
  `pg1_fluDate3` date DEFAULT NULL,
  `pg1_fluDate4` date DEFAULT NULL,
  `pg1_fluDate5` date DEFAULT NULL,
  `pg1_fluDate6` date DEFAULT NULL,
  `pg1_fluDate7` date DEFAULT NULL,
  `pg1_pneumoVaccDate1` date DEFAULT NULL,
  `pg1_pneumoVaccDate2` date DEFAULT NULL,
  `pg1_pneumoVaccDate3` date DEFAULT NULL,
  `pg1_pneumoVaccDate4` date DEFAULT NULL,
  `pg1_pneumoVaccDate5` date DEFAULT NULL,
  `pg1_pneumoVaccDate6` date DEFAULT NULL,
  `pg1_pneumoVaccDate7` date DEFAULT NULL,
  `pg1_tdDate1` date DEFAULT NULL,
  `pg1_tdDate2` date DEFAULT NULL,
  `pg1_tdDate3` date DEFAULT NULL,
  `pg1_tdDate4` date DEFAULT NULL,
  `pg1_tdDate5` date DEFAULT NULL,
  `pg1_tdDate6` date DEFAULT NULL,
  `pg1_tdDate7` date DEFAULT NULL,
  `pg1_hepaDate1` date DEFAULT NULL,
  `pg1_hepaDate2` date DEFAULT NULL,
  `pg1_hepaDate3` date DEFAULT NULL,
  `pg1_hepaDate4` date DEFAULT NULL,
  `pg1_hepaDate5` date DEFAULT NULL,
  `pg1_hepaDate6` date DEFAULT NULL,
  `pg1_hepaDate7` date DEFAULT NULL,
  `pg1_hepbDate1` date DEFAULT NULL,
  `pg1_hepbDate2` date DEFAULT NULL,
  `pg1_hepbDate3` date DEFAULT NULL,
  `pg1_hepbDate4` date DEFAULT NULL,
  `pg1_hepbDate5` date DEFAULT NULL,
  `pg1_hepbDate6` date DEFAULT NULL,
  `pg1_hepbDate7` date DEFAULT NULL,
  `pg1_otherVac` varchar(30) DEFAULT NULL,
  `pg1_otherDate1` date DEFAULT NULL,
  `pg1_otherDate2` date DEFAULT NULL,
  `pg1_otherDate3` date DEFAULT NULL,
  `pg1_otherDate4` date DEFAULT NULL,
  `pg1_otherDate5` date DEFAULT NULL,
  `pg1_otherDate6` date DEFAULT NULL,
  `pg1_otherDate7` date DEFAULT NULL,
  `pg2_date1` date DEFAULT NULL,
  `pg2_medName1` varchar(30) DEFAULT NULL,
  `pg2_dose1` varchar(10) DEFAULT NULL,
  `pg2_howOften1` varchar(10) DEFAULT NULL,
  `pg2_reason1` varchar(20) DEFAULT NULL,
  `pg2_date2` date DEFAULT NULL,
  `pg2_medName2` varchar(30) DEFAULT NULL,
  `pg2_dose2` varchar(10) DEFAULT NULL,
  `pg2_howOften2` varchar(10) DEFAULT NULL,
  `pg2_reason2` varchar(20) DEFAULT NULL,
  `pg2_date3` date DEFAULT NULL,
  `pg2_medName3` varchar(30) DEFAULT NULL,
  `pg2_dose3` varchar(10) DEFAULT NULL,
  `pg2_howOften3` varchar(10) DEFAULT NULL,
  `pg2_reason3` varchar(20) DEFAULT NULL,
  `pg2_date4` date DEFAULT NULL,
  `pg2_medName4` varchar(30) DEFAULT NULL,
  `pg2_dose4` varchar(10) DEFAULT NULL,
  `pg2_howOften4` varchar(10) DEFAULT NULL,
  `pg2_reason4` varchar(20) DEFAULT NULL,
  `pg2_date5` date DEFAULT NULL,
  `pg2_medName5` varchar(30) DEFAULT NULL,
  `pg2_dose5` varchar(10) DEFAULT NULL,
  `pg2_howOften5` varchar(10) DEFAULT NULL,
  `pg2_reason5` varchar(20) DEFAULT NULL,
  `pg2_date6` date DEFAULT NULL,
  `pg2_medName6` varchar(30) DEFAULT NULL,
  `pg2_dose6` varchar(10) DEFAULT NULL,
  `pg2_howOften6` varchar(10) DEFAULT NULL,
  `pg2_reason6` varchar(20) DEFAULT NULL,
  `pg2_date7` date DEFAULT NULL,
  `pg2_medName7` varchar(30) DEFAULT NULL,
  `pg2_dose7` varchar(10) DEFAULT NULL,
  `pg2_howOften7` varchar(10) DEFAULT NULL,
  `pg2_reason7` varchar(20) DEFAULT NULL,
  `pg2_date8` date DEFAULT NULL,
  `pg2_medName8` varchar(30) DEFAULT NULL,
  `pg2_dose8` varchar(10) DEFAULT NULL,
  `pg2_howOften8` varchar(10) DEFAULT NULL,
  `pg2_reason8` varchar(20) DEFAULT NULL,
  `pg2_date9` date DEFAULT NULL,
  `pg2_medName9` varchar(30) DEFAULT NULL,
  `pg2_dose9` varchar(10) DEFAULT NULL,
  `pg2_howOften9` varchar(10) DEFAULT NULL,
  `pg2_reason9` varchar(20) DEFAULT NULL,
  `pg2_date10` date DEFAULT NULL,
  `pg2_medName10` varchar(30) DEFAULT NULL,
  `pg2_dose10` varchar(10) DEFAULT NULL,
  `pg2_howOften10` varchar(10) DEFAULT NULL,
  `pg2_reason10` varchar(20) DEFAULT NULL,
  `pg2_date11` date DEFAULT NULL,
  `pg2_medName11` varchar(30) DEFAULT NULL,
  `pg2_dose11` varchar(10) DEFAULT NULL,
  `pg2_howOften11` varchar(10) DEFAULT NULL,
  `pg2_reason11` varchar(20) DEFAULT NULL,
  `pg2_date12` date DEFAULT NULL,
  `pg2_medName12` varchar(30) DEFAULT NULL,
  `pg2_dose12` varchar(10) DEFAULT NULL,
  `pg2_howOften12` varchar(10) DEFAULT NULL,
  `pg2_reason12` varchar(20) DEFAULT NULL,
  `pg2_date13` date DEFAULT NULL,
  `pg2_medName13` varchar(30) DEFAULT NULL,
  `pg2_dose13` varchar(10) DEFAULT NULL,
  `pg2_howOften13` varchar(10) DEFAULT NULL,
  `pg2_reason13` varchar(20) DEFAULT NULL,
  `pg2_date14` date DEFAULT NULL,
  `pg2_medName14` varchar(30) DEFAULT NULL,
  `pg2_dose14` varchar(10) DEFAULT NULL,
  `pg2_howOften14` varchar(10) DEFAULT NULL,
  `pg2_reason14` varchar(20) DEFAULT NULL,
  `pg2_fluDate1` date DEFAULT NULL,
  `pg2_fluDate2` date DEFAULT NULL,
  `pg2_fluDate3` date DEFAULT NULL,
  `pg2_fluDate4` date DEFAULT NULL,
  `pg2_fluDate5` date DEFAULT NULL,
  `pg2_fluDate6` date DEFAULT NULL,
  `pg2_fluDate7` date DEFAULT NULL,
  `pg2_otherVac1` varchar(30) DEFAULT NULL,
  `pg2_other1Date1` date DEFAULT NULL,
  `pg2_other1Date2` date DEFAULT NULL,
  `pg2_other1Date3` date DEFAULT NULL,
  `pg2_other1Date4` date DEFAULT NULL,
  `pg2_other1Date5` date DEFAULT NULL,
  `pg2_other1Date6` date DEFAULT NULL,
  `pg2_other1Date7` date DEFAULT NULL,
  `pg2_otherVac2` varchar(30) DEFAULT NULL,
  `pg2_other2Date1` date DEFAULT NULL,
  `pg2_other2Date2` date DEFAULT NULL,
  `pg2_other2Date3` date DEFAULT NULL,
  `pg2_other2Date4` date DEFAULT NULL,
  `pg2_other2Date5` date DEFAULT NULL,
  `pg2_other2Date6` date DEFAULT NULL,
  `pg2_other2Date7` date DEFAULT NULL,
  `pg2_otherVac3` varchar(30) DEFAULT NULL,
  `pg2_other3Date1` date DEFAULT NULL,
  `pg2_other3Date2` date DEFAULT NULL,
  `pg2_other3Date3` date DEFAULT NULL,
  `pg2_other3Date4` date DEFAULT NULL,
  `pg2_other3Date5` date DEFAULT NULL,
  `pg2_other3Date6` date DEFAULT NULL,
  `pg2_other3Date7` date DEFAULT NULL,
  `pg2_otherVac4` varchar(30) DEFAULT NULL,
  `pg2_other4Date1` date DEFAULT NULL,
  `pg2_other4Date2` date DEFAULT NULL,
  `pg2_other4Date3` date DEFAULT NULL,
  `pg2_other4Date4` date DEFAULT NULL,
  `pg2_other4Date5` date DEFAULT NULL,
  `pg2_other4Date6` date DEFAULT NULL,
  `pg2_other4Date7` date DEFAULT NULL,
  `pg2_otherVac5` varchar(30) DEFAULT NULL,
  `pg2_other5Date1` date DEFAULT NULL,
  `pg2_other5Date2` date DEFAULT NULL,
  `pg2_other5Date3` date DEFAULT NULL,
  `pg2_other5Date4` date DEFAULT NULL,
  `pg2_other5Date5` date DEFAULT NULL,
  `pg2_other5Date6` date DEFAULT NULL,
  `pg2_other5Date7` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formCESD`
--

DROP TABLE IF EXISTS `formCESD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formCESD` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `Q1Rare` tinyint(1) DEFAULT NULL,
  `Q1Some` tinyint(1) DEFAULT NULL,
  `Q1Occ` tinyint(1) DEFAULT NULL,
  `Q1Most` tinyint(1) DEFAULT NULL,
  `Q2Rare` tinyint(1) DEFAULT NULL,
  `Q2Some` tinyint(1) DEFAULT NULL,
  `Q2Occ` tinyint(1) DEFAULT NULL,
  `Q2Most` tinyint(1) DEFAULT NULL,
  `Q3Rare` tinyint(1) DEFAULT NULL,
  `Q3Some` tinyint(1) DEFAULT NULL,
  `Q3Occ` tinyint(1) DEFAULT NULL,
  `Q3Most` tinyint(1) DEFAULT NULL,
  `Q4Rare` tinyint(1) DEFAULT NULL,
  `Q4Some` tinyint(1) DEFAULT NULL,
  `Q4Occ` tinyint(1) DEFAULT NULL,
  `Q4Most` tinyint(1) DEFAULT NULL,
  `Q5Rare` tinyint(1) DEFAULT NULL,
  `Q5Some` tinyint(1) DEFAULT NULL,
  `Q5Occ` tinyint(1) DEFAULT NULL,
  `Q5Most` tinyint(1) DEFAULT NULL,
  `Q6Rare` tinyint(1) DEFAULT NULL,
  `Q6Some` tinyint(1) DEFAULT NULL,
  `Q6Occ` tinyint(1) DEFAULT NULL,
  `Q6Most` tinyint(1) DEFAULT NULL,
  `Q7Rare` tinyint(1) DEFAULT NULL,
  `Q7Some` tinyint(1) DEFAULT NULL,
  `Q7Occ` tinyint(1) DEFAULT NULL,
  `Q7Most` tinyint(1) DEFAULT NULL,
  `Q8Rare` tinyint(1) DEFAULT NULL,
  `Q8Some` tinyint(1) DEFAULT NULL,
  `Q8Occ` tinyint(1) DEFAULT NULL,
  `Q8Most` tinyint(1) DEFAULT NULL,
  `Q9Rare` tinyint(1) DEFAULT NULL,
  `Q9Some` tinyint(1) DEFAULT NULL,
  `Q9Occ` tinyint(1) DEFAULT NULL,
  `Q9Most` tinyint(1) DEFAULT NULL,
  `Q10Rare` tinyint(1) DEFAULT NULL,
  `Q10Some` tinyint(1) DEFAULT NULL,
  `Q10Occ` tinyint(1) DEFAULT NULL,
  `Q10Most` tinyint(1) DEFAULT NULL,
  `Q11Rare` tinyint(1) DEFAULT NULL,
  `Q11Some` tinyint(1) DEFAULT NULL,
  `Q11Occ` tinyint(1) DEFAULT NULL,
  `Q11Most` tinyint(1) DEFAULT NULL,
  `Q12Rare` tinyint(1) DEFAULT NULL,
  `Q12Some` tinyint(1) DEFAULT NULL,
  `Q12Occ` tinyint(1) DEFAULT NULL,
  `Q12Most` tinyint(1) DEFAULT NULL,
  `Q13Rare` tinyint(1) DEFAULT NULL,
  `Q13Some` tinyint(1) DEFAULT NULL,
  `Q13Occ` tinyint(1) DEFAULT NULL,
  `Q13Most` tinyint(1) DEFAULT NULL,
  `Q14Rare` tinyint(1) DEFAULT NULL,
  `Q14Some` tinyint(1) DEFAULT NULL,
  `Q14Occ` tinyint(1) DEFAULT NULL,
  `Q14Most` tinyint(1) DEFAULT NULL,
  `Q15Rare` tinyint(1) DEFAULT NULL,
  `Q15Some` tinyint(1) DEFAULT NULL,
  `Q15Occ` tinyint(1) DEFAULT NULL,
  `Q15Most` tinyint(1) DEFAULT NULL,
  `Q16Rare` tinyint(1) DEFAULT NULL,
  `Q16Some` tinyint(1) DEFAULT NULL,
  `Q16Occ` tinyint(1) DEFAULT NULL,
  `Q16Most` tinyint(1) DEFAULT NULL,
  `Q17Rare` tinyint(1) DEFAULT NULL,
  `Q17Some` tinyint(1) DEFAULT NULL,
  `Q17Occ` tinyint(1) DEFAULT NULL,
  `Q17Most` tinyint(1) DEFAULT NULL,
  `Q18Rare` tinyint(1) DEFAULT NULL,
  `Q18Some` tinyint(1) DEFAULT NULL,
  `Q18Occ` tinyint(1) DEFAULT NULL,
  `Q18Most` tinyint(1) DEFAULT NULL,
  `Q19Rare` tinyint(1) DEFAULT NULL,
  `Q19Some` tinyint(1) DEFAULT NULL,
  `Q19Occ` tinyint(1) DEFAULT NULL,
  `Q19Most` tinyint(1) DEFAULT NULL,
  `Q20Rare` tinyint(1) DEFAULT NULL,
  `Q20Some` tinyint(1) DEFAULT NULL,
  `Q20Occ` tinyint(1) DEFAULT NULL,
  `Q20Most` tinyint(1) DEFAULT NULL,
  `score` int(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formCaregiver`
--

DROP TABLE IF EXISTS `formCaregiver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formCaregiver` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `sexM` tinyint(1) DEFAULT NULL,
  `sexF` tinyint(1) DEFAULT NULL,
  `dobYear` varchar(4) DEFAULT NULL,
  `dobMonth` varchar(2) DEFAULT NULL,
  `dobDay` varchar(2) DEFAULT NULL,
  `spouseY` tinyint(1) DEFAULT NULL,
  `childY` tinyint(1) DEFAULT NULL,
  `grandchildY` tinyint(1) DEFAULT NULL,
  `siblingY` tinyint(1) DEFAULT NULL,
  `friendY` tinyint(1) DEFAULT NULL,
  `otherY` tinyint(1) DEFAULT NULL,
  `otherRelation` varchar(255) DEFAULT NULL,
  `resideY` tinyint(1) DEFAULT NULL,
  `resideN` tinyint(1) DEFAULT NULL,
  `healthEx` tinyint(1) DEFAULT NULL,
  `healthVG` tinyint(1) DEFAULT NULL,
  `healthG` tinyint(1) DEFAULT NULL,
  `healthF` tinyint(1) DEFAULT NULL,
  `healthP` tinyint(1) DEFAULT NULL,
  `Q1Y` tinyint(1) DEFAULT NULL,
  `Q1N` tinyint(1) DEFAULT NULL,
  `Q2Y` tinyint(1) DEFAULT NULL,
  `Q2N` tinyint(1) DEFAULT NULL,
  `Q3Y` tinyint(1) DEFAULT NULL,
  `Q3N` tinyint(1) DEFAULT NULL,
  `Q4Y` tinyint(1) DEFAULT NULL,
  `Q4N` tinyint(1) DEFAULT NULL,
  `Q5Y` tinyint(1) DEFAULT NULL,
  `Q5N` tinyint(1) DEFAULT NULL,
  `Q6Y` tinyint(1) DEFAULT NULL,
  `Q6N` tinyint(1) DEFAULT NULL,
  `Q7Y` tinyint(1) DEFAULT NULL,
  `Q7N` tinyint(1) DEFAULT NULL,
  `Q8Y` tinyint(1) DEFAULT NULL,
  `Q8N` tinyint(1) DEFAULT NULL,
  `Q9Y` tinyint(1) DEFAULT NULL,
  `Q9N` tinyint(1) DEFAULT NULL,
  `Q10Y` tinyint(1) DEFAULT NULL,
  `Q10N` tinyint(1) DEFAULT NULL,
  `Q11Y` tinyint(1) DEFAULT NULL,
  `Q11N` tinyint(1) DEFAULT NULL,
  `Q12Y` tinyint(1) DEFAULT NULL,
  `Q12N` tinyint(1) DEFAULT NULL,
  `Q13Y` tinyint(1) DEFAULT NULL,
  `Q13N` tinyint(1) DEFAULT NULL,
  `score1` int(2) DEFAULT NULL,
  `SRBScore` int(3) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formConsult`
--

DROP TABLE IF EXISTS `formConsult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formConsult` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` int(10) DEFAULT NULL,
  `doc_name` varchar(60) DEFAULT NULL,
  `cl_name` varchar(60) DEFAULT NULL,
  `cl_address1` varchar(170) DEFAULT NULL,
  `cl_address2` varchar(170) DEFAULT NULL,
  `cl_phone` varchar(16) DEFAULT NULL,
  `cl_fax` varchar(16) DEFAULT NULL,
  `billingreferral_no` int(10) DEFAULT NULL,
  `t_name` varchar(60) DEFAULT NULL,
  `t_name2` varchar(60) DEFAULT NULL,
  `t_address1` varchar(170) DEFAULT NULL,
  `t_address2` varchar(170) DEFAULT NULL,
  `t_phone` varchar(16) DEFAULT NULL,
  `t_fax` varchar(16) DEFAULT NULL,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `p_name` varchar(60) DEFAULT NULL,
  `p_address1` varchar(170) DEFAULT NULL,
  `p_address2` varchar(170) DEFAULT NULL,
  `p_phone` varchar(16) DEFAULT NULL,
  `p_birthdate` varchar(30) DEFAULT NULL,
  `p_healthcard` varchar(20) DEFAULT NULL,
  `comments` text,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `consultTime` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formCostQuestionnaire`
--

DROP TABLE IF EXISTS `formCostQuestionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formCostQuestionnaire` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `seenDoctorY` tinyint(1) DEFAULT NULL,
  `seenDoctorN` tinyint(1) DEFAULT NULL,
  `familyPhyVisits` int(3) DEFAULT NULL,
  `specialistVisits` int(3) DEFAULT NULL,
  `otherProviderY` tinyint(1) DEFAULT NULL,
  `otherProviderN` tinyint(1) DEFAULT NULL,
  `visitNurse` int(3) DEFAULT NULL,
  `homeMaker` int(3) DEFAULT NULL,
  `physiotherapist` int(3) DEFAULT NULL,
  `therapist` int(3) DEFAULT NULL,
  `psychologist` int(3) DEFAULT NULL,
  `socialWorker` int(3) DEFAULT NULL,
  `supportGroup` int(3) DEFAULT NULL,
  `mealOnWheels` int(3) DEFAULT NULL,
  `other` int(3) DEFAULT NULL,
  `paidService1` varchar(255) DEFAULT NULL,
  `paidServiceHour1` int(5) DEFAULT NULL,
  `paidServiceCost1` double DEFAULT NULL,
  `paidService2` varchar(255) DEFAULT NULL,
  `paidServiceHour2` int(5) DEFAULT NULL,
  `paidServiceCost2` double DEFAULT NULL,
  `paidService3` varchar(255) DEFAULT NULL,
  `paidServiceHour3` int(5) DEFAULT NULL,
  `paidServiceCost3` double DEFAULT NULL,
  `plannedHospN` tinyint(1) DEFAULT NULL,
  `plannedHospY` tinyint(1) DEFAULT NULL,
  `plannedHospAdmitted` int(3) DEFAULT NULL,
  `plannedHospDays` int(3) DEFAULT NULL,
  `nursingHomeN` tinyint(1) DEFAULT NULL,
  `nursingHomeY` tinyint(1) DEFAULT NULL,
  `nursingHomeDays` int(3) DEFAULT NULL,
  `emergencyN` tinyint(1) DEFAULT NULL,
  `emergencyY` tinyint(1) DEFAULT NULL,
  `emergency911` int(3) DEFAULT NULL,
  `emergency` int(3) DEFAULT NULL,
  `emergencyAmbulance` int(3) DEFAULT NULL,
  `walkinN` tinyint(1) DEFAULT NULL,
  `walkinY` tinyint(1) DEFAULT NULL,
  `walkin` int(3) DEFAULT NULL,
  `itemPurchased1` varchar(255) DEFAULT NULL,
  `itemCost1` double DEFAULT NULL,
  `itemPurchased2` varchar(255) DEFAULT NULL,
  `itemCost2` double DEFAULT NULL,
  `itemPurchased3` varchar(255) DEFAULT NULL,
  `itemCost3` double DEFAULT NULL,
  `employed` tinyint(1) DEFAULT NULL,
  `employedFullTime` tinyint(1) DEFAULT NULL,
  `employedPartTime` tinyint(1) DEFAULT NULL,
  `selfEmployed` tinyint(1) DEFAULT NULL,
  `selfEmployedFullTime` tinyint(1) DEFAULT NULL,
  `selfEmployedPartTime` tinyint(1) DEFAULT NULL,
  `unemployed` tinyint(1) DEFAULT NULL,
  `unemployedAble` tinyint(1) DEFAULT NULL,
  `unemployedUnable` tinyint(1) DEFAULT NULL,
  `disability` tinyint(1) DEFAULT NULL,
  `disabilityShortTerm` tinyint(1) DEFAULT NULL,
  `disabilityLongTerm` tinyint(1) DEFAULT NULL,
  `retired` tinyint(1) DEFAULT NULL,
  `homemakerWithOutPaid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formDischargeSummary`
--

DROP TABLE IF EXISTS `formDischargeSummary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formDischargeSummary` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `demographic_no` bigint(11) NOT NULL DEFAULT '0',
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `clientName` varchar(60) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `ohip` varchar(25) DEFAULT NULL,
  `admitDate` date DEFAULT NULL,
  `dischargeDate` date DEFAULT NULL,
  `programName` varchar(70) DEFAULT NULL,
  `allergies` text,
  `admissionNotes` text,
  `currentIssues` text,
  `briefSummary` text,
  `dischargePlan` text,
  `followUpAppointment` char(1) DEFAULT NULL,
  `doctor1` varchar(30) DEFAULT NULL,
  `phoneNumber1` varchar(30) DEFAULT NULL,
  `date1` varchar(20) DEFAULT NULL,
  `location1` varchar(100) DEFAULT NULL,
  `doctor2` varchar(30) DEFAULT NULL,
  `phoneNumber2` varchar(30) DEFAULT NULL,
  `date2` varchar(20) DEFAULT NULL,
  `location2` varchar(100) DEFAULT NULL,
  `doctor3` varchar(30) DEFAULT NULL,
  `phoneNumber3` varchar(30) DEFAULT NULL,
  `date3` varchar(20) DEFAULT NULL,
  `location3` varchar(100) DEFAULT NULL,
  `doctor4` varchar(30) DEFAULT NULL,
  `phoneNumber4` varchar(30) DEFAULT NULL,
  `date4` varchar(20) DEFAULT NULL,
  `location4` varchar(100) DEFAULT NULL,
  `prescriptionSummary` text,
  `prescriptionProvided` char(1) DEFAULT NULL,
  `medicationProvided` char(1) DEFAULT NULL,
  `ODBFormReqired` char(1) DEFAULT NULL,
  `changeMedications` varchar(255) DEFAULT NULL,
  `referralProgram1` varchar(255) DEFAULT NULL,
  `referralMade1` varchar(255) DEFAULT NULL,
  `referralOutcome1` varchar(255) DEFAULT NULL,
  `referralProgram2` varchar(255) DEFAULT NULL,
  `referralMade2` varchar(255) DEFAULT NULL,
  `referralOutcome2` varchar(255) DEFAULT NULL,
  `referralProgram3` varchar(255) DEFAULT NULL,
  `referralMade3` varchar(255) DEFAULT NULL,
  `referralOutcome3` varchar(255) DEFAULT NULL,
  `referralProgram4` varchar(255) DEFAULT NULL,
  `referralMade4` varchar(255) DEFAULT NULL,
  `referralOutcome4` varchar(255) DEFAULT NULL,
  `referralProgram5` varchar(255) DEFAULT NULL,
  `referralMade5` varchar(255) DEFAULT NULL,
  `referralOutcome5` varchar(255) DEFAULT NULL,
  `provider_no` bigint(11) NOT NULL DEFAULT '0',
  `providerName` varchar(60) DEFAULT NULL,
  `signature` varchar(60) DEFAULT NULL,
  `signatureDate` varchar(20) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formFalls`
--

DROP TABLE IF EXISTS `formFalls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formFalls` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `fallenLast12MY` tinyint(1) DEFAULT NULL,
  `fallenLast12MN` tinyint(1) DEFAULT NULL,
  `fallenLast12MNotRemember` tinyint(1) DEFAULT NULL,
  `injuredY` tinyint(1) DEFAULT NULL,
  `injuredN` tinyint(1) DEFAULT NULL,
  `medAttnY` tinyint(1) DEFAULT NULL,
  `medAttnN` tinyint(1) DEFAULT NULL,
  `hospitalizedY` tinyint(1) DEFAULT NULL,
  `hospitalizedN` tinyint(1) DEFAULT NULL,
  `limitActY` tinyint(1) DEFAULT NULL,
  `limitActN` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formGripStrength`
--

DROP TABLE IF EXISTS `formGripStrength`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formGripStrength` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `dom1` varchar(5) DEFAULT NULL,
  `nonDom1` varchar(5) DEFAULT NULL,
  `dom2` varchar(5) DEFAULT NULL,
  `nonDom2` varchar(5) DEFAULT NULL,
  `dom3` varchar(5) DEFAULT NULL,
  `nonDom3` varchar(5) DEFAULT NULL,
  `domAvg` varchar(5) DEFAULT NULL,
  `nonDomAvg` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formGrowth0_36`
--

DROP TABLE IF EXISTS `formGrowth0_36`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formGrowth0_36` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `patientName` varchar(80) DEFAULT NULL,
  `recordNo` varchar(10) DEFAULT NULL,
  `motherStature` varchar(80) DEFAULT NULL,
  `gestationalAge` varchar(5) DEFAULT NULL,
  `fatherStature` varchar(80) DEFAULT NULL,
  `edc` varchar(10) DEFAULT NULL,
  `date_1` date DEFAULT NULL,
  `age_1` varchar(5) DEFAULT NULL,
  `weight_1` varchar(6) DEFAULT NULL,
  `length_1` varchar(6) DEFAULT NULL,
  `headCirc_1` varchar(6) DEFAULT NULL,
  `comment_1` varchar(25) DEFAULT NULL,
  `date_2` date DEFAULT NULL,
  `age_2` varchar(5) DEFAULT NULL,
  `weight_2` varchar(6) DEFAULT NULL,
  `length_2` varchar(6) DEFAULT NULL,
  `headCirc_2` varchar(6) DEFAULT NULL,
  `comment_2` varchar(25) DEFAULT NULL,
  `date_3` date DEFAULT NULL,
  `age_3` varchar(5) DEFAULT NULL,
  `weight_3` varchar(6) DEFAULT NULL,
  `length_3` varchar(6) DEFAULT NULL,
  `headCirc_3` varchar(6) DEFAULT NULL,
  `comment_3` varchar(25) DEFAULT NULL,
  `date_4` date DEFAULT NULL,
  `age_4` varchar(5) DEFAULT NULL,
  `weight_4` varchar(6) DEFAULT NULL,
  `length_4` varchar(6) DEFAULT NULL,
  `headCirc_4` varchar(6) DEFAULT NULL,
  `comment_4` varchar(25) DEFAULT NULL,
  `date_5` date DEFAULT NULL,
  `age_5` varchar(5) DEFAULT NULL,
  `weight_5` varchar(6) DEFAULT NULL,
  `length_5` varchar(6) DEFAULT NULL,
  `headCirc_5` varchar(6) DEFAULT NULL,
  `comment_5` varchar(25) DEFAULT NULL,
  `date_6` date DEFAULT NULL,
  `age_6` varchar(5) DEFAULT NULL,
  `weight_6` varchar(6) DEFAULT NULL,
  `length_6` varchar(6) DEFAULT NULL,
  `headCirc_6` varchar(6) DEFAULT NULL,
  `comment_6` varchar(25) DEFAULT NULL,
  `date_7` date DEFAULT NULL,
  `age_7` varchar(5) DEFAULT NULL,
  `weight_7` varchar(6) DEFAULT NULL,
  `length_7` varchar(6) DEFAULT NULL,
  `headCirc_7` varchar(6) DEFAULT NULL,
  `comment_7` varchar(25) DEFAULT NULL,
  `date_8` date DEFAULT NULL,
  `age_8` varchar(5) DEFAULT NULL,
  `weight_8` varchar(6) DEFAULT NULL,
  `length_8` varchar(6) DEFAULT NULL,
  `headCirc_8` varchar(6) DEFAULT NULL,
  `comment_8` varchar(25) DEFAULT NULL,
  `date_9` date DEFAULT NULL,
  `age_9` varchar(5) DEFAULT NULL,
  `weight_9` varchar(6) DEFAULT NULL,
  `length_9` varchar(6) DEFAULT NULL,
  `headCirc_9` varchar(6) DEFAULT NULL,
  `comment_9` varchar(25) DEFAULT NULL,
  `date_10` date DEFAULT NULL,
  `age_10` varchar(5) DEFAULT NULL,
  `weight_10` varchar(6) DEFAULT NULL,
  `length_10` varchar(6) DEFAULT NULL,
  `headCirc_10` varchar(6) DEFAULT NULL,
  `comment_10` varchar(25) DEFAULT NULL,
  `date_11` date DEFAULT NULL,
  `age_11` varchar(5) DEFAULT NULL,
  `weight_11` varchar(6) DEFAULT NULL,
  `length_11` varchar(6) DEFAULT NULL,
  `headCirc_11` varchar(6) DEFAULT NULL,
  `comment_11` varchar(25) DEFAULT NULL,
  `date_12` date DEFAULT NULL,
  `age_12` varchar(5) DEFAULT NULL,
  `weight_12` varchar(6) DEFAULT NULL,
  `length_12` varchar(6) DEFAULT NULL,
  `headCirc_12` varchar(6) DEFAULT NULL,
  `comment_12` varchar(25) DEFAULT NULL,
  `date_13` date DEFAULT NULL,
  `age_13` varchar(5) DEFAULT NULL,
  `weight_13` varchar(6) DEFAULT NULL,
  `length_13` varchar(6) DEFAULT NULL,
  `headCirc_13` varchar(6) DEFAULT NULL,
  `comment_13` varchar(25) DEFAULT NULL,
  `date_14` date DEFAULT NULL,
  `age_14` varchar(5) DEFAULT NULL,
  `weight_14` varchar(6) DEFAULT NULL,
  `length_14` varchar(6) DEFAULT NULL,
  `headCirc_14` varchar(6) DEFAULT NULL,
  `comment_14` varchar(25) DEFAULT NULL,
  `date_15` date DEFAULT NULL,
  `age_15` varchar(5) DEFAULT NULL,
  `weight_15` varchar(6) DEFAULT NULL,
  `length_15` varchar(6) DEFAULT NULL,
  `headCirc_15` varchar(6) DEFAULT NULL,
  `comment_15` varchar(25) DEFAULT NULL,
  `date_16` date DEFAULT NULL,
  `age_16` varchar(5) DEFAULT NULL,
  `weight_16` varchar(6) DEFAULT NULL,
  `length_16` varchar(6) DEFAULT NULL,
  `headCirc_16` varchar(6) DEFAULT NULL,
  `comment_16` varchar(25) DEFAULT NULL,
  `date_17` date DEFAULT NULL,
  `age_17` varchar(5) DEFAULT NULL,
  `weight_17` varchar(6) DEFAULT NULL,
  `length_17` varchar(6) DEFAULT NULL,
  `headCirc_17` varchar(6) DEFAULT NULL,
  `comment_17` varchar(25) DEFAULT NULL,
  `date_18` date DEFAULT NULL,
  `age_18` varchar(5) DEFAULT NULL,
  `weight_18` varchar(6) DEFAULT NULL,
  `length_18` varchar(6) DEFAULT NULL,
  `headCirc_18` varchar(6) DEFAULT NULL,
  `comment_18` varchar(25) DEFAULT NULL,
  `date_19` date DEFAULT NULL,
  `age_19` varchar(5) DEFAULT NULL,
  `weight_19` varchar(6) DEFAULT NULL,
  `length_19` varchar(6) DEFAULT NULL,
  `headCirc_19` varchar(6) DEFAULT NULL,
  `comment_19` varchar(25) DEFAULT NULL,
  `date_20` date DEFAULT NULL,
  `age_20` varchar(5) DEFAULT NULL,
  `weight_20` varchar(6) DEFAULT NULL,
  `length_20` varchar(6) DEFAULT NULL,
  `headCirc_20` varchar(6) DEFAULT NULL,
  `comment_20` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `demographic_no` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formGrowthChart`
--

DROP TABLE IF EXISTS `formGrowthChart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formGrowthChart` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `patientName` varchar(80) DEFAULT NULL,
  `recordNo` varchar(10) DEFAULT NULL,
  `motherStature` varchar(80) DEFAULT NULL,
  `fatherStature` varchar(80) DEFAULT NULL,
  `date_1` date DEFAULT NULL,
  `age_1` varchar(5) DEFAULT NULL,
  `stature_1` varchar(6) DEFAULT NULL,
  `weight_1` varchar(6) DEFAULT NULL,
  `comment_1` varchar(25) DEFAULT NULL,
  `bmi_1` varchar(5) DEFAULT NULL,
  `date_2` date DEFAULT NULL,
  `age_2` varchar(5) DEFAULT NULL,
  `stature_2` varchar(6) DEFAULT NULL,
  `weight_2` varchar(6) DEFAULT NULL,
  `comment_2` varchar(25) DEFAULT NULL,
  `bmi_2` varchar(5) DEFAULT NULL,
  `date_3` date DEFAULT NULL,
  `age_3` varchar(5) DEFAULT NULL,
  `stature_3` varchar(6) DEFAULT NULL,
  `weight_3` varchar(6) DEFAULT NULL,
  `comment_3` varchar(25) DEFAULT NULL,
  `bmi_3` varchar(5) DEFAULT NULL,
  `date_4` date DEFAULT NULL,
  `age_4` varchar(5) DEFAULT NULL,
  `stature_4` varchar(6) DEFAULT NULL,
  `weight_4` varchar(6) DEFAULT NULL,
  `comment_4` varchar(25) DEFAULT NULL,
  `bmi_4` varchar(5) DEFAULT NULL,
  `date_5` date DEFAULT NULL,
  `age_5` varchar(5) DEFAULT NULL,
  `stature_5` varchar(6) DEFAULT NULL,
  `weight_5` varchar(6) DEFAULT NULL,
  `comment_5` varchar(25) DEFAULT NULL,
  `bmi_5` varchar(5) DEFAULT NULL,
  `date_6` date DEFAULT NULL,
  `age_6` varchar(5) DEFAULT NULL,
  `stature_6` varchar(6) DEFAULT NULL,
  `weight_6` varchar(6) DEFAULT NULL,
  `comment_6` varchar(25) DEFAULT NULL,
  `bmi_6` varchar(5) DEFAULT NULL,
  `date_7` date DEFAULT NULL,
  `age_7` varchar(5) DEFAULT NULL,
  `stature_7` varchar(6) DEFAULT NULL,
  `weight_7` varchar(6) DEFAULT NULL,
  `comment_7` varchar(25) DEFAULT NULL,
  `bmi_7` varchar(5) DEFAULT NULL,
  `date_8` date DEFAULT NULL,
  `age_8` varchar(5) DEFAULT NULL,
  `stature_8` varchar(6) DEFAULT NULL,
  `weight_8` varchar(6) DEFAULT NULL,
  `comment_8` varchar(25) DEFAULT NULL,
  `bmi_8` varchar(5) DEFAULT NULL,
  `date_9` date DEFAULT NULL,
  `age_9` varchar(5) DEFAULT NULL,
  `stature_9` varchar(6) DEFAULT NULL,
  `weight_9` varchar(6) DEFAULT NULL,
  `comment_9` varchar(25) DEFAULT NULL,
  `bmi_9` varchar(5) DEFAULT NULL,
  `date_10` date DEFAULT NULL,
  `age_10` varchar(5) DEFAULT NULL,
  `stature_10` varchar(6) DEFAULT NULL,
  `weight_10` varchar(6) DEFAULT NULL,
  `comment_10` varchar(25) DEFAULT NULL,
  `bmi_10` varchar(5) DEFAULT NULL,
  `date_11` date DEFAULT NULL,
  `age_11` varchar(5) DEFAULT NULL,
  `stature_11` varchar(6) DEFAULT NULL,
  `weight_11` varchar(6) DEFAULT NULL,
  `comment_11` varchar(25) DEFAULT NULL,
  `bmi_11` varchar(5) DEFAULT NULL,
  `date_12` date DEFAULT NULL,
  `age_12` varchar(5) DEFAULT NULL,
  `stature_12` varchar(6) DEFAULT NULL,
  `weight_12` varchar(6) DEFAULT NULL,
  `comment_12` varchar(25) DEFAULT NULL,
  `bmi_12` varchar(5) DEFAULT NULL,
  `date_13` date DEFAULT NULL,
  `age_13` varchar(5) DEFAULT NULL,
  `stature_13` varchar(6) DEFAULT NULL,
  `weight_13` varchar(6) DEFAULT NULL,
  `comment_13` varchar(25) DEFAULT NULL,
  `bmi_13` varchar(5) DEFAULT NULL,
  `date_14` date DEFAULT NULL,
  `age_14` varchar(5) DEFAULT NULL,
  `stature_14` varchar(6) DEFAULT NULL,
  `weight_14` varchar(6) DEFAULT NULL,
  `comment_14` varchar(25) DEFAULT NULL,
  `bmi_14` varchar(5) DEFAULT NULL,
  `date_15` date DEFAULT NULL,
  `age_15` varchar(5) DEFAULT NULL,
  `stature_15` varchar(6) DEFAULT NULL,
  `weight_15` varchar(6) DEFAULT NULL,
  `comment_15` varchar(25) DEFAULT NULL,
  `bmi_15` varchar(5) DEFAULT NULL,
  `date_16` date DEFAULT NULL,
  `age_16` varchar(5) DEFAULT NULL,
  `stature_16` varchar(6) DEFAULT NULL,
  `weight_16` varchar(6) DEFAULT NULL,
  `comment_16` varchar(25) DEFAULT NULL,
  `bmi_16` varchar(5) DEFAULT NULL,
  `date_17` date DEFAULT NULL,
  `age_17` varchar(5) DEFAULT NULL,
  `stature_17` varchar(6) DEFAULT NULL,
  `weight_17` varchar(6) DEFAULT NULL,
  `comment_17` varchar(25) DEFAULT NULL,
  `bmi_17` varchar(5) DEFAULT NULL,
  `date_18` date DEFAULT NULL,
  `age_18` varchar(5) DEFAULT NULL,
  `stature_18` varchar(6) DEFAULT NULL,
  `weight_18` varchar(6) DEFAULT NULL,
  `comment_18` varchar(25) DEFAULT NULL,
  `bmi_18` varchar(5) DEFAULT NULL,
  `date_19` date DEFAULT NULL,
  `age_19` varchar(5) DEFAULT NULL,
  `stature_19` varchar(6) DEFAULT NULL,
  `weight_19` varchar(6) DEFAULT NULL,
  `comment_19` varchar(25) DEFAULT NULL,
  `bmi_19` varchar(5) DEFAULT NULL,
  `date_20` date DEFAULT NULL,
  `age_20` varchar(5) DEFAULT NULL,
  `stature_20` varchar(6) DEFAULT NULL,
  `weight_20` varchar(6) DEFAULT NULL,
  `comment_20` varchar(25) DEFAULT NULL,
  `bmi_20` varchar(5) DEFAULT NULL,
  `date_21` date DEFAULT NULL,
  `age_21` varchar(5) DEFAULT NULL,
  `stature_21` varchar(6) DEFAULT NULL,
  `weight_21` varchar(6) DEFAULT NULL,
  `comment_21` varchar(25) DEFAULT NULL,
  `bmi_21` varchar(5) DEFAULT NULL,
  `date_22` date DEFAULT NULL,
  `age_22` varchar(5) DEFAULT NULL,
  `stature_22` varchar(6) DEFAULT NULL,
  `weight_22` varchar(6) DEFAULT NULL,
  `comment_22` varchar(25) DEFAULT NULL,
  `bmi_22` varchar(5) DEFAULT NULL,
  `date_23` date DEFAULT NULL,
  `age_23` varchar(5) DEFAULT NULL,
  `stature_23` varchar(6) DEFAULT NULL,
  `weight_23` varchar(6) DEFAULT NULL,
  `comment_23` varchar(25) DEFAULT NULL,
  `bmi_23` varchar(5) DEFAULT NULL,
  `date_24` date DEFAULT NULL,
  `age_24` varchar(5) DEFAULT NULL,
  `stature_24` varchar(6) DEFAULT NULL,
  `weight_24` varchar(6) DEFAULT NULL,
  `comment_24` varchar(25) DEFAULT NULL,
  `bmi_24` varchar(5) DEFAULT NULL,
  `date_25` date DEFAULT NULL,
  `age_25` varchar(5) DEFAULT NULL,
  `stature_25` varchar(6) DEFAULT NULL,
  `weight_25` varchar(6) DEFAULT NULL,
  `comment_25` varchar(25) DEFAULT NULL,
  `bmi_25` varchar(5) DEFAULT NULL,
  `date_26` date DEFAULT NULL,
  `age_26` varchar(5) DEFAULT NULL,
  `stature_26` varchar(6) DEFAULT NULL,
  `weight_26` varchar(6) DEFAULT NULL,
  `comment_26` varchar(25) DEFAULT NULL,
  `bmi_26` varchar(5) DEFAULT NULL,
  `date_27` date DEFAULT NULL,
  `age_27` varchar(5) DEFAULT NULL,
  `stature_27` varchar(6) DEFAULT NULL,
  `weight_27` varchar(6) DEFAULT NULL,
  `comment_27` varchar(25) DEFAULT NULL,
  `bmi_27` varchar(5) DEFAULT NULL,
  `date_28` date DEFAULT NULL,
  `age_28` varchar(5) DEFAULT NULL,
  `stature_28` varchar(6) DEFAULT NULL,
  `weight_28` varchar(6) DEFAULT NULL,
  `comment_28` varchar(25) DEFAULT NULL,
  `bmi_28` varchar(5) DEFAULT NULL,
  `date_29` date DEFAULT NULL,
  `age_29` varchar(5) DEFAULT NULL,
  `stature_29` varchar(6) DEFAULT NULL,
  `weight_29` varchar(6) DEFAULT NULL,
  `comment_29` varchar(25) DEFAULT NULL,
  `bmi_29` varchar(5) DEFAULT NULL,
  `date_30` date DEFAULT NULL,
  `age_30` varchar(5) DEFAULT NULL,
  `stature_30` varchar(6) DEFAULT NULL,
  `weight_30` varchar(6) DEFAULT NULL,
  `comment_30` varchar(25) DEFAULT NULL,
  `bmi_30` varchar(5) DEFAULT NULL,
  `date_31` date DEFAULT NULL,
  `age_31` varchar(5) DEFAULT NULL,
  `stature_31` varchar(6) DEFAULT NULL,
  `weight_31` varchar(6) DEFAULT NULL,
  `comment_31` varchar(25) DEFAULT NULL,
  `bmi_31` varchar(5) DEFAULT NULL,
  `date_32` date DEFAULT NULL,
  `age_32` varchar(5) DEFAULT NULL,
  `stature_32` varchar(6) DEFAULT NULL,
  `weight_32` varchar(6) DEFAULT NULL,
  `comment_32` varchar(25) DEFAULT NULL,
  `bmi_32` varchar(5) DEFAULT NULL,
  `date_33` date DEFAULT NULL,
  `age_33` varchar(5) DEFAULT NULL,
  `stature_33` varchar(6) DEFAULT NULL,
  `weight_33` varchar(6) DEFAULT NULL,
  `comment_33` varchar(25) DEFAULT NULL,
  `bmi_33` varchar(5) DEFAULT NULL,
  `date_34` date DEFAULT NULL,
  `age_34` varchar(5) DEFAULT NULL,
  `stature_34` varchar(6) DEFAULT NULL,
  `weight_34` varchar(6) DEFAULT NULL,
  `comment_34` varchar(25) DEFAULT NULL,
  `bmi_34` varchar(5) DEFAULT NULL,
  `date_35` date DEFAULT NULL,
  `age_35` varchar(5) DEFAULT NULL,
  `stature_35` varchar(6) DEFAULT NULL,
  `weight_35` varchar(6) DEFAULT NULL,
  `comment_35` varchar(25) DEFAULT NULL,
  `bmi_35` varchar(5) DEFAULT NULL,
  `date_36` date DEFAULT NULL,
  `age_36` varchar(5) DEFAULT NULL,
  `stature_36` varchar(6) DEFAULT NULL,
  `weight_36` varchar(6) DEFAULT NULL,
  `comment_36` varchar(25) DEFAULT NULL,
  `bmi_36` varchar(5) DEFAULT NULL,
  `date_37` date DEFAULT NULL,
  `age_37` varchar(5) DEFAULT NULL,
  `stature_37` varchar(6) DEFAULT NULL,
  `weight_37` varchar(6) DEFAULT NULL,
  `comment_37` varchar(25) DEFAULT NULL,
  `bmi_37` varchar(5) DEFAULT NULL,
  `date_38` date DEFAULT NULL,
  `age_38` varchar(5) DEFAULT NULL,
  `stature_38` varchar(6) DEFAULT NULL,
  `weight_38` varchar(6) DEFAULT NULL,
  `comment_38` varchar(25) DEFAULT NULL,
  `bmi_38` varchar(5) DEFAULT NULL,
  `date_39` date DEFAULT NULL,
  `age_39` varchar(5) DEFAULT NULL,
  `stature_39` varchar(6) DEFAULT NULL,
  `weight_39` varchar(6) DEFAULT NULL,
  `comment_39` varchar(25) DEFAULT NULL,
  `bmi_39` varchar(5) DEFAULT NULL,
  `date_40` date DEFAULT NULL,
  `age_40` varchar(5) DEFAULT NULL,
  `stature_40` varchar(6) DEFAULT NULL,
  `weight_40` varchar(6) DEFAULT NULL,
  `comment_40` varchar(25) DEFAULT NULL,
  `bmi_40` varchar(5) DEFAULT NULL,
  `date_41` date DEFAULT NULL,
  `age_41` varchar(5) DEFAULT NULL,
  `stature_41` varchar(6) DEFAULT NULL,
  `weight_41` varchar(6) DEFAULT NULL,
  `comment_41` varchar(25) DEFAULT NULL,
  `bmi_41` varchar(5) DEFAULT NULL,
  `date_42` date DEFAULT NULL,
  `age_42` varchar(5) DEFAULT NULL,
  `stature_42` varchar(6) DEFAULT NULL,
  `weight_42` varchar(6) DEFAULT NULL,
  `comment_42` varchar(25) DEFAULT NULL,
  `bmi_42` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formHomeFalls`
--

DROP TABLE IF EXISTS `formHomeFalls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formHomeFalls` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `floor1Y` tinyint(1) DEFAULT NULL,
  `floor1N` tinyint(1) DEFAULT NULL,
  `floor2Y` tinyint(1) DEFAULT NULL,
  `floor2N` tinyint(1) DEFAULT NULL,
  `floor3Y` tinyint(1) DEFAULT NULL,
  `floor3N` tinyint(1) DEFAULT NULL,
  `floor4Y` tinyint(1) DEFAULT NULL,
  `floor4N` tinyint(1) DEFAULT NULL,
  `floor4NA` tinyint(1) DEFAULT NULL,
  `furniture5Y` tinyint(1) DEFAULT NULL,
  `furniture5N` tinyint(1) DEFAULT NULL,
  `furniture5NA` tinyint(1) DEFAULT NULL,
  `furniture6Y` tinyint(1) DEFAULT NULL,
  `furniture6N` tinyint(1) DEFAULT NULL,
  `furniture6NA` tinyint(1) DEFAULT NULL,
  `lighting7Y` tinyint(1) DEFAULT NULL,
  `lighting7N` tinyint(1) DEFAULT NULL,
  `lighting8Y` tinyint(1) DEFAULT NULL,
  `lighting8N` tinyint(1) DEFAULT NULL,
  `lighting9Y` tinyint(1) DEFAULT NULL,
  `lighting9N` tinyint(1) DEFAULT NULL,
  `lighting9NA` tinyint(1) DEFAULT NULL,
  `bathroom10Y` tinyint(1) DEFAULT NULL,
  `bathroom10N` tinyint(1) DEFAULT NULL,
  `bathroom10NA` tinyint(1) DEFAULT NULL,
  `bathroom11Y` tinyint(1) DEFAULT NULL,
  `bathroom11N` tinyint(1) DEFAULT NULL,
  `bathroom11NA` tinyint(1) DEFAULT NULL,
  `bathroom12Y` tinyint(1) DEFAULT NULL,
  `bathroom12N` tinyint(1) DEFAULT NULL,
  `bathroom12NA` tinyint(1) DEFAULT NULL,
  `bathroom13Y` tinyint(1) DEFAULT NULL,
  `bathroom13N` tinyint(1) DEFAULT NULL,
  `bathroom14Y` tinyint(1) DEFAULT NULL,
  `bathroom14N` tinyint(1) DEFAULT NULL,
  `bathroom15Y` tinyint(1) DEFAULT NULL,
  `bathroom15N` tinyint(1) DEFAULT NULL,
  `storage16Y` tinyint(1) DEFAULT NULL,
  `storage16N` tinyint(1) DEFAULT NULL,
  `storage17Y` tinyint(1) DEFAULT NULL,
  `storage17N` tinyint(1) DEFAULT NULL,
  `stairway18Y` tinyint(1) DEFAULT NULL,
  `stairway18N` tinyint(1) DEFAULT NULL,
  `stairway18NA` tinyint(1) DEFAULT NULL,
  `stairway19Y` tinyint(1) DEFAULT NULL,
  `stairway19N` tinyint(1) DEFAULT NULL,
  `stairway19NA` tinyint(1) DEFAULT NULL,
  `stairway20Y` tinyint(1) DEFAULT NULL,
  `stairway20N` tinyint(1) DEFAULT NULL,
  `stairway20NA` tinyint(1) DEFAULT NULL,
  `stairway21Y` tinyint(1) DEFAULT NULL,
  `stairway21N` tinyint(1) DEFAULT NULL,
  `stairway21NA` tinyint(1) DEFAULT NULL,
  `stairway22Y` tinyint(1) DEFAULT NULL,
  `stairway22N` tinyint(1) DEFAULT NULL,
  `mobility23Y` tinyint(1) DEFAULT NULL,
  `mobility23N` tinyint(1) DEFAULT NULL,
  `mobility23NA` tinyint(1) DEFAULT NULL,
  `mobility24Y` tinyint(1) DEFAULT NULL,
  `mobility24N` tinyint(1) DEFAULT NULL,
  `mobility25Y` tinyint(1) DEFAULT NULL,
  `mobility25N` tinyint(1) DEFAULT NULL,
  `mobility25NA` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formImmunAllergy`
--

DROP TABLE IF EXISTS `formImmunAllergy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formImmunAllergy` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_surname` varchar(30) DEFAULT NULL,
  `c_givenName` varchar(30) DEFAULT NULL,
  `dateAdmin` date DEFAULT NULL,
  `tradeName` varchar(50) DEFAULT NULL,
  `manufacturer` varchar(50) DEFAULT NULL,
  `lot` varchar(50) DEFAULT NULL,
  `expiDate` date DEFAULT NULL,
  `doseAdminSC` tinyint(1) DEFAULT NULL,
  `doseAdminIM` tinyint(1) DEFAULT NULL,
  `doseAdminml` tinyint(1) DEFAULT NULL,
  `doseAdminTxtml` varchar(10) DEFAULT NULL,
  `locLtDel` tinyint(1) DEFAULT NULL,
  `locRtDel` tinyint(1) DEFAULT NULL,
  `locLtDelOUQ` tinyint(1) DEFAULT NULL,
  `locRtDelOUQ` tinyint(1) DEFAULT NULL,
  `locOther` tinyint(1) DEFAULT NULL,
  `InstrStay20` tinyint(1) DEFAULT NULL,
  `InstrExpectLoc` tinyint(1) DEFAULT NULL,
  `InstrFU` tinyint(1) DEFAULT NULL,
  `disChNoComp` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formIntakeInfo`
--

DROP TABLE IF EXISTS `formIntakeInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formIntakeInfo` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `sex` varchar(1) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `contact` varchar(20) DEFAULT NULL,
  `ethnoCulturalGr` varchar(255) DEFAULT NULL,
  `accommodationHouse` tinyint(1) DEFAULT NULL,
  `accommodationApt` tinyint(1) DEFAULT NULL,
  `accommodationSen` tinyint(1) DEFAULT NULL,
  `accommodationNur` tinyint(1) DEFAULT NULL,
  `accommodationLTC` tinyint(1) DEFAULT NULL,
  `maritalStMarried` tinyint(1) DEFAULT NULL,
  `maritalStLivingTogether` tinyint(1) DEFAULT NULL,
  `maritalStSeparated` tinyint(1) DEFAULT NULL,
  `maritalStDivorced` tinyint(1) DEFAULT NULL,
  `maritalStWidowed` tinyint(1) DEFAULT NULL,
  `maritalStRemarried` tinyint(1) DEFAULT NULL,
  `maritalStNeverMarried` tinyint(1) DEFAULT NULL,
  `nbpplInHousehold` int(3) DEFAULT NULL,
  `helpY` tinyint(1) DEFAULT NULL,
  `helpN` tinyint(1) DEFAULT NULL,
  `helpNoNeed` tinyint(1) DEFAULT NULL,
  `helpRelationshipSpouse` tinyint(1) DEFAULT NULL,
  `helpRelationshipSibling` tinyint(1) DEFAULT NULL,
  `helpRelationshipFriend` tinyint(1) DEFAULT NULL,
  `helpRelationshipChildren` tinyint(1) DEFAULT NULL,
  `helpRelationshipGChildren` tinyint(1) DEFAULT NULL,
  `otherSupportFriends` tinyint(1) DEFAULT NULL,
  `otherSupportSiblings` tinyint(1) DEFAULT NULL,
  `otherSupportNeighbour` tinyint(1) DEFAULT NULL,
  `otherSupportChildren` tinyint(1) DEFAULT NULL,
  `otherSupportGChildren` tinyint(1) DEFAULT NULL,
  `eduNoSchool` tinyint(1) DEFAULT NULL,
  `eduSomeCommunity` tinyint(1) DEFAULT NULL,
  `eduSomeElementary` tinyint(1) DEFAULT NULL,
  `eduCompletedCommunity` tinyint(1) DEFAULT NULL,
  `eduCompletedElementary` tinyint(1) DEFAULT NULL,
  `eduSomeUni` tinyint(1) DEFAULT NULL,
  `eduSomeSec` tinyint(1) DEFAULT NULL,
  `eduCompletedUni` tinyint(1) DEFAULT NULL,
  `eduCompletedSec` tinyint(1) DEFAULT NULL,
  `incomeBelow10` tinyint(1) DEFAULT NULL,
  `income40To50` tinyint(1) DEFAULT NULL,
  `income10To20` tinyint(1) DEFAULT NULL,
  `incomeOver50` tinyint(1) DEFAULT NULL,
  `income20To30` tinyint(1) DEFAULT NULL,
  `incomeDoNotKnow` tinyint(1) DEFAULT NULL,
  `income30To40` tinyint(1) DEFAULT NULL,
  `incomeRefusedToAns` tinyint(1) DEFAULT NULL,
  `financialDifficult` tinyint(1) DEFAULT NULL,
  `financialEnough` tinyint(1) DEFAULT NULL,
  `financialComfortable` tinyint(1) DEFAULT NULL,
  `ActPaidWk` int(4) DEFAULT NULL,
  `ActUnpaidWk` int(4) DEFAULT NULL,
  `ActVolunteering` int(4) DEFAULT NULL,
  `ActCaregiving` int(4) DEFAULT NULL,
  `anyHealthPb` varchar(255) DEFAULT NULL,
  `smkY` tinyint(1) DEFAULT NULL,
  `smkN` tinyint(1) DEFAULT NULL,
  `nbCigarettes` int(5) DEFAULT NULL,
  `howLongSmk` varchar(20) DEFAULT NULL,
  `didSmkY` tinyint(1) DEFAULT NULL,
  `didSmkN` tinyint(1) DEFAULT NULL,
  `didNbCigarettes` int(5) DEFAULT NULL,
  `didHowLongSmk` varchar(20) DEFAULT NULL,
  `alcoholY` tinyint(1) DEFAULT NULL,
  `alcoholN` tinyint(1) DEFAULT NULL,
  `more12DrinksY` tinyint(1) DEFAULT NULL,
  `more12DrinksN` tinyint(1) DEFAULT NULL,
  `heartAttackY` tinyint(1) DEFAULT NULL,
  `heartAttackRefused` tinyint(1) DEFAULT NULL,
  `heartAttackN` tinyint(1) DEFAULT NULL,
  `heartAttackDoNotKnow` tinyint(1) DEFAULT NULL,
  `anginaY` tinyint(1) DEFAULT NULL,
  `anginaRefused` tinyint(1) DEFAULT NULL,
  `anginaN` tinyint(1) DEFAULT NULL,
  `anginaDoNotKnow` tinyint(1) DEFAULT NULL,
  `heartFailureY` tinyint(1) DEFAULT NULL,
  `heartFailureRefused` tinyint(1) DEFAULT NULL,
  `heartFailureN` tinyint(1) DEFAULT NULL,
  `heartFailureDoNotKnow` tinyint(1) DEFAULT NULL,
  `highBPY` tinyint(1) DEFAULT NULL,
  `highBPRefused` tinyint(1) DEFAULT NULL,
  `highBPN` tinyint(1) DEFAULT NULL,
  `highBPDoNotKnow` tinyint(1) DEFAULT NULL,
  `otherHeartDiseaseY` tinyint(1) DEFAULT NULL,
  `otherHeartDiseaseRefused` tinyint(1) DEFAULT NULL,
  `otherHeartDiseaseN` tinyint(1) DEFAULT NULL,
  `otherHeartDiseaseDoNotKnow` tinyint(1) DEFAULT NULL,
  `diabetesY` tinyint(1) DEFAULT NULL,
  `diabetesRefused` tinyint(1) DEFAULT NULL,
  `diabetesN` tinyint(1) DEFAULT NULL,
  `diabetesDoNotKnow` tinyint(1) DEFAULT NULL,
  `arthritisY` tinyint(1) DEFAULT NULL,
  `arthritisRefused` tinyint(1) DEFAULT NULL,
  `arthritisN` tinyint(1) DEFAULT NULL,
  `arthritisDoNotKnow` tinyint(1) DEFAULT NULL,
  `strokeY` tinyint(1) DEFAULT NULL,
  `strokeRefused` tinyint(1) DEFAULT NULL,
  `strokeN` tinyint(1) DEFAULT NULL,
  `strokeDoNotKnow` tinyint(1) DEFAULT NULL,
  `cancerY` tinyint(1) DEFAULT NULL,
  `cancerRefused` tinyint(1) DEFAULT NULL,
  `cancerN` tinyint(1) DEFAULT NULL,
  `cancerDoNotKnow` tinyint(1) DEFAULT NULL,
  `brokenHipY` tinyint(1) DEFAULT NULL,
  `brokenHipRefused` tinyint(1) DEFAULT NULL,
  `brokenHipN` tinyint(1) DEFAULT NULL,
  `brokenHipDoNotKnow` tinyint(1) DEFAULT NULL,
  `parkinsonY` tinyint(1) DEFAULT NULL,
  `parkinsonRefused` tinyint(1) DEFAULT NULL,
  `parkinsonN` tinyint(1) DEFAULT NULL,
  `parkinsonDoNotKnow` tinyint(1) DEFAULT NULL,
  `lungDiseaseY` tinyint(1) DEFAULT NULL,
  `lungDiseaseRefused` tinyint(1) DEFAULT NULL,
  `lungDiseaseN` tinyint(1) DEFAULT NULL,
  `lungDiseaseDoNotKnow` tinyint(1) DEFAULT NULL,
  `hearingPbY` tinyint(1) DEFAULT NULL,
  `hearingPbRefused` tinyint(1) DEFAULT NULL,
  `hearingPbN` tinyint(1) DEFAULT NULL,
  `hearingPbDoNotKnow` tinyint(1) DEFAULT NULL,
  `visionPbY` tinyint(1) DEFAULT NULL,
  `visionPbRefused` tinyint(1) DEFAULT NULL,
  `visionPbN` tinyint(1) DEFAULT NULL,
  `visionPbDoNotKnow` tinyint(1) DEFAULT NULL,
  `osteoporosisY` tinyint(1) DEFAULT NULL,
  `osteoporosisRefused` tinyint(1) DEFAULT NULL,
  `osteoporosisN` tinyint(1) DEFAULT NULL,
  `osteoporosisDoNotKnow` tinyint(1) DEFAULT NULL,
  `fibromyalgiaY` tinyint(1) DEFAULT NULL,
  `fibromyalgiaRefused` tinyint(1) DEFAULT NULL,
  `fibromyalgiaN` tinyint(1) DEFAULT NULL,
  `fibromyalgiaDoNotKnow` tinyint(1) DEFAULT NULL,
  `multiplesclerosisY` tinyint(1) DEFAULT NULL,
  `multiplesclerosisRefused` tinyint(1) DEFAULT NULL,
  `multiplesclerosisN` tinyint(1) DEFAULT NULL,
  `multiplesclerosisDoNotKnow` tinyint(1) DEFAULT NULL,
  `asthmaY` tinyint(1) DEFAULT NULL,
  `asthmaRefused` tinyint(1) DEFAULT NULL,
  `asthmaN` tinyint(1) DEFAULT NULL,
  `asthmaDoNotKnow` tinyint(1) DEFAULT NULL,
  `backpainY` tinyint(1) DEFAULT NULL,
  `backpainRefused` tinyint(1) DEFAULT NULL,
  `backpainN` tinyint(1) DEFAULT NULL,
  `backpainDoNotKnow` tinyint(1) DEFAULT NULL,
  `weightY` tinyint(1) DEFAULT NULL,
  `weightRefused` tinyint(1) DEFAULT NULL,
  `weightN` tinyint(1) DEFAULT NULL,
  `weightDoNotKnow` tinyint(1) DEFAULT NULL,
  `weight` varchar(10) DEFAULT NULL,
  `height` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formInternetAccess`
--

DROP TABLE IF EXISTS `formInternetAccess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formInternetAccess` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `computerY` tinyint(1) DEFAULT NULL,
  `computerN` tinyint(1) DEFAULT NULL,
  `internetY` tinyint(1) DEFAULT NULL,
  `internetN` tinyint(1) DEFAULT NULL,
  `internetHome` tinyint(1) DEFAULT NULL,
  `internetWork` tinyint(1) DEFAULT NULL,
  `internetOther` tinyint(1) DEFAULT NULL,
  `internetOtherTx` varchar(255) DEFAULT NULL,
  `timeDaily` varchar(2) DEFAULT NULL,
  `timeWeekly` varchar(3) DEFAULT NULL,
  `infoY` tinyint(1) DEFAULT NULL,
  `infoN` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formLabReq`
--

DROP TABLE IF EXISTS `formLabReq`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formLabReq` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `provName` varchar(60) DEFAULT NULL,
  `reqProvName` varchar(60) DEFAULT '',
  `clinicAddress` varchar(30) DEFAULT NULL,
  `clinicCity` varchar(20) DEFAULT NULL,
  `clinicPC` varchar(7) DEFAULT NULL,
  `practitionerNo` varchar(14) DEFAULT NULL,
  `ohip` tinyint(1) DEFAULT NULL,
  `thirdParty` tinyint(1) DEFAULT NULL,
  `wcb` tinyint(1) DEFAULT NULL,
  `aci` text,
  `healthNumber` varchar(10) DEFAULT NULL,
  `version` char(2) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `paymentProgram` varchar(4) DEFAULT NULL,
  `province` varchar(15) DEFAULT NULL,
  `orn` varchar(12) DEFAULT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `patientName` varchar(40) DEFAULT NULL,
  `sex` varchar(6) DEFAULT NULL,
  `patientAddress` varchar(20) DEFAULT NULL,
  `patientCity` varchar(20) DEFAULT NULL,
  `patientPC` varchar(7) DEFAULT NULL,
  `b_glucose` tinyint(1) DEFAULT NULL,
  `b_creatine` tinyint(1) DEFAULT NULL,
  `b_uricAcid` tinyint(1) DEFAULT NULL,
  `b_sodium` tinyint(1) DEFAULT NULL,
  `b_potassium` tinyint(1) DEFAULT NULL,
  `b_chloride` tinyint(1) DEFAULT NULL,
  `b_ast` tinyint(1) DEFAULT NULL,
  `b_alkPhosphate` tinyint(1) DEFAULT NULL,
  `b_bilirubin` tinyint(1) DEFAULT NULL,
  `b_cholesterol` tinyint(1) DEFAULT NULL,
  `b_triglyceride` tinyint(1) DEFAULT NULL,
  `b_urinalysis` tinyint(1) DEFAULT NULL,
  `v_acuteHepatitis` tinyint(1) DEFAULT NULL,
  `v_chronicHepatitis` tinyint(1) DEFAULT NULL,
  `v_immune` tinyint(1) DEFAULT NULL,
  `v_hepA` varchar(20) DEFAULT NULL,
  `v_hepB` varchar(20) DEFAULT NULL,
  `h_bloodFilmExam` tinyint(1) DEFAULT NULL,
  `h_hemoglobin` tinyint(1) DEFAULT NULL,
  `h_wcbCount` tinyint(1) DEFAULT NULL,
  `h_hematocrit` tinyint(1) DEFAULT NULL,
  `h_prothrombTime` tinyint(1) DEFAULT NULL,
  `h_otherC` tinyint(1) DEFAULT NULL,
  `h_other` varchar(20) DEFAULT NULL,
  `i_pregnancyTest` tinyint(1) DEFAULT NULL,
  `i_heterophile` tinyint(1) DEFAULT NULL,
  `i_rubella` tinyint(1) DEFAULT NULL,
  `i_prenatal` tinyint(1) DEFAULT NULL,
  `i_repeatPrenatal` tinyint(1) DEFAULT NULL,
  `i_prenatalHepatitisB` tinyint(1) DEFAULT NULL,
  `i_vdrl` tinyint(1) DEFAULT NULL,
  `i_otherC` tinyint(1) DEFAULT NULL,
  `i_other` varchar(20) DEFAULT NULL,
  `m_cervicalVaginal` tinyint(1) DEFAULT NULL,
  `m_sputum` tinyint(1) DEFAULT NULL,
  `m_throat` tinyint(1) DEFAULT NULL,
  `m_urine` tinyint(1) DEFAULT NULL,
  `m_stoolCulture` tinyint(1) DEFAULT NULL,
  `m_otherSwabs` tinyint(1) DEFAULT NULL,
  `m_other` varchar(20) DEFAULT NULL,
  `otherTest` text,
  `formDate` date DEFAULT NULL,
  `signature` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formLabReq07`
--

DROP TABLE IF EXISTS `formLabReq07`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formLabReq07` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `b_glucose` tinyint(1) DEFAULT NULL,
  `b_glucose_random` tinyint(1) DEFAULT NULL,
  `b_glucose_fasting` tinyint(1) DEFAULT NULL,
  `b_hba1c` tinyint(1) DEFAULT NULL,
  `b_creatinine` tinyint(1) DEFAULT NULL,
  `b_uricAcid` tinyint(1) DEFAULT NULL,
  `b_sodium` tinyint(1) DEFAULT NULL,
  `b_potassium` tinyint(1) DEFAULT NULL,
  `b_chloride` tinyint(1) DEFAULT NULL,
  `b_ck` tinyint(1) DEFAULT NULL,
  `b_alt` tinyint(1) DEFAULT NULL,
  `b_alkPhosphatase` tinyint(1) DEFAULT NULL,
  `ohip` tinyint(1) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `patientFirstName` varchar(40) DEFAULT NULL,
  `b_timeNextDose2` varchar(20) DEFAULT NULL,
  `clinicCity` varchar(40) DEFAULT NULL,
  `b_timeNextDose1` varchar(20) DEFAULT NULL,
  `b_timeLastDose2` varchar(20) DEFAULT NULL,
  `b_timeLastDose1` varchar(20) DEFAULT NULL,
  `provider_no` int(11) DEFAULT NULL,
  `m_vaginalRectal` tinyint(1) DEFAULT NULL,
  `m_vaginal` tinyint(1) DEFAULT NULL,
  `b_acRatioUrine` tinyint(1) DEFAULT NULL,
  `healthNumber` varchar(20) DEFAULT NULL,
  `patientCity` varchar(40) DEFAULT NULL,
  `b_patientsTelNo` varchar(40) DEFAULT NULL,
  `clinicianContactUrgent` varchar(40) DEFAULT NULL,
  `b_childsAgeDays` varchar(20) DEFAULT NULL,
  `b_tsh` tinyint(1) DEFAULT NULL,
  `b_timeCollected2` varchar(20) DEFAULT NULL,
  `b_timeCollected1` varchar(20) DEFAULT NULL,
  `b_therapeuticDrugMonitoring` tinyint(1) DEFAULT NULL,
  `i_rubella` tinyint(1) DEFAULT NULL,
  `m_cervical` tinyint(1) DEFAULT NULL,
  `patientAddress` varchar(60) DEFAULT NULL,
  `b_vitaminB12` tinyint(1) DEFAULT NULL,
  `m_blank` tinyint(1) DEFAULT NULL,
  `reqProvName` varchar(60) DEFAULT NULL,
  `v_chronicHepatitis` tinyint(1) DEFAULT NULL,
  `version` varchar(6) DEFAULT NULL,
  `oprn` varchar(40) DEFAULT NULL,
  `b_albumin` tinyint(1) DEFAULT NULL,
  `aci` text,
  `patientPC` varchar(10) DEFAULT NULL,
  `b_urinalysis` tinyint(1) DEFAULT NULL,
  `h_cbc` tinyint(1) DEFAULT NULL,
  `form_class` tinyint(1) DEFAULT NULL,
  `sex` varchar(8) DEFAULT NULL,
  `i_pregnancyTest` tinyint(1) DEFAULT NULL,
  `submit` tinyint(1) DEFAULT NULL,
  `v_acuteHepatitis` tinyint(1) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `patientBirthMth` varchar(25) DEFAULT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `m_otherSwabsSource` varchar(60) DEFAULT NULL,
  `m_otherSwabsPus` tinyint(1) DEFAULT NULL,
  `clinicAddress` varchar(100) DEFAULT NULL,
  `m_gcSource` varchar(60) DEFAULT NULL,
  `b_childsAgeHours` varchar(20) DEFAULT NULL,
  `m_throat` tinyint(1) DEFAULT NULL,
  `patientLastName` varchar(40) DEFAULT NULL,
  `m_sputum` tinyint(1) DEFAULT NULL,
  `b_neonatalBilirubin` tinyint(1) DEFAULT NULL,
  `m_fecalOccultBlood` tinyint(1) DEFAULT NULL,
  `m_urine` tinyint(1) DEFAULT NULL,
  `m_blankText` varchar(100) DEFAULT NULL,
  `b_nameDrug2` varchar(100) DEFAULT NULL,
  `m_stoolOvaParasites` tinyint(1) DEFAULT NULL,
  `b_nameDrug1` varchar(100) DEFAULT NULL,
  `m_gc` tinyint(1) DEFAULT NULL,
  `i_prenatal` tinyint(1) DEFAULT NULL,
  `h_prothrombinTime` tinyint(1) DEFAULT NULL,
  `patientBirthYear` varchar(10) DEFAULT NULL,
  `m_chlamydiaSource` varchar(60) DEFAULT NULL,
  `i_repeatPrenatalAntibodies` tinyint(1) DEFAULT NULL,
  `b_ferritin` tinyint(1) DEFAULT NULL,
  `wcb` tinyint(1) DEFAULT NULL,
  `v_immuneStatus` tinyint(1) DEFAULT NULL,
  `m_stoolCulture` tinyint(1) DEFAULT NULL,
  `province` varchar(20) DEFAULT NULL,
  `m_woundSource` varchar(60) DEFAULT NULL,
  `patientBirthDay` varchar(30) DEFAULT NULL,
  `demographic_no` int(11) DEFAULT NULL,
  `i_mononucleosisScreen` tinyint(1) DEFAULT NULL,
  `b_lipidAssessment` tinyint(1) DEFAULT NULL,
  `m_wound` tinyint(1) DEFAULT NULL,
  `provName` varchar(60) DEFAULT NULL,
  `thirdParty` tinyint(1) DEFAULT NULL,
  `clinicName` varchar(60) DEFAULT NULL,
  `b_bilirubin` tinyint(1) DEFAULT NULL,
  `m_specimenCollectionTime` varchar(15) DEFAULT NULL,
  `o_otherTests16` varchar(150) DEFAULT NULL,
  `o_otherTests15` varchar(150) DEFAULT NULL,
  `o_otherTests14` varchar(150) DEFAULT NULL,
  `o_otherTests13` varchar(150) DEFAULT NULL,
  `o_otherTests12` varchar(150) DEFAULT NULL,
  `o_otherTests11` varchar(150) DEFAULT NULL,
  `o_otherTests10` varchar(150) DEFAULT NULL,
  `o_otherTests9` varchar(150) DEFAULT NULL,
  `o_otherTests8` varchar(150) DEFAULT NULL,
  `o_otherTests7` varchar(150) DEFAULT NULL,
  `o_otherTests6` varchar(150) DEFAULT NULL,
  `o_specimenCollectionDate` date DEFAULT NULL,
  `o_otherTests5` varchar(150) DEFAULT NULL,
  `clinicPC` varchar(10) DEFAULT NULL,
  `o_otherTests4` varchar(150) DEFAULT NULL,
  `o_otherTests3` varchar(150) DEFAULT NULL,
  `o_otherTests2` varchar(150) DEFAULT NULL,
  `b_cliniciansTelNo` varchar(40) DEFAULT NULL,
  `o_otherTests1` varchar(150) DEFAULT NULL,
  `patientName` varchar(40) DEFAULT NULL,
  `b_dateSigned` date DEFAULT NULL,
  `practitionerNo` varchar(20) DEFAULT NULL,
  `m_chlamydia` tinyint(1) DEFAULT NULL,
  `v_immune_HepatitisC` tinyint(1) DEFAULT NULL,
  `v_immune_HepatitisB` tinyint(1) DEFAULT NULL,
  `v_immune_HepatitisA` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formLabReq10`
--

DROP TABLE IF EXISTS `formLabReq10`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formLabReq10` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `b_glucose` tinyint(1) DEFAULT NULL,
  `b_glucose_random` tinyint(1) DEFAULT NULL,
  `b_glucose_fasting` tinyint(1) DEFAULT NULL,
  `b_hba1c` tinyint(1) DEFAULT NULL,
  `b_creatinine` tinyint(1) DEFAULT NULL,
  `b_uricAcid` tinyint(1) DEFAULT NULL,
  `b_sodium` tinyint(1) DEFAULT NULL,
  `b_potassium` tinyint(1) DEFAULT NULL,
  `b_chloride` tinyint(1) DEFAULT NULL,
  `b_ck` tinyint(1) DEFAULT NULL,
  `b_alt` tinyint(1) DEFAULT NULL,
  `b_alkPhosphatase` tinyint(1) DEFAULT NULL,
  `ohip` tinyint(1) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `patientFirstName` varchar(40) DEFAULT NULL,
  `b_timeNextDose2` varchar(20) DEFAULT NULL,
  `clinicCity` varchar(40) DEFAULT NULL,
  `b_timeNextDose1` varchar(20) DEFAULT NULL,
  `b_timeLastDose2` varchar(20) DEFAULT NULL,
  `b_timeLastDose1` varchar(20) DEFAULT NULL,
  `provider_no` int(11) DEFAULT NULL,
  `m_vaginalRectal` tinyint(1) DEFAULT NULL,
  `m_vaginal` tinyint(1) DEFAULT NULL,
  `b_acRatioUrine` tinyint(1) DEFAULT NULL,
  `healthNumber` varchar(20) DEFAULT NULL,
  `patientCity` varchar(40) DEFAULT NULL,
  `b_patientsTelNo` varchar(40) DEFAULT NULL,
  `clinicianContactUrgent` varchar(40) DEFAULT NULL,
  `b_childsAgeDays` varchar(20) DEFAULT NULL,
  `b_tsh` tinyint(1) DEFAULT NULL,
  `b_timeCollected2` varchar(20) DEFAULT NULL,
  `b_timeCollected1` varchar(20) DEFAULT NULL,
  `b_therapeuticDrugMonitoring` tinyint(1) DEFAULT NULL,
  `i_rubella` tinyint(1) DEFAULT NULL,
  `m_cervical` tinyint(1) DEFAULT NULL,
  `patientAddress` varchar(60) DEFAULT NULL,
  `b_vitaminB12` tinyint(1) DEFAULT NULL,
  `m_blank` tinyint(1) DEFAULT NULL,
  `reqProvName` varchar(60) DEFAULT NULL,
  `v_chronicHepatitis` tinyint(1) DEFAULT NULL,
  `version` varchar(6) DEFAULT NULL,
  `oprn` varchar(40) DEFAULT NULL,
  `b_albumin` tinyint(1) DEFAULT NULL,
  `aci` text,
  `patientPC` varchar(10) DEFAULT NULL,
  `b_urinalysis` tinyint(1) DEFAULT NULL,
  `h_cbc` tinyint(1) DEFAULT NULL,
  `form_class` tinyint(1) DEFAULT NULL,
  `sex` varchar(8) DEFAULT NULL,
  `i_pregnancyTest` tinyint(1) DEFAULT NULL,
  `submit` tinyint(1) DEFAULT NULL,
  `v_acuteHepatitis` tinyint(1) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `patientBirthMth` varchar(25) DEFAULT NULL,
  `phoneNumber` varchar(20) DEFAULT NULL,
  `m_otherSwabsSource` varchar(60) DEFAULT NULL,
  `m_otherSwabsPus` tinyint(1) DEFAULT NULL,
  `clinicAddress` varchar(100) DEFAULT NULL,
  `m_gcSource` varchar(60) DEFAULT NULL,
  `b_childsAgeHours` varchar(20) DEFAULT NULL,
  `m_throat` tinyint(1) DEFAULT NULL,
  `patientLastName` varchar(40) DEFAULT NULL,
  `m_sputum` tinyint(1) DEFAULT NULL,
  `b_neonatalBilirubin` tinyint(1) DEFAULT NULL,
  `m_fecalOccultBlood` tinyint(1) DEFAULT NULL,
  `m_urine` tinyint(1) DEFAULT NULL,
  `m_blankText` varchar(100) DEFAULT NULL,
  `b_nameDrug2` varchar(100) DEFAULT NULL,
  `m_stoolOvaParasites` tinyint(1) DEFAULT NULL,
  `b_nameDrug1` varchar(100) DEFAULT NULL,
  `m_gc` tinyint(1) DEFAULT NULL,
  `i_prenatal` tinyint(1) DEFAULT NULL,
  `h_prothrombinTime` tinyint(1) DEFAULT NULL,
  `patientBirthYear` varchar(10) DEFAULT NULL,
  `m_chlamydiaSource` varchar(60) DEFAULT NULL,
  `i_repeatPrenatalAntibodies` tinyint(1) DEFAULT NULL,
  `b_ferritin` tinyint(1) DEFAULT NULL,
  `wcb` tinyint(1) DEFAULT NULL,
  `v_immuneStatus` tinyint(1) DEFAULT NULL,
  `m_stoolCulture` tinyint(1) DEFAULT NULL,
  `province` varchar(20) DEFAULT NULL,
  `m_woundSource` varchar(60) DEFAULT NULL,
  `patientBirthDay` varchar(30) DEFAULT NULL,
  `demographic_no` int(11) DEFAULT NULL,
  `i_mononucleosisScreen` tinyint(1) DEFAULT NULL,
  `b_lipidAssessment` tinyint(1) DEFAULT NULL,
  `m_wound` tinyint(1) DEFAULT NULL,
  `provName` varchar(60) DEFAULT NULL,
  `thirdParty` tinyint(1) DEFAULT NULL,
  `clinicName` varchar(60) DEFAULT NULL,
  `b_bilirubin` tinyint(1) DEFAULT NULL,
  `m_specimenCollectionTime` varchar(15) DEFAULT NULL,
  `o_otherTests16` varchar(150) DEFAULT NULL,
  `o_otherTests15` varchar(150) DEFAULT NULL,
  `o_otherTests14` varchar(150) DEFAULT NULL,
  `o_otherTests13` varchar(150) DEFAULT NULL,
  `o_otherTests12` varchar(150) DEFAULT NULL,
  `o_otherTests11` varchar(150) DEFAULT NULL,
  `o_otherTests10` varchar(150) DEFAULT NULL,
  `o_otherTests9` varchar(150) DEFAULT NULL,
  `o_otherTests8` varchar(150) DEFAULT NULL,
  `o_otherTests7` varchar(150) DEFAULT NULL,
  `o_otherTests6` varchar(150) DEFAULT NULL,
  `o_specimenCollectionDate` date DEFAULT NULL,
  `o_otherTests5` varchar(150) DEFAULT NULL,
  `clinicPC` varchar(10) DEFAULT NULL,
  `o_otherTests4` varchar(150) DEFAULT NULL,
  `o_otherTests3` varchar(150) DEFAULT NULL,
  `o_otherTests2` varchar(150) DEFAULT NULL,
  `b_cliniciansTelNo` varchar(40) DEFAULT NULL,
  `o_otherTests1` varchar(150) DEFAULT NULL,
  `patientName` varchar(40) DEFAULT NULL,
  `b_dateSigned` date DEFAULT NULL,
  `practitionerNo` varchar(20) DEFAULT NULL,
  `m_chlamydia` tinyint(1) DEFAULT NULL,
  `v_immune_HepatitisC` tinyint(1) DEFAULT NULL,
  `v_immune_HepatitisB` tinyint(1) DEFAULT NULL,
  `v_immune_HepatitisA` tinyint(1) DEFAULT NULL,
  `fobt_nonCCC` tinyint(1) DEFAULT NULL,
  `fobt_CCC` tinyint(1) DEFAULT NULL,
  `psa_total` tinyint(1) DEFAULT NULL,
  `psa_free` tinyint(1) DEFAULT NULL,
  `psa_insured` tinyint(1) DEFAULT NULL,
  `psa_uninsured` tinyint(1) DEFAULT NULL,
  `copy2clinician` tinyint(1) DEFAULT NULL,
  `copyLname` varchar(32) DEFAULT NULL,
  `copyFname` varchar(32) DEFAULT NULL,
  `copyAddress` varchar(100) DEFAULT NULL,
  `vitd_uninsured` tinyint(1) DEFAULT NULL,
  `vitd_insured` tinyint(1) DEFAULT NULL,
  `hcType` varchar(4) DEFAULT NULL,
  `male` tinyint(1) DEFAULT NULL,
  `female` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formLateLifeFDIDisability`
--

DROP TABLE IF EXISTS `formLateLifeFDIDisability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formLateLifeFDIDisability` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `D1VeryOften` tinyint(1) DEFAULT NULL,
  `D1Often` tinyint(1) DEFAULT NULL,
  `D1OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D1AlmostNever` tinyint(1) DEFAULT NULL,
  `D1Never` tinyint(1) DEFAULT NULL,
  `D1Not` tinyint(1) DEFAULT NULL,
  `D1Little` tinyint(1) DEFAULT NULL,
  `D1Somewhat` tinyint(1) DEFAULT NULL,
  `D1Alot` tinyint(1) DEFAULT NULL,
  `D1Completely` tinyint(1) DEFAULT NULL,
  `D2VeryOften` tinyint(1) DEFAULT NULL,
  `D2Often` tinyint(1) DEFAULT NULL,
  `D2OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D2AlmostNever` tinyint(1) DEFAULT NULL,
  `D2Never` tinyint(1) DEFAULT NULL,
  `D2Not` tinyint(1) DEFAULT NULL,
  `D2Little` tinyint(1) DEFAULT NULL,
  `D2Somewhat` tinyint(1) DEFAULT NULL,
  `D2Alot` tinyint(1) DEFAULT NULL,
  `D2Completely` tinyint(1) DEFAULT NULL,
  `D3VeryOften` tinyint(1) DEFAULT NULL,
  `D3Often` tinyint(1) DEFAULT NULL,
  `D3OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D3AlmostNever` tinyint(1) DEFAULT NULL,
  `D3Never` tinyint(1) DEFAULT NULL,
  `D3Not` tinyint(1) DEFAULT NULL,
  `D3Little` tinyint(1) DEFAULT NULL,
  `D3Somewhat` tinyint(1) DEFAULT NULL,
  `D3Alot` tinyint(1) DEFAULT NULL,
  `D3Completely` tinyint(1) DEFAULT NULL,
  `D4VeryOften` tinyint(1) DEFAULT NULL,
  `D4Often` tinyint(1) DEFAULT NULL,
  `D4OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D4AlmostNever` tinyint(1) DEFAULT NULL,
  `D4Never` tinyint(1) DEFAULT NULL,
  `D4Not` tinyint(1) DEFAULT NULL,
  `D4Little` tinyint(1) DEFAULT NULL,
  `D4Somewhat` tinyint(1) DEFAULT NULL,
  `D4Alot` tinyint(1) DEFAULT NULL,
  `D4Completely` tinyint(1) DEFAULT NULL,
  `D5VeryOften` tinyint(1) DEFAULT NULL,
  `D5Often` tinyint(1) DEFAULT NULL,
  `D5OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D5AlmostNever` tinyint(1) DEFAULT NULL,
  `D5Never` tinyint(1) DEFAULT NULL,
  `D5Not` tinyint(1) DEFAULT NULL,
  `D5Little` tinyint(1) DEFAULT NULL,
  `D5Somewhat` tinyint(1) DEFAULT NULL,
  `D5Alot` tinyint(1) DEFAULT NULL,
  `D5Completely` tinyint(1) DEFAULT NULL,
  `D6VeryOften` tinyint(1) DEFAULT NULL,
  `D6Often` tinyint(1) DEFAULT NULL,
  `D6OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D6AlmostNever` tinyint(1) DEFAULT NULL,
  `D6Never` tinyint(1) DEFAULT NULL,
  `D6Not` tinyint(1) DEFAULT NULL,
  `D6Little` tinyint(1) DEFAULT NULL,
  `D6Somewhat` tinyint(1) DEFAULT NULL,
  `D6Alot` tinyint(1) DEFAULT NULL,
  `D6Completely` tinyint(1) DEFAULT NULL,
  `D7VeryOften` tinyint(1) DEFAULT NULL,
  `D7Often` tinyint(1) DEFAULT NULL,
  `D7OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D7AlmostNever` tinyint(1) DEFAULT NULL,
  `D7Never` tinyint(1) DEFAULT NULL,
  `D7Not` tinyint(1) DEFAULT NULL,
  `D7Little` tinyint(1) DEFAULT NULL,
  `D7Somewhat` tinyint(1) DEFAULT NULL,
  `D7Alot` tinyint(1) DEFAULT NULL,
  `D7Completely` tinyint(1) DEFAULT NULL,
  `D8VeryOften` tinyint(1) DEFAULT NULL,
  `D8Often` tinyint(1) DEFAULT NULL,
  `D8OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D8AlmostNever` tinyint(1) DEFAULT NULL,
  `D8Never` tinyint(1) DEFAULT NULL,
  `D8Not` tinyint(1) DEFAULT NULL,
  `D8Little` tinyint(1) DEFAULT NULL,
  `D8Somewhat` tinyint(1) DEFAULT NULL,
  `D8Alot` tinyint(1) DEFAULT NULL,
  `D8Completely` tinyint(1) DEFAULT NULL,
  `D9VeryOften` tinyint(1) DEFAULT NULL,
  `D9Often` tinyint(1) DEFAULT NULL,
  `D9OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D9AlmostNever` tinyint(1) DEFAULT NULL,
  `D9Never` tinyint(1) DEFAULT NULL,
  `D9Not` tinyint(1) DEFAULT NULL,
  `D9Little` tinyint(1) DEFAULT NULL,
  `D9Somewhat` tinyint(1) DEFAULT NULL,
  `D9Alot` tinyint(1) DEFAULT NULL,
  `D9Completely` tinyint(1) DEFAULT NULL,
  `D10VeryOften` tinyint(1) DEFAULT NULL,
  `D10Often` tinyint(1) DEFAULT NULL,
  `D10OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D10AlmostNever` tinyint(1) DEFAULT NULL,
  `D10Never` tinyint(1) DEFAULT NULL,
  `D10Not` tinyint(1) DEFAULT NULL,
  `D10Little` tinyint(1) DEFAULT NULL,
  `D10Somewhat` tinyint(1) DEFAULT NULL,
  `D10Alot` tinyint(1) DEFAULT NULL,
  `D10Completely` tinyint(1) DEFAULT NULL,
  `D11VeryOften` tinyint(1) DEFAULT NULL,
  `D11Often` tinyint(1) DEFAULT NULL,
  `D11OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D11AlmostNever` tinyint(1) DEFAULT NULL,
  `D11Never` tinyint(1) DEFAULT NULL,
  `D11Not` tinyint(1) DEFAULT NULL,
  `D11Little` tinyint(1) DEFAULT NULL,
  `D11Somewhat` tinyint(1) DEFAULT NULL,
  `D11Alot` tinyint(1) DEFAULT NULL,
  `D11Completely` tinyint(1) DEFAULT NULL,
  `D12VeryOften` tinyint(1) DEFAULT NULL,
  `D12Often` tinyint(1) DEFAULT NULL,
  `D12OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D12AlmostNever` tinyint(1) DEFAULT NULL,
  `D12Never` tinyint(1) DEFAULT NULL,
  `D12Not` tinyint(1) DEFAULT NULL,
  `D12Little` tinyint(1) DEFAULT NULL,
  `D12Somewhat` tinyint(1) DEFAULT NULL,
  `D12Alot` tinyint(1) DEFAULT NULL,
  `D12Completely` tinyint(1) DEFAULT NULL,
  `D13VeryOften` tinyint(1) DEFAULT NULL,
  `D13Often` tinyint(1) DEFAULT NULL,
  `D13OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D13AlmostNever` tinyint(1) DEFAULT NULL,
  `D13Never` tinyint(1) DEFAULT NULL,
  `D13Not` tinyint(1) DEFAULT NULL,
  `D13Little` tinyint(1) DEFAULT NULL,
  `D13Somewhat` tinyint(1) DEFAULT NULL,
  `D13Alot` tinyint(1) DEFAULT NULL,
  `D13Completely` tinyint(1) DEFAULT NULL,
  `D14VeryOften` tinyint(1) DEFAULT NULL,
  `D14Often` tinyint(1) DEFAULT NULL,
  `D14OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D14AlmostNever` tinyint(1) DEFAULT NULL,
  `D14Never` tinyint(1) DEFAULT NULL,
  `D14Not` tinyint(1) DEFAULT NULL,
  `D14Little` tinyint(1) DEFAULT NULL,
  `D14Somewhat` tinyint(1) DEFAULT NULL,
  `D14Alot` tinyint(1) DEFAULT NULL,
  `D14Completely` tinyint(1) DEFAULT NULL,
  `D15VeryOften` tinyint(1) DEFAULT NULL,
  `D15Often` tinyint(1) DEFAULT NULL,
  `D15OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D15AlmostNever` tinyint(1) DEFAULT NULL,
  `D15Never` tinyint(1) DEFAULT NULL,
  `D15Not` tinyint(1) DEFAULT NULL,
  `D15Little` tinyint(1) DEFAULT NULL,
  `D15Somewhat` tinyint(1) DEFAULT NULL,
  `D15Alot` tinyint(1) DEFAULT NULL,
  `D15Completely` tinyint(1) DEFAULT NULL,
  `D16VeryOften` tinyint(1) DEFAULT NULL,
  `D16Often` tinyint(1) DEFAULT NULL,
  `D16OnceInAWhile` tinyint(1) DEFAULT NULL,
  `D16AlmostNever` tinyint(1) DEFAULT NULL,
  `D16Never` tinyint(1) DEFAULT NULL,
  `D16Not` tinyint(1) DEFAULT NULL,
  `D16Little` tinyint(1) DEFAULT NULL,
  `D16Somewhat` tinyint(1) DEFAULT NULL,
  `D16Alot` tinyint(1) DEFAULT NULL,
  `D16Completely` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formLateLifeFDIFunction`
--

DROP TABLE IF EXISTS `formLateLifeFDIFunction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formLateLifeFDIFunction` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `F1None` tinyint(1) DEFAULT NULL,
  `F1ALittle` tinyint(1) DEFAULT NULL,
  `F1Some` tinyint(1) DEFAULT NULL,
  `F1ALot` tinyint(1) DEFAULT NULL,
  `F1Cannot` tinyint(1) DEFAULT NULL,
  `F2None` tinyint(1) DEFAULT NULL,
  `F2ALittle` tinyint(1) DEFAULT NULL,
  `F2Some` tinyint(1) DEFAULT NULL,
  `F2ALot` tinyint(1) DEFAULT NULL,
  `F2Cannot` tinyint(1) DEFAULT NULL,
  `F3None` tinyint(1) DEFAULT NULL,
  `F3ALittle` tinyint(1) DEFAULT NULL,
  `F3Some` tinyint(1) DEFAULT NULL,
  `F3ALot` tinyint(1) DEFAULT NULL,
  `F3Cannot` tinyint(1) DEFAULT NULL,
  `F4None` tinyint(1) DEFAULT NULL,
  `F4ALittle` tinyint(1) DEFAULT NULL,
  `F4Some` tinyint(1) DEFAULT NULL,
  `F4ALot` tinyint(1) DEFAULT NULL,
  `F4Cannot` tinyint(1) DEFAULT NULL,
  `F5None` tinyint(1) DEFAULT NULL,
  `F5ALittle` tinyint(1) DEFAULT NULL,
  `F5Some` tinyint(1) DEFAULT NULL,
  `F5ALot` tinyint(1) DEFAULT NULL,
  `F5Cannot` tinyint(1) DEFAULT NULL,
  `F6None` tinyint(1) DEFAULT NULL,
  `F6ALittle` tinyint(1) DEFAULT NULL,
  `F6Some` tinyint(1) DEFAULT NULL,
  `F6ALot` tinyint(1) DEFAULT NULL,
  `F6Cannot` tinyint(1) DEFAULT NULL,
  `F7None` tinyint(1) DEFAULT NULL,
  `F7ALittle` tinyint(1) DEFAULT NULL,
  `F7Some` tinyint(1) DEFAULT NULL,
  `F7ALot` tinyint(1) DEFAULT NULL,
  `F7Cannot` tinyint(1) DEFAULT NULL,
  `F8None` tinyint(1) DEFAULT NULL,
  `F8ALittle` tinyint(1) DEFAULT NULL,
  `F8Some` tinyint(1) DEFAULT NULL,
  `F8ALot` tinyint(1) DEFAULT NULL,
  `F8Cannot` tinyint(1) DEFAULT NULL,
  `F9None` tinyint(1) DEFAULT NULL,
  `F9ALittle` tinyint(1) DEFAULT NULL,
  `F9Some` tinyint(1) DEFAULT NULL,
  `F9ALot` tinyint(1) DEFAULT NULL,
  `F9Cannot` tinyint(1) DEFAULT NULL,
  `F10None` tinyint(1) DEFAULT NULL,
  `F10ALittle` tinyint(1) DEFAULT NULL,
  `F10Some` tinyint(1) DEFAULT NULL,
  `F10ALot` tinyint(1) DEFAULT NULL,
  `F10Cannot` tinyint(1) DEFAULT NULL,
  `F11None` tinyint(1) DEFAULT NULL,
  `F11ALittle` tinyint(1) DEFAULT NULL,
  `F11Some` tinyint(1) DEFAULT NULL,
  `F11ALot` tinyint(1) DEFAULT NULL,
  `F11Cannot` tinyint(1) DEFAULT NULL,
  `F12None` tinyint(1) DEFAULT NULL,
  `F12ALittle` tinyint(1) DEFAULT NULL,
  `F12Some` tinyint(1) DEFAULT NULL,
  `F12ALot` tinyint(1) DEFAULT NULL,
  `F12Cannot` tinyint(1) DEFAULT NULL,
  `F13None` tinyint(1) DEFAULT NULL,
  `F13ALittle` tinyint(1) DEFAULT NULL,
  `F13Some` tinyint(1) DEFAULT NULL,
  `F13ALot` tinyint(1) DEFAULT NULL,
  `F13Cannot` tinyint(1) DEFAULT NULL,
  `F14None` tinyint(1) DEFAULT NULL,
  `F14ALittle` tinyint(1) DEFAULT NULL,
  `F14Some` tinyint(1) DEFAULT NULL,
  `F14ALot` tinyint(1) DEFAULT NULL,
  `F14Cannot` tinyint(1) DEFAULT NULL,
  `F15None` tinyint(1) DEFAULT NULL,
  `F15ALittle` tinyint(1) DEFAULT NULL,
  `F15Some` tinyint(1) DEFAULT NULL,
  `F15ALot` tinyint(1) DEFAULT NULL,
  `F15Cannot` tinyint(1) DEFAULT NULL,
  `F16None` tinyint(1) DEFAULT NULL,
  `F16ALittle` tinyint(1) DEFAULT NULL,
  `F16Some` tinyint(1) DEFAULT NULL,
  `F16ALot` tinyint(1) DEFAULT NULL,
  `F16Cannot` tinyint(1) DEFAULT NULL,
  `F17None` tinyint(1) DEFAULT NULL,
  `F17ALittle` tinyint(1) DEFAULT NULL,
  `F17Some` tinyint(1) DEFAULT NULL,
  `F17ALot` tinyint(1) DEFAULT NULL,
  `F17Cannot` tinyint(1) DEFAULT NULL,
  `F18None` tinyint(1) DEFAULT NULL,
  `F18ALittle` tinyint(1) DEFAULT NULL,
  `F18Some` tinyint(1) DEFAULT NULL,
  `F18ALot` tinyint(1) DEFAULT NULL,
  `F18Cannot` tinyint(1) DEFAULT NULL,
  `F19None` tinyint(1) DEFAULT NULL,
  `F19ALittle` tinyint(1) DEFAULT NULL,
  `F19Some` tinyint(1) DEFAULT NULL,
  `F19ALot` tinyint(1) DEFAULT NULL,
  `F19Cannot` tinyint(1) DEFAULT NULL,
  `F20None` tinyint(1) DEFAULT NULL,
  `F20ALittle` tinyint(1) DEFAULT NULL,
  `F20Some` tinyint(1) DEFAULT NULL,
  `F20ALot` tinyint(1) DEFAULT NULL,
  `F20Cannot` tinyint(1) DEFAULT NULL,
  `F21None` tinyint(1) DEFAULT NULL,
  `F21ALittle` tinyint(1) DEFAULT NULL,
  `F21Some` tinyint(1) DEFAULT NULL,
  `F21ALot` tinyint(1) DEFAULT NULL,
  `F21Cannot` tinyint(1) DEFAULT NULL,
  `F22None` tinyint(1) DEFAULT NULL,
  `F22ALittle` tinyint(1) DEFAULT NULL,
  `F22Some` tinyint(1) DEFAULT NULL,
  `F22ALot` tinyint(1) DEFAULT NULL,
  `F22Cannot` tinyint(1) DEFAULT NULL,
  `F23None` tinyint(1) DEFAULT NULL,
  `F23ALittle` tinyint(1) DEFAULT NULL,
  `F23Some` tinyint(1) DEFAULT NULL,
  `F23ALot` tinyint(1) DEFAULT NULL,
  `F23Cannot` tinyint(1) DEFAULT NULL,
  `F24None` tinyint(1) DEFAULT NULL,
  `F24ALittle` tinyint(1) DEFAULT NULL,
  `F24Some` tinyint(1) DEFAULT NULL,
  `F24ALot` tinyint(1) DEFAULT NULL,
  `F24Cannot` tinyint(1) DEFAULT NULL,
  `F25None` tinyint(1) DEFAULT NULL,
  `F25ALittle` tinyint(1) DEFAULT NULL,
  `F25Some` tinyint(1) DEFAULT NULL,
  `F25ALot` tinyint(1) DEFAULT NULL,
  `F25Cannot` tinyint(1) DEFAULT NULL,
  `F26None` tinyint(1) DEFAULT NULL,
  `F26ALittle` tinyint(1) DEFAULT NULL,
  `F26Some` tinyint(1) DEFAULT NULL,
  `F26ALot` tinyint(1) DEFAULT NULL,
  `F26Cannot` tinyint(1) DEFAULT NULL,
  `F27None` tinyint(1) DEFAULT NULL,
  `F27ALittle` tinyint(1) DEFAULT NULL,
  `F27Some` tinyint(1) DEFAULT NULL,
  `F27ALot` tinyint(1) DEFAULT NULL,
  `F27Cannot` tinyint(1) DEFAULT NULL,
  `F28None` tinyint(1) DEFAULT NULL,
  `F28ALittle` tinyint(1) DEFAULT NULL,
  `F28Some` tinyint(1) DEFAULT NULL,
  `F28ALot` tinyint(1) DEFAULT NULL,
  `F28Cannot` tinyint(1) DEFAULT NULL,
  `F29None` tinyint(1) DEFAULT NULL,
  `F29ALittle` tinyint(1) DEFAULT NULL,
  `F29Some` tinyint(1) DEFAULT NULL,
  `F29ALot` tinyint(1) DEFAULT NULL,
  `F29Cannot` tinyint(1) DEFAULT NULL,
  `F30None` tinyint(1) DEFAULT NULL,
  `F30ALittle` tinyint(1) DEFAULT NULL,
  `F30Some` tinyint(1) DEFAULT NULL,
  `F30ALot` tinyint(1) DEFAULT NULL,
  `F30Cannot` tinyint(1) DEFAULT NULL,
  `F31None` tinyint(1) DEFAULT NULL,
  `F31ALittle` tinyint(1) DEFAULT NULL,
  `F31Some` tinyint(1) DEFAULT NULL,
  `F31ALot` tinyint(1) DEFAULT NULL,
  `F31Cannot` tinyint(1) DEFAULT NULL,
  `F32None` tinyint(1) DEFAULT NULL,
  `F32ALittle` tinyint(1) DEFAULT NULL,
  `F32Some` tinyint(1) DEFAULT NULL,
  `F32ALot` tinyint(1) DEFAULT NULL,
  `F32Cannot` tinyint(1) DEFAULT NULL,
  `FD7None` tinyint(1) DEFAULT NULL,
  `FD7ALittle` tinyint(1) DEFAULT NULL,
  `FD7Some` tinyint(1) DEFAULT NULL,
  `FD7ALot` tinyint(1) DEFAULT NULL,
  `FD7Cannot` tinyint(1) DEFAULT NULL,
  `FD8None` tinyint(1) DEFAULT NULL,
  `FD8ALittle` tinyint(1) DEFAULT NULL,
  `FD8Some` tinyint(1) DEFAULT NULL,
  `FD8ALot` tinyint(1) DEFAULT NULL,
  `FD8Cannot` tinyint(1) DEFAULT NULL,
  `FD14None` tinyint(1) DEFAULT NULL,
  `FD14ALittle` tinyint(1) DEFAULT NULL,
  `FD14Some` tinyint(1) DEFAULT NULL,
  `FD14ALot` tinyint(1) DEFAULT NULL,
  `FD14Cannot` tinyint(1) DEFAULT NULL,
  `FD15None` tinyint(1) DEFAULT NULL,
  `FD15ALittle` tinyint(1) DEFAULT NULL,
  `FD15Some` tinyint(1) DEFAULT NULL,
  `FD15ALot` tinyint(1) DEFAULT NULL,
  `FD15Cannot` tinyint(1) DEFAULT NULL,
  `FD26None` tinyint(1) DEFAULT NULL,
  `FD26ALittle` tinyint(1) DEFAULT NULL,
  `FD26Some` tinyint(1) DEFAULT NULL,
  `FD26ALot` tinyint(1) DEFAULT NULL,
  `FD26Cannot` tinyint(1) DEFAULT NULL,
  `FD29None` tinyint(1) DEFAULT NULL,
  `FD29ALittle` tinyint(1) DEFAULT NULL,
  `FD29Some` tinyint(1) DEFAULT NULL,
  `FD29ALot` tinyint(1) DEFAULT NULL,
  `FD29Cannot` tinyint(1) DEFAULT NULL,
  `FD30None` tinyint(1) DEFAULT NULL,
  `FD30ALittle` tinyint(1) DEFAULT NULL,
  `FD30Some` tinyint(1) DEFAULT NULL,
  `FD30ALot` tinyint(1) DEFAULT NULL,
  `FD30Cannot` tinyint(1) DEFAULT NULL,
  `FD32None` tinyint(1) DEFAULT NULL,
  `FD32ALittle` tinyint(1) DEFAULT NULL,
  `FD32Some` tinyint(1) DEFAULT NULL,
  `FD32ALot` tinyint(1) DEFAULT NULL,
  `FD32Cannot` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formMMSE`
--

DROP TABLE IF EXISTS `formMMSE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formMMSE` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pName` varchar(50) DEFAULT NULL,
  `age` char(3) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `formDate` date DEFAULT NULL,
  `diagnosis` text,
  `meds` text,
  `o_date` char(1) DEFAULT NULL,
  `o_place` char(1) DEFAULT NULL,
  `r_objects` char(1) DEFAULT NULL,
  `a_serial` char(1) DEFAULT NULL,
  `re_name` char(1) DEFAULT NULL,
  `l_name` char(1) DEFAULT NULL,
  `l_repeat` char(1) DEFAULT NULL,
  `l_follow` char(1) DEFAULT NULL,
  `l_read` char(1) DEFAULT NULL,
  `l_write` char(1) DEFAULT NULL,
  `l_copy` char(1) DEFAULT NULL,
  `total` char(2) DEFAULT NULL,
  `lc_alert` tinyint(1) DEFAULT NULL,
  `lc_drowsy` tinyint(1) DEFAULT NULL,
  `lc_stupor` tinyint(1) DEFAULT NULL,
  `lc_coma` tinyint(1) DEFAULT NULL,
  `i_dementia` tinyint(1) DEFAULT NULL,
  `i_depression` tinyint(1) DEFAULT NULL,
  `i_normal` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formMentalHealth`
--

DROP TABLE IF EXISTS `formMentalHealth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formMentalHealth` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_lastVisited` varchar(15) DEFAULT NULL,
  `c_pName` varchar(60) DEFAULT NULL,
  `c_address` varchar(80) DEFAULT NULL,
  `c_birthDate` date DEFAULT NULL,
  `c_sex` varchar(6) DEFAULT NULL,
  `c_homePhone` varchar(10) DEFAULT NULL,
  `c_referralDate` date DEFAULT NULL,
  `c_referredBy` varchar(30) DEFAULT NULL,
  `r_rps1` char(2) DEFAULT NULL,
  `r_rps2` char(2) DEFAULT NULL,
  `r_rps3` char(2) DEFAULT NULL,
  `r_rpsOther` varchar(30) DEFAULT NULL,
  `r_rpi1` char(2) DEFAULT NULL,
  `r_rpi2` char(2) DEFAULT NULL,
  `r_rpi3` char(2) DEFAULT NULL,
  `r_rpiOther` varchar(30) DEFAULT NULL,
  `r_rmpi1` char(2) DEFAULT NULL,
  `r_rmpi2` char(2) DEFAULT NULL,
  `r_rmpi3` char(2) DEFAULT NULL,
  `r_rmpiOther` varchar(30) DEFAULT NULL,
  `r_ir1` char(2) DEFAULT NULL,
  `r_ir2` char(2) DEFAULT NULL,
  `r_ir3` char(2) DEFAULT NULL,
  `r_irOther` varchar(30) DEFAULT NULL,
  `r_arm1` char(2) DEFAULT NULL,
  `r_arm2` char(2) DEFAULT NULL,
  `r_arm3` char(2) DEFAULT NULL,
  `r_armOther` varchar(30) DEFAULT NULL,
  `r_refComments` text,
  `a_specialist` varchar(30) DEFAULT NULL,
  `a_aps1` char(2) DEFAULT NULL,
  `a_aps2` char(2) DEFAULT NULL,
  `a_aps3` char(2) DEFAULT NULL,
  `a_apsOther` varchar(30) DEFAULT NULL,
  `a_api1` char(2) DEFAULT NULL,
  `a_api2` char(2) DEFAULT NULL,
  `a_api3` char(2) DEFAULT NULL,
  `a_apiOther` varchar(30) DEFAULT NULL,
  `a_ampi1` char(2) DEFAULT NULL,
  `a_ampi2` char(2) DEFAULT NULL,
  `a_ampi3` char(2) DEFAULT NULL,
  `a_ampiOther` varchar(50) DEFAULT NULL,
  `a_assComments` text,
  `a_tp1` char(2) DEFAULT NULL,
  `a_tp2` char(2) DEFAULT NULL,
  `a_tp3` char(2) DEFAULT NULL,
  `a_tpOther` varchar(30) DEFAULT NULL,
  `o_specialist` varchar(30) DEFAULT NULL,
  `o_numVisits` varchar(5) DEFAULT NULL,
  `o_formDate` date DEFAULT NULL,
  `o_sp1` char(2) DEFAULT NULL,
  `o_sp2` char(2) DEFAULT NULL,
  `o_sp3` char(2) DEFAULT NULL,
  `o_spOther` varchar(30) DEFAULT NULL,
  `o_pe1` char(2) DEFAULT NULL,
  `o_pe2` char(2) DEFAULT NULL,
  `o_pe3` char(2) DEFAULT NULL,
  `o_peOther` varchar(30) DEFAULT NULL,
  `o_d1` char(2) DEFAULT NULL,
  `o_d2` char(2) DEFAULT NULL,
  `o_d3` char(2) DEFAULT NULL,
  `o_dOther` varchar(30) DEFAULT NULL,
  `o_pns1` char(2) DEFAULT NULL,
  `o_pns2` char(2) DEFAULT NULL,
  `o_pns3` char(2) DEFAULT NULL,
  `o_pnsOther` varchar(30) DEFAULT NULL,
  `o_outComments` text,
  `a_formDate` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formMentalHealthForm1`
--

DROP TABLE IF EXISTS `formMentalHealthForm1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formMentalHealthForm1` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `demographic_no` bigint(11) NOT NULL DEFAULT '0',
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `physicianName` varchar(60) DEFAULT NULL,
  `physicianAddress` varchar(255) DEFAULT NULL,
  `telephoneNumber` varchar(20) DEFAULT NULL,
  `faxNumber` varchar(20) DEFAULT NULL,
  `onDate` varchar(10) DEFAULT NULL,
  `clientName` varchar(60) DEFAULT NULL,
  `clientAddress` varchar(250) DEFAULT NULL,
  `threatened` tinyint(1) DEFAULT '0',
  `attempted` tinyint(1) DEFAULT '0',
  `behaved` tinyint(1) DEFAULT '0',
  `caused` tinyint(1) DEFAULT '0',
  `shown` tinyint(1) DEFAULT '0',
  `observation` text,
  `facts` text,
  `harmHimself` tinyint(1) DEFAULT '0',
  `harmOthers` tinyint(1) DEFAULT '0',
  `impairment` tinyint(1) DEFAULT '0',
  `observation2` text,
  `facts2` text,
  `harmHimselfB` tinyint(1) DEFAULT '0',
  `harmOthersB` tinyint(1) DEFAULT '0',
  `deteriorationB` tinyint(1) DEFAULT '0',
  `impairmentB` tinyint(1) DEFAULT '0',
  `harmHimselfB2` tinyint(1) DEFAULT '0',
  `harmOthersB2` tinyint(1) DEFAULT '0',
  `deteriorationB2` tinyint(1) DEFAULT '0',
  `impairmentB2` tinyint(1) DEFAULT '0',
  `observationB` text,
  `factsB` text,
  `todayDate` varchar(20) DEFAULT NULL,
  `todayTime` varchar(8) DEFAULT NULL,
  `signature` varchar(60) DEFAULT NULL,
  `datetimeOfDetention` varchar(20) DEFAULT NULL,
  `signature1` varchar(60) DEFAULT NULL,
  `datetimeOfDelivered` varchar(20) DEFAULT NULL,
  `signature2` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formMentalHealthForm14`
--

DROP TABLE IF EXISTS `formMentalHealthForm14`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formMentalHealthForm14` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `demographic_no` bigint(11) NOT NULL DEFAULT '0',
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(60) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `physicianName` varchar(60) DEFAULT NULL,
  `nameOfFacility` varchar(100) DEFAULT NULL,
  `clientName` varchar(60) DEFAULT NULL,
  `clientDOB` varchar(10) DEFAULT NULL,
  `witness` varchar(60) DEFAULT NULL,
  `signature` varchar(60) DEFAULT NULL,
  `relationship` varchar(20) DEFAULT NULL,
  `signatureDate` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formMentalHealthForm42`
--

DROP TABLE IF EXISTS `formMentalHealthForm42`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formMentalHealthForm42` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `demographic_no` bigint(11) NOT NULL DEFAULT '0',
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(60) DEFAULT NULL,
  `homeAddress` varchar(255) DEFAULT NULL,
  `physician` varchar(60) DEFAULT NULL,
  `dateOfExamination` varchar(10) DEFAULT NULL,
  `chkThreatenedA` tinyint(1) DEFAULT '0',
  `chkBehavedA` tinyint(1) DEFAULT '0',
  `chkCompetenceA` tinyint(1) DEFAULT '0',
  `chkHarmYourselfA` tinyint(1) DEFAULT '0',
  `chkHarmAnotherA` tinyint(1) DEFAULT '0',
  `chkImpairmentA` tinyint(1) DEFAULT '0',
  `chkHarmYourselfB` tinyint(1) DEFAULT '0',
  `chkHarmAnotherB` tinyint(1) DEFAULT '0',
  `chkDeteriorationB` tinyint(1) DEFAULT '0',
  `chkImpairmentB` tinyint(1) DEFAULT '0',
  `chkHarmYourselfB2` tinyint(1) DEFAULT '0',
  `chkHarmAnotherB2` tinyint(1) DEFAULT '0',
  `chkDeteriorationB2` tinyint(1) DEFAULT '0',
  `chkImpairmentB2` tinyint(1) DEFAULT '0',
  `dateOfSign` varchar(10) DEFAULT '0',
  `signPhysician` varchar(60) DEFAULT NULL,
  `name2` varchar(60) DEFAULT NULL,
  `homeAddress2` varchar(255) DEFAULT NULL,
  `nameOfMinisterHealth` varchar(255) DEFAULT NULL,
  `chkHarmYourself2` tinyint(1) DEFAULT '0',
  `chkHarmAnother2` tinyint(1) DEFAULT '0',
  `dateOfOrder` varchar(10) DEFAULT NULL,
  `dateOfSign2` varchar(10) DEFAULT NULL,
  `signPhysician2` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formONAR`
--

DROP TABLE IF EXISTS `formONAR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formONAR` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_lastName` varchar(80) DEFAULT NULL,
  `c_firstName` varchar(80) DEFAULT NULL,
  `c_address` varchar(80) DEFAULT NULL,
  `c_apt` varchar(20) DEFAULT NULL,
  `c_city` varchar(80) DEFAULT NULL,
  `c_province` varchar(80) DEFAULT NULL,
  `c_postal` varchar(10) DEFAULT NULL,
  `c_partnerLastName` varchar(80) DEFAULT NULL,
  `c_partnerFirstName` varchar(80) DEFAULT NULL,
  `pg1_homePhone` varchar(20) DEFAULT NULL,
  `pg1_workPhone` varchar(20) DEFAULT NULL,
  `pg1_language` varchar(25) DEFAULT NULL,
  `pg1_partnerOccupation` varchar(25) DEFAULT NULL,
  `pg1_partnerEduLevel` varchar(25) DEFAULT NULL,
  `pg1_partnerAge` varchar(5) DEFAULT NULL,
  `pg1_dateOfBirth` date DEFAULT NULL,
  `pg1_age` varchar(10) DEFAULT NULL,
  `pg1_occupation` varchar(25) DEFAULT NULL,
  `pg1_eduLevel` varchar(25) DEFAULT NULL,
  `pg1_ethnicBg` varchar(200) DEFAULT NULL,
  `c_hin` varchar(20) DEFAULT NULL,
  `c_fileNo` varchar(20) DEFAULT NULL,
  `pg1_msSingle` tinyint(1) DEFAULT NULL,
  `pg1_msCommonLaw` tinyint(1) DEFAULT NULL,
  `pg1_msMarried` tinyint(1) DEFAULT NULL,
  `pg1_baObs` tinyint(1) DEFAULT NULL,
  `pg1_baFP` tinyint(1) DEFAULT NULL,
  `pg1_baMidwife` tinyint(1) DEFAULT NULL,
  `c_ba` varchar(25) DEFAULT NULL,
  `pg1_ncPed` tinyint(1) DEFAULT NULL,
  `pg1_ncFP` tinyint(1) DEFAULT NULL,
  `pg1_ncMidwife` tinyint(1) DEFAULT NULL,
  `c_nc` varchar(25) DEFAULT NULL,
  `c_famPhys` varchar(80) DEFAULT NULL,
  `c_allergies` text,
  `c_meds` text,
  `pg1_menLMP` date DEFAULT NULL,
  `pg1_psCertY` tinyint(1) DEFAULT NULL,
  `pg1_psCertN` tinyint(1) DEFAULT NULL,
  `pg1_menCycle` varchar(7) DEFAULT NULL,
  `pg1_menReg` tinyint(1) DEFAULT NULL,
  `pg1_menRegN` tinyint(1) DEFAULT NULL,
  `pg1_contracep` varchar(25) DEFAULT NULL,
  `pg1_lastUsed` date DEFAULT NULL,
  `pg1_menEDB` date DEFAULT NULL,
  `c_finalEDB` date DEFAULT NULL,
  `pg1_edbByDate` tinyint(1) DEFAULT NULL,
  `pg1_edbByT1` tinyint(1) DEFAULT NULL,
  `pg1_edbByT2` tinyint(1) DEFAULT NULL,
  `pg1_edbByART` tinyint(1) DEFAULT NULL,
  `c_gravida` varchar(3) DEFAULT NULL,
  `c_term` varchar(3) DEFAULT NULL,
  `c_prem` varchar(3) DEFAULT NULL,
  `c_abort` varchar(3) DEFAULT NULL,
  `c_living` varchar(3) DEFAULT NULL,
  `pg1_year1` varchar(10) DEFAULT NULL,
  `pg1_sex1` char(1) DEFAULT NULL,
  `pg1_oh_gest1` varchar(5) DEFAULT NULL,
  `pg1_weight1` varchar(6) DEFAULT NULL,
  `pg1_length1` varchar(6) DEFAULT NULL,
  `pg1_place1` varchar(20) DEFAULT NULL,
  `pg1_svb1` tinyint(1) DEFAULT NULL,
  `pg1_cs1` tinyint(1) DEFAULT NULL,
  `pg1_ass1` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments1` varchar(80) DEFAULT NULL,
  `pg1_year2` varchar(10) DEFAULT NULL,
  `pg1_sex2` char(1) DEFAULT NULL,
  `pg1_oh_gest2` varchar(5) DEFAULT NULL,
  `pg1_weight2` varchar(6) DEFAULT NULL,
  `pg1_length2` varchar(6) DEFAULT NULL,
  `pg1_place2` varchar(20) DEFAULT NULL,
  `pg1_svb2` tinyint(1) DEFAULT NULL,
  `pg1_cs2` tinyint(1) DEFAULT NULL,
  `pg1_ass2` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments2` varchar(80) DEFAULT NULL,
  `pg1_year3` varchar(10) DEFAULT NULL,
  `pg1_sex3` char(1) DEFAULT NULL,
  `pg1_oh_gest3` varchar(5) DEFAULT NULL,
  `pg1_weight3` varchar(6) DEFAULT NULL,
  `pg1_length3` varchar(6) DEFAULT NULL,
  `pg1_place3` varchar(20) DEFAULT NULL,
  `pg1_svb3` tinyint(1) DEFAULT NULL,
  `pg1_cs3` tinyint(1) DEFAULT NULL,
  `pg1_ass3` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments3` varchar(80) DEFAULT NULL,
  `pg1_year4` varchar(10) DEFAULT NULL,
  `pg1_sex4` char(1) DEFAULT NULL,
  `pg1_oh_gest4` varchar(5) DEFAULT NULL,
  `pg1_weight4` varchar(6) DEFAULT NULL,
  `pg1_length4` varchar(6) DEFAULT NULL,
  `pg1_place4` varchar(20) DEFAULT NULL,
  `pg1_svb4` tinyint(1) DEFAULT NULL,
  `pg1_cs4` tinyint(1) DEFAULT NULL,
  `pg1_ass4` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments4` varchar(80) DEFAULT NULL,
  `pg1_year5` varchar(10) DEFAULT NULL,
  `pg1_sex5` char(1) DEFAULT NULL,
  `pg1_oh_gest5` varchar(5) DEFAULT NULL,
  `pg1_weight5` varchar(6) DEFAULT NULL,
  `pg1_length5` varchar(6) DEFAULT NULL,
  `pg1_place5` varchar(20) DEFAULT NULL,
  `pg1_svb5` tinyint(1) DEFAULT NULL,
  `pg1_cs5` tinyint(1) DEFAULT NULL,
  `pg1_ass5` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments5` varchar(80) DEFAULT NULL,
  `pg1_year6` varchar(10) DEFAULT NULL,
  `pg1_sex6` char(1) DEFAULT NULL,
  `pg1_oh_gest6` varchar(5) DEFAULT NULL,
  `pg1_weight6` varchar(6) DEFAULT NULL,
  `pg1_length6` varchar(6) DEFAULT NULL,
  `pg1_place6` varchar(20) DEFAULT NULL,
  `pg1_svb6` tinyint(1) DEFAULT NULL,
  `pg1_cs6` tinyint(1) DEFAULT NULL,
  `pg1_ass6` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments6` varchar(80) DEFAULT NULL,
  `pg1_cp1` tinyint(1) DEFAULT NULL,
  `pg1_cp1N` tinyint(1) DEFAULT NULL,
  `pg1_cp2` tinyint(1) DEFAULT NULL,
  `pg1_cp2N` tinyint(1) DEFAULT NULL,
  `pg1_box3` varchar(3) DEFAULT NULL,
  `pg1_cp3` tinyint(1) DEFAULT NULL,
  `pg1_cp3N` tinyint(1) DEFAULT NULL,
  `pg1_cp4` tinyint(1) DEFAULT NULL,
  `pg1_cp4N` tinyint(1) DEFAULT NULL,
  `pg1_cp8` tinyint(1) DEFAULT NULL,
  `pg1_cp8N` tinyint(1) DEFAULT NULL,
  `pg1_naDietRes` tinyint(1) DEFAULT NULL,
  `pg1_naDietBal` tinyint(1) DEFAULT NULL,
  `pg1_naMilk` tinyint(1) DEFAULT NULL,
  `pg1_naMilkN` tinyint(1) DEFAULT NULL,
  `pg1_naFolic` tinyint(1) DEFAULT NULL,
  `pg1_naFolicN` tinyint(1) DEFAULT NULL,
  `pg1_yes9` tinyint(1) DEFAULT NULL,
  `pg1_no9` tinyint(1) DEFAULT NULL,
  `pg1_yes10` tinyint(1) DEFAULT NULL,
  `pg1_no10` tinyint(1) DEFAULT NULL,
  `pg1_yes12` tinyint(1) DEFAULT NULL,
  `pg1_no12` tinyint(1) DEFAULT NULL,
  `pg1_yes13` tinyint(1) DEFAULT NULL,
  `pg1_no13` tinyint(1) DEFAULT NULL,
  `pg1_yes14` tinyint(1) DEFAULT NULL,
  `pg1_no14` tinyint(1) DEFAULT NULL,
  `pg1_yes17` tinyint(1) DEFAULT NULL,
  `pg1_no17` tinyint(1) DEFAULT NULL,
  `pg1_yes22` tinyint(1) DEFAULT NULL,
  `pg1_no22` tinyint(1) DEFAULT NULL,
  `pg1_yes20` tinyint(1) DEFAULT NULL,
  `pg1_no20` tinyint(1) DEFAULT NULL,
  `pg1_bloodTranY` tinyint(1) DEFAULT NULL,
  `pg1_bloodTranN` tinyint(1) DEFAULT NULL,
  `pg1_yes21` tinyint(1) DEFAULT NULL,
  `pg1_no21` tinyint(1) DEFAULT NULL,
  `pg1_yes24` tinyint(1) DEFAULT NULL,
  `pg1_no24` tinyint(1) DEFAULT NULL,
  `pg1_yes15` tinyint(1) DEFAULT NULL,
  `pg1_no15` tinyint(1) DEFAULT NULL,
  `pg1_box25` varchar(25) DEFAULT NULL,
  `pg1_yes25` tinyint(1) DEFAULT NULL,
  `pg1_no25` tinyint(1) DEFAULT NULL,
  `pg1_yes27` tinyint(1) DEFAULT NULL,
  `pg1_no27` tinyint(1) DEFAULT NULL,
  `pg1_yes31` tinyint(1) DEFAULT NULL,
  `pg1_no31` tinyint(1) DEFAULT NULL,
  `pg1_yes32` tinyint(1) DEFAULT NULL,
  `pg1_no32` tinyint(1) DEFAULT NULL,
  `pg1_yes34` tinyint(1) DEFAULT NULL,
  `pg1_no34` tinyint(1) DEFAULT NULL,
  `pg1_yes35` tinyint(1) DEFAULT NULL,
  `pg1_no35` tinyint(1) DEFAULT NULL,
  `pg1_idt40` tinyint(1) DEFAULT NULL,
  `pg1_idt40N` tinyint(1) DEFAULT NULL,
  `pg1_idt38` tinyint(1) DEFAULT NULL,
  `pg1_idt38N` tinyint(1) DEFAULT NULL,
  `pg1_idt42` tinyint(1) DEFAULT NULL,
  `pg1_idt42N` tinyint(1) DEFAULT NULL,
  `pg1_infectDisOther` varchar(20) DEFAULT NULL,
  `pg1_infectDisOtherY` tinyint(1) DEFAULT NULL,
  `pg1_infectDisOtherN` tinyint(1) DEFAULT NULL,
  `pg1_pdt43` tinyint(1) DEFAULT NULL,
  `pg1_pdt43N` tinyint(1) DEFAULT NULL,
  `pg1_pdt44` tinyint(1) DEFAULT NULL,
  `pg1_pdt44N` tinyint(1) DEFAULT NULL,
  `pg1_pdt45` tinyint(1) DEFAULT NULL,
  `pg1_pdt45N` tinyint(1) DEFAULT NULL,
  `pg1_pdt46` tinyint(1) DEFAULT NULL,
  `pg1_pdt46N` tinyint(1) DEFAULT NULL,
  `pg1_pdt47` tinyint(1) DEFAULT NULL,
  `pg1_pdt47N` tinyint(1) DEFAULT NULL,
  `pg1_pdt48` tinyint(1) DEFAULT NULL,
  `pg1_pdt48N` tinyint(1) DEFAULT NULL,
  `pg1_reliCultY` tinyint(1) DEFAULT NULL,
  `pg1_reliCultN` tinyint(1) DEFAULT NULL,
  `pg1_fhRiskY` tinyint(1) DEFAULT NULL,
  `pg1_fhRiskN` tinyint(1) DEFAULT NULL,
  `pg1_ht` varchar(6) DEFAULT NULL,
  `pg1_wt` varchar(6) DEFAULT NULL,
  `c_bmi` varchar(6) DEFAULT NULL,
  `pg1_BP` varchar(10) DEFAULT NULL,
  `pg1_thyroid` tinyint(1) DEFAULT NULL,
  `pg1_thyroidA` tinyint(1) DEFAULT NULL,
  `pg1_chest` tinyint(1) DEFAULT NULL,
  `pg1_chestA` tinyint(1) DEFAULT NULL,
  `pg1_breasts` tinyint(1) DEFAULT NULL,
  `pg1_breastsA` tinyint(1) DEFAULT NULL,
  `pg1_cardio` tinyint(1) DEFAULT NULL,
  `pg1_cardioA` tinyint(1) DEFAULT NULL,
  `pg1_abdomen` tinyint(1) DEFAULT NULL,
  `pg1_abdomenA` tinyint(1) DEFAULT NULL,
  `pg1_vari` tinyint(1) DEFAULT NULL,
  `pg1_variA` tinyint(1) DEFAULT NULL,
  `pg1_extGen` tinyint(1) DEFAULT NULL,
  `pg1_extGenA` tinyint(1) DEFAULT NULL,
  `pg1_cervix` tinyint(1) DEFAULT NULL,
  `pg1_cervixA` tinyint(1) DEFAULT NULL,
  `pg1_uterus` tinyint(1) DEFAULT NULL,
  `pg1_uterusA` tinyint(1) DEFAULT NULL,
  `pg1_uterusBox` varchar(3) DEFAULT NULL,
  `pg1_adnexa` tinyint(1) DEFAULT NULL,
  `pg1_adnexaA` tinyint(1) DEFAULT NULL,
  `pg1_pExOther` varchar(20) DEFAULT NULL,
  `pg1_pExOtherN` tinyint(1) DEFAULT NULL,
  `pg1_pExOtherA` tinyint(1) DEFAULT NULL,
  `pg1_labHb` varchar(20) DEFAULT NULL,
  `pg1_labHIV` varchar(20) DEFAULT NULL,
  `pg1_labMCV` varchar(20) DEFAULT NULL,
  `pg1_labHIVCounsel` tinyint(1) DEFAULT NULL,
  `pg1_labABO` varchar(20) DEFAULT NULL,
  `pg1_labLastPapDate` varchar(10) DEFAULT NULL,
  `pg1_labLastPap` varchar(20) DEFAULT NULL,
  `pg1_labRh` varchar(20) DEFAULT NULL,
  `pg1_labAntiScr` varchar(20) DEFAULT NULL,
  `pg1_labGC` varchar(20) DEFAULT NULL,
  `pg1_labRubella` varchar(20) DEFAULT NULL,
  `pg1_labUrine` varchar(20) DEFAULT NULL,
  `pg1_labHBsAg` varchar(20) DEFAULT NULL,
  `pg1_labVDRL` varchar(20) DEFAULT NULL,
  `pg1_labSickle` varchar(20) DEFAULT NULL,
  `pg1_geneticA` varchar(20) DEFAULT NULL,
  `pg1_geneticB` varchar(20) DEFAULT NULL,
  `pg1_geneticC` varchar(20) DEFAULT NULL,
  `pg1_geneticD` tinyint(1) DEFAULT NULL,
  `pg1_commentsAR1` text,
  `pg1_signature` varchar(50) DEFAULT NULL,
  `pg1_formDate` date DEFAULT NULL,
  `pg1_signature2` varchar(50) DEFAULT NULL,
  `pg1_formDate2` date DEFAULT NULL,
  `c_riskFactors1` varchar(50) DEFAULT NULL,
  `c_planManage1` varchar(100) DEFAULT NULL,
  `c_riskFactors2` varchar(50) DEFAULT NULL,
  `c_planManage2` varchar(100) DEFAULT NULL,
  `c_riskFactors3` varchar(50) DEFAULT NULL,
  `c_planManage3` varchar(100) DEFAULT NULL,
  `c_riskFactors4` varchar(50) DEFAULT NULL,
  `c_planManage4` varchar(100) DEFAULT NULL,
  `c_riskFactors5` varchar(50) DEFAULT NULL,
  `c_planManage5` varchar(100) DEFAULT NULL,
  `c_riskFactors6` varchar(50) DEFAULT NULL,
  `c_planManage6` varchar(100) DEFAULT NULL,
  `c_riskFactors7` varchar(50) DEFAULT NULL,
  `c_planManage7` varchar(100) DEFAULT NULL,
  `ar2_rhNeg` tinyint(1) DEFAULT NULL,
  `ar2_rhIG` varchar(10) DEFAULT NULL,
  `ar2_rubella` tinyint(1) DEFAULT NULL,
  `ar2_hepBIG` tinyint(1) DEFAULT NULL,
  `ar2_hepBVac` tinyint(1) DEFAULT NULL,
  `pg2_date1` date DEFAULT NULL,
  `pg2_gest1` varchar(6) DEFAULT NULL,
  `pg2_wt1` varchar(6) DEFAULT NULL,
  `pg2_BP1` varchar(8) DEFAULT NULL,
  `pg2_urinePr1` char(3) DEFAULT NULL,
  `pg2_urineGl1` char(3) DEFAULT NULL,
  `pg2_ht1` varchar(6) DEFAULT NULL,
  `pg2_presn1` varchar(6) DEFAULT NULL,
  `pg2_FHR1` varchar(6) DEFAULT NULL,
  `pg2_comments1` varchar(255) DEFAULT NULL,
  `pg2_date2` date DEFAULT NULL,
  `pg2_gest2` varchar(6) DEFAULT NULL,
  `pg2_ht2` varchar(6) DEFAULT NULL,
  `pg2_wt2` varchar(6) DEFAULT NULL,
  `pg2_presn2` varchar(6) DEFAULT NULL,
  `pg2_FHR2` varchar(6) DEFAULT NULL,
  `pg2_urinePr2` char(3) DEFAULT NULL,
  `pg2_urineGl2` char(3) DEFAULT NULL,
  `pg2_BP2` varchar(8) DEFAULT NULL,
  `pg2_comments2` varchar(255) DEFAULT NULL,
  `pg2_date3` date DEFAULT NULL,
  `pg2_gest3` varchar(6) DEFAULT NULL,
  `pg2_ht3` varchar(6) DEFAULT NULL,
  `pg2_wt3` varchar(6) DEFAULT NULL,
  `pg2_presn3` varchar(6) DEFAULT NULL,
  `pg2_FHR3` varchar(6) DEFAULT NULL,
  `pg2_urinePr3` char(3) DEFAULT NULL,
  `pg2_urineGl3` char(3) DEFAULT NULL,
  `pg2_BP3` varchar(8) DEFAULT NULL,
  `pg2_comments3` varchar(255) DEFAULT NULL,
  `pg2_date4` date DEFAULT NULL,
  `pg2_gest4` varchar(6) DEFAULT NULL,
  `pg2_ht4` varchar(6) DEFAULT NULL,
  `pg2_wt4` varchar(6) DEFAULT NULL,
  `pg2_presn4` varchar(6) DEFAULT NULL,
  `pg2_FHR4` varchar(6) DEFAULT NULL,
  `pg2_urinePr4` char(3) DEFAULT NULL,
  `pg2_urineGl4` char(3) DEFAULT NULL,
  `pg2_BP4` varchar(8) DEFAULT NULL,
  `pg2_comments4` varchar(255) DEFAULT NULL,
  `pg2_date5` date DEFAULT NULL,
  `pg2_gest5` varchar(6) DEFAULT NULL,
  `pg2_ht5` varchar(6) DEFAULT NULL,
  `pg2_wt5` varchar(6) DEFAULT NULL,
  `pg2_presn5` varchar(6) DEFAULT NULL,
  `pg2_FHR5` varchar(6) DEFAULT NULL,
  `pg2_urinePr5` char(3) DEFAULT NULL,
  `pg2_urineGl5` char(3) DEFAULT NULL,
  `pg2_BP5` varchar(8) DEFAULT NULL,
  `pg2_comments5` varchar(255) DEFAULT NULL,
  `pg2_date6` date DEFAULT NULL,
  `pg2_gest6` varchar(6) DEFAULT NULL,
  `pg2_ht6` varchar(6) DEFAULT NULL,
  `pg2_wt6` varchar(6) DEFAULT NULL,
  `pg2_presn6` varchar(6) DEFAULT NULL,
  `pg2_FHR6` varchar(6) DEFAULT NULL,
  `pg2_urinePr6` char(3) DEFAULT NULL,
  `pg2_urineGl6` char(3) DEFAULT NULL,
  `pg2_BP6` varchar(8) DEFAULT NULL,
  `pg2_comments6` varchar(255) DEFAULT NULL,
  `pg2_date7` date DEFAULT NULL,
  `pg2_gest7` varchar(6) DEFAULT NULL,
  `pg2_ht7` varchar(6) DEFAULT NULL,
  `pg2_wt7` varchar(6) DEFAULT NULL,
  `pg2_presn7` varchar(6) DEFAULT NULL,
  `pg2_FHR7` varchar(6) DEFAULT NULL,
  `pg2_urinePr7` char(3) DEFAULT NULL,
  `pg2_urineGl7` char(3) DEFAULT NULL,
  `pg2_BP7` varchar(8) DEFAULT NULL,
  `pg2_comments7` varchar(255) DEFAULT NULL,
  `pg2_date8` date DEFAULT NULL,
  `pg2_gest8` varchar(6) DEFAULT NULL,
  `pg2_ht8` varchar(6) DEFAULT NULL,
  `pg2_wt8` varchar(6) DEFAULT NULL,
  `pg2_presn8` varchar(6) DEFAULT NULL,
  `pg2_FHR8` varchar(6) DEFAULT NULL,
  `pg2_urinePr8` char(3) DEFAULT NULL,
  `pg2_urineGl8` char(3) DEFAULT NULL,
  `pg2_BP8` varchar(8) DEFAULT NULL,
  `pg2_comments8` varchar(255) DEFAULT NULL,
  `pg2_date9` date DEFAULT NULL,
  `pg2_gest9` varchar(6) DEFAULT NULL,
  `pg2_ht9` varchar(6) DEFAULT NULL,
  `pg2_wt9` varchar(6) DEFAULT NULL,
  `pg2_presn9` varchar(6) DEFAULT NULL,
  `pg2_FHR9` varchar(6) DEFAULT NULL,
  `pg2_urinePr9` char(3) DEFAULT NULL,
  `pg2_urineGl9` char(3) DEFAULT NULL,
  `pg2_BP9` varchar(8) DEFAULT NULL,
  `pg2_comments9` varchar(255) DEFAULT NULL,
  `pg2_date10` date DEFAULT NULL,
  `pg2_gest10` varchar(6) DEFAULT NULL,
  `pg2_ht10` varchar(6) DEFAULT NULL,
  `pg2_wt10` varchar(6) DEFAULT NULL,
  `pg2_presn10` varchar(6) DEFAULT NULL,
  `pg2_FHR10` varchar(6) DEFAULT NULL,
  `pg2_urinePr10` char(3) DEFAULT NULL,
  `pg2_urineGl10` char(3) DEFAULT NULL,
  `pg2_BP10` varchar(8) DEFAULT NULL,
  `pg2_comments10` varchar(255) DEFAULT NULL,
  `pg2_date11` date DEFAULT NULL,
  `pg2_gest11` varchar(6) DEFAULT NULL,
  `pg2_ht11` varchar(6) DEFAULT NULL,
  `pg2_wt11` varchar(6) DEFAULT NULL,
  `pg2_presn11` varchar(6) DEFAULT NULL,
  `pg2_FHR11` varchar(6) DEFAULT NULL,
  `pg2_urinePr11` char(3) DEFAULT NULL,
  `pg2_urineGl11` char(3) DEFAULT NULL,
  `pg2_BP11` varchar(8) DEFAULT NULL,
  `pg2_comments11` varchar(255) DEFAULT NULL,
  `pg2_date12` date DEFAULT NULL,
  `pg2_gest12` varchar(6) DEFAULT NULL,
  `pg2_ht12` varchar(6) DEFAULT NULL,
  `pg2_wt12` varchar(6) DEFAULT NULL,
  `pg2_presn12` varchar(6) DEFAULT NULL,
  `pg2_FHR12` varchar(6) DEFAULT NULL,
  `pg2_urinePr12` char(3) DEFAULT NULL,
  `pg2_urineGl12` char(3) DEFAULT NULL,
  `pg2_BP12` varchar(8) DEFAULT NULL,
  `pg2_comments12` varchar(255) DEFAULT NULL,
  `pg2_date13` date DEFAULT NULL,
  `pg2_gest13` varchar(6) DEFAULT NULL,
  `pg2_ht13` varchar(6) DEFAULT NULL,
  `pg2_wt13` varchar(6) DEFAULT NULL,
  `pg2_presn13` varchar(6) DEFAULT NULL,
  `pg2_FHR13` varchar(6) DEFAULT NULL,
  `pg2_urinePr13` char(3) DEFAULT NULL,
  `pg2_urineGl13` char(3) DEFAULT NULL,
  `pg2_BP13` varchar(8) DEFAULT NULL,
  `pg2_comments13` varchar(255) DEFAULT NULL,
  `pg2_date14` date DEFAULT NULL,
  `pg2_gest14` varchar(6) DEFAULT NULL,
  `pg2_ht14` varchar(6) DEFAULT NULL,
  `pg2_wt14` varchar(6) DEFAULT NULL,
  `pg2_presn14` varchar(6) DEFAULT NULL,
  `pg2_FHR14` varchar(6) DEFAULT NULL,
  `pg2_urinePr14` char(3) DEFAULT NULL,
  `pg2_urineGl14` char(3) DEFAULT NULL,
  `pg2_BP14` varchar(8) DEFAULT NULL,
  `pg2_comments14` varchar(255) DEFAULT NULL,
  `pg2_date15` date DEFAULT NULL,
  `pg2_gest15` varchar(6) DEFAULT NULL,
  `pg2_ht15` varchar(6) DEFAULT NULL,
  `pg2_wt15` varchar(6) DEFAULT NULL,
  `pg2_presn15` varchar(6) DEFAULT NULL,
  `pg2_FHR15` varchar(6) DEFAULT NULL,
  `pg2_urinePr15` char(3) DEFAULT NULL,
  `pg2_urineGl15` char(3) DEFAULT NULL,
  `pg2_BP15` varchar(8) DEFAULT NULL,
  `pg2_comments15` varchar(255) DEFAULT NULL,
  `pg2_date16` date DEFAULT NULL,
  `pg2_gest16` varchar(6) DEFAULT NULL,
  `pg2_ht16` varchar(6) DEFAULT NULL,
  `pg2_wt16` varchar(6) DEFAULT NULL,
  `pg2_presn16` varchar(6) DEFAULT NULL,
  `pg2_FHR16` varchar(6) DEFAULT NULL,
  `pg2_urinePr16` char(3) DEFAULT NULL,
  `pg2_urineGl16` char(3) DEFAULT NULL,
  `pg2_BP16` varchar(8) DEFAULT NULL,
  `pg2_comments16` varchar(255) DEFAULT NULL,
  `pg2_date17` date DEFAULT NULL,
  `pg2_gest17` varchar(6) DEFAULT NULL,
  `pg2_ht17` varchar(6) DEFAULT NULL,
  `pg2_wt17` varchar(6) DEFAULT NULL,
  `pg2_presn17` varchar(6) DEFAULT NULL,
  `pg2_FHR17` varchar(6) DEFAULT NULL,
  `pg2_urinePr17` char(3) DEFAULT NULL,
  `pg2_urineGl17` char(3) DEFAULT NULL,
  `pg2_BP17` varchar(8) DEFAULT NULL,
  `pg2_comments17` varchar(255) DEFAULT NULL,
  `pg2_date18` date DEFAULT NULL,
  `pg2_gest18` varchar(6) DEFAULT NULL,
  `pg2_ht18` varchar(6) DEFAULT NULL,
  `pg2_wt18` varchar(6) DEFAULT NULL,
  `pg2_presn18` varchar(6) DEFAULT NULL,
  `pg2_FHR18` varchar(6) DEFAULT NULL,
  `pg2_urinePr18` char(3) DEFAULT NULL,
  `pg2_urineGl18` char(3) DEFAULT NULL,
  `pg2_BP18` varchar(8) DEFAULT NULL,
  `pg2_comments18` varchar(255) DEFAULT NULL,
  `pg3_date19` date DEFAULT NULL,
  `pg3_gest19` varchar(6) DEFAULT NULL,
  `pg3_ht19` varchar(6) DEFAULT NULL,
  `pg3_wt19` varchar(6) DEFAULT NULL,
  `pg3_presn19` varchar(6) DEFAULT NULL,
  `pg3_FHR19` varchar(6) DEFAULT NULL,
  `pg3_urinePr19` char(3) DEFAULT NULL,
  `pg3_urineGl19` char(3) DEFAULT NULL,
  `pg3_BP19` varchar(8) DEFAULT NULL,
  `pg3_comments19` varchar(255) DEFAULT NULL,
  `pg3_date20` date DEFAULT NULL,
  `pg3_gest20` varchar(6) DEFAULT NULL,
  `pg3_ht20` varchar(6) DEFAULT NULL,
  `pg3_wt20` varchar(6) DEFAULT NULL,
  `pg3_presn20` varchar(6) DEFAULT NULL,
  `pg3_FHR20` varchar(6) DEFAULT NULL,
  `pg3_urinePr20` char(3) DEFAULT NULL,
  `pg3_urineGl20` char(3) DEFAULT NULL,
  `pg3_BP20` varchar(8) DEFAULT NULL,
  `pg3_comments20` varchar(255) DEFAULT NULL,
  `pg3_date21` date DEFAULT NULL,
  `pg3_gest21` varchar(6) DEFAULT NULL,
  `pg3_ht21` varchar(6) DEFAULT NULL,
  `pg3_wt21` varchar(6) DEFAULT NULL,
  `pg3_presn21` varchar(6) DEFAULT NULL,
  `pg3_FHR21` varchar(6) DEFAULT NULL,
  `pg3_urinePr21` char(3) DEFAULT NULL,
  `pg3_urineGl21` char(3) DEFAULT NULL,
  `pg3_BP21` varchar(8) DEFAULT NULL,
  `pg3_comments21` varchar(255) DEFAULT NULL,
  `pg3_date22` date DEFAULT NULL,
  `pg3_gest22` varchar(6) DEFAULT NULL,
  `pg3_ht22` varchar(6) DEFAULT NULL,
  `pg3_wt22` varchar(6) DEFAULT NULL,
  `pg3_presn22` varchar(6) DEFAULT NULL,
  `pg3_FHR22` varchar(6) DEFAULT NULL,
  `pg3_urinePr22` char(3) DEFAULT NULL,
  `pg3_urineGl22` char(3) DEFAULT NULL,
  `pg3_BP22` varchar(8) DEFAULT NULL,
  `pg3_comments22` varchar(255) DEFAULT NULL,
  `pg3_date23` date DEFAULT NULL,
  `pg3_gest23` varchar(6) DEFAULT NULL,
  `pg3_ht23` varchar(6) DEFAULT NULL,
  `pg3_wt23` varchar(6) DEFAULT NULL,
  `pg3_presn23` varchar(6) DEFAULT NULL,
  `pg3_FHR23` varchar(6) DEFAULT NULL,
  `pg3_urinePr23` char(3) DEFAULT NULL,
  `pg3_urineGl23` char(3) DEFAULT NULL,
  `pg3_BP23` varchar(8) DEFAULT NULL,
  `pg3_comments23` varchar(255) DEFAULT NULL,
  `pg3_date24` date DEFAULT NULL,
  `pg3_gest24` varchar(6) DEFAULT NULL,
  `pg3_ht24` varchar(6) DEFAULT NULL,
  `pg3_wt24` varchar(6) DEFAULT NULL,
  `pg3_presn24` varchar(6) DEFAULT NULL,
  `pg3_FHR24` varchar(6) DEFAULT NULL,
  `pg3_urinePr24` char(3) DEFAULT NULL,
  `pg3_urineGl24` char(3) DEFAULT NULL,
  `pg3_BP24` varchar(8) DEFAULT NULL,
  `pg3_comments24` varchar(255) DEFAULT NULL,
  `pg3_date25` date DEFAULT NULL,
  `pg3_gest25` varchar(6) DEFAULT NULL,
  `pg3_ht25` varchar(6) DEFAULT NULL,
  `pg3_wt25` varchar(6) DEFAULT NULL,
  `pg3_presn25` varchar(6) DEFAULT NULL,
  `pg3_FHR25` varchar(6) DEFAULT NULL,
  `pg3_urinePr25` char(3) DEFAULT NULL,
  `pg3_urineGl25` char(3) DEFAULT NULL,
  `pg3_BP25` varchar(8) DEFAULT NULL,
  `pg3_comments25` varchar(255) DEFAULT NULL,
  `pg3_date26` date DEFAULT NULL,
  `pg3_gest26` varchar(6) DEFAULT NULL,
  `pg3_ht26` varchar(6) DEFAULT NULL,
  `pg3_wt26` varchar(6) DEFAULT NULL,
  `pg3_presn26` varchar(6) DEFAULT NULL,
  `pg3_FHR26` varchar(6) DEFAULT NULL,
  `pg3_urinePr26` char(3) DEFAULT NULL,
  `pg3_urineGl26` char(3) DEFAULT NULL,
  `pg3_BP26` varchar(8) DEFAULT NULL,
  `pg3_comments26` varchar(255) DEFAULT NULL,
  `pg3_date27` date DEFAULT NULL,
  `pg3_gest27` varchar(6) DEFAULT NULL,
  `pg3_ht27` varchar(6) DEFAULT NULL,
  `pg3_wt27` varchar(6) DEFAULT NULL,
  `pg3_presn27` varchar(6) DEFAULT NULL,
  `pg3_FHR27` varchar(6) DEFAULT NULL,
  `pg3_urinePr27` char(3) DEFAULT NULL,
  `pg3_urineGl27` char(3) DEFAULT NULL,
  `pg3_BP27` varchar(8) DEFAULT NULL,
  `pg3_comments27` varchar(255) DEFAULT NULL,
  `pg3_date28` date DEFAULT NULL,
  `pg3_gest28` varchar(6) DEFAULT NULL,
  `pg3_ht28` varchar(6) DEFAULT NULL,
  `pg3_wt28` varchar(6) DEFAULT NULL,
  `pg3_presn28` varchar(6) DEFAULT NULL,
  `pg3_FHR28` varchar(6) DEFAULT NULL,
  `pg3_urinePr28` char(3) DEFAULT NULL,
  `pg3_urineGl28` char(3) DEFAULT NULL,
  `pg3_BP28` varchar(8) DEFAULT NULL,
  `pg3_comments28` varchar(255) DEFAULT NULL,
  `pg3_date29` date DEFAULT NULL,
  `pg3_gest29` varchar(6) DEFAULT NULL,
  `pg3_ht29` varchar(6) DEFAULT NULL,
  `pg3_wt29` varchar(6) DEFAULT NULL,
  `pg3_presn29` varchar(6) DEFAULT NULL,
  `pg3_FHR29` varchar(6) DEFAULT NULL,
  `pg3_urinePr29` char(3) DEFAULT NULL,
  `pg3_urineGl29` char(3) DEFAULT NULL,
  `pg3_BP29` varchar(8) DEFAULT NULL,
  `pg3_comments29` varchar(255) DEFAULT NULL,
  `pg3_date30` date DEFAULT NULL,
  `pg3_gest30` varchar(6) DEFAULT NULL,
  `pg3_ht30` varchar(6) DEFAULT NULL,
  `pg3_wt30` varchar(6) DEFAULT NULL,
  `pg3_presn30` varchar(6) DEFAULT NULL,
  `pg3_FHR30` varchar(6) DEFAULT NULL,
  `pg3_urinePr30` char(3) DEFAULT NULL,
  `pg3_urineGl30` char(3) DEFAULT NULL,
  `pg3_BP30` varchar(8) DEFAULT NULL,
  `pg3_comments30` varchar(255) DEFAULT NULL,
  `pg3_date31` date DEFAULT NULL,
  `pg3_gest31` varchar(6) DEFAULT NULL,
  `pg3_ht31` varchar(6) DEFAULT NULL,
  `pg3_wt31` varchar(6) DEFAULT NULL,
  `pg3_presn31` varchar(6) DEFAULT NULL,
  `pg3_FHR31` varchar(6) DEFAULT NULL,
  `pg3_urinePr31` char(3) DEFAULT NULL,
  `pg3_urineGl31` char(3) DEFAULT NULL,
  `pg3_BP31` varchar(8) DEFAULT NULL,
  `pg3_comments31` varchar(255) DEFAULT NULL,
  `pg3_date32` date DEFAULT NULL,
  `pg3_gest32` varchar(6) DEFAULT NULL,
  `pg3_ht32` varchar(6) DEFAULT NULL,
  `pg3_wt32` varchar(6) DEFAULT NULL,
  `pg3_presn32` varchar(6) DEFAULT NULL,
  `pg3_FHR32` varchar(6) DEFAULT NULL,
  `pg3_urinePr32` char(3) DEFAULT NULL,
  `pg3_urineGl32` char(3) DEFAULT NULL,
  `pg3_BP32` varchar(8) DEFAULT NULL,
  `pg3_comments32` varchar(255) DEFAULT NULL,
  `pg3_date33` date DEFAULT NULL,
  `pg3_gest33` varchar(6) DEFAULT NULL,
  `pg3_ht33` varchar(6) DEFAULT NULL,
  `pg3_wt33` varchar(6) DEFAULT NULL,
  `pg3_presn33` varchar(6) DEFAULT NULL,
  `pg3_FHR33` varchar(6) DEFAULT NULL,
  `pg3_urinePr33` char(3) DEFAULT NULL,
  `pg3_urineGl33` char(3) DEFAULT NULL,
  `pg3_BP33` varchar(8) DEFAULT NULL,
  `pg3_comments33` varchar(255) DEFAULT NULL,
  `pg3_date34` date DEFAULT NULL,
  `pg3_gest34` varchar(6) DEFAULT NULL,
  `pg3_ht34` varchar(6) DEFAULT NULL,
  `pg3_wt34` varchar(6) DEFAULT NULL,
  `pg3_presn34` varchar(6) DEFAULT NULL,
  `pg3_FHR34` varchar(6) DEFAULT NULL,
  `pg3_urinePr34` char(3) DEFAULT NULL,
  `pg3_urineGl34` char(3) DEFAULT NULL,
  `pg3_BP34` varchar(8) DEFAULT NULL,
  `pg3_comments34` varchar(255) DEFAULT NULL,
  `pg3_date35` date DEFAULT NULL,
  `pg3_gest35` varchar(6) DEFAULT NULL,
  `pg3_ht35` varchar(6) DEFAULT NULL,
  `pg3_wt35` varchar(6) DEFAULT NULL,
  `pg3_presn35` varchar(6) DEFAULT NULL,
  `pg3_FHR35` varchar(6) DEFAULT NULL,
  `pg3_urinePr35` char(3) DEFAULT NULL,
  `pg3_urineGl35` char(3) DEFAULT NULL,
  `pg3_BP35` varchar(8) DEFAULT NULL,
  `pg3_comments35` varchar(255) DEFAULT NULL,
  `pg3_date36` date DEFAULT NULL,
  `pg3_gest36` varchar(6) DEFAULT NULL,
  `pg3_ht36` varchar(6) DEFAULT NULL,
  `pg3_wt36` varchar(6) DEFAULT NULL,
  `pg3_presn36` varchar(6) DEFAULT NULL,
  `pg3_FHR36` varchar(6) DEFAULT NULL,
  `pg3_urinePr36` char(3) DEFAULT NULL,
  `pg3_urineGl36` char(3) DEFAULT NULL,
  `pg3_BP36` varchar(8) DEFAULT NULL,
  `pg3_comments36` varchar(255) DEFAULT NULL,
  `pg4_date37` date DEFAULT NULL,
  `pg4_gest37` varchar(6) DEFAULT NULL,
  `pg4_ht37` varchar(6) DEFAULT NULL,
  `pg4_wt37` varchar(6) DEFAULT NULL,
  `pg4_presn37` varchar(6) DEFAULT NULL,
  `pg4_FHR37` varchar(6) DEFAULT NULL,
  `pg4_urinePr37` char(3) DEFAULT NULL,
  `pg4_urineGl37` char(3) DEFAULT NULL,
  `pg4_BP37` varchar(8) DEFAULT NULL,
  `pg4_comments37` varchar(255) DEFAULT NULL,
  `pg4_date38` date DEFAULT NULL,
  `pg4_gest38` varchar(6) DEFAULT NULL,
  `pg4_ht38` varchar(6) DEFAULT NULL,
  `pg4_wt38` varchar(6) DEFAULT NULL,
  `pg4_presn38` varchar(6) DEFAULT NULL,
  `pg4_FHR38` varchar(6) DEFAULT NULL,
  `pg4_urinePr38` char(3) DEFAULT NULL,
  `pg4_urineGl38` char(3) DEFAULT NULL,
  `pg4_BP38` varchar(8) DEFAULT NULL,
  `pg4_comments38` varchar(255) DEFAULT NULL,
  `pg4_date39` date DEFAULT NULL,
  `pg4_gest39` varchar(6) DEFAULT NULL,
  `pg4_ht39` varchar(6) DEFAULT NULL,
  `pg4_wt39` varchar(6) DEFAULT NULL,
  `pg4_presn39` varchar(6) DEFAULT NULL,
  `pg4_FHR39` varchar(6) DEFAULT NULL,
  `pg4_urinePr39` char(3) DEFAULT NULL,
  `pg4_urineGl39` char(3) DEFAULT NULL,
  `pg4_BP39` varchar(8) DEFAULT NULL,
  `pg4_comments39` varchar(255) DEFAULT NULL,
  `pg4_date40` date DEFAULT NULL,
  `pg4_gest40` varchar(6) DEFAULT NULL,
  `pg4_ht40` varchar(6) DEFAULT NULL,
  `pg4_wt40` varchar(6) DEFAULT NULL,
  `pg4_presn40` varchar(6) DEFAULT NULL,
  `pg4_FHR40` varchar(6) DEFAULT NULL,
  `pg4_urinePr40` char(3) DEFAULT NULL,
  `pg4_urineGl40` char(3) DEFAULT NULL,
  `pg4_BP40` varchar(8) DEFAULT NULL,
  `pg4_comments40` varchar(255) DEFAULT NULL,
  `pg4_date41` date DEFAULT NULL,
  `pg4_gest41` varchar(6) DEFAULT NULL,
  `pg4_ht41` varchar(6) DEFAULT NULL,
  `pg4_wt41` varchar(6) DEFAULT NULL,
  `pg4_presn41` varchar(6) DEFAULT NULL,
  `pg4_FHR41` varchar(6) DEFAULT NULL,
  `pg4_urinePr41` char(3) DEFAULT NULL,
  `pg4_urineGl41` char(3) DEFAULT NULL,
  `pg4_BP41` varchar(8) DEFAULT NULL,
  `pg4_comments41` varchar(255) DEFAULT NULL,
  `pg4_date42` date DEFAULT NULL,
  `pg4_gest42` varchar(6) DEFAULT NULL,
  `pg4_ht42` varchar(6) DEFAULT NULL,
  `pg4_wt42` varchar(6) DEFAULT NULL,
  `pg4_presn42` varchar(6) DEFAULT NULL,
  `pg4_FHR42` varchar(6) DEFAULT NULL,
  `pg4_urinePr42` char(3) DEFAULT NULL,
  `pg4_urineGl42` char(3) DEFAULT NULL,
  `pg4_BP42` varchar(8) DEFAULT NULL,
  `pg4_comments42` varchar(255) DEFAULT NULL,
  `pg4_date43` date DEFAULT NULL,
  `pg4_gest43` varchar(6) DEFAULT NULL,
  `pg4_ht43` varchar(6) DEFAULT NULL,
  `pg4_wt43` varchar(6) DEFAULT NULL,
  `pg4_presn43` varchar(6) DEFAULT NULL,
  `pg4_FHR43` varchar(6) DEFAULT NULL,
  `pg4_urinePr43` char(3) DEFAULT NULL,
  `pg4_urineGl43` char(3) DEFAULT NULL,
  `pg4_BP43` varchar(8) DEFAULT NULL,
  `pg4_comments43` varchar(255) DEFAULT NULL,
  `pg4_date44` date DEFAULT NULL,
  `pg4_gest44` varchar(6) DEFAULT NULL,
  `pg4_ht44` varchar(6) DEFAULT NULL,
  `pg4_wt44` varchar(6) DEFAULT NULL,
  `pg4_presn44` varchar(6) DEFAULT NULL,
  `pg4_FHR44` varchar(6) DEFAULT NULL,
  `pg4_urinePr44` char(3) DEFAULT NULL,
  `pg4_urineGl44` char(3) DEFAULT NULL,
  `pg4_BP44` varchar(8) DEFAULT NULL,
  `pg4_comments44` varchar(255) DEFAULT NULL,
  `pg4_date45` date DEFAULT NULL,
  `pg4_gest45` varchar(6) DEFAULT NULL,
  `pg4_ht45` varchar(6) DEFAULT NULL,
  `pg4_wt45` varchar(6) DEFAULT NULL,
  `pg4_presn45` varchar(6) DEFAULT NULL,
  `pg4_FHR45` varchar(6) DEFAULT NULL,
  `pg4_urinePr45` char(3) DEFAULT NULL,
  `pg4_urineGl45` char(3) DEFAULT NULL,
  `pg4_BP45` varchar(8) DEFAULT NULL,
  `pg4_comments45` varchar(255) DEFAULT NULL,
  `pg4_date46` date DEFAULT NULL,
  `pg4_gest46` varchar(6) DEFAULT NULL,
  `pg4_ht46` varchar(6) DEFAULT NULL,
  `pg4_wt46` varchar(6) DEFAULT NULL,
  `pg4_presn46` varchar(6) DEFAULT NULL,
  `pg4_FHR46` varchar(6) DEFAULT NULL,
  `pg4_urinePr46` char(3) DEFAULT NULL,
  `pg4_urineGl46` char(3) DEFAULT NULL,
  `pg4_BP46` varchar(8) DEFAULT NULL,
  `pg4_comments46` varchar(255) DEFAULT NULL,
  `pg4_date47` date DEFAULT NULL,
  `pg4_gest47` varchar(6) DEFAULT NULL,
  `pg4_ht47` varchar(6) DEFAULT NULL,
  `pg4_wt47` varchar(6) DEFAULT NULL,
  `pg4_presn47` varchar(6) DEFAULT NULL,
  `pg4_FHR47` varchar(6) DEFAULT NULL,
  `pg4_urinePr47` char(3) DEFAULT NULL,
  `pg4_urineGl47` char(3) DEFAULT NULL,
  `pg4_BP47` varchar(8) DEFAULT NULL,
  `pg4_comments47` varchar(255) DEFAULT NULL,
  `pg4_date48` date DEFAULT NULL,
  `pg4_gest48` varchar(6) DEFAULT NULL,
  `pg4_ht48` varchar(6) DEFAULT NULL,
  `pg4_wt48` varchar(6) DEFAULT NULL,
  `pg4_presn48` varchar(6) DEFAULT NULL,
  `pg4_FHR48` varchar(6) DEFAULT NULL,
  `pg4_urinePr48` char(3) DEFAULT NULL,
  `pg4_urineGl48` char(3) DEFAULT NULL,
  `pg4_BP48` varchar(8) DEFAULT NULL,
  `pg4_comments48` varchar(255) DEFAULT NULL,
  `pg4_date49` date DEFAULT NULL,
  `pg4_gest49` varchar(6) DEFAULT NULL,
  `pg4_ht49` varchar(6) DEFAULT NULL,
  `pg4_wt49` varchar(6) DEFAULT NULL,
  `pg4_presn49` varchar(6) DEFAULT NULL,
  `pg4_FHR49` varchar(6) DEFAULT NULL,
  `pg4_urinePr49` char(3) DEFAULT NULL,
  `pg4_urineGl49` char(3) DEFAULT NULL,
  `pg4_BP49` varchar(8) DEFAULT NULL,
  `pg4_comments49` varchar(255) DEFAULT NULL,
  `pg4_date50` date DEFAULT NULL,
  `pg4_gest50` varchar(6) DEFAULT NULL,
  `pg4_ht50` varchar(6) DEFAULT NULL,
  `pg4_wt50` varchar(6) DEFAULT NULL,
  `pg4_presn50` varchar(6) DEFAULT NULL,
  `pg4_FHR50` varchar(6) DEFAULT NULL,
  `pg4_urinePr50` char(3) DEFAULT NULL,
  `pg4_urineGl50` char(3) DEFAULT NULL,
  `pg4_BP50` varchar(8) DEFAULT NULL,
  `pg4_comments50` varchar(255) DEFAULT NULL,
  `pg4_date51` date DEFAULT NULL,
  `pg4_gest51` varchar(6) DEFAULT NULL,
  `pg4_ht51` varchar(6) DEFAULT NULL,
  `pg4_wt51` varchar(6) DEFAULT NULL,
  `pg4_presn51` varchar(6) DEFAULT NULL,
  `pg4_FHR51` varchar(6) DEFAULT NULL,
  `pg4_urinePr51` char(3) DEFAULT NULL,
  `pg4_urineGl51` char(3) DEFAULT NULL,
  `pg4_BP51` varchar(8) DEFAULT NULL,
  `pg4_comments51` varchar(255) DEFAULT NULL,
  `pg4_date52` date DEFAULT NULL,
  `pg4_gest52` varchar(6) DEFAULT NULL,
  `pg4_ht52` varchar(6) DEFAULT NULL,
  `pg4_wt52` varchar(6) DEFAULT NULL,
  `pg4_presn52` varchar(6) DEFAULT NULL,
  `pg4_FHR52` varchar(6) DEFAULT NULL,
  `pg4_urinePr52` char(3) DEFAULT NULL,
  `pg4_urineGl52` char(3) DEFAULT NULL,
  `pg4_BP52` varchar(8) DEFAULT NULL,
  `pg4_comments52` varchar(255) DEFAULT NULL,
  `pg4_date53` date DEFAULT NULL,
  `pg4_gest53` varchar(6) DEFAULT NULL,
  `pg4_ht53` varchar(6) DEFAULT NULL,
  `pg4_wt53` varchar(6) DEFAULT NULL,
  `pg4_presn53` varchar(6) DEFAULT NULL,
  `pg4_FHR53` varchar(6) DEFAULT NULL,
  `pg4_urinePr53` char(3) DEFAULT NULL,
  `pg4_urineGl53` char(3) DEFAULT NULL,
  `pg4_BP53` varchar(8) DEFAULT NULL,
  `pg4_comments53` varchar(255) DEFAULT NULL,
  `pg4_date54` date DEFAULT NULL,
  `pg4_gest54` varchar(6) DEFAULT NULL,
  `pg4_ht54` varchar(6) DEFAULT NULL,
  `pg4_wt54` varchar(6) DEFAULT NULL,
  `pg4_presn54` varchar(6) DEFAULT NULL,
  `pg4_FHR54` varchar(6) DEFAULT NULL,
  `pg4_urinePr54` char(3) DEFAULT NULL,
  `pg4_urineGl54` char(3) DEFAULT NULL,
  `pg4_BP54` varchar(8) DEFAULT NULL,
  `pg4_comments54` varchar(255) DEFAULT NULL,
  `ar2_uDate1` date DEFAULT NULL,
  `ar2_uGA1` varchar(10) DEFAULT NULL,
  `ar2_uResults1` varchar(50) DEFAULT NULL,
  `ar2_uDate2` date DEFAULT NULL,
  `ar2_uGA2` varchar(10) DEFAULT NULL,
  `ar2_uResults2` varchar(50) DEFAULT NULL,
  `ar2_uDate3` date DEFAULT NULL,
  `ar2_uGA3` varchar(10) DEFAULT NULL,
  `ar2_uResults3` varchar(50) DEFAULT NULL,
  `ar2_uDate4` date DEFAULT NULL,
  `ar2_uGA4` varchar(10) DEFAULT NULL,
  `ar2_uResults4` varchar(50) DEFAULT NULL,
  `ar2_hb` varchar(10) DEFAULT NULL,
  `ar2_bloodGroup` varchar(6) DEFAULT NULL,
  `ar2_rh` varchar(6) DEFAULT NULL,
  `ar2_labABS` varchar(10) DEFAULT NULL,
  `ar2_lab1GCT` varchar(10) DEFAULT NULL,
  `ar2_lab2GTT` varchar(10) DEFAULT NULL,
  `ar2_strep` varchar(10) DEFAULT NULL,
  `ar2_exercise` tinyint(1) DEFAULT NULL,
  `ar2_workPlan` tinyint(1) DEFAULT NULL,
  `ar2_intercourse` tinyint(1) DEFAULT NULL,
  `ar2_travel` tinyint(1) DEFAULT NULL,
  `ar2_prenatal` tinyint(1) DEFAULT NULL,
  `ar2_birth` tinyint(1) DEFAULT NULL,
  `ar2_onCall` tinyint(1) DEFAULT NULL,
  `ar2_preterm` tinyint(1) DEFAULT NULL,
  `ar2_prom` tinyint(1) DEFAULT NULL,
  `ar2_aph` tinyint(1) DEFAULT NULL,
  `ar2_fetal` tinyint(1) DEFAULT NULL,
  `ar2_admission` tinyint(1) DEFAULT NULL,
  `ar2_pain` tinyint(1) DEFAULT NULL,
  `ar2_labour` tinyint(1) DEFAULT NULL,
  `ar2_breast` tinyint(1) DEFAULT NULL,
  `ar2_circumcision` tinyint(1) DEFAULT NULL,
  `ar2_dischargePlan` tinyint(1) DEFAULT NULL,
  `ar2_car` tinyint(1) DEFAULT NULL,
  `ar2_depression` tinyint(1) DEFAULT NULL,
  `ar2_contraception` tinyint(1) DEFAULT NULL,
  `ar2_postpartumCare` tinyint(1) DEFAULT NULL,
  `pg2_signature` varchar(50) DEFAULT NULL,
  `pg2_formDate` date DEFAULT NULL,
  `pg2_signature2` varchar(50) DEFAULT NULL,
  `pg2_formDate2` date DEFAULT NULL,
  `pg3_signature` varchar(50) DEFAULT NULL,
  `pg3_formDate` date DEFAULT NULL,
  `pg3_signature2` varchar(50) DEFAULT NULL,
  `pg3_formDate2` date DEFAULT NULL,
  `pg4_signature` varchar(50) DEFAULT NULL,
  `pg4_formDate` date DEFAULT NULL,
  `pg4_signature2` varchar(50) DEFAULT NULL,
  `pg4_formDate2` date DEFAULT NULL,
  `pg1_labExtra1Name` varchar(20) DEFAULT NULL,
  `pg1_labExtra2Name` varchar(20) DEFAULT NULL,
  `pg1_labExtra3Name` varchar(20) DEFAULT NULL,
  `pg1_labExtra1Value` varchar(20) DEFAULT NULL,
  `pg1_labExtra2Value` varchar(20) DEFAULT NULL,
  `pg1_labExtra3Value` varchar(20) DEFAULT NULL,
  `pg1_commentsAR1_2` text,
  `pg1_commentsAR1_3` text,
  `pg1_commentsAR1_4` text,
  `pg1_4ColCom` tinyint(1) DEFAULT NULL,
  `pg1_lockPage` tinyint(1) DEFAULT NULL,
  `pg2_labExtra1Name` varchar(20) DEFAULT NULL,
  `pg2_labExtra2Name` varchar(20) DEFAULT NULL,
  `pg2_labExtra3Name` varchar(20) DEFAULT NULL,
  `pg2_labExtra1Value` varchar(20) DEFAULT NULL,
  `pg2_labExtra2Value` varchar(20) DEFAULT NULL,
  `pg2_labExtra3Value` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formONAREnhanced`
--

DROP TABLE IF EXISTS `formONAREnhanced`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formONAREnhanced` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `episodeId` int(11) DEFAULT NULL,
  `sent_to_born` tinyint(1) DEFAULT '0',
  `obxhx_num` varchar(10) DEFAULT '0',
  `rf_num` varchar(10) DEFAULT '0',
  `sv_num` varchar(10) DEFAULT '0',
  `us_num` varchar(10) DEFAULT '0',
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_lastName` varchar(80) DEFAULT NULL,
  `c_firstName` varchar(80) DEFAULT NULL,
  `c_address` varchar(80) DEFAULT NULL,
  `c_apt` varchar(20) DEFAULT NULL,
  `c_city` varchar(80) DEFAULT NULL,
  `c_province` varchar(80) DEFAULT NULL,
  `c_postal` varchar(10) DEFAULT NULL,
  `c_partnerLastName` varchar(80) DEFAULT NULL,
  `c_partnerFirstName` varchar(80) DEFAULT NULL,
  `pg1_homePhone` varchar(20) DEFAULT NULL,
  `pg1_workPhone` varchar(20) DEFAULT NULL,
  `pg1_language` varchar(25) DEFAULT NULL,
  `pg1_partnerOccupation` varchar(25) DEFAULT NULL,
  `c_partnerOccupationOther` varchar(255) DEFAULT NULL,
  `pg1_partnerEduLevel` varchar(25) DEFAULT NULL,
  `pg1_partnerAge` varchar(5) DEFAULT NULL,
  `pg1_dateOfBirth` date DEFAULT NULL,
  `pg1_age` varchar(10) DEFAULT NULL,
  `pg1_occupation` varchar(25) DEFAULT NULL,
  `pg1_occupationOther` varchar(255) DEFAULT NULL,
  `pg1_eduLevel` varchar(25) DEFAULT NULL,
  `pg1_ethnicBgMother` varchar(200) DEFAULT NULL,
  `pg1_ethnicBgFather` varchar(200) DEFAULT NULL,
  `c_hin` varchar(20) DEFAULT NULL,
  `c_hinType` varchar(20) DEFAULT NULL,
  `c_fileNo` varchar(20) DEFAULT NULL,
  `pg1_maritalStatus` varchar(20) DEFAULT NULL,
  `pg1_msSingle` tinyint(1) DEFAULT NULL,
  `pg1_msCommonLaw` tinyint(1) DEFAULT NULL,
  `pg1_msMarried` tinyint(1) DEFAULT NULL,
  `pg1_baObs` tinyint(1) DEFAULT NULL,
  `pg1_baFP` tinyint(1) DEFAULT NULL,
  `pg1_baMidwife` tinyint(1) DEFAULT NULL,
  `c_ba` varchar(25) DEFAULT NULL,
  `pg1_ncPed` tinyint(1) DEFAULT NULL,
  `pg1_ncFP` tinyint(1) DEFAULT NULL,
  `pg1_ncMidwife` tinyint(1) DEFAULT NULL,
  `c_nc` varchar(25) DEFAULT NULL,
  `c_famPhys` varchar(80) DEFAULT NULL,
  `c_allergies` text,
  `c_meds` text,
  `pg1_menLMP` date DEFAULT NULL,
  `pg1_psCertY` tinyint(1) DEFAULT NULL,
  `pg1_psCertN` tinyint(1) DEFAULT NULL,
  `pg1_menCycle` varchar(7) DEFAULT NULL,
  `pg1_menReg` tinyint(1) DEFAULT NULL,
  `pg1_menRegN` tinyint(1) DEFAULT NULL,
  `pg1_contracep` varchar(25) DEFAULT NULL,
  `pg1_lastUsed` date DEFAULT NULL,
  `pg1_menEDB` date DEFAULT NULL,
  `c_finalEDB` date DEFAULT NULL,
  `pg1_edbByDate` tinyint(1) DEFAULT NULL,
  `pg1_edbByT1` tinyint(1) DEFAULT NULL,
  `pg1_edbByT2` tinyint(1) DEFAULT NULL,
  `pg1_edbByART` tinyint(1) DEFAULT NULL,
  `c_gravida` varchar(3) DEFAULT NULL,
  `c_term` varchar(3) DEFAULT NULL,
  `c_prem` varchar(3) DEFAULT NULL,
  `c_abort` varchar(3) DEFAULT NULL,
  `c_living` varchar(3) DEFAULT NULL,
  `pg1_year1` varchar(10) DEFAULT NULL,
  `pg1_sex1` char(1) DEFAULT NULL,
  `pg1_oh_gest1` varchar(5) DEFAULT NULL,
  `pg1_weight1` varchar(6) DEFAULT NULL,
  `pg1_length1` varchar(6) DEFAULT NULL,
  `pg1_place1` varchar(20) DEFAULT NULL,
  `pg1_svb1` tinyint(1) DEFAULT NULL,
  `pg1_cs1` tinyint(1) DEFAULT NULL,
  `pg1_ass1` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments1` varchar(80) DEFAULT NULL,
  `pg1_year2` varchar(10) DEFAULT NULL,
  `pg1_sex2` char(1) DEFAULT NULL,
  `pg1_oh_gest2` varchar(5) DEFAULT NULL,
  `pg1_weight2` varchar(6) DEFAULT NULL,
  `pg1_length2` varchar(6) DEFAULT NULL,
  `pg1_place2` varchar(20) DEFAULT NULL,
  `pg1_svb2` tinyint(1) DEFAULT NULL,
  `pg1_cs2` tinyint(1) DEFAULT NULL,
  `pg1_ass2` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments2` varchar(80) DEFAULT NULL,
  `pg1_year3` varchar(10) DEFAULT NULL,
  `pg1_sex3` char(1) DEFAULT NULL,
  `pg1_oh_gest3` varchar(5) DEFAULT NULL,
  `pg1_weight3` varchar(6) DEFAULT NULL,
  `pg1_length3` varchar(6) DEFAULT NULL,
  `pg1_place3` varchar(20) DEFAULT NULL,
  `pg1_svb3` tinyint(1) DEFAULT NULL,
  `pg1_cs3` tinyint(1) DEFAULT NULL,
  `pg1_ass3` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments3` varchar(80) DEFAULT NULL,
  `pg1_year4` varchar(10) DEFAULT NULL,
  `pg1_sex4` char(1) DEFAULT NULL,
  `pg1_oh_gest4` varchar(5) DEFAULT NULL,
  `pg1_weight4` varchar(6) DEFAULT NULL,
  `pg1_length4` varchar(6) DEFAULT NULL,
  `pg1_place4` varchar(20) DEFAULT NULL,
  `pg1_svb4` tinyint(1) DEFAULT NULL,
  `pg1_cs4` tinyint(1) DEFAULT NULL,
  `pg1_ass4` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments4` varchar(80) DEFAULT NULL,
  `pg1_year5` varchar(10) DEFAULT NULL,
  `pg1_sex5` char(1) DEFAULT NULL,
  `pg1_oh_gest5` varchar(5) DEFAULT NULL,
  `pg1_weight5` varchar(6) DEFAULT NULL,
  `pg1_length5` varchar(6) DEFAULT NULL,
  `pg1_place5` varchar(20) DEFAULT NULL,
  `pg1_svb5` tinyint(1) DEFAULT NULL,
  `pg1_cs5` tinyint(1) DEFAULT NULL,
  `pg1_ass5` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments5` varchar(80) DEFAULT NULL,
  `pg1_year6` varchar(10) DEFAULT NULL,
  `pg1_sex6` char(1) DEFAULT NULL,
  `pg1_oh_gest6` varchar(5) DEFAULT NULL,
  `pg1_weight6` varchar(6) DEFAULT NULL,
  `pg1_length6` varchar(6) DEFAULT NULL,
  `pg1_place6` varchar(20) DEFAULT NULL,
  `pg1_svb6` tinyint(1) DEFAULT NULL,
  `pg1_cs6` tinyint(1) DEFAULT NULL,
  `pg1_ass6` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments6` varchar(80) DEFAULT NULL,
  `pg1_year7` varchar(10) DEFAULT NULL,
  `pg1_sex7` char(1) DEFAULT NULL,
  `pg1_oh_gest7` varchar(5) DEFAULT NULL,
  `pg1_weight7` varchar(6) DEFAULT NULL,
  `pg1_length7` varchar(6) DEFAULT NULL,
  `pg1_place7` varchar(20) DEFAULT NULL,
  `pg1_svb7` tinyint(1) DEFAULT NULL,
  `pg1_cs7` tinyint(1) DEFAULT NULL,
  `pg1_ass7` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments7` varchar(80) DEFAULT NULL,
  `pg1_year8` varchar(10) DEFAULT NULL,
  `pg1_sex8` char(1) DEFAULT NULL,
  `pg1_oh_gest8` varchar(5) DEFAULT NULL,
  `pg1_weight8` varchar(6) DEFAULT NULL,
  `pg1_length8` varchar(6) DEFAULT NULL,
  `pg1_place8` varchar(20) DEFAULT NULL,
  `pg1_svb8` tinyint(1) DEFAULT NULL,
  `pg1_cs8` tinyint(1) DEFAULT NULL,
  `pg1_ass8` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments8` varchar(80) DEFAULT NULL,
  `pg1_year9` varchar(10) DEFAULT NULL,
  `pg1_sex9` char(1) DEFAULT NULL,
  `pg1_oh_gest9` varchar(5) DEFAULT NULL,
  `pg1_weight9` varchar(6) DEFAULT NULL,
  `pg1_length9` varchar(6) DEFAULT NULL,
  `pg1_place9` varchar(20) DEFAULT NULL,
  `pg1_svb9` tinyint(1) DEFAULT NULL,
  `pg1_cs9` tinyint(1) DEFAULT NULL,
  `pg1_ass9` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments9` varchar(80) DEFAULT NULL,
  `pg1_year10` varchar(10) DEFAULT NULL,
  `pg1_sex10` char(1) DEFAULT NULL,
  `pg1_oh_gest10` varchar(5) DEFAULT NULL,
  `pg1_weight10` varchar(6) DEFAULT NULL,
  `pg1_length10` varchar(6) DEFAULT NULL,
  `pg1_place10` varchar(20) DEFAULT NULL,
  `pg1_svb10` tinyint(1) DEFAULT NULL,
  `pg1_cs10` tinyint(1) DEFAULT NULL,
  `pg1_ass10` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments10` varchar(80) DEFAULT NULL,
  `pg1_year11` varchar(10) DEFAULT NULL,
  `pg1_sex11` char(1) DEFAULT NULL,
  `pg1_oh_gest11` varchar(5) DEFAULT NULL,
  `pg1_weight11` varchar(6) DEFAULT NULL,
  `pg1_length11` varchar(6) DEFAULT NULL,
  `pg1_place11` varchar(20) DEFAULT NULL,
  `pg1_svb11` tinyint(1) DEFAULT NULL,
  `pg1_cs11` tinyint(1) DEFAULT NULL,
  `pg1_ass11` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments11` varchar(80) DEFAULT NULL,
  `pg1_year12` varchar(10) DEFAULT NULL,
  `pg1_sex12` char(1) DEFAULT NULL,
  `pg1_oh_gest12` varchar(5) DEFAULT NULL,
  `pg1_weight12` varchar(6) DEFAULT NULL,
  `pg1_length12` varchar(6) DEFAULT NULL,
  `pg1_place12` varchar(20) DEFAULT NULL,
  `pg1_svb12` tinyint(1) DEFAULT NULL,
  `pg1_cs12` tinyint(1) DEFAULT NULL,
  `pg1_ass12` tinyint(1) DEFAULT NULL,
  `pg1_oh_comments12` text,
  `pg1_cp1` tinyint(1) DEFAULT NULL,
  `pg1_cp1N` tinyint(1) DEFAULT NULL,
  `pg1_cp2` tinyint(1) DEFAULT NULL,
  `pg1_cp2N` tinyint(1) DEFAULT NULL,
  `pg1_box3` varchar(10) DEFAULT NULL,
  `pg1_cp3` tinyint(1) DEFAULT NULL,
  `pg1_cp3N` tinyint(1) DEFAULT NULL,
  `pg1_cp4` tinyint(1) DEFAULT NULL,
  `pg1_cp4N` tinyint(1) DEFAULT NULL,
  `pg1_cp8` tinyint(1) DEFAULT NULL,
  `pg1_cp8N` tinyint(1) DEFAULT NULL,
  `pg1_naDiet` tinyint(1) DEFAULT NULL,
  `pg1_naDietN` tinyint(1) DEFAULT NULL,
  `pg1_naMilk` tinyint(1) DEFAULT NULL,
  `pg1_naMilkN` tinyint(1) DEFAULT NULL,
  `pg1_naFolic` tinyint(1) DEFAULT NULL,
  `pg1_naFolicN` tinyint(1) DEFAULT NULL,
  `pg1_yes9` tinyint(1) DEFAULT NULL,
  `pg1_no9` tinyint(1) DEFAULT NULL,
  `pg1_yes10` tinyint(1) DEFAULT NULL,
  `pg1_no10` tinyint(1) DEFAULT NULL,
  `pg1_yes12` tinyint(1) DEFAULT NULL,
  `pg1_no12` tinyint(1) DEFAULT NULL,
  `pg1_yes13` tinyint(1) DEFAULT NULL,
  `pg1_no13` tinyint(1) DEFAULT NULL,
  `pg1_yes14` tinyint(1) DEFAULT NULL,
  `pg1_no14` tinyint(1) DEFAULT NULL,
  `pg1_yes17` tinyint(1) DEFAULT NULL,
  `pg1_no17` tinyint(1) DEFAULT NULL,
  `pg1_yes22` tinyint(1) DEFAULT NULL,
  `pg1_no22` tinyint(1) DEFAULT NULL,
  `pg1_yes20` tinyint(1) DEFAULT NULL,
  `pg1_no20` tinyint(1) DEFAULT NULL,
  `pg1_bloodTranY` tinyint(1) DEFAULT NULL,
  `pg1_bloodTranN` tinyint(1) DEFAULT NULL,
  `pg1_yes21` tinyint(1) DEFAULT NULL,
  `pg1_no21` tinyint(1) DEFAULT NULL,
  `pg1_yes24` tinyint(1) DEFAULT NULL,
  `pg1_no24` tinyint(1) DEFAULT NULL,
  `pg1_yes15` tinyint(1) DEFAULT NULL,
  `pg1_no15` tinyint(1) DEFAULT NULL,
  `pg1_box25` varchar(25) DEFAULT NULL,
  `pg1_yes25` tinyint(1) DEFAULT NULL,
  `pg1_no25` tinyint(1) DEFAULT NULL,
  `pg1_yes27` tinyint(1) DEFAULT NULL,
  `pg1_no27` tinyint(1) DEFAULT NULL,
  `pg1_yes31` tinyint(1) DEFAULT NULL,
  `pg1_no31` tinyint(1) DEFAULT NULL,
  `pg1_yes32` tinyint(1) DEFAULT NULL,
  `pg1_no32` tinyint(1) DEFAULT NULL,
  `pg1_yes34` tinyint(1) DEFAULT NULL,
  `pg1_no34` tinyint(1) DEFAULT NULL,
  `pg1_yes35` tinyint(1) DEFAULT NULL,
  `pg1_no35` tinyint(1) DEFAULT NULL,
  `pg1_idt40` tinyint(1) DEFAULT NULL,
  `pg1_idt40N` tinyint(1) DEFAULT NULL,
  `pg1_idt38` tinyint(1) DEFAULT NULL,
  `pg1_idt38N` tinyint(1) DEFAULT NULL,
  `pg1_idt42` tinyint(1) DEFAULT NULL,
  `pg1_idt42N` tinyint(1) DEFAULT NULL,
  `pg1_infectDisOther` varchar(20) DEFAULT NULL,
  `pg1_infectDisOtherY` tinyint(1) DEFAULT NULL,
  `pg1_infectDisOtherN` tinyint(1) DEFAULT NULL,
  `pg1_pdt43` tinyint(1) DEFAULT NULL,
  `pg1_pdt43N` tinyint(1) DEFAULT NULL,
  `pg1_pdt44` tinyint(1) DEFAULT NULL,
  `pg1_pdt44N` tinyint(1) DEFAULT NULL,
  `pg1_pdt45` tinyint(1) DEFAULT NULL,
  `pg1_pdt45N` tinyint(1) DEFAULT NULL,
  `pg1_pdt46` tinyint(1) DEFAULT NULL,
  `pg1_pdt46N` tinyint(1) DEFAULT NULL,
  `pg1_pdt47` tinyint(1) DEFAULT NULL,
  `pg1_pdt47N` tinyint(1) DEFAULT NULL,
  `pg1_pdt48` tinyint(1) DEFAULT NULL,
  `pg1_pdt48N` tinyint(1) DEFAULT NULL,
  `pg1_reliCultY` tinyint(1) DEFAULT NULL,
  `pg1_reliCultN` tinyint(1) DEFAULT NULL,
  `pg1_fhRiskY` tinyint(1) DEFAULT NULL,
  `pg1_fhRiskN` tinyint(1) DEFAULT NULL,
  `pg1_ht` varchar(6) DEFAULT NULL,
  `pg1_wt` varchar(6) DEFAULT NULL,
  `c_bmi` varchar(6) DEFAULT NULL,
  `pg1_BP` varchar(10) DEFAULT NULL,
  `pg1_thyroid` tinyint(1) DEFAULT NULL,
  `pg1_thyroidA` tinyint(1) DEFAULT NULL,
  `pg1_chest` tinyint(1) DEFAULT NULL,
  `pg1_chestA` tinyint(1) DEFAULT NULL,
  `pg1_breasts` tinyint(1) DEFAULT NULL,
  `pg1_breastsA` tinyint(1) DEFAULT NULL,
  `pg1_cardio` tinyint(1) DEFAULT NULL,
  `pg1_cardioA` tinyint(1) DEFAULT NULL,
  `pg1_abdomen` tinyint(1) DEFAULT NULL,
  `pg1_abdomenA` tinyint(1) DEFAULT NULL,
  `pg1_vari` tinyint(1) DEFAULT NULL,
  `pg1_variA` tinyint(1) DEFAULT NULL,
  `pg1_extGen` tinyint(1) DEFAULT NULL,
  `pg1_extGenA` tinyint(1) DEFAULT NULL,
  `pg1_cervix` tinyint(1) DEFAULT NULL,
  `pg1_cervixA` tinyint(1) DEFAULT NULL,
  `pg1_uterus` tinyint(1) DEFAULT NULL,
  `pg1_uterusA` tinyint(1) DEFAULT NULL,
  `pg1_uterusBox` varchar(3) DEFAULT NULL,
  `pg1_adnexa` tinyint(1) DEFAULT NULL,
  `pg1_adnexaA` tinyint(1) DEFAULT NULL,
  `pg1_pExOtherDesc` varchar(20) DEFAULT NULL,
  `pg1_pExOther` tinyint(1) DEFAULT NULL,
  `pg1_pExOtherA` tinyint(1) DEFAULT NULL,
  `pg1_labHb` varchar(20) DEFAULT NULL,
  `pg1_labHIV` varchar(20) DEFAULT NULL,
  `pg1_labMCV` varchar(20) DEFAULT NULL,
  `pg1_labHIVCounsel` tinyint(1) DEFAULT NULL,
  `pg1_labABO` varchar(20) DEFAULT NULL,
  `pg1_labLastPapDate` varchar(10) DEFAULT NULL,
  `pg1_labLastPap` varchar(20) DEFAULT NULL,
  `pg1_labCustom1Label` varchar(40) DEFAULT NULL,
  `pg1_labCustom1Result` varchar(40) DEFAULT NULL,
  `pg1_labCustom2Label` varchar(40) DEFAULT NULL,
  `pg1_labCustom2Result` varchar(40) DEFAULT NULL,
  `pg1_labCustom3Label` varchar(40) DEFAULT NULL,
  `pg1_labCustom3Result` varchar(40) DEFAULT NULL,
  `pg1_labCustom4Label` varchar(40) DEFAULT NULL,
  `pg1_labCustom4Result` varchar(40) DEFAULT NULL,
  `pg1_labRh` varchar(20) DEFAULT NULL,
  `pg1_labAntiScr` varchar(20) DEFAULT NULL,
  `pg1_labGC` varchar(20) DEFAULT NULL,
  `pg1_labChlamydia` varchar(20) DEFAULT NULL,
  `pg1_labRubella` varchar(20) DEFAULT NULL,
  `pg1_labUrine` varchar(20) DEFAULT NULL,
  `pg1_labHBsAg` varchar(20) DEFAULT NULL,
  `pg1_labVDRL` varchar(20) DEFAULT NULL,
  `pg1_labSickle` varchar(20) DEFAULT NULL,
  `pg1_geneticA` varchar(20) DEFAULT NULL,
  `pg1_geneticB` varchar(20) DEFAULT NULL,
  `pg1_geneticC` varchar(20) DEFAULT NULL,
  `pg1_geneticD` varchar(20) DEFAULT NULL,
  `pg1_geneticD1` tinyint(1) DEFAULT NULL,
  `pg1_geneticD2` tinyint(1) DEFAULT NULL,
  `pg1_commentsAR1` text,
  `pg1_comments2AR1` text,
  `pg1_signature` varchar(50) DEFAULT NULL,
  `pg1_formDate` date DEFAULT NULL,
  `pg1_signature2` varchar(50) DEFAULT NULL,
  `pg1_formDate2` date DEFAULT NULL,
  `c_riskFactors1` varchar(50) DEFAULT NULL,
  `c_planManage1` varchar(100) DEFAULT NULL,
  `c_riskFactors2` varchar(50) DEFAULT NULL,
  `c_planManage2` varchar(100) DEFAULT NULL,
  `c_riskFactors3` varchar(50) DEFAULT NULL,
  `c_planManage3` varchar(100) DEFAULT NULL,
  `c_riskFactors4` varchar(50) DEFAULT NULL,
  `c_planManage4` varchar(100) DEFAULT NULL,
  `c_riskFactors5` varchar(50) DEFAULT NULL,
  `c_planManage5` varchar(100) DEFAULT NULL,
  `c_riskFactors6` varchar(50) DEFAULT NULL,
  `c_planManage6` varchar(100) DEFAULT NULL,
  `c_riskFactors7` varchar(50) DEFAULT NULL,
  `c_planManage7` varchar(100) DEFAULT NULL,
  `c_riskFactors8` varchar(50) DEFAULT NULL,
  `c_planManage8` varchar(100) DEFAULT NULL,
  `c_riskFactors9` varchar(50) DEFAULT NULL,
  `c_planManage9` varchar(100) DEFAULT NULL,
  `c_riskFactors10` varchar(50) DEFAULT NULL,
  `c_planManage10` varchar(100) DEFAULT NULL,
  `c_riskFactors11` varchar(50) DEFAULT NULL,
  `c_planManage11` varchar(100) DEFAULT NULL,
  `c_riskFactors12` varchar(50) DEFAULT NULL,
  `c_planManage12` varchar(100) DEFAULT NULL,
  `c_riskFactors13` varchar(50) DEFAULT NULL,
  `c_planManage13` varchar(100) DEFAULT NULL,
  `c_riskFactors14` varchar(50) DEFAULT NULL,
  `c_planManage14` varchar(100) DEFAULT NULL,
  `c_riskFactors15` varchar(50) DEFAULT NULL,
  `c_planManage15` varchar(100) DEFAULT NULL,
  `c_riskFactors16` varchar(50) DEFAULT NULL,
  `c_planManage16` varchar(100) DEFAULT NULL,
  `c_riskFactors17` varchar(50) DEFAULT NULL,
  `c_planManage17` varchar(100) DEFAULT NULL,
  `c_riskFactors18` varchar(50) DEFAULT NULL,
  `c_planManage18` varchar(100) DEFAULT NULL,
  `c_riskFactors19` varchar(50) DEFAULT NULL,
  `c_planManage19` varchar(100) DEFAULT NULL,
  `c_riskFactors20` varchar(50) DEFAULT NULL,
  `c_planManage20` varchar(100) DEFAULT NULL,
  `ar2_rhNeg` tinyint(1) DEFAULT NULL,
  `ar2_rhIG` varchar(10) DEFAULT NULL,
  `ar2_rubella` tinyint(1) DEFAULT NULL,
  `ar2_hepBIG` tinyint(1) DEFAULT NULL,
  `ar2_hepBVac` tinyint(1) DEFAULT NULL,
  `pg2_date1` date DEFAULT NULL,
  `pg2_gest1` varchar(6) DEFAULT NULL,
  `pg2_wt1` varchar(6) DEFAULT NULL,
  `pg2_BP1` varchar(8) DEFAULT NULL,
  `pg2_urinePr1` char(3) DEFAULT NULL,
  `pg2_urineGl1` char(3) DEFAULT NULL,
  `pg2_ht1` varchar(6) DEFAULT NULL,
  `pg2_presn1` varchar(6) DEFAULT NULL,
  `pg2_FHR1` varchar(6) DEFAULT NULL,
  `pg2_comments1` varchar(255) DEFAULT NULL,
  `pg2_date2` date DEFAULT NULL,
  `pg2_gest2` varchar(6) DEFAULT NULL,
  `pg2_ht2` varchar(6) DEFAULT NULL,
  `pg2_wt2` varchar(6) DEFAULT NULL,
  `pg2_presn2` varchar(6) DEFAULT NULL,
  `pg2_FHR2` varchar(6) DEFAULT NULL,
  `pg2_urinePr2` char(3) DEFAULT NULL,
  `pg2_urineGl2` char(3) DEFAULT NULL,
  `pg2_BP2` varchar(8) DEFAULT NULL,
  `pg2_comments2` varchar(255) DEFAULT NULL,
  `pg2_date3` date DEFAULT NULL,
  `pg2_gest3` varchar(6) DEFAULT NULL,
  `pg2_ht3` varchar(6) DEFAULT NULL,
  `pg2_wt3` varchar(6) DEFAULT NULL,
  `pg2_presn3` varchar(6) DEFAULT NULL,
  `pg2_FHR3` varchar(6) DEFAULT NULL,
  `pg2_urinePr3` char(3) DEFAULT NULL,
  `pg2_urineGl3` char(3) DEFAULT NULL,
  `pg2_BP3` varchar(8) DEFAULT NULL,
  `pg2_comments3` varchar(255) DEFAULT NULL,
  `pg2_date4` date DEFAULT NULL,
  `pg2_gest4` varchar(6) DEFAULT NULL,
  `pg2_ht4` varchar(6) DEFAULT NULL,
  `pg2_wt4` varchar(6) DEFAULT NULL,
  `pg2_presn4` varchar(6) DEFAULT NULL,
  `pg2_FHR4` varchar(6) DEFAULT NULL,
  `pg2_urinePr4` char(3) DEFAULT NULL,
  `pg2_urineGl4` char(3) DEFAULT NULL,
  `pg2_BP4` varchar(8) DEFAULT NULL,
  `pg2_comments4` varchar(255) DEFAULT NULL,
  `pg2_date5` date DEFAULT NULL,
  `pg2_gest5` varchar(6) DEFAULT NULL,
  `pg2_ht5` varchar(6) DEFAULT NULL,
  `pg2_wt5` varchar(6) DEFAULT NULL,
  `pg2_presn5` varchar(6) DEFAULT NULL,
  `pg2_FHR5` varchar(6) DEFAULT NULL,
  `pg2_urinePr5` char(3) DEFAULT NULL,
  `pg2_urineGl5` char(3) DEFAULT NULL,
  `pg2_BP5` varchar(8) DEFAULT NULL,
  `pg2_comments5` varchar(255) DEFAULT NULL,
  `pg2_date6` date DEFAULT NULL,
  `pg2_gest6` varchar(6) DEFAULT NULL,
  `pg2_ht6` varchar(6) DEFAULT NULL,
  `pg2_wt6` varchar(6) DEFAULT NULL,
  `pg2_presn6` varchar(6) DEFAULT NULL,
  `pg2_FHR6` varchar(6) DEFAULT NULL,
  `pg2_urinePr6` char(3) DEFAULT NULL,
  `pg2_urineGl6` char(3) DEFAULT NULL,
  `pg2_BP6` varchar(8) DEFAULT NULL,
  `pg2_comments6` varchar(255) DEFAULT NULL,
  `pg2_date7` date DEFAULT NULL,
  `pg2_gest7` varchar(6) DEFAULT NULL,
  `pg2_ht7` varchar(6) DEFAULT NULL,
  `pg2_wt7` varchar(6) DEFAULT NULL,
  `pg2_presn7` varchar(6) DEFAULT NULL,
  `pg2_FHR7` varchar(6) DEFAULT NULL,
  `pg2_urinePr7` char(3) DEFAULT NULL,
  `pg2_urineGl7` char(3) DEFAULT NULL,
  `pg2_BP7` varchar(8) DEFAULT NULL,
  `pg2_comments7` varchar(255) DEFAULT NULL,
  `pg2_date8` date DEFAULT NULL,
  `pg2_gest8` varchar(6) DEFAULT NULL,
  `pg2_ht8` varchar(6) DEFAULT NULL,
  `pg2_wt8` varchar(6) DEFAULT NULL,
  `pg2_presn8` varchar(6) DEFAULT NULL,
  `pg2_FHR8` varchar(6) DEFAULT NULL,
  `pg2_urinePr8` char(3) DEFAULT NULL,
  `pg2_urineGl8` char(3) DEFAULT NULL,
  `pg2_BP8` varchar(8) DEFAULT NULL,
  `pg2_comments8` varchar(255) DEFAULT NULL,
  `pg2_date9` date DEFAULT NULL,
  `pg2_gest9` varchar(6) DEFAULT NULL,
  `pg2_ht9` varchar(6) DEFAULT NULL,
  `pg2_wt9` varchar(6) DEFAULT NULL,
  `pg2_presn9` varchar(6) DEFAULT NULL,
  `pg2_FHR9` varchar(6) DEFAULT NULL,
  `pg2_urinePr9` char(3) DEFAULT NULL,
  `pg2_urineGl9` char(3) DEFAULT NULL,
  `pg2_BP9` varchar(8) DEFAULT NULL,
  `pg2_comments9` varchar(255) DEFAULT NULL,
  `pg2_date10` date DEFAULT NULL,
  `pg2_gest10` varchar(6) DEFAULT NULL,
  `pg2_ht10` varchar(6) DEFAULT NULL,
  `pg2_wt10` varchar(6) DEFAULT NULL,
  `pg2_presn10` varchar(6) DEFAULT NULL,
  `pg2_FHR10` varchar(6) DEFAULT NULL,
  `pg2_urinePr10` char(3) DEFAULT NULL,
  `pg2_urineGl10` char(3) DEFAULT NULL,
  `pg2_BP10` varchar(8) DEFAULT NULL,
  `pg2_comments10` varchar(255) DEFAULT NULL,
  `pg2_date11` date DEFAULT NULL,
  `pg2_gest11` varchar(6) DEFAULT NULL,
  `pg2_ht11` varchar(6) DEFAULT NULL,
  `pg2_wt11` varchar(6) DEFAULT NULL,
  `pg2_presn11` varchar(6) DEFAULT NULL,
  `pg2_FHR11` varchar(6) DEFAULT NULL,
  `pg2_urinePr11` char(3) DEFAULT NULL,
  `pg2_urineGl11` char(3) DEFAULT NULL,
  `pg2_BP11` varchar(8) DEFAULT NULL,
  `pg2_comments11` varchar(255) DEFAULT NULL,
  `pg2_date12` date DEFAULT NULL,
  `pg2_gest12` varchar(6) DEFAULT NULL,
  `pg2_ht12` varchar(6) DEFAULT NULL,
  `pg2_wt12` varchar(6) DEFAULT NULL,
  `pg2_presn12` varchar(6) DEFAULT NULL,
  `pg2_FHR12` varchar(6) DEFAULT NULL,
  `pg2_urinePr12` char(3) DEFAULT NULL,
  `pg2_urineGl12` char(3) DEFAULT NULL,
  `pg2_BP12` varchar(8) DEFAULT NULL,
  `pg2_comments12` varchar(255) DEFAULT NULL,
  `pg2_date13` date DEFAULT NULL,
  `pg2_gest13` varchar(6) DEFAULT NULL,
  `pg2_ht13` varchar(6) DEFAULT NULL,
  `pg2_wt13` varchar(6) DEFAULT NULL,
  `pg2_presn13` varchar(6) DEFAULT NULL,
  `pg2_FHR13` varchar(6) DEFAULT NULL,
  `pg2_urinePr13` char(3) DEFAULT NULL,
  `pg2_urineGl13` char(3) DEFAULT NULL,
  `pg2_BP13` varchar(8) DEFAULT NULL,
  `pg2_comments13` varchar(255) DEFAULT NULL,
  `pg2_date14` date DEFAULT NULL,
  `pg2_gest14` varchar(6) DEFAULT NULL,
  `pg2_ht14` varchar(6) DEFAULT NULL,
  `pg2_wt14` varchar(6) DEFAULT NULL,
  `pg2_presn14` varchar(6) DEFAULT NULL,
  `pg2_FHR14` varchar(6) DEFAULT NULL,
  `pg2_urinePr14` char(3) DEFAULT NULL,
  `pg2_urineGl14` char(3) DEFAULT NULL,
  `pg2_BP14` varchar(8) DEFAULT NULL,
  `pg2_comments14` varchar(255) DEFAULT NULL,
  `pg2_date15` date DEFAULT NULL,
  `pg2_gest15` varchar(6) DEFAULT NULL,
  `pg2_ht15` varchar(6) DEFAULT NULL,
  `pg2_wt15` varchar(6) DEFAULT NULL,
  `pg2_presn15` varchar(6) DEFAULT NULL,
  `pg2_FHR15` varchar(6) DEFAULT NULL,
  `pg2_urinePr15` char(3) DEFAULT NULL,
  `pg2_urineGl15` char(3) DEFAULT NULL,
  `pg2_BP15` varchar(8) DEFAULT NULL,
  `pg2_comments15` varchar(255) DEFAULT NULL,
  `pg2_date16` date DEFAULT NULL,
  `pg2_gest16` varchar(6) DEFAULT NULL,
  `pg2_ht16` varchar(6) DEFAULT NULL,
  `pg2_wt16` varchar(6) DEFAULT NULL,
  `pg2_presn16` varchar(6) DEFAULT NULL,
  `pg2_FHR16` varchar(6) DEFAULT NULL,
  `pg2_urinePr16` char(3) DEFAULT NULL,
  `pg2_urineGl16` char(3) DEFAULT NULL,
  `pg2_BP16` varchar(8) DEFAULT NULL,
  `pg2_comments16` varchar(255) DEFAULT NULL,
  `pg2_date17` date DEFAULT NULL,
  `pg2_gest17` varchar(6) DEFAULT NULL,
  `pg2_ht17` varchar(6) DEFAULT NULL,
  `pg2_wt17` varchar(6) DEFAULT NULL,
  `pg2_presn17` varchar(6) DEFAULT NULL,
  `pg2_FHR17` varchar(6) DEFAULT NULL,
  `pg2_urinePr17` char(3) DEFAULT NULL,
  `pg2_urineGl17` char(3) DEFAULT NULL,
  `pg2_BP17` varchar(8) DEFAULT NULL,
  `pg2_comments17` varchar(255) DEFAULT NULL,
  `pg2_date18` date DEFAULT NULL,
  `pg2_gest18` varchar(6) DEFAULT NULL,
  `pg2_ht18` varchar(6) DEFAULT NULL,
  `pg2_wt18` varchar(6) DEFAULT NULL,
  `pg2_presn18` varchar(6) DEFAULT NULL,
  `pg2_FHR18` varchar(6) DEFAULT NULL,
  `pg2_urinePr18` char(3) DEFAULT NULL,
  `pg2_urineGl18` char(3) DEFAULT NULL,
  `pg2_BP18` varchar(8) DEFAULT NULL,
  `pg2_comments18` varchar(255) DEFAULT NULL,
  `pg2_date19` date DEFAULT NULL,
  `pg2_gest19` varchar(6) DEFAULT NULL,
  `pg2_ht19` varchar(6) DEFAULT NULL,
  `pg2_wt19` varchar(6) DEFAULT NULL,
  `pg2_presn19` varchar(6) DEFAULT NULL,
  `pg2_FHR19` varchar(6) DEFAULT NULL,
  `pg2_urinePr19` char(3) DEFAULT NULL,
  `pg2_urineGl19` char(3) DEFAULT NULL,
  `pg2_BP19` varchar(8) DEFAULT NULL,
  `pg2_comments19` varchar(255) DEFAULT NULL,
  `pg2_date20` date DEFAULT NULL,
  `pg2_gest20` varchar(6) DEFAULT NULL,
  `pg2_ht20` varchar(6) DEFAULT NULL,
  `pg2_wt20` varchar(6) DEFAULT NULL,
  `pg2_presn20` varchar(6) DEFAULT NULL,
  `pg2_FHR20` varchar(6) DEFAULT NULL,
  `pg2_urinePr20` char(3) DEFAULT NULL,
  `pg2_urineGl20` char(3) DEFAULT NULL,
  `pg2_BP20` varchar(8) DEFAULT NULL,
  `pg2_comments20` varchar(255) DEFAULT NULL,
  `pg2_date21` date DEFAULT NULL,
  `pg2_gest21` varchar(6) DEFAULT NULL,
  `pg2_ht21` varchar(6) DEFAULT NULL,
  `pg2_wt21` varchar(6) DEFAULT NULL,
  `pg2_presn21` varchar(6) DEFAULT NULL,
  `pg2_FHR21` varchar(6) DEFAULT NULL,
  `pg2_urinePr21` char(3) DEFAULT NULL,
  `pg2_urineGl21` char(3) DEFAULT NULL,
  `pg2_BP21` varchar(8) DEFAULT NULL,
  `pg2_comments21` varchar(255) DEFAULT NULL,
  `pg2_date22` date DEFAULT NULL,
  `pg2_gest22` varchar(6) DEFAULT NULL,
  `pg2_ht22` varchar(6) DEFAULT NULL,
  `pg2_wt22` varchar(6) DEFAULT NULL,
  `pg2_presn22` varchar(6) DEFAULT NULL,
  `pg2_FHR22` varchar(6) DEFAULT NULL,
  `pg2_urinePr22` char(3) DEFAULT NULL,
  `pg2_urineGl22` char(3) DEFAULT NULL,
  `pg2_BP22` varchar(8) DEFAULT NULL,
  `pg2_comments22` varchar(255) DEFAULT NULL,
  `pg2_date23` date DEFAULT NULL,
  `pg2_gest23` varchar(6) DEFAULT NULL,
  `pg2_ht23` varchar(6) DEFAULT NULL,
  `pg2_wt23` varchar(6) DEFAULT NULL,
  `pg2_presn23` varchar(6) DEFAULT NULL,
  `pg2_FHR23` varchar(6) DEFAULT NULL,
  `pg2_urinePr23` char(3) DEFAULT NULL,
  `pg2_urineGl23` char(3) DEFAULT NULL,
  `pg2_BP23` varchar(8) DEFAULT NULL,
  `pg2_comments23` varchar(255) DEFAULT NULL,
  `pg2_date24` date DEFAULT NULL,
  `pg2_gest24` varchar(6) DEFAULT NULL,
  `pg2_ht24` varchar(6) DEFAULT NULL,
  `pg2_wt24` varchar(6) DEFAULT NULL,
  `pg2_presn24` varchar(6) DEFAULT NULL,
  `pg2_FHR24` varchar(6) DEFAULT NULL,
  `pg2_urinePr24` char(3) DEFAULT NULL,
  `pg2_urineGl24` char(3) DEFAULT NULL,
  `pg2_BP24` varchar(8) DEFAULT NULL,
  `pg2_comments24` varchar(255) DEFAULT NULL,
  `pg2_date25` date DEFAULT NULL,
  `pg2_gest25` varchar(6) DEFAULT NULL,
  `pg2_ht25` varchar(6) DEFAULT NULL,
  `pg2_wt25` varchar(6) DEFAULT NULL,
  `pg2_presn25` varchar(6) DEFAULT NULL,
  `pg2_FHR25` varchar(6) DEFAULT NULL,
  `pg2_urinePr25` char(3) DEFAULT NULL,
  `pg2_urineGl25` char(3) DEFAULT NULL,
  `pg2_BP25` varchar(8) DEFAULT NULL,
  `pg2_comments25` varchar(255) DEFAULT NULL,
  `pg2_date26` date DEFAULT NULL,
  `pg2_gest26` varchar(6) DEFAULT NULL,
  `pg2_ht26` varchar(6) DEFAULT NULL,
  `pg2_wt26` varchar(6) DEFAULT NULL,
  `pg2_presn26` varchar(6) DEFAULT NULL,
  `pg2_FHR26` varchar(6) DEFAULT NULL,
  `pg2_urinePr26` char(3) DEFAULT NULL,
  `pg2_urineGl26` char(3) DEFAULT NULL,
  `pg2_BP26` varchar(8) DEFAULT NULL,
  `pg2_comments26` varchar(255) DEFAULT NULL,
  `pg2_date27` date DEFAULT NULL,
  `pg2_gest27` varchar(6) DEFAULT NULL,
  `pg2_ht27` varchar(6) DEFAULT NULL,
  `pg2_wt27` varchar(6) DEFAULT NULL,
  `pg2_presn27` varchar(6) DEFAULT NULL,
  `pg2_FHR27` varchar(6) DEFAULT NULL,
  `pg2_urinePr27` char(3) DEFAULT NULL,
  `pg2_urineGl27` char(3) DEFAULT NULL,
  `pg2_BP27` varchar(8) DEFAULT NULL,
  `pg2_comments27` varchar(255) DEFAULT NULL,
  `pg2_date28` date DEFAULT NULL,
  `pg2_gest28` varchar(6) DEFAULT NULL,
  `pg2_ht28` varchar(6) DEFAULT NULL,
  `pg2_wt28` varchar(6) DEFAULT NULL,
  `pg2_presn28` varchar(6) DEFAULT NULL,
  `pg2_FHR28` varchar(6) DEFAULT NULL,
  `pg2_urinePr28` char(3) DEFAULT NULL,
  `pg2_urineGl28` char(3) DEFAULT NULL,
  `pg2_BP28` varchar(8) DEFAULT NULL,
  `pg2_comments28` varchar(255) DEFAULT NULL,
  `pg2_date29` date DEFAULT NULL,
  `pg2_gest29` varchar(6) DEFAULT NULL,
  `pg2_ht29` varchar(6) DEFAULT NULL,
  `pg2_wt29` varchar(6) DEFAULT NULL,
  `pg2_presn29` varchar(6) DEFAULT NULL,
  `pg2_FHR29` varchar(6) DEFAULT NULL,
  `pg2_urinePr29` char(3) DEFAULT NULL,
  `pg2_urineGl29` char(3) DEFAULT NULL,
  `pg2_BP29` varchar(8) DEFAULT NULL,
  `pg2_comments29` varchar(255) DEFAULT NULL,
  `pg2_date30` date DEFAULT NULL,
  `pg2_gest30` varchar(6) DEFAULT NULL,
  `pg2_ht30` varchar(6) DEFAULT NULL,
  `pg2_wt30` varchar(6) DEFAULT NULL,
  `pg2_presn30` varchar(6) DEFAULT NULL,
  `pg2_FHR30` varchar(6) DEFAULT NULL,
  `pg2_urinePr30` char(3) DEFAULT NULL,
  `pg2_urineGl30` char(3) DEFAULT NULL,
  `pg2_BP30` varchar(8) DEFAULT NULL,
  `pg2_comments30` varchar(255) DEFAULT NULL,
  `pg2_date31` date DEFAULT NULL,
  `pg2_gest31` varchar(6) DEFAULT NULL,
  `pg2_ht31` varchar(6) DEFAULT NULL,
  `pg2_wt31` varchar(6) DEFAULT NULL,
  `pg2_presn31` varchar(6) DEFAULT NULL,
  `pg2_FHR31` varchar(6) DEFAULT NULL,
  `pg2_urinePr31` char(3) DEFAULT NULL,
  `pg2_urineGl31` char(3) DEFAULT NULL,
  `pg2_BP31` varchar(8) DEFAULT NULL,
  `pg2_comments31` varchar(255) DEFAULT NULL,
  `pg2_date32` date DEFAULT NULL,
  `pg2_gest32` varchar(6) DEFAULT NULL,
  `pg2_ht32` varchar(6) DEFAULT NULL,
  `pg2_wt32` varchar(6) DEFAULT NULL,
  `pg2_presn32` varchar(6) DEFAULT NULL,
  `pg2_FHR32` varchar(6) DEFAULT NULL,
  `pg2_urinePr32` char(3) DEFAULT NULL,
  `pg2_urineGl32` char(3) DEFAULT NULL,
  `pg2_BP32` varchar(8) DEFAULT NULL,
  `pg2_comments32` varchar(255) DEFAULT NULL,
  `pg2_date33` date DEFAULT NULL,
  `pg2_gest33` varchar(6) DEFAULT NULL,
  `pg2_ht33` varchar(6) DEFAULT NULL,
  `pg2_wt33` varchar(6) DEFAULT NULL,
  `pg2_presn33` varchar(6) DEFAULT NULL,
  `pg2_FHR33` varchar(6) DEFAULT NULL,
  `pg2_urinePr33` char(3) DEFAULT NULL,
  `pg2_urineGl33` char(3) DEFAULT NULL,
  `pg2_BP33` varchar(8) DEFAULT NULL,
  `pg2_comments33` varchar(255) DEFAULT NULL,
  `pg2_date34` date DEFAULT NULL,
  `pg2_gest34` varchar(6) DEFAULT NULL,
  `pg2_ht34` varchar(6) DEFAULT NULL,
  `pg2_wt34` varchar(6) DEFAULT NULL,
  `pg2_presn34` varchar(6) DEFAULT NULL,
  `pg2_FHR34` varchar(6) DEFAULT NULL,
  `pg2_urinePr34` char(3) DEFAULT NULL,
  `pg2_urineGl34` char(3) DEFAULT NULL,
  `pg2_BP34` varchar(8) DEFAULT NULL,
  `pg2_comments34` varchar(255) DEFAULT NULL,
  `pg2_date35` date DEFAULT NULL,
  `pg2_gest35` varchar(6) DEFAULT NULL,
  `pg2_ht35` varchar(6) DEFAULT NULL,
  `pg2_wt35` varchar(6) DEFAULT NULL,
  `pg2_presn35` varchar(6) DEFAULT NULL,
  `pg2_FHR35` varchar(6) DEFAULT NULL,
  `pg2_urinePr35` char(3) DEFAULT NULL,
  `pg2_urineGl35` char(3) DEFAULT NULL,
  `pg2_BP35` varchar(8) DEFAULT NULL,
  `pg2_comments35` varchar(255) DEFAULT NULL,
  `pg2_date36` date DEFAULT NULL,
  `pg2_gest36` varchar(6) DEFAULT NULL,
  `pg2_ht36` varchar(6) DEFAULT NULL,
  `pg2_wt36` varchar(6) DEFAULT NULL,
  `pg2_presn36` varchar(6) DEFAULT NULL,
  `pg2_FHR36` varchar(6) DEFAULT NULL,
  `pg2_urinePr36` char(3) DEFAULT NULL,
  `pg2_urineGl36` char(3) DEFAULT NULL,
  `pg2_BP36` varchar(8) DEFAULT NULL,
  `pg2_comments36` varchar(255) DEFAULT NULL,
  `pg2_date37` date DEFAULT NULL,
  `pg2_gest37` varchar(6) DEFAULT NULL,
  `pg2_ht37` varchar(6) DEFAULT NULL,
  `pg2_wt37` varchar(6) DEFAULT NULL,
  `pg2_presn37` varchar(6) DEFAULT NULL,
  `pg2_FHR37` varchar(6) DEFAULT NULL,
  `pg2_urinePr37` char(3) DEFAULT NULL,
  `pg2_urineGl37` char(3) DEFAULT NULL,
  `pg2_BP37` varchar(8) DEFAULT NULL,
  `pg2_comments37` varchar(255) DEFAULT NULL,
  `pg2_date38` date DEFAULT NULL,
  `pg2_gest38` varchar(6) DEFAULT NULL,
  `pg2_ht38` varchar(6) DEFAULT NULL,
  `pg2_wt38` varchar(6) DEFAULT NULL,
  `pg2_presn38` varchar(6) DEFAULT NULL,
  `pg2_FHR38` varchar(6) DEFAULT NULL,
  `pg2_urinePr38` char(3) DEFAULT NULL,
  `pg2_urineGl38` char(3) DEFAULT NULL,
  `pg2_BP38` varchar(8) DEFAULT NULL,
  `pg2_comments38` varchar(255) DEFAULT NULL,
  `pg2_date39` date DEFAULT NULL,
  `pg2_gest39` varchar(6) DEFAULT NULL,
  `pg2_ht39` varchar(6) DEFAULT NULL,
  `pg2_wt39` varchar(6) DEFAULT NULL,
  `pg2_presn39` varchar(6) DEFAULT NULL,
  `pg2_FHR39` varchar(6) DEFAULT NULL,
  `pg2_urinePr39` char(3) DEFAULT NULL,
  `pg2_urineGl39` char(3) DEFAULT NULL,
  `pg2_BP39` varchar(8) DEFAULT NULL,
  `pg2_comments39` varchar(255) DEFAULT NULL,
  `pg2_date40` date DEFAULT NULL,
  `pg2_gest40` varchar(6) DEFAULT NULL,
  `pg2_ht40` varchar(6) DEFAULT NULL,
  `pg2_wt40` varchar(6) DEFAULT NULL,
  `pg2_presn40` varchar(6) DEFAULT NULL,
  `pg2_FHR40` varchar(6) DEFAULT NULL,
  `pg2_urinePr40` char(3) DEFAULT NULL,
  `pg2_urineGl40` char(3) DEFAULT NULL,
  `pg2_BP40` varchar(8) DEFAULT NULL,
  `pg2_comments40` varchar(255) DEFAULT NULL,
  `pg2_date41` date DEFAULT NULL,
  `pg2_gest41` varchar(6) DEFAULT NULL,
  `pg2_ht41` varchar(6) DEFAULT NULL,
  `pg2_wt41` varchar(6) DEFAULT NULL,
  `pg2_presn41` varchar(6) DEFAULT NULL,
  `pg2_FHR41` varchar(6) DEFAULT NULL,
  `pg2_urinePr41` char(3) DEFAULT NULL,
  `pg2_urineGl41` char(3) DEFAULT NULL,
  `pg2_BP41` varchar(8) DEFAULT NULL,
  `pg2_comments41` varchar(255) DEFAULT NULL,
  `pg2_date42` date DEFAULT NULL,
  `pg2_gest42` varchar(6) DEFAULT NULL,
  `pg2_ht42` varchar(6) DEFAULT NULL,
  `pg2_wt42` varchar(6) DEFAULT NULL,
  `pg2_presn42` varchar(6) DEFAULT NULL,
  `pg2_FHR42` varchar(6) DEFAULT NULL,
  `pg2_urinePr42` char(3) DEFAULT NULL,
  `pg2_urineGl42` char(3) DEFAULT NULL,
  `pg2_BP42` varchar(8) DEFAULT NULL,
  `pg2_comments42` varchar(255) DEFAULT NULL,
  `pg2_date43` date DEFAULT NULL,
  `pg2_gest43` varchar(6) DEFAULT NULL,
  `pg2_ht43` varchar(6) DEFAULT NULL,
  `pg2_wt43` varchar(6) DEFAULT NULL,
  `pg2_presn43` varchar(6) DEFAULT NULL,
  `pg2_FHR43` varchar(6) DEFAULT NULL,
  `pg2_urinePr43` char(3) DEFAULT NULL,
  `pg2_urineGl43` char(3) DEFAULT NULL,
  `pg2_BP43` varchar(8) DEFAULT NULL,
  `pg2_comments43` varchar(255) DEFAULT NULL,
  `pg2_date44` date DEFAULT NULL,
  `pg2_gest44` varchar(6) DEFAULT NULL,
  `pg2_ht44` varchar(6) DEFAULT NULL,
  `pg2_wt44` varchar(6) DEFAULT NULL,
  `pg2_presn44` varchar(6) DEFAULT NULL,
  `pg2_FHR44` varchar(6) DEFAULT NULL,
  `pg2_urinePr44` char(3) DEFAULT NULL,
  `pg2_urineGl44` char(3) DEFAULT NULL,
  `pg2_BP44` varchar(8) DEFAULT NULL,
  `pg2_comments44` varchar(255) DEFAULT NULL,
  `pg2_date45` date DEFAULT NULL,
  `pg2_gest45` varchar(6) DEFAULT NULL,
  `pg2_ht45` varchar(6) DEFAULT NULL,
  `pg2_wt45` varchar(6) DEFAULT NULL,
  `pg2_presn45` varchar(6) DEFAULT NULL,
  `pg2_FHR45` varchar(6) DEFAULT NULL,
  `pg2_urinePr45` char(3) DEFAULT NULL,
  `pg2_urineGl45` char(3) DEFAULT NULL,
  `pg2_BP45` varchar(8) DEFAULT NULL,
  `pg2_comments45` varchar(255) DEFAULT NULL,
  `pg2_date46` date DEFAULT NULL,
  `pg2_gest46` varchar(6) DEFAULT NULL,
  `pg2_ht46` varchar(6) DEFAULT NULL,
  `pg2_wt46` varchar(6) DEFAULT NULL,
  `pg2_presn46` varchar(6) DEFAULT NULL,
  `pg2_FHR46` varchar(6) DEFAULT NULL,
  `pg2_urinePr46` char(3) DEFAULT NULL,
  `pg2_urineGl46` char(3) DEFAULT NULL,
  `pg2_BP46` varchar(8) DEFAULT NULL,
  `pg2_comments46` varchar(255) DEFAULT NULL,
  `pg2_date47` date DEFAULT NULL,
  `pg2_gest47` varchar(6) DEFAULT NULL,
  `pg2_ht47` varchar(6) DEFAULT NULL,
  `pg2_wt47` varchar(6) DEFAULT NULL,
  `pg2_presn47` varchar(6) DEFAULT NULL,
  `pg2_FHR47` varchar(6) DEFAULT NULL,
  `pg2_urinePr47` char(3) DEFAULT NULL,
  `pg2_urineGl47` char(3) DEFAULT NULL,
  `pg2_BP47` varchar(8) DEFAULT NULL,
  `pg2_comments47` varchar(255) DEFAULT NULL,
  `pg2_date48` date DEFAULT NULL,
  `pg2_gest48` varchar(6) DEFAULT NULL,
  `pg2_ht48` varchar(6) DEFAULT NULL,
  `pg2_wt48` varchar(6) DEFAULT NULL,
  `pg2_presn48` varchar(6) DEFAULT NULL,
  `pg2_FHR48` varchar(6) DEFAULT NULL,
  `pg2_urinePr48` char(3) DEFAULT NULL,
  `pg2_urineGl48` char(3) DEFAULT NULL,
  `pg2_BP48` varchar(8) DEFAULT NULL,
  `pg2_comments48` varchar(255) DEFAULT NULL,
  `pg2_date49` date DEFAULT NULL,
  `pg2_gest49` varchar(6) DEFAULT NULL,
  `pg2_ht49` varchar(6) DEFAULT NULL,
  `pg2_wt49` varchar(6) DEFAULT NULL,
  `pg2_presn49` varchar(6) DEFAULT NULL,
  `pg2_FHR49` varchar(6) DEFAULT NULL,
  `pg2_urinePr49` char(3) DEFAULT NULL,
  `pg2_urineGl49` char(3) DEFAULT NULL,
  `pg2_BP49` varchar(8) DEFAULT NULL,
  `pg2_comments49` varchar(255) DEFAULT NULL,
  `pg2_date50` date DEFAULT NULL,
  `pg2_gest50` varchar(6) DEFAULT NULL,
  `pg2_ht50` varchar(6) DEFAULT NULL,
  `pg2_wt50` varchar(6) DEFAULT NULL,
  `pg2_presn50` varchar(6) DEFAULT NULL,
  `pg2_FHR50` varchar(6) DEFAULT NULL,
  `pg2_urinePr50` char(3) DEFAULT NULL,
  `pg2_urineGl50` char(3) DEFAULT NULL,
  `pg2_BP50` varchar(8) DEFAULT NULL,
  `pg2_comments50` varchar(255) DEFAULT NULL,
  `pg2_date51` date DEFAULT NULL,
  `pg2_gest51` varchar(6) DEFAULT NULL,
  `pg2_ht51` varchar(6) DEFAULT NULL,
  `pg2_wt51` varchar(6) DEFAULT NULL,
  `pg2_presn51` varchar(6) DEFAULT NULL,
  `pg2_FHR51` varchar(6) DEFAULT NULL,
  `pg2_urinePr51` char(3) DEFAULT NULL,
  `pg2_urineGl51` char(3) DEFAULT NULL,
  `pg2_BP51` varchar(8) DEFAULT NULL,
  `pg2_comments51` varchar(255) DEFAULT NULL,
  `pg2_date52` date DEFAULT NULL,
  `pg2_gest52` varchar(6) DEFAULT NULL,
  `pg2_ht52` varchar(6) DEFAULT NULL,
  `pg2_wt52` varchar(6) DEFAULT NULL,
  `pg2_presn52` varchar(6) DEFAULT NULL,
  `pg2_FHR52` varchar(6) DEFAULT NULL,
  `pg2_urinePr52` char(3) DEFAULT NULL,
  `pg2_urineGl52` char(3) DEFAULT NULL,
  `pg2_BP52` varchar(8) DEFAULT NULL,
  `pg2_comments52` varchar(255) DEFAULT NULL,
  `pg2_date53` date DEFAULT NULL,
  `pg2_gest53` varchar(6) DEFAULT NULL,
  `pg2_ht53` varchar(6) DEFAULT NULL,
  `pg2_wt53` varchar(6) DEFAULT NULL,
  `pg2_presn53` varchar(6) DEFAULT NULL,
  `pg2_FHR53` varchar(6) DEFAULT NULL,
  `pg2_urinePr53` char(3) DEFAULT NULL,
  `pg2_urineGl53` char(3) DEFAULT NULL,
  `pg2_BP53` varchar(8) DEFAULT NULL,
  `pg2_comments53` varchar(255) DEFAULT NULL,
  `pg2_date54` date DEFAULT NULL,
  `pg2_gest54` varchar(6) DEFAULT NULL,
  `pg2_ht54` varchar(6) DEFAULT NULL,
  `pg2_wt54` varchar(6) DEFAULT NULL,
  `pg2_presn54` varchar(6) DEFAULT NULL,
  `pg2_FHR54` varchar(6) DEFAULT NULL,
  `pg2_urinePr54` char(3) DEFAULT NULL,
  `pg2_urineGl54` char(3) DEFAULT NULL,
  `pg2_BP54` varchar(8) DEFAULT NULL,
  `pg2_comments54` varchar(255) DEFAULT NULL,
  `pg2_date55` date DEFAULT NULL,
  `pg2_gest55` varchar(6) DEFAULT NULL,
  `pg2_ht55` varchar(6) DEFAULT NULL,
  `pg2_wt55` varchar(6) DEFAULT NULL,
  `pg2_presn55` varchar(6) DEFAULT NULL,
  `pg2_FHR55` varchar(6) DEFAULT NULL,
  `pg2_urinePr55` char(3) DEFAULT NULL,
  `pg2_urineGl55` char(3) DEFAULT NULL,
  `pg2_BP55` varchar(8) DEFAULT NULL,
  `pg2_comments55` varchar(255) DEFAULT NULL,
  `pg2_date56` date DEFAULT NULL,
  `pg2_gest56` varchar(6) DEFAULT NULL,
  `pg2_ht56` varchar(6) DEFAULT NULL,
  `pg2_wt56` varchar(6) DEFAULT NULL,
  `pg2_presn56` varchar(6) DEFAULT NULL,
  `pg2_FHR56` varchar(6) DEFAULT NULL,
  `pg2_urinePr56` char(3) DEFAULT NULL,
  `pg2_urineGl56` char(3) DEFAULT NULL,
  `pg2_BP56` varchar(8) DEFAULT NULL,
  `pg2_comments56` varchar(255) DEFAULT NULL,
  `pg2_date57` date DEFAULT NULL,
  `pg2_gest57` varchar(6) DEFAULT NULL,
  `pg2_ht57` varchar(6) DEFAULT NULL,
  `pg2_wt57` varchar(6) DEFAULT NULL,
  `pg2_presn57` varchar(6) DEFAULT NULL,
  `pg2_FHR57` varchar(6) DEFAULT NULL,
  `pg2_urinePr57` char(3) DEFAULT NULL,
  `pg2_urineGl57` char(3) DEFAULT NULL,
  `pg2_BP57` varchar(8) DEFAULT NULL,
  `pg2_comments57` varchar(255) DEFAULT NULL,
  `pg2_date58` date DEFAULT NULL,
  `pg2_gest58` varchar(6) DEFAULT NULL,
  `pg2_ht58` varchar(6) DEFAULT NULL,
  `pg2_wt58` varchar(6) DEFAULT NULL,
  `pg2_presn58` varchar(6) DEFAULT NULL,
  `pg2_FHR58` varchar(6) DEFAULT NULL,
  `pg2_urinePr58` char(3) DEFAULT NULL,
  `pg2_urineGl58` char(3) DEFAULT NULL,
  `pg2_BP58` varchar(8) DEFAULT NULL,
  `pg2_comments58` varchar(255) DEFAULT NULL,
  `pg2_date59` date DEFAULT NULL,
  `pg2_gest59` varchar(6) DEFAULT NULL,
  `pg2_ht59` varchar(6) DEFAULT NULL,
  `pg2_wt59` varchar(6) DEFAULT NULL,
  `pg2_presn59` varchar(6) DEFAULT NULL,
  `pg2_FHR59` varchar(6) DEFAULT NULL,
  `pg2_urinePr59` char(3) DEFAULT NULL,
  `pg2_urineGl59` char(3) DEFAULT NULL,
  `pg2_BP59` varchar(8) DEFAULT NULL,
  `pg2_comments59` varchar(255) DEFAULT NULL,
  `pg2_date60` date DEFAULT NULL,
  `pg2_gest60` varchar(6) DEFAULT NULL,
  `pg2_ht60` varchar(6) DEFAULT NULL,
  `pg2_wt60` varchar(6) DEFAULT NULL,
  `pg2_presn60` varchar(6) DEFAULT NULL,
  `pg2_FHR60` varchar(6) DEFAULT NULL,
  `pg2_urinePr60` char(3) DEFAULT NULL,
  `pg2_urineGl60` char(3) DEFAULT NULL,
  `pg2_BP60` varchar(8) DEFAULT NULL,
  `pg2_comments60` varchar(255) DEFAULT NULL,
  `pg2_date61` date DEFAULT NULL,
  `pg2_gest61` varchar(6) DEFAULT NULL,
  `pg2_ht61` varchar(6) DEFAULT NULL,
  `pg2_wt61` varchar(6) DEFAULT NULL,
  `pg2_presn61` varchar(6) DEFAULT NULL,
  `pg2_FHR61` varchar(6) DEFAULT NULL,
  `pg2_urinePr61` char(3) DEFAULT NULL,
  `pg2_urineGl61` char(3) DEFAULT NULL,
  `pg2_BP61` varchar(8) DEFAULT NULL,
  `pg2_comments61` varchar(255) DEFAULT NULL,
  `pg2_date62` date DEFAULT NULL,
  `pg2_gest62` varchar(6) DEFAULT NULL,
  `pg2_ht62` varchar(6) DEFAULT NULL,
  `pg2_wt62` varchar(6) DEFAULT NULL,
  `pg2_presn62` varchar(6) DEFAULT NULL,
  `pg2_FHR62` varchar(6) DEFAULT NULL,
  `pg2_urinePr62` char(3) DEFAULT NULL,
  `pg2_urineGl62` char(3) DEFAULT NULL,
  `pg2_BP62` varchar(8) DEFAULT NULL,
  `pg2_comments62` varchar(255) DEFAULT NULL,
  `pg2_date63` date DEFAULT NULL,
  `pg2_gest63` varchar(6) DEFAULT NULL,
  `pg2_ht63` varchar(6) DEFAULT NULL,
  `pg2_wt63` varchar(6) DEFAULT NULL,
  `pg2_presn63` varchar(6) DEFAULT NULL,
  `pg2_FHR63` varchar(6) DEFAULT NULL,
  `pg2_urinePr63` char(3) DEFAULT NULL,
  `pg2_urineGl63` char(3) DEFAULT NULL,
  `pg2_BP63` varchar(8) DEFAULT NULL,
  `pg2_comments63` varchar(255) DEFAULT NULL,
  `pg2_date64` date DEFAULT NULL,
  `pg2_gest64` varchar(6) DEFAULT NULL,
  `pg2_ht64` varchar(6) DEFAULT NULL,
  `pg2_wt64` varchar(6) DEFAULT NULL,
  `pg2_presn64` varchar(6) DEFAULT NULL,
  `pg2_FHR64` varchar(6) DEFAULT NULL,
  `pg2_urinePr64` char(3) DEFAULT NULL,
  `pg2_urineGl64` char(3) DEFAULT NULL,
  `pg2_BP64` varchar(8) DEFAULT NULL,
  `pg2_comments64` varchar(255) DEFAULT NULL,
  `pg2_date65` date DEFAULT NULL,
  `pg2_gest65` varchar(6) DEFAULT NULL,
  `pg2_ht65` varchar(6) DEFAULT NULL,
  `pg2_wt65` varchar(6) DEFAULT NULL,
  `pg2_presn65` varchar(6) DEFAULT NULL,
  `pg2_FHR65` varchar(6) DEFAULT NULL,
  `pg2_urinePr65` char(3) DEFAULT NULL,
  `pg2_urineGl65` char(3) DEFAULT NULL,
  `pg2_BP65` varchar(8) DEFAULT NULL,
  `pg2_comments65` varchar(255) DEFAULT NULL,
  `pg2_date66` date DEFAULT NULL,
  `pg2_gest66` varchar(6) DEFAULT NULL,
  `pg2_ht66` varchar(6) DEFAULT NULL,
  `pg2_wt66` varchar(6) DEFAULT NULL,
  `pg2_presn66` varchar(6) DEFAULT NULL,
  `pg2_FHR66` varchar(6) DEFAULT NULL,
  `pg2_urinePr66` char(3) DEFAULT NULL,
  `pg2_urineGl66` char(3) DEFAULT NULL,
  `pg2_BP66` varchar(8) DEFAULT NULL,
  `pg2_comments66` varchar(255) DEFAULT NULL,
  `pg2_date67` date DEFAULT NULL,
  `pg2_gest67` varchar(6) DEFAULT NULL,
  `pg2_ht67` varchar(6) DEFAULT NULL,
  `pg2_wt67` varchar(6) DEFAULT NULL,
  `pg2_presn67` varchar(6) DEFAULT NULL,
  `pg2_FHR67` varchar(6) DEFAULT NULL,
  `pg2_urinePr67` char(3) DEFAULT NULL,
  `pg2_urineGl67` char(3) DEFAULT NULL,
  `pg2_BP67` varchar(8) DEFAULT NULL,
  `pg2_comments67` varchar(255) DEFAULT NULL,
  `pg2_date68` date DEFAULT NULL,
  `pg2_gest68` varchar(6) DEFAULT NULL,
  `pg2_ht68` varchar(6) DEFAULT NULL,
  `pg2_wt68` varchar(6) DEFAULT NULL,
  `pg2_presn68` varchar(6) DEFAULT NULL,
  `pg2_FHR68` varchar(6) DEFAULT NULL,
  `pg2_urinePr68` char(3) DEFAULT NULL,
  `pg2_urineGl68` char(3) DEFAULT NULL,
  `pg2_BP68` varchar(8) DEFAULT NULL,
  `pg2_comments68` varchar(255) DEFAULT NULL,
  `pg2_date69` date DEFAULT NULL,
  `pg2_gest69` varchar(6) DEFAULT NULL,
  `pg2_ht69` varchar(6) DEFAULT NULL,
  `pg2_wt69` varchar(6) DEFAULT NULL,
  `pg2_presn69` varchar(6) DEFAULT NULL,
  `pg2_FHR69` varchar(6) DEFAULT NULL,
  `pg2_urinePr69` char(3) DEFAULT NULL,
  `pg2_urineGl69` char(3) DEFAULT NULL,
  `pg2_BP69` varchar(8) DEFAULT NULL,
  `pg2_comments69` varchar(255) DEFAULT NULL,
  `pg2_date70` date DEFAULT NULL,
  `pg2_gest70` varchar(6) DEFAULT NULL,
  `pg2_ht70` varchar(6) DEFAULT NULL,
  `pg2_wt70` varchar(6) DEFAULT NULL,
  `pg2_presn70` varchar(6) DEFAULT NULL,
  `pg2_FHR70` varchar(6) DEFAULT NULL,
  `pg2_urinePr70` char(3) DEFAULT NULL,
  `pg2_urineGl70` char(3) DEFAULT NULL,
  `pg2_BP70` varchar(8) DEFAULT NULL,
  `pg2_comments70` varchar(255) DEFAULT NULL,
  `ar2_uDate1` date DEFAULT NULL,
  `ar2_uGA1` varchar(10) DEFAULT NULL,
  `ar2_uResults1` varchar(50) DEFAULT NULL,
  `ar2_uDate2` date DEFAULT NULL,
  `ar2_uGA2` varchar(10) DEFAULT NULL,
  `ar2_uResults2` varchar(50) DEFAULT NULL,
  `ar2_uDate3` date DEFAULT NULL,
  `ar2_uGA3` varchar(10) DEFAULT NULL,
  `ar2_uResults3` varchar(50) DEFAULT NULL,
  `ar2_uDate4` date DEFAULT NULL,
  `ar2_uGA4` varchar(10) DEFAULT NULL,
  `ar2_uResults4` varchar(50) DEFAULT NULL,
  `ar2_uDate5` date DEFAULT NULL,
  `ar2_uGA5` varchar(10) DEFAULT NULL,
  `ar2_uResults5` varchar(50) DEFAULT NULL,
  `ar2_uDate6` date DEFAULT NULL,
  `ar2_uGA6` varchar(10) DEFAULT NULL,
  `ar2_uResults6` varchar(50) DEFAULT NULL,
  `ar2_uDate7` date DEFAULT NULL,
  `ar2_uGA7` varchar(10) DEFAULT NULL,
  `ar2_uResults7` varchar(50) DEFAULT NULL,
  `ar2_uDate8` date DEFAULT NULL,
  `ar2_uGA8` varchar(10) DEFAULT NULL,
  `ar2_uResults8` varchar(50) DEFAULT NULL,
  `ar2_uDate9` date DEFAULT NULL,
  `ar2_uGA9` varchar(10) DEFAULT NULL,
  `ar2_uResults9` varchar(50) DEFAULT NULL,
  `ar2_uDate10` date DEFAULT NULL,
  `ar2_uGA10` varchar(10) DEFAULT NULL,
  `ar2_uResults10` varchar(50) DEFAULT NULL,
  `ar2_uDate11` date DEFAULT NULL,
  `ar2_uGA11` varchar(10) DEFAULT NULL,
  `ar2_uResults11` varchar(50) DEFAULT NULL,
  `ar2_uDate12` date DEFAULT NULL,
  `ar2_uGA12` varchar(10) DEFAULT NULL,
  `ar2_uResults12` varchar(50) DEFAULT NULL,
  `ar2_hb` varchar(10) DEFAULT NULL,
  `ar2_bloodGroup` varchar(6) DEFAULT NULL,
  `ar2_rh` varchar(6) DEFAULT NULL,
  `ar2_labABS` varchar(10) DEFAULT NULL,
  `ar2_lab1GCT` varchar(10) DEFAULT NULL,
  `ar2_lab2GTT` varchar(14) DEFAULT NULL,
  `ar2_strep` varchar(10) DEFAULT NULL,
  `ar2_labCustom1Label` varchar(40) DEFAULT NULL,
  `ar2_labCustom1Result` varchar(40) DEFAULT NULL,
  `ar2_labCustom2Label` varchar(40) DEFAULT NULL,
  `ar2_labCustom2Result` varchar(40) DEFAULT NULL,
  `ar2_labCustom3Label` varchar(40) DEFAULT NULL,
  `ar2_labCustom3Result` varchar(40) DEFAULT NULL,
  `ar2_labCustom4Label` varchar(40) DEFAULT NULL,
  `ar2_labCustom4Result` varchar(40) DEFAULT NULL,
  `ar2_exercise` tinyint(1) DEFAULT NULL,
  `ar2_workPlan` tinyint(1) DEFAULT NULL,
  `ar2_intercourse` tinyint(1) DEFAULT NULL,
  `ar2_travel` tinyint(1) DEFAULT NULL,
  `ar2_prenatal` tinyint(1) DEFAULT NULL,
  `ar2_birth` tinyint(1) DEFAULT NULL,
  `ar2_onCall` tinyint(1) DEFAULT NULL,
  `ar2_preterm` tinyint(1) DEFAULT NULL,
  `ar2_prom` tinyint(1) DEFAULT NULL,
  `ar2_aph` tinyint(1) DEFAULT NULL,
  `ar2_fetal` tinyint(1) DEFAULT NULL,
  `ar2_admission` tinyint(1) DEFAULT NULL,
  `ar2_pain` tinyint(1) DEFAULT NULL,
  `ar2_labour` tinyint(1) DEFAULT NULL,
  `ar2_breast` tinyint(1) DEFAULT NULL,
  `ar2_circumcision` tinyint(1) DEFAULT NULL,
  `ar2_dischargePlan` tinyint(1) DEFAULT NULL,
  `ar2_car` tinyint(1) DEFAULT NULL,
  `ar2_depression` tinyint(1) DEFAULT NULL,
  `ar2_contraception` tinyint(1) DEFAULT NULL,
  `ar2_postpartumCare` tinyint(1) DEFAULT NULL,
  `pg2_signature` varchar(50) DEFAULT NULL,
  `pg2_formDate` date DEFAULT NULL,
  `pg2_signature2` varchar(50) DEFAULT NULL,
  `pg2_formDate2` date DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formPalliativeCare`
--

DROP TABLE IF EXISTS `formPalliativeCare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formPalliativeCare` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pName` varchar(60) DEFAULT NULL,
  `diagnosis` varchar(60) DEFAULT NULL,
  `date1` date DEFAULT NULL,
  `date2` date DEFAULT NULL,
  `date3` date DEFAULT NULL,
  `date4` date DEFAULT NULL,
  `pain1` varchar(255) DEFAULT NULL,
  `pain2` varchar(255) DEFAULT NULL,
  `pain3` varchar(255) DEFAULT NULL,
  `pain4` varchar(255) DEFAULT NULL,
  `giBowels1` varchar(255) DEFAULT NULL,
  `giBowels2` varchar(255) DEFAULT NULL,
  `giBowels3` varchar(255) DEFAULT NULL,
  `giBowels4` varchar(255) DEFAULT NULL,
  `giNausea1` varchar(255) DEFAULT NULL,
  `giNausea2` varchar(255) DEFAULT NULL,
  `giNausea3` varchar(255) DEFAULT NULL,
  `giNausea4` varchar(255) DEFAULT NULL,
  `giDysphagia1` varchar(255) DEFAULT NULL,
  `giDysphagia2` varchar(255) DEFAULT NULL,
  `giDysphagia3` varchar(255) DEFAULT NULL,
  `giDysphagia4` varchar(255) DEFAULT NULL,
  `giHiccups1` varchar(255) DEFAULT NULL,
  `giHiccups2` varchar(255) DEFAULT NULL,
  `giHiccups3` varchar(255) DEFAULT NULL,
  `giHiccups4` varchar(255) DEFAULT NULL,
  `giMouth1` varchar(255) DEFAULT NULL,
  `giMouth2` varchar(255) DEFAULT NULL,
  `giMouth3` varchar(255) DEFAULT NULL,
  `giMouth4` varchar(255) DEFAULT NULL,
  `gu1` varchar(255) DEFAULT NULL,
  `gu2` varchar(255) DEFAULT NULL,
  `gu3` varchar(255) DEFAULT NULL,
  `gu4` varchar(255) DEFAULT NULL,
  `skinUlcers1` varchar(255) DEFAULT NULL,
  `skinUlcers2` varchar(255) DEFAULT NULL,
  `skinUlcers3` varchar(255) DEFAULT NULL,
  `skinUlcers4` varchar(255) DEFAULT NULL,
  `skinPruritis1` varchar(255) DEFAULT NULL,
  `skinPruritis2` varchar(255) DEFAULT NULL,
  `skinPruritis3` varchar(255) DEFAULT NULL,
  `skinPruritis4` varchar(255) DEFAULT NULL,
  `psychAgitation1` varchar(255) DEFAULT NULL,
  `psychAgitation2` varchar(255) DEFAULT NULL,
  `psychAgitation3` varchar(255) DEFAULT NULL,
  `psychAgitation4` varchar(255) DEFAULT NULL,
  `psychAnorexia1` varchar(255) DEFAULT NULL,
  `psychAnorexia2` varchar(255) DEFAULT NULL,
  `psychAnorexia3` varchar(255) DEFAULT NULL,
  `psychAnorexia4` varchar(255) DEFAULT NULL,
  `psychAnxiety1` varchar(255) DEFAULT NULL,
  `psychAnxiety2` varchar(255) DEFAULT NULL,
  `psychAnxiety3` varchar(255) DEFAULT NULL,
  `psychAnxiety4` varchar(255) DEFAULT NULL,
  `psychDepression1` varchar(255) DEFAULT NULL,
  `psychDepression2` varchar(255) DEFAULT NULL,
  `psychDepression3` varchar(255) DEFAULT NULL,
  `psychDepression4` varchar(255) DEFAULT NULL,
  `psychFatigue1` varchar(255) DEFAULT NULL,
  `psychFatigue2` varchar(255) DEFAULT NULL,
  `psychFatigue3` varchar(255) DEFAULT NULL,
  `psychFatigue4` varchar(255) DEFAULT NULL,
  `psychSomnolence1` varchar(255) DEFAULT NULL,
  `psychSomnolence2` varchar(255) DEFAULT NULL,
  `psychSomnolence3` varchar(255) DEFAULT NULL,
  `psychSomnolence4` varchar(255) DEFAULT NULL,
  `respCough1` varchar(255) DEFAULT NULL,
  `respCough2` varchar(255) DEFAULT NULL,
  `respCough3` varchar(255) DEFAULT NULL,
  `respCough4` varchar(255) DEFAULT NULL,
  `respDyspnea1` varchar(255) DEFAULT NULL,
  `respDyspnea2` varchar(255) DEFAULT NULL,
  `respDyspnea3` varchar(255) DEFAULT NULL,
  `respDyspnea4` varchar(255) DEFAULT NULL,
  `respFever1` varchar(255) DEFAULT NULL,
  `respFever2` varchar(255) DEFAULT NULL,
  `respFever3` varchar(255) DEFAULT NULL,
  `respFever4` varchar(255) DEFAULT NULL,
  `respCaregiver1` varchar(255) DEFAULT NULL,
  `respCaregiver2` varchar(255) DEFAULT NULL,
  `respCaregiver3` varchar(255) DEFAULT NULL,
  `respCaregiver4` varchar(255) DEFAULT NULL,
  `other1` varchar(255) DEFAULT NULL,
  `other2` varchar(255) DEFAULT NULL,
  `other3` varchar(255) DEFAULT NULL,
  `other4` varchar(255) DEFAULT NULL,
  `signature1` varchar(50) DEFAULT NULL,
  `signature2` varchar(50) DEFAULT NULL,
  `signature3` varchar(50) DEFAULT NULL,
  `signature4` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formPeriMenopausal`
--

DROP TABLE IF EXISTS `formPeriMenopausal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formPeriMenopausal` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lastVisited` char(1) DEFAULT NULL,
  `pName` varchar(60) DEFAULT NULL,
  `ageMenopause` char(2) DEFAULT NULL,
  `age` char(3) DEFAULT NULL,
  `orf_emYes` tinyint(1) DEFAULT NULL,
  `orf_emNo` tinyint(1) DEFAULT NULL,
  `orf_fhoYes` tinyint(1) DEFAULT NULL,
  `orf_fhoNo` tinyint(1) DEFAULT NULL,
  `orf_fhofYes` tinyint(1) DEFAULT NULL,
  `orf_fhofNo` tinyint(1) DEFAULT NULL,
  `orf_lhYes` tinyint(1) DEFAULT NULL,
  `orf_lhNo` tinyint(1) DEFAULT NULL,
  `orf_phfYes` tinyint(1) DEFAULT NULL,
  `orf_phfNo` tinyint(1) DEFAULT NULL,
  `orf_warYes` tinyint(1) DEFAULT NULL,
  `orf_warNo` tinyint(1) DEFAULT NULL,
  `orf_tsbYes` tinyint(1) DEFAULT NULL,
  `orf_tsbNo` tinyint(1) DEFAULT NULL,
  `orf_hipYes` tinyint(1) DEFAULT NULL,
  `orf_hipNo` tinyint(1) DEFAULT NULL,
  `orf_ieYes` tinyint(1) DEFAULT NULL,
  `orf_ieNo` tinyint(1) DEFAULT NULL,
  `orf_llciYes` tinyint(1) DEFAULT NULL,
  `orf_llciNo` tinyint(1) DEFAULT NULL,
  `orf_csYes` tinyint(1) DEFAULT NULL,
  `orf_csNo` tinyint(1) DEFAULT NULL,
  `orf_cYes` tinyint(1) DEFAULT NULL,
  `orf_cNo` tinyint(1) DEFAULT NULL,
  `orf_aYes` tinyint(1) DEFAULT NULL,
  `orf_aNo` tinyint(1) DEFAULT NULL,
  `orf_cptdYes` tinyint(1) DEFAULT NULL,
  `orf_cptdNo` tinyint(1) DEFAULT NULL,
  `orf_dcYes` tinyint(1) DEFAULT NULL,
  `orf_dcNo` tinyint(1) DEFAULT NULL,
  `orf_adYes` tinyint(1) DEFAULT NULL,
  `orf_adNo` tinyint(1) DEFAULT NULL,
  `orf_tmYes` tinyint(1) DEFAULT NULL,
  `orf_tmNo` tinyint(1) DEFAULT NULL,
  `orf_comments` varchar(255) DEFAULT NULL,
  `cs_mcYes` tinyint(1) DEFAULT NULL,
  `cs_mcNo` tinyint(1) DEFAULT NULL,
  `cs_mpYes` tinyint(1) DEFAULT NULL,
  `cs_mpNo` tinyint(1) DEFAULT NULL,
  `cs_hfYes` tinyint(1) DEFAULT NULL,
  `cs_hfNo` tinyint(1) DEFAULT NULL,
  `cs_vdYes` tinyint(1) DEFAULT NULL,
  `cs_vdNo` tinyint(1) DEFAULT NULL,
  `cs_dsiYes` tinyint(1) DEFAULT NULL,
  `cs_dsiNo` tinyint(1) DEFAULT NULL,
  `cs_lisaYes` tinyint(1) DEFAULT NULL,
  `cs_lisaNo` tinyint(1) DEFAULT NULL,
  `cs_lbcYes` tinyint(1) DEFAULT NULL,
  `cs_lbcNo` tinyint(1) DEFAULT NULL,
  `cs_hbiYes` tinyint(1) DEFAULT NULL,
  `cs_hbiNo` tinyint(1) DEFAULT NULL,
  `cs_comments` varchar(255) DEFAULT NULL,
  `crf_fhhdYes` tinyint(1) DEFAULT NULL,
  `crf_fhhdNo` tinyint(1) DEFAULT NULL,
  `crf_haYes` tinyint(1) DEFAULT NULL,
  `crf_haNo` tinyint(1) DEFAULT NULL,
  `crf_hchfYes` tinyint(1) DEFAULT NULL,
  `crf_hchfNo` tinyint(1) DEFAULT NULL,
  `crf_hhaYes` tinyint(1) DEFAULT NULL,
  `crf_hhaNo` tinyint(1) DEFAULT NULL,
  `crf_hdYes` tinyint(1) DEFAULT NULL,
  `crf_hdNo` tinyint(1) DEFAULT NULL,
  `crf_csYes` tinyint(1) DEFAULT NULL,
  `crf_csNo` tinyint(1) DEFAULT NULL,
  `crf_hbpYes` tinyint(1) DEFAULT NULL,
  `crf_hbpNo` tinyint(1) DEFAULT NULL,
  `crf_lhcYes` tinyint(1) DEFAULT NULL,
  `crf_lhcNo` tinyint(1) DEFAULT NULL,
  `crf_htYes` tinyint(1) DEFAULT NULL,
  `crf_htNo` tinyint(1) DEFAULT NULL,
  `crf_hlcYes` tinyint(1) DEFAULT NULL,
  `crf_hlcNo` tinyint(1) DEFAULT NULL,
  `crf_oYes` tinyint(1) DEFAULT NULL,
  `crf_oNo` tinyint(1) DEFAULT NULL,
  `crf_slYes` tinyint(1) DEFAULT NULL,
  `crf_slNo` tinyint(1) DEFAULT NULL,
  `crf_comments` varchar(255) DEFAULT NULL,
  `rh_fhbcYes` tinyint(1) DEFAULT NULL,
  `rh_fhbcNo` tinyint(1) DEFAULT NULL,
  `rh_phbcYes` tinyint(1) DEFAULT NULL,
  `rh_phbcNo` tinyint(1) DEFAULT NULL,
  `rh_phocYes` tinyint(1) DEFAULT NULL,
  `rh_phocNo` tinyint(1) DEFAULT NULL,
  `ageHysterectomy` char(2) DEFAULT NULL,
  `rh_hYes` tinyint(1) DEFAULT NULL,
  `rh_hNo` tinyint(1) DEFAULT NULL,
  `rh_hwroYes` tinyint(1) DEFAULT NULL,
  `rh_hwroNo` tinyint(1) DEFAULT NULL,
  `rh_hpcbYes` tinyint(1) DEFAULT NULL,
  `rh_hpcbNo` tinyint(1) DEFAULT NULL,
  `rh_fhadYes` tinyint(1) DEFAULT NULL,
  `rh_fhadNo` tinyint(1) DEFAULT NULL,
  `rh_fhccYes` tinyint(1) DEFAULT NULL,
  `rh_fhccNo` tinyint(1) DEFAULT NULL,
  `rh_other` varchar(60) DEFAULT NULL,
  `rh_oYes` tinyint(1) DEFAULT NULL,
  `rh_oNo` tinyint(1) DEFAULT NULL,
  `rh_comments` varchar(255) DEFAULT NULL,
  `cm_cs` varchar(30) DEFAULT NULL,
  `cm_vds` varchar(30) DEFAULT NULL,
  `cm_other1` varchar(30) DEFAULT NULL,
  `cm_o1` varchar(30) DEFAULT NULL,
  `cm_other2` varchar(30) DEFAULT NULL,
  `cm_o2` varchar(30) DEFAULT NULL,
  `cm_comments` varchar(255) DEFAULT NULL,
  `phrtYes` tinyint(1) DEFAULT NULL,
  `phrtNo` tinyint(1) DEFAULT NULL,
  `estrogenYes` tinyint(1) DEFAULT NULL,
  `estrogenNo` tinyint(1) DEFAULT NULL,
  `progesteroneYes` tinyint(1) DEFAULT NULL,
  `progesteroneNo` tinyint(1) DEFAULT NULL,
  `hrtYes` tinyint(1) DEFAULT NULL,
  `hrtNo` tinyint(1) DEFAULT NULL,
  `whenHrt` varchar(20) DEFAULT NULL,
  `reasonDiscontinued` varchar(100) DEFAULT NULL,
  `date1` date DEFAULT NULL,
  `date2` date DEFAULT NULL,
  `date3` date DEFAULT NULL,
  `date4` date DEFAULT NULL,
  `date5` date DEFAULT NULL,
  `date6` date DEFAULT NULL,
  `date7` date DEFAULT NULL,
  `date8` date DEFAULT NULL,
  `etohUse1` varchar(100) DEFAULT NULL,
  `etohUse2` varchar(100) DEFAULT NULL,
  `etohUse3` varchar(100) DEFAULT NULL,
  `etohUse4` varchar(100) DEFAULT NULL,
  `smokingCessation1` varchar(100) DEFAULT NULL,
  `smokingCessation2` varchar(100) DEFAULT NULL,
  `smokingCessation3` varchar(100) DEFAULT NULL,
  `smokingCessation4` varchar(100) DEFAULT NULL,
  `exercise1` varchar(100) DEFAULT NULL,
  `exercise2` varchar(100) DEFAULT NULL,
  `exercise3` varchar(100) DEFAULT NULL,
  `exercise4` varchar(100) DEFAULT NULL,
  `vision1` varchar(100) DEFAULT NULL,
  `vision2` varchar(100) DEFAULT NULL,
  `vision3` varchar(100) DEFAULT NULL,
  `vision4` varchar(100) DEFAULT NULL,
  `lowFat1` varchar(100) DEFAULT NULL,
  `lowFat2` varchar(100) DEFAULT NULL,
  `lowFat3` varchar(100) DEFAULT NULL,
  `lowFat4` varchar(100) DEFAULT NULL,
  `tdLast1` varchar(100) DEFAULT NULL,
  `tdLast2` varchar(100) DEFAULT NULL,
  `tdLast3` varchar(100) DEFAULT NULL,
  `tdLast4` varchar(100) DEFAULT NULL,
  `calcium1` varchar(100) DEFAULT NULL,
  `calcium2` varchar(100) DEFAULT NULL,
  `calcium3` varchar(100) DEFAULT NULL,
  `calcium4` varchar(100) DEFAULT NULL,
  `flu1` varchar(100) DEFAULT NULL,
  `flu2` varchar(100) DEFAULT NULL,
  `flu3` varchar(100) DEFAULT NULL,
  `flu4` varchar(100) DEFAULT NULL,
  `vitaminD1` varchar(100) DEFAULT NULL,
  `vitaminD2` varchar(100) DEFAULT NULL,
  `vitaminD3` varchar(100) DEFAULT NULL,
  `vitaminD4` varchar(100) DEFAULT NULL,
  `pneumovaxDate` date DEFAULT NULL,
  `pneumovax1` varchar(100) DEFAULT NULL,
  `pneumovax2` varchar(100) DEFAULT NULL,
  `pneumovax3` varchar(100) DEFAULT NULL,
  `pneumovax4` varchar(100) DEFAULT NULL,
  `papSmear1` varchar(100) DEFAULT NULL,
  `papSmear2` varchar(100) DEFAULT NULL,
  `papSmear3` varchar(100) DEFAULT NULL,
  `papSmear4` varchar(100) DEFAULT NULL,
  `height1` varchar(100) DEFAULT NULL,
  `height2` varchar(100) DEFAULT NULL,
  `height3` varchar(100) DEFAULT NULL,
  `height4` varchar(100) DEFAULT NULL,
  `bloodPressure1` varchar(100) DEFAULT NULL,
  `bloodPressure2` varchar(100) DEFAULT NULL,
  `bloodPressure3` varchar(100) DEFAULT NULL,
  `bloodPressure4` varchar(100) DEFAULT NULL,
  `weight1` varchar(100) DEFAULT NULL,
  `weight2` varchar(100) DEFAULT NULL,
  `weight3` varchar(100) DEFAULT NULL,
  `weight4` varchar(100) DEFAULT NULL,
  `cbe1` varchar(100) DEFAULT NULL,
  `cbe2` varchar(100) DEFAULT NULL,
  `cbe3` varchar(100) DEFAULT NULL,
  `cbe4` varchar(100) DEFAULT NULL,
  `bmd1` varchar(100) DEFAULT NULL,
  `bmd2` varchar(100) DEFAULT NULL,
  `bmd3` varchar(100) DEFAULT NULL,
  `bmd4` varchar(100) DEFAULT NULL,
  `mammography1` varchar(100) DEFAULT NULL,
  `mammography2` varchar(100) DEFAULT NULL,
  `mammography3` varchar(100) DEFAULT NULL,
  `mammography4` varchar(100) DEFAULT NULL,
  `other1` varchar(30) DEFAULT NULL,
  `other11` varchar(100) DEFAULT NULL,
  `other12` varchar(100) DEFAULT NULL,
  `other13` varchar(100) DEFAULT NULL,
  `other14` varchar(100) DEFAULT NULL,
  `other2` varchar(30) DEFAULT NULL,
  `other21` varchar(100) DEFAULT NULL,
  `other22` varchar(100) DEFAULT NULL,
  `other23` varchar(100) DEFAULT NULL,
  `other24` varchar(100) DEFAULT NULL,
  `other3` varchar(30) DEFAULT NULL,
  `other31` varchar(100) DEFAULT NULL,
  `other32` varchar(100) DEFAULT NULL,
  `other33` varchar(100) DEFAULT NULL,
  `other34` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formRhImmuneGlobulin`
--

DROP TABLE IF EXISTS `formRhImmuneGlobulin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formRhImmuneGlobulin` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `workflowId` int(10) DEFAULT NULL,
  `state` char(1) DEFAULT NULL,
  `dateOfReferral` datetime DEFAULT NULL,
  `edd` datetime DEFAULT NULL,
  `motherSurname` varchar(30) DEFAULT NULL,
  `motherFirstname` varchar(30) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `motherHIN` varchar(20) DEFAULT NULL,
  `motherVC` varchar(30) DEFAULT NULL,
  `motherAddress` varchar(60) DEFAULT NULL,
  `motherCity` varchar(60) DEFAULT NULL,
  `motherProvince` varchar(60) DEFAULT NULL,
  `motherPostalCode` varchar(10) DEFAULT NULL,
  `motherABO` char(3) DEFAULT NULL,
  `motherRHtype` varchar(4) DEFAULT NULL,
  `hospitalForDelivery` varchar(255) DEFAULT NULL,
  `refPhySurname` varchar(30) DEFAULT NULL,
  `refPhyFirstname` varchar(30) DEFAULT NULL,
  `refPhyAddress` varchar(60) DEFAULT NULL,
  `refPhyCity` varchar(60) DEFAULT NULL,
  `refPhyProvince` varchar(60) DEFAULT NULL,
  `refPhyPostalCode` varchar(10) DEFAULT NULL,
  `refPhyPhone` varchar(20) DEFAULT NULL,
  `refPhyFax` varchar(20) DEFAULT NULL,
  `comments` text,
  `obsHisG` varchar(10) DEFAULT NULL,
  `obsHisP` varchar(10) DEFAULT NULL,
  `obsHisT` varchar(10) DEFAULT NULL,
  `obsHisA` varchar(10) DEFAULT NULL,
  `obsHisL` varchar(10) DEFAULT NULL,
  `obsHisTubMolPregYes` tinyint(1) DEFAULT NULL,
  `obsHisTubMolPregNo` tinyint(1) DEFAULT NULL,
  `obsHisMisAbortionYes` tinyint(1) DEFAULT NULL,
  `obsHisMisAbortionNo` tinyint(1) DEFAULT NULL,
  `obsHisReceiveAntiDYes` tinyint(1) DEFAULT NULL,
  `obsHisReceiveAntiDNo` tinyint(1) DEFAULT NULL,
  `motherAntibodies` varchar(4) DEFAULT NULL,
  `fatherABO` char(3) DEFAULT NULL,
  `fatherRHtype` varchar(4) DEFAULT NULL,
  `pmHisBlClDisordersYes` tinyint(1) DEFAULT NULL,
  `pmHisBlClDisordersNo` tinyint(1) DEFAULT NULL,
  `pmHisBlClDisordersComment` text,
  `pmHisBlPlTransfusYes` tinyint(1) DEFAULT NULL,
  `pmHisBlPlTransfusNo` tinyint(1) DEFAULT NULL,
  `pmHisBlPlTransfusComment` text,
  `allReactionsYes` tinyint(1) DEFAULT NULL,
  `allReactionsNo` tinyint(1) DEFAULT NULL,
  `allReactionsComment` text,
  `curPregDueDateChangeYes` tinyint(1) DEFAULT NULL,
  `curPregDueDateChangeNo` tinyint(1) DEFAULT NULL,
  `curPregProceduresYes` tinyint(1) DEFAULT NULL,
  `curPregProceduresNo` tinyint(1) DEFAULT NULL,
  `curPregProceduresComment` text,
  `curPregBleedingYes` tinyint(1) DEFAULT NULL,
  `curPregBleedingNo` tinyint(1) DEFAULT NULL,
  `curPregBleedingComment` text,
  `curPregBleedingContYes` tinyint(1) DEFAULT NULL,
  `curPregBleedingContNo` tinyint(1) DEFAULT NULL,
  `curPregTraumaYes` tinyint(1) DEFAULT NULL,
  `curPregTraumaNo` tinyint(1) DEFAULT NULL,
  `curPregAntiDYes` tinyint(1) DEFAULT NULL,
  `curPregAntiDNo` tinyint(1) DEFAULT NULL,
  `curPregAntiDComment` text,
  `curPregAntiDReactionYes` tinyint(1) DEFAULT NULL,
  `curPregAntiDReactionNo` tinyint(1) DEFAULT NULL,
  `curPregBloodDrawnYes` tinyint(1) DEFAULT NULL,
  `curPregBloodDrawnNo` tinyint(1) DEFAULT NULL,
  `curPregDueDateChangeComment` text,
  `famPhySurname` varchar(30) DEFAULT NULL,
  `famPhyFirstname` varchar(30) DEFAULT NULL,
  `famPhyAddress` varchar(60) DEFAULT NULL,
  `famPhyCity` varchar(60) DEFAULT NULL,
  `famPhyProvince` varchar(60) DEFAULT NULL,
  `famPhyPostalCode` varchar(10) DEFAULT NULL,
  `famPhyPhone` varchar(20) DEFAULT NULL,
  `famPhyFax` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formRourke`
--

DROP TABLE IF EXISTS `formRourke`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formRourke` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_lastVisited` char(3) DEFAULT NULL,
  `c_birthRemarks` text,
  `c_riskFactors` text,
  `c_pName` varchar(60) DEFAULT NULL,
  `c_birthDate` date DEFAULT NULL,
  `c_length` varchar(6) DEFAULT NULL,
  `c_headCirc` varchar(6) DEFAULT NULL,
  `c_birthWeight` varchar(7) DEFAULT NULL,
  `c_dischargeWeight` varchar(7) DEFAULT NULL,
  `p1_date1w` date DEFAULT NULL,
  `p1_date2w` date DEFAULT NULL,
  `p1_date1m` date DEFAULT NULL,
  `p1_date2m` date DEFAULT NULL,
  `p1_ht1w` varchar(5) DEFAULT NULL,
  `p1_wt1w` varchar(5) DEFAULT NULL,
  `p1_hc1w` varchar(5) DEFAULT NULL,
  `p1_ht2w` varchar(5) DEFAULT NULL,
  `p1_wt2w` varchar(5) DEFAULT NULL,
  `p1_hc2w` varchar(5) DEFAULT NULL,
  `p1_ht1m` varchar(5) DEFAULT NULL,
  `p1_wt1m` varchar(5) DEFAULT NULL,
  `p1_hc1m` varchar(5) DEFAULT NULL,
  `p1_ht2m` varchar(5) DEFAULT NULL,
  `p1_wt2m` varchar(5) DEFAULT NULL,
  `p1_hc2m` varchar(5) DEFAULT NULL,
  `p1_pConcern1w` text,
  `p1_pConcern2w` text,
  `p1_pConcern1m` text,
  `p1_pConcern2m` text,
  `p1_breastFeeding1w` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1w` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine1w` tinyint(1) DEFAULT NULL,
  `p1_nutrition1w` varchar(250) DEFAULT NULL,
  `p1_breastFeeding2w` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding2w` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine2w` tinyint(1) DEFAULT NULL,
  `p1_nutrition2w` varchar(250) DEFAULT NULL,
  `p1_breastFeeding1m` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1m` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine1m` tinyint(1) DEFAULT NULL,
  `p1_nutrition1m` varchar(250) DEFAULT NULL,
  `p1_breastFeeding2m` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding2m` tinyint(1) DEFAULT NULL,
  `p1_nutrition2m` varchar(250) DEFAULT NULL,
  `p1_carSeat1w` tinyint(1) DEFAULT NULL,
  `p1_cribSafety1w` tinyint(1) DEFAULT NULL,
  `p1_sleeping1w` tinyint(1) DEFAULT NULL,
  `p1_sooth1w` tinyint(1) DEFAULT NULL,
  `p1_bonding1w` tinyint(1) DEFAULT NULL,
  `p1_fatigue1w` tinyint(1) DEFAULT NULL,
  `p1_siblings1w` tinyint(1) DEFAULT NULL,
  `p1_family1w` tinyint(1) DEFAULT NULL,
  `p1_homeVisit1w` tinyint(1) DEFAULT NULL,
  `p1_sleepPos1w` tinyint(1) DEFAULT NULL,
  `p1_temp1w` tinyint(1) DEFAULT NULL,
  `p1_smoke1w` tinyint(1) DEFAULT NULL,
  `p1_educationAdvice1w` varchar(250) DEFAULT NULL,
  `p1_carSeat2w` tinyint(1) DEFAULT NULL,
  `p1_cribSafety2w` tinyint(1) DEFAULT NULL,
  `p1_sleeping2w` tinyint(1) DEFAULT NULL,
  `p1_sooth2w` tinyint(1) DEFAULT NULL,
  `p1_bonding2w` tinyint(1) DEFAULT NULL,
  `p1_fatigue2w` tinyint(1) DEFAULT NULL,
  `p1_family2w` tinyint(1) DEFAULT NULL,
  `p1_siblings2w` tinyint(1) DEFAULT NULL,
  `p1_homeVisit2w` tinyint(1) DEFAULT NULL,
  `p1_sleepPos2w` tinyint(1) DEFAULT NULL,
  `p1_temp2w` tinyint(1) DEFAULT NULL,
  `p1_smoke2w` tinyint(1) DEFAULT NULL,
  `p1_educationAdvice2w` varchar(250) DEFAULT NULL,
  `p1_carbonMonoxide1m` tinyint(1) DEFAULT NULL,
  `p1_sleepwear1m` tinyint(1) DEFAULT NULL,
  `p1_hotWater1m` tinyint(1) DEFAULT NULL,
  `p1_toys1m` tinyint(1) DEFAULT NULL,
  `p1_crying1m` tinyint(1) DEFAULT NULL,
  `p1_sooth1m` tinyint(1) DEFAULT NULL,
  `p1_interaction1m` tinyint(1) DEFAULT NULL,
  `p1_supports1m` tinyint(1) DEFAULT NULL,
  `p1_educationAdvice1m` varchar(250) DEFAULT NULL,
  `p1_falls2m` tinyint(1) DEFAULT NULL,
  `p1_toys2m` tinyint(1) DEFAULT NULL,
  `p1_crying2m` tinyint(1) DEFAULT NULL,
  `p1_sooth2m` tinyint(1) DEFAULT NULL,
  `p1_interaction2m` tinyint(1) DEFAULT NULL,
  `p1_stress2m` tinyint(1) DEFAULT NULL,
  `p1_fever2m` tinyint(1) DEFAULT NULL,
  `p1_educationAdvice2m` varchar(250) DEFAULT NULL,
  `p1_development1w` varchar(250) DEFAULT NULL,
  `p1_development2w` varchar(250) DEFAULT NULL,
  `p1_focusGaze1m` tinyint(1) DEFAULT NULL,
  `p1_startles1m` tinyint(1) DEFAULT NULL,
  `p1_sucks1m` tinyint(1) DEFAULT NULL,
  `p1_noParentsConcerns1m` tinyint(1) DEFAULT NULL,
  `p1_development1m` varchar(250) DEFAULT NULL,
  `p1_followMoves2m` tinyint(1) DEFAULT NULL,
  `p1_sounds2m` tinyint(1) DEFAULT NULL,
  `p1_headUp2m` tinyint(1) DEFAULT NULL,
  `p1_cuddled2m` tinyint(1) DEFAULT NULL,
  `p1_noParentConcerns2m` tinyint(1) DEFAULT NULL,
  `p1_development2m` varchar(250) DEFAULT NULL,
  `p1_skin1w` tinyint(1) DEFAULT NULL,
  `p1_fontanelles1w` tinyint(1) DEFAULT NULL,
  `p1_eyes1w` tinyint(1) DEFAULT NULL,
  `p1_ears1w` tinyint(1) DEFAULT NULL,
  `p1_heartLungs1w` tinyint(1) DEFAULT NULL,
  `p1_umbilicus1w` tinyint(1) DEFAULT NULL,
  `p1_femoralPulses1w` tinyint(1) DEFAULT NULL,
  `p1_hips1w` tinyint(1) DEFAULT NULL,
  `p1_testicles1w` tinyint(1) DEFAULT NULL,
  `p1_maleUrinary1w` tinyint(1) DEFAULT NULL,
  `p1_physical1w` varchar(250) DEFAULT NULL,
  `p1_skin2w` tinyint(1) DEFAULT NULL,
  `p1_fontanelles2w` tinyint(1) DEFAULT NULL,
  `p1_eyes2w` tinyint(1) DEFAULT NULL,
  `p1_ears2w` tinyint(1) DEFAULT NULL,
  `p1_heartLungs2w` tinyint(1) DEFAULT NULL,
  `p1_umbilicus2w` tinyint(1) DEFAULT NULL,
  `p1_femoralPulses2w` tinyint(1) DEFAULT NULL,
  `p1_hips2w` tinyint(1) DEFAULT NULL,
  `p1_testicles2w` tinyint(1) DEFAULT NULL,
  `p1_maleUrinary2w` tinyint(1) DEFAULT NULL,
  `p1_physical2w` varchar(250) DEFAULT NULL,
  `p1_fontanelles1m` tinyint(1) DEFAULT NULL,
  `p1_eyes1m` tinyint(1) DEFAULT NULL,
  `p1_cover1m` tinyint(1) DEFAULT NULL,
  `p1_hearing1m` tinyint(1) DEFAULT NULL,
  `p1_heart1m` tinyint(1) DEFAULT NULL,
  `p1_hips1m` tinyint(1) DEFAULT NULL,
  `p1_physical1m` varchar(250) DEFAULT NULL,
  `p1_fontanelles2m` tinyint(1) DEFAULT NULL,
  `p1_eyes2m` tinyint(1) DEFAULT NULL,
  `p1_cover2m` tinyint(1) DEFAULT NULL,
  `p1_hearing2m` tinyint(1) DEFAULT NULL,
  `p1_heart2m` tinyint(1) DEFAULT NULL,
  `p1_hips2m` tinyint(1) DEFAULT NULL,
  `p1_physical2m` varchar(250) DEFAULT NULL,
  `p1_pkuThyroid1w` tinyint(1) DEFAULT NULL,
  `p1_hemoScreen1w` tinyint(1) DEFAULT NULL,
  `p1_problems1w` varchar(250) DEFAULT NULL,
  `p1_problems2w` varchar(250) DEFAULT NULL,
  `p1_problems1m` varchar(250) DEFAULT NULL,
  `p1_problems2m` varchar(250) DEFAULT NULL,
  `p1_hepB1w` tinyint(1) DEFAULT NULL,
  `p1_immunization1w` varchar(250) DEFAULT NULL,
  `p1_immunization2w` varchar(250) DEFAULT NULL,
  `p1_immuniz1m` tinyint(1) DEFAULT NULL,
  `p1_acetaminophen1m` tinyint(1) DEFAULT NULL,
  `p1_hepB1m` tinyint(1) DEFAULT NULL,
  `p1_immunization1m` varchar(250) DEFAULT NULL,
  `p1_acetaminophen2m` tinyint(1) DEFAULT NULL,
  `p1_hib2m` tinyint(1) DEFAULT NULL,
  `p1_polio2m` tinyint(1) DEFAULT NULL,
  `p1_immunization2m` varchar(250) DEFAULT NULL,
  `p1_signature1w` varchar(250) DEFAULT NULL,
  `p1_signature2w` varchar(250) DEFAULT NULL,
  `p1_signature1m` varchar(250) DEFAULT NULL,
  `p1_signature2m` varchar(250) DEFAULT NULL,
  `p2_date4m` date DEFAULT NULL,
  `p2_date6m` date DEFAULT NULL,
  `p2_date9m` date DEFAULT NULL,
  `p2_date12m` date DEFAULT NULL,
  `p2_ht4m` varchar(5) DEFAULT NULL,
  `p2_wt4m` varchar(5) DEFAULT NULL,
  `p2_hc4m` varchar(5) DEFAULT NULL,
  `p2_ht6m` varchar(5) DEFAULT NULL,
  `p2_wt6m` varchar(5) DEFAULT NULL,
  `p2_hc6m` varchar(5) DEFAULT NULL,
  `p2_ht9m` varchar(5) DEFAULT NULL,
  `p2_wt9m` varchar(5) DEFAULT NULL,
  `p2_hc9m` varchar(5) DEFAULT NULL,
  `p2_ht12m` varchar(5) DEFAULT NULL,
  `p2_wt12m` varchar(5) DEFAULT NULL,
  `p2_hc12m` varchar(5) DEFAULT NULL,
  `p2_pConcern4m` text,
  `p2_pConcern6m` text,
  `p2_pConcern9m` text,
  `p2_pConcern12m` text,
  `p2_breastFeeding4m` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding4m` tinyint(1) DEFAULT NULL,
  `p2_cereal4m` tinyint(1) DEFAULT NULL,
  `p2_nutrition4m` varchar(250) DEFAULT NULL,
  `p2_breastFeeding6m` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding6m` tinyint(1) DEFAULT NULL,
  `p2_bottle6m` tinyint(1) DEFAULT NULL,
  `p2_vegFruit6m` tinyint(1) DEFAULT NULL,
  `p2_egg6m` tinyint(1) DEFAULT NULL,
  `p2_choking6m` tinyint(1) DEFAULT NULL,
  `p2_nutrition6m` varchar(250) DEFAULT NULL,
  `p2_breastFeeding9m` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding9m` tinyint(1) DEFAULT NULL,
  `p2_bottle9m` tinyint(1) DEFAULT NULL,
  `p2_meat9m` tinyint(1) DEFAULT NULL,
  `p2_milk9m` tinyint(1) DEFAULT NULL,
  `p2_egg9m` tinyint(1) DEFAULT NULL,
  `p2_choking9m` tinyint(1) DEFAULT NULL,
  `p2_nutrition9m` varchar(250) DEFAULT NULL,
  `p2_milk12m` tinyint(1) DEFAULT NULL,
  `p2_bottle12m` tinyint(1) DEFAULT NULL,
  `p2_appetite12m` tinyint(1) DEFAULT NULL,
  `p2_nutrition12m` varchar(250) DEFAULT NULL,
  `p2_carSeat4m` tinyint(1) DEFAULT NULL,
  `p2_stairs4m` tinyint(1) DEFAULT NULL,
  `p2_bath4m` tinyint(1) DEFAULT NULL,
  `p2_sleeping4m` tinyint(1) DEFAULT NULL,
  `p2_parent4m` tinyint(1) DEFAULT NULL,
  `p2_childCare4m` tinyint(1) DEFAULT NULL,
  `p2_family4m` tinyint(1) DEFAULT NULL,
  `p2_teething4m` tinyint(1) DEFAULT NULL,
  `p2_educationAdvice4m` varchar(250) DEFAULT NULL,
  `p2_poison6m` tinyint(1) DEFAULT NULL,
  `p2_electric6m` tinyint(1) DEFAULT NULL,
  `p2_sleeping6m` tinyint(1) DEFAULT NULL,
  `p2_parent6m` tinyint(1) DEFAULT NULL,
  `p2_childCare6m` tinyint(1) DEFAULT NULL,
  `p2_educationAdvice6m` varchar(250) DEFAULT NULL,
  `p2_childProof9m` tinyint(1) DEFAULT NULL,
  `p2_separation9m` tinyint(1) DEFAULT NULL,
  `p2_sleeping9m` tinyint(1) DEFAULT NULL,
  `p2_dayCare9m` tinyint(1) DEFAULT NULL,
  `p2_homeVisit9m` tinyint(1) DEFAULT NULL,
  `p2_smoke9m` tinyint(1) DEFAULT NULL,
  `p2_educationAdvice9m` varchar(250) DEFAULT NULL,
  `p2_poison12m` tinyint(1) DEFAULT NULL,
  `p2_electric12m` tinyint(1) DEFAULT NULL,
  `p2_carbon12m` tinyint(1) DEFAULT NULL,
  `p2_hotWater12m` tinyint(1) DEFAULT NULL,
  `p2_sleeping12m` tinyint(1) DEFAULT NULL,
  `p2_parent12m` tinyint(1) DEFAULT NULL,
  `p2_teething12m` tinyint(1) DEFAULT NULL,
  `p2_educationAdvice12m` varchar(250) DEFAULT NULL,
  `p2_turnHead4m` tinyint(1) DEFAULT NULL,
  `p2_laugh4m` tinyint(1) DEFAULT NULL,
  `p2_headSteady4m` tinyint(1) DEFAULT NULL,
  `p2_grasp4m` tinyint(1) DEFAULT NULL,
  `p2_concern4m` tinyint(1) DEFAULT NULL,
  `p2_development4m` varchar(250) DEFAULT NULL,
  `p2_follow6m` tinyint(1) DEFAULT NULL,
  `p2_respond6m` tinyint(1) DEFAULT NULL,
  `p2_babbles6m` tinyint(1) DEFAULT NULL,
  `p2_rolls6m` tinyint(1) DEFAULT NULL,
  `p2_sits6m` tinyint(1) DEFAULT NULL,
  `p2_mouth6m` tinyint(1) DEFAULT NULL,
  `p2_concern6m` tinyint(1) DEFAULT NULL,
  `p2_development6m` varchar(250) DEFAULT NULL,
  `p2_looks9m` tinyint(1) DEFAULT NULL,
  `p2_babbles9m` tinyint(1) DEFAULT NULL,
  `p2_sits9m` tinyint(1) DEFAULT NULL,
  `p2_stands9m` tinyint(1) DEFAULT NULL,
  `p2_opposes9m` tinyint(1) DEFAULT NULL,
  `p2_reaches9m` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns9m` tinyint(1) DEFAULT NULL,
  `p2_development9m` varchar(250) DEFAULT NULL,
  `p2_understands12m` tinyint(1) DEFAULT NULL,
  `p2_chatters12m` tinyint(1) DEFAULT NULL,
  `p2_crawls12m` tinyint(1) DEFAULT NULL,
  `p2_pulls12m` tinyint(1) DEFAULT NULL,
  `p2_emotions12m` tinyint(1) DEFAULT NULL,
  `p2_noParentConcerns12m` tinyint(1) DEFAULT NULL,
  `p2_development12m` varchar(250) DEFAULT NULL,
  `p2_eyes4m` tinyint(1) DEFAULT NULL,
  `p2_cover4m` tinyint(1) DEFAULT NULL,
  `p2_hearing4m` tinyint(1) DEFAULT NULL,
  `p2_babbling4m` tinyint(1) DEFAULT NULL,
  `p2_hips4m` tinyint(1) DEFAULT NULL,
  `p2_physical4m` varchar(250) DEFAULT NULL,
  `p2_fontanelles6m` tinyint(1) DEFAULT NULL,
  `p2_eyes6m` tinyint(1) DEFAULT NULL,
  `p2_cover6m` tinyint(1) DEFAULT NULL,
  `p2_hearing6m` tinyint(1) DEFAULT NULL,
  `p2_hips6m` tinyint(1) DEFAULT NULL,
  `p2_physical6m` varchar(250) DEFAULT NULL,
  `p2_eyes9m` tinyint(1) DEFAULT NULL,
  `p2_cover9m` tinyint(1) DEFAULT NULL,
  `p2_hearing9m` tinyint(1) DEFAULT NULL,
  `p2_physical9m` varchar(250) DEFAULT NULL,
  `p2_eyes12m` tinyint(1) DEFAULT NULL,
  `p2_cover12m` tinyint(1) DEFAULT NULL,
  `p2_hearing12m` tinyint(1) DEFAULT NULL,
  `p2_hips12m` tinyint(1) DEFAULT NULL,
  `p2_physical12m` varchar(250) DEFAULT NULL,
  `p2_problems4m` varchar(250) DEFAULT NULL,
  `p2_tb6m` tinyint(1) DEFAULT NULL,
  `p2_problems6m` varchar(250) DEFAULT NULL,
  `p2_antiHbs9m` tinyint(1) DEFAULT NULL,
  `p2_hgb9m` tinyint(1) DEFAULT NULL,
  `p2_problems9m` varchar(250) DEFAULT NULL,
  `p2_hgb12m` tinyint(1) DEFAULT NULL,
  `p2_serum12m` tinyint(1) DEFAULT NULL,
  `p2_problems12m` varchar(250) DEFAULT NULL,
  `p2_hib4m` tinyint(1) DEFAULT NULL,
  `p2_polio4m` tinyint(1) DEFAULT NULL,
  `p2_immunization4m` varchar(250) DEFAULT NULL,
  `p2_hib6m` tinyint(1) DEFAULT NULL,
  `p2_polio6m` tinyint(1) DEFAULT NULL,
  `p2_hepB6m` tinyint(1) DEFAULT NULL,
  `p2_immunization6m` varchar(250) DEFAULT NULL,
  `p2_tbSkin9m` tinyint(1) DEFAULT NULL,
  `p2_immunization9m` varchar(250) DEFAULT NULL,
  `p2_mmr12m` tinyint(1) DEFAULT NULL,
  `p2_varicella12m` tinyint(1) DEFAULT NULL,
  `p2_immunization12m` varchar(250) DEFAULT NULL,
  `p2_signature4m` varchar(250) DEFAULT NULL,
  `p2_signature6m` varchar(250) DEFAULT NULL,
  `p2_signature9m` varchar(250) DEFAULT NULL,
  `p2_signature12m` varchar(250) DEFAULT NULL,
  `p3_date18m` date DEFAULT NULL,
  `p3_date2y` date DEFAULT NULL,
  `p3_date4y` date DEFAULT NULL,
  `p3_ht18m` varchar(5) DEFAULT NULL,
  `p3_wt18m` varchar(5) DEFAULT NULL,
  `p3_hc18m` varchar(5) DEFAULT NULL,
  `p3_ht2y` varchar(5) DEFAULT NULL,
  `p3_wt2y` varchar(5) DEFAULT NULL,
  `p3_ht4y` varchar(5) DEFAULT NULL,
  `p3_wt4y` varchar(5) DEFAULT NULL,
  `p3_pConcern18m` text,
  `p3_pConcern2y` text,
  `p3_pConcern4y` text,
  `p3_bottle18m` tinyint(1) DEFAULT NULL,
  `p3_nutrition18m` varchar(250) DEFAULT NULL,
  `p3_milk2y` tinyint(1) DEFAULT NULL,
  `p3_food2y` tinyint(1) DEFAULT NULL,
  `p3_nutrition2y` varchar(250) DEFAULT NULL,
  `p3_milk4y` tinyint(1) DEFAULT NULL,
  `p3_food4y` tinyint(1) DEFAULT NULL,
  `p3_nutrition4y` varchar(250) DEFAULT NULL,
  `p3_bath18m` tinyint(1) DEFAULT NULL,
  `p3_choking18m` tinyint(1) DEFAULT NULL,
  `p3_temperment18m` tinyint(1) DEFAULT NULL,
  `p3_limit18m` tinyint(1) DEFAULT NULL,
  `p3_social18m` tinyint(1) DEFAULT NULL,
  `p3_dental18m` tinyint(1) DEFAULT NULL,
  `p3_toilet18m` tinyint(1) DEFAULT NULL,
  `p3_educationAdvice18m` varchar(250) DEFAULT NULL,
  `p3_bike2y` tinyint(1) DEFAULT NULL,
  `p3_matches2y` tinyint(1) DEFAULT NULL,
  `p3_carbon2y` tinyint(1) DEFAULT NULL,
  `p3_parent2y` tinyint(1) DEFAULT NULL,
  `p3_social2y` tinyint(1) DEFAULT NULL,
  `p3_dayCare2y` tinyint(1) DEFAULT NULL,
  `p3_dental2y` tinyint(1) DEFAULT NULL,
  `p3_toilet2y` tinyint(1) DEFAULT NULL,
  `p3_educationAdvice2y` varchar(250) DEFAULT NULL,
  `p3_bike4y` tinyint(1) DEFAULT NULL,
  `p3_matches4y` tinyint(1) DEFAULT NULL,
  `p3_carbon4y` tinyint(1) DEFAULT NULL,
  `p3_water4y` tinyint(1) DEFAULT NULL,
  `p3_social4y` tinyint(1) DEFAULT NULL,
  `p3_dental4y` tinyint(1) DEFAULT NULL,
  `p3_school4y` tinyint(1) DEFAULT NULL,
  `p3_educationAdvice4y` varchar(250) DEFAULT NULL,
  `p3_points18m` tinyint(1) DEFAULT NULL,
  `p3_words18m` tinyint(1) DEFAULT NULL,
  `p3_picks18m` tinyint(1) DEFAULT NULL,
  `p3_walks18m` tinyint(1) DEFAULT NULL,
  `p3_stacks18m` tinyint(1) DEFAULT NULL,
  `p3_affection18m` tinyint(1) DEFAULT NULL,
  `p3_showParents18m` tinyint(1) DEFAULT NULL,
  `p3_looks18m` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns18m` tinyint(1) DEFAULT NULL,
  `p3_development18m` varchar(250) DEFAULT NULL,
  `p3_word2y` tinyint(1) DEFAULT NULL,
  `p3_sentence2y` tinyint(1) DEFAULT NULL,
  `p3_run2y` tinyint(1) DEFAULT NULL,
  `p3_container2y` tinyint(1) DEFAULT NULL,
  `p3_copies2y` tinyint(1) DEFAULT NULL,
  `p3_skills2y` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns2y` tinyint(1) DEFAULT NULL,
  `p3_development2y` varchar(250) DEFAULT NULL,
  `p3_understands3y` tinyint(1) DEFAULT NULL,
  `p3_twists3y` tinyint(1) DEFAULT NULL,
  `p3_turnPages3y` tinyint(1) DEFAULT NULL,
  `p3_share3y` tinyint(1) DEFAULT NULL,
  `p3_listens3y` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns3y` tinyint(1) DEFAULT NULL,
  `p3_development3y` varchar(250) DEFAULT NULL,
  `p3_understands4y` tinyint(1) DEFAULT NULL,
  `p3_questions4y` tinyint(1) DEFAULT NULL,
  `p3_oneFoot4y` tinyint(1) DEFAULT NULL,
  `p3_draws4y` tinyint(1) DEFAULT NULL,
  `p3_toilet4y` tinyint(1) DEFAULT NULL,
  `p3_comfort4y` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns4y` tinyint(1) DEFAULT NULL,
  `p3_development4y` varchar(250) DEFAULT NULL,
  `p3_counts5y` tinyint(1) DEFAULT NULL,
  `p3_speaks5y` tinyint(1) DEFAULT NULL,
  `p3_ball5y` tinyint(1) DEFAULT NULL,
  `p3_hops5y` tinyint(1) DEFAULT NULL,
  `p3_shares5y` tinyint(1) DEFAULT NULL,
  `p3_alone5y` tinyint(1) DEFAULT NULL,
  `p3_separate5y` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns5y` tinyint(1) DEFAULT NULL,
  `p3_development5y` varchar(250) DEFAULT NULL,
  `p3_eyes18m` tinyint(1) DEFAULT NULL,
  `p3_cover18m` tinyint(1) DEFAULT NULL,
  `p3_hearing18m` tinyint(1) DEFAULT NULL,
  `p3_physical18m` varchar(250) DEFAULT NULL,
  `p3_visual2y` tinyint(1) DEFAULT NULL,
  `p3_cover2y` tinyint(1) DEFAULT NULL,
  `p3_hearing2y` tinyint(1) DEFAULT NULL,
  `p3_physical2y` varchar(250) DEFAULT NULL,
  `p3_visual4y` tinyint(1) DEFAULT NULL,
  `p3_cover4y` tinyint(1) DEFAULT NULL,
  `p3_hearing4y` tinyint(1) DEFAULT NULL,
  `p3_blood4y` tinyint(1) DEFAULT NULL,
  `p3_physical4y` varchar(250) DEFAULT NULL,
  `p3_problems18m` varchar(250) DEFAULT NULL,
  `p3_serum2y` tinyint(1) DEFAULT NULL,
  `p3_problems2y` varchar(250) DEFAULT NULL,
  `p3_problems4y` varchar(250) DEFAULT NULL,
  `p3_hib18m` tinyint(1) DEFAULT NULL,
  `p3_polio18m` tinyint(1) DEFAULT NULL,
  `p3_immunization18m` varchar(250) DEFAULT NULL,
  `p3_immunization2y` varchar(250) DEFAULT NULL,
  `p3_mmr4y` tinyint(1) DEFAULT NULL,
  `p3_polio4y` tinyint(1) DEFAULT NULL,
  `p3_immunization4y` varchar(250) DEFAULT NULL,
  `p3_signature18m` varchar(250) DEFAULT NULL,
  `p3_signature2y` varchar(50) DEFAULT NULL,
  `p3_signature4y` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formRourke2006`
--

DROP TABLE IF EXISTS `formRourke2006`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formRourke2006` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_lastVisited` char(3) DEFAULT NULL,
  `c_birthRemarks` text,
  `c_riskFactors` text,
  `c_famHistory` text,
  `c_pName` varchar(60) DEFAULT NULL,
  `c_birthDate` date DEFAULT NULL,
  `c_length` varchar(6) DEFAULT NULL,
  `c_headCirc` varchar(6) DEFAULT NULL,
  `c_birthWeight` varchar(7) DEFAULT NULL,
  `c_dischargeWeight` varchar(7) DEFAULT NULL,
  `p1_date1w` date DEFAULT NULL,
  `p1_date2w` date DEFAULT NULL,
  `p1_date1m` date DEFAULT NULL,
  `p1_ht1w` varchar(5) DEFAULT NULL,
  `p1_wt1w` varchar(5) DEFAULT NULL,
  `p1_hc1w` varchar(5) DEFAULT NULL,
  `p1_ht2w` varchar(5) DEFAULT NULL,
  `p1_wt2w` varchar(5) DEFAULT NULL,
  `p1_hc2w` varchar(5) DEFAULT NULL,
  `p1_ht1m` varchar(5) DEFAULT NULL,
  `p1_wt1m` varchar(5) DEFAULT NULL,
  `p1_hc1m` varchar(5) DEFAULT NULL,
  `p1_pConcern1w` text,
  `p1_pConcern2w` text,
  `p1_pConcern1m` text,
  `p1_breastFeeding1w` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1w` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine1w` tinyint(1) DEFAULT NULL,
  `p1_nutrition1w` varchar(250) DEFAULT NULL,
  `p1_breastFeeding2w` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding2w` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine2w` tinyint(1) DEFAULT NULL,
  `p1_nutrition2w` varchar(250) DEFAULT NULL,
  `p1_breastFeeding1m` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1m` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine1m` tinyint(1) DEFAULT NULL,
  `p1_nutrition1m` varchar(250) DEFAULT NULL,
  `p1_carSeatOk` tinyint(1) DEFAULT NULL,
  `p1_carSeatNo` tinyint(1) DEFAULT NULL,
  `p1_sleepPosOk` tinyint(1) DEFAULT NULL,
  `p1_sleepPosNo` tinyint(1) DEFAULT NULL,
  `p1_cribSafetyOk` tinyint(1) DEFAULT NULL,
  `p1_cribSafetyNo` tinyint(1) DEFAULT NULL,
  `p1_firearmSafetyOk` tinyint(1) DEFAULT NULL,
  `p1_firearmSafetyNo` tinyint(1) DEFAULT NULL,
  `p1_smokeSafetyOk` tinyint(1) DEFAULT NULL,
  `p1_smokeSafetyNo` tinyint(1) DEFAULT NULL,
  `p1_hotWaterOk` tinyint(1) DEFAULT NULL,
  `p1_hotWaterNo` tinyint(1) DEFAULT NULL,
  `p1_safeToysOk` tinyint(1) DEFAULT NULL,
  `p1_safeToysNo` tinyint(1) DEFAULT NULL,
  `p1_sleepCryOk` tinyint(1) DEFAULT NULL,
  `p1_sleepCryNo` tinyint(1) DEFAULT NULL,
  `p1_soothabilityOk` tinyint(1) DEFAULT NULL,
  `p1_soothabilityNo` tinyint(1) DEFAULT NULL,
  `p1_homeVisitOk` tinyint(1) DEFAULT NULL,
  `p1_homeVisitNo` tinyint(1) DEFAULT NULL,
  `p1_bondingOk` tinyint(1) DEFAULT NULL,
  `p1_bondingNo` tinyint(1) DEFAULT NULL,
  `p1_pFatigueOk` tinyint(1) DEFAULT NULL,
  `p1_pFatigueNo` tinyint(1) DEFAULT NULL,
  `p1_famConflictOk` tinyint(1) DEFAULT NULL,
  `p1_famConflictNo` tinyint(1) DEFAULT NULL,
  `p1_siblingsOk` tinyint(1) DEFAULT NULL,
  `p1_siblingsNo` tinyint(1) DEFAULT NULL,
  `p1_2ndSmokeOk` tinyint(1) DEFAULT NULL,
  `p1_2ndSmokeNo` tinyint(1) DEFAULT NULL,
  `p1_altMedOk` tinyint(1) DEFAULT NULL,
  `p1_altMedNo` tinyint(1) DEFAULT NULL,
  `p1_pacifierOk` tinyint(1) DEFAULT NULL,
  `p1_pacifierNo` tinyint(1) DEFAULT NULL,
  `p1_feverOk` tinyint(1) DEFAULT NULL,
  `p1_feverNo` tinyint(1) DEFAULT NULL,
  `p1_tmpControlOk` tinyint(1) DEFAULT NULL,
  `p1_tmpControlNo` tinyint(1) DEFAULT NULL,
  `p1_sunExposureOk` tinyint(1) DEFAULT NULL,
  `p1_sunExposureNo` tinyint(1) DEFAULT NULL,
  `p1_development1w` text,
  `p1_development2w` text,
  `p1_development1m` text,
  `p1_focusGaze1mOk` tinyint(1) DEFAULT NULL,
  `p1_focusGaze1mNo` tinyint(1) DEFAULT NULL,
  `p1_startles1mOk` tinyint(1) DEFAULT NULL,
  `p1_startles1mNo` tinyint(1) DEFAULT NULL,
  `p1_sucks1mOk` tinyint(1) DEFAULT NULL,
  `p1_sucks1mNo` tinyint(1) DEFAULT NULL,
  `p1_noParentsConcerns1mOk` tinyint(1) DEFAULT NULL,
  `p1_noParentsConcerns1mNo` tinyint(1) DEFAULT NULL,
  `p1_skin1w` tinyint(1) DEFAULT NULL,
  `p1_fontanelles1w` tinyint(1) DEFAULT NULL,
  `p1_eyes1w` tinyint(1) DEFAULT NULL,
  `p1_ears1w` tinyint(1) DEFAULT NULL,
  `p1_heartLungs1w` tinyint(1) DEFAULT NULL,
  `p1_umbilicus1w` tinyint(1) DEFAULT NULL,
  `p1_femoralPulses1w` tinyint(1) DEFAULT NULL,
  `p1_hips1w` tinyint(1) DEFAULT NULL,
  `p1_muscleTone1w` tinyint(1) DEFAULT NULL,
  `p1_testicles1w` tinyint(1) DEFAULT NULL,
  `p1_maleUrinary1w` tinyint(1) DEFAULT NULL,
  `p1_skin2w` tinyint(1) DEFAULT NULL,
  `p1_fontanelles2w` tinyint(1) DEFAULT NULL,
  `p1_eyes2w` tinyint(1) DEFAULT NULL,
  `p1_ears2w` tinyint(1) DEFAULT NULL,
  `p1_heartLungs2w` tinyint(1) DEFAULT NULL,
  `p1_umbilicus2w` tinyint(1) DEFAULT NULL,
  `p1_femoralPulses2w` tinyint(1) DEFAULT NULL,
  `p1_hips2w` tinyint(1) DEFAULT NULL,
  `p1_muscleTone2w` tinyint(1) DEFAULT NULL,
  `p1_testicles2w` tinyint(1) DEFAULT NULL,
  `p1_maleUrinary2w` tinyint(1) DEFAULT NULL,
  `p1_fontanelles1m` tinyint(1) DEFAULT NULL,
  `p1_eyes1m` tinyint(1) DEFAULT NULL,
  `p1_corneal1m` tinyint(1) DEFAULT NULL,
  `p1_hearing1m` tinyint(1) DEFAULT NULL,
  `p1_heart1m` tinyint(1) DEFAULT NULL,
  `p1_hips1m` tinyint(1) DEFAULT NULL,
  `p1_muscleTone1m` tinyint(1) DEFAULT NULL,
  `p1_pkuThyroid1w` tinyint(1) DEFAULT NULL,
  `p1_hemoScreen1w` tinyint(1) DEFAULT NULL,
  `p1_problems1w` text,
  `p1_problems2w` text,
  `p1_problems1m` text,
  `p1_hepatitisVaccine1w` tinyint(1) DEFAULT NULL,
  `p1_hepatitisVaccine1m` tinyint(1) DEFAULT NULL,
  `p1_signature2w` varchar(250) DEFAULT NULL,
  `p2_date2m` date DEFAULT NULL,
  `p2_date4m` date DEFAULT NULL,
  `p2_date6m` date DEFAULT NULL,
  `p2_ht2m` varchar(5) DEFAULT NULL,
  `p2_wt2m` varchar(5) DEFAULT NULL,
  `p2_hc2m` varchar(5) DEFAULT NULL,
  `p2_ht4m` varchar(5) DEFAULT NULL,
  `p2_wt4m` varchar(5) DEFAULT NULL,
  `p2_hc4m` varchar(5) DEFAULT NULL,
  `p2_ht6m` varchar(5) DEFAULT NULL,
  `p2_wt6m` varchar(5) DEFAULT NULL,
  `p2_hc6m` varchar(5) DEFAULT NULL,
  `p2_pConcern2m` text,
  `p2_pConcern4m` text,
  `p2_pConcern6m` text,
  `p2_nutrition2m` text,
  `p2_breastFeeding2m` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding2m` tinyint(1) DEFAULT NULL,
  `p2_nutrition4m` text,
  `p2_breastFeeding4m` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding4m` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding6m` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding6m` tinyint(1) DEFAULT NULL,
  `p2_bottle6m` tinyint(1) DEFAULT NULL,
  `p2_liquids6m` tinyint(1) DEFAULT NULL,
  `p2_iron6m` tinyint(1) DEFAULT NULL,
  `p2_vegFruit6m` tinyint(1) DEFAULT NULL,
  `p2_egg6m` tinyint(1) DEFAULT NULL,
  `p2_choking6m` tinyint(1) DEFAULT NULL,
  `p2_carSeatOk` tinyint(1) DEFAULT NULL,
  `p2_carSeatNo` tinyint(1) DEFAULT NULL,
  `p2_sleepPosOk` tinyint(1) DEFAULT NULL,
  `p2_sleepPosNo` tinyint(1) DEFAULT NULL,
  `p2_poisonsOk` tinyint(1) DEFAULT NULL,
  `p2_poisonsNo` tinyint(1) DEFAULT NULL,
  `p2_firearmSafetyOk` tinyint(1) DEFAULT NULL,
  `p2_firearmSafetyNo` tinyint(1) DEFAULT NULL,
  `p2_electricOk` tinyint(1) DEFAULT NULL,
  `p2_electricNo` tinyint(1) DEFAULT NULL,
  `p2_smokeSafetyOk` tinyint(1) DEFAULT NULL,
  `p2_smokeSafetyNo` tinyint(1) DEFAULT NULL,
  `p2_hotWaterOk` tinyint(1) DEFAULT NULL,
  `p2_hotWaterNo` tinyint(1) DEFAULT NULL,
  `p2_fallsOk` tinyint(1) DEFAULT NULL,
  `p2_fallsNo` tinyint(1) DEFAULT NULL,
  `p2_safeToysOk` tinyint(1) DEFAULT NULL,
  `p2_safeToysNo` tinyint(1) DEFAULT NULL,
  `p2_sleepCryOk` tinyint(1) DEFAULT NULL,
  `p2_sleepCryNo` tinyint(1) DEFAULT NULL,
  `p2_soothabilityOk` tinyint(1) DEFAULT NULL,
  `p2_soothabilityNo` tinyint(1) DEFAULT NULL,
  `p2_homeVisitOk` tinyint(1) DEFAULT NULL,
  `p2_homeVisitNo` tinyint(1) DEFAULT NULL,
  `p2_bondingOk` tinyint(1) DEFAULT NULL,
  `p2_bondingNo` tinyint(1) DEFAULT NULL,
  `p2_pFatigueOk` tinyint(1) DEFAULT NULL,
  `p2_pFatigueNo` tinyint(1) DEFAULT NULL,
  `p2_famConflictOk` tinyint(1) DEFAULT NULL,
  `p2_famConflictNo` tinyint(1) DEFAULT NULL,
  `p2_siblingsOk` tinyint(1) DEFAULT NULL,
  `p2_siblingsNo` tinyint(1) DEFAULT NULL,
  `p2_childCareOk` tinyint(1) DEFAULT NULL,
  `p2_childCareNo` tinyint(1) DEFAULT NULL,
  `p2_2ndSmokeOk` tinyint(1) DEFAULT NULL,
  `p2_2ndSmokeNo` tinyint(1) DEFAULT NULL,
  `p2_teethingOk` tinyint(1) DEFAULT NULL,
  `p2_teethingNo` tinyint(1) DEFAULT NULL,
  `p2_altMedOk` tinyint(1) DEFAULT NULL,
  `p2_altMedNo` tinyint(1) DEFAULT NULL,
  `p2_pacifierOk` tinyint(1) DEFAULT NULL,
  `p2_pacifierNo` tinyint(1) DEFAULT NULL,
  `p2_tmpControlOk` tinyint(1) DEFAULT NULL,
  `p2_tmpControlNo` tinyint(1) DEFAULT NULL,
  `p2_feverOk` tinyint(1) DEFAULT NULL,
  `p2_feverNo` tinyint(1) DEFAULT NULL,
  `p2_sunExposureOk` tinyint(1) DEFAULT NULL,
  `p2_sunExposureNo` tinyint(1) DEFAULT NULL,
  `p2_pesticidesOk` tinyint(1) DEFAULT NULL,
  `p2_pesticidesNo` tinyint(1) DEFAULT NULL,
  `p2_development2m` text,
  `p2_eyesOk` tinyint(1) DEFAULT NULL,
  `p2_eyesNo` tinyint(1) DEFAULT NULL,
  `p2_soundsOk` tinyint(1) DEFAULT NULL,
  `p2_soundsNo` tinyint(1) DEFAULT NULL,
  `p2_headUpOk` tinyint(1) DEFAULT NULL,
  `p2_headUpNo` tinyint(1) DEFAULT NULL,
  `p2_cuddledOk` tinyint(1) DEFAULT NULL,
  `p2_cuddledNo` tinyint(1) DEFAULT NULL,
  `p2_smilesOk` tinyint(1) DEFAULT NULL,
  `p2_smilesNo` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns2mOk` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns2mNo` tinyint(1) DEFAULT NULL,
  `p2_development4m` text,
  `p2_turnsHeadOk` tinyint(1) DEFAULT NULL,
  `p2_turnsHeadNo` tinyint(1) DEFAULT NULL,
  `p2_laughsOk` tinyint(1) DEFAULT NULL,
  `p2_laughsNo` tinyint(1) DEFAULT NULL,
  `p2_headSteadyOk` tinyint(1) DEFAULT NULL,
  `p2_headSteadyNo` tinyint(1) DEFAULT NULL,
  `p2_graspOk` tinyint(1) DEFAULT NULL,
  `p2_graspNo` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns4mOk` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns4mNo` tinyint(1) DEFAULT NULL,
  `p2_development6m` text,
  `p2_movingObjOk` tinyint(1) DEFAULT NULL,
  `p2_movingObjNo` tinyint(1) DEFAULT NULL,
  `p2_looksOk` tinyint(1) DEFAULT NULL,
  `p2_looksNo` tinyint(1) DEFAULT NULL,
  `p2_babblesOk` tinyint(1) DEFAULT NULL,
  `p2_babblesNo` tinyint(1) DEFAULT NULL,
  `p2_rollsOk` tinyint(1) DEFAULT NULL,
  `p2_rollsNo` tinyint(1) DEFAULT NULL,
  `p2_sitsOk` tinyint(1) DEFAULT NULL,
  `p2_sitsNo` tinyint(1) DEFAULT NULL,
  `p2_handToMouthOk` tinyint(1) DEFAULT NULL,
  `p2_handToMouthNo` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns6mOk` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns6mNo` tinyint(1) DEFAULT NULL,
  `p2_fontanelles2m` tinyint(1) DEFAULT NULL,
  `p2_eyes2m` tinyint(1) DEFAULT NULL,
  `p2_corneal2m` tinyint(1) DEFAULT NULL,
  `p2_hearing2m` tinyint(1) DEFAULT NULL,
  `p2_heart2m` tinyint(1) DEFAULT NULL,
  `p2_hips2m` tinyint(1) DEFAULT NULL,
  `p2_muscleTone2m` tinyint(1) DEFAULT NULL,
  `p2_eyes4m` tinyint(1) DEFAULT NULL,
  `p2_corneal4m` tinyint(1) DEFAULT NULL,
  `p2_hearing4m` tinyint(1) DEFAULT NULL,
  `p2_hips4m` tinyint(1) DEFAULT NULL,
  `p2_muscleTone4m` tinyint(1) DEFAULT NULL,
  `p2_fontanelles6m` tinyint(1) DEFAULT NULL,
  `p2_eyes6m` tinyint(1) DEFAULT NULL,
  `p2_corneal6m` tinyint(1) DEFAULT NULL,
  `p2_hearing6m` tinyint(1) DEFAULT NULL,
  `p2_hips6m` tinyint(1) DEFAULT NULL,
  `p2_muscleTone6m` tinyint(1) DEFAULT NULL,
  `p2_problems2m` text,
  `p2_problems4m` text,
  `p2_problems6m` text,
  `p2_tb6m` tinyint(1) DEFAULT NULL,
  `p2_hepatitisVaccine6m` tinyint(1) DEFAULT NULL,
  `p2_signature2m` varchar(250) DEFAULT NULL,
  `p2_signature4m` varchar(250) DEFAULT NULL,
  `p3_date9m` date DEFAULT NULL,
  `p3_date12m` date DEFAULT NULL,
  `p3_date15m` date DEFAULT NULL,
  `p3_ht9m` varchar(5) DEFAULT NULL,
  `p3_wt9m` varchar(5) DEFAULT NULL,
  `p3_hc9m` varchar(5) DEFAULT NULL,
  `p3_ht12m` varchar(5) DEFAULT NULL,
  `p3_wt12m` varchar(5) DEFAULT NULL,
  `p3_hc12m` varchar(5) DEFAULT NULL,
  `p3_ht15m` varchar(5) DEFAULT NULL,
  `p3_wt15m` varchar(5) DEFAULT NULL,
  `p3_hc15m` varchar(5) DEFAULT NULL,
  `p3_pConcern9m` text,
  `p3_pConcern12m` text,
  `p3_pConcern15m` text,
  `p3_breastFeeding9m` tinyint(1) DEFAULT NULL,
  `p3_formulaFeeding9m` tinyint(1) DEFAULT NULL,
  `p3_bottle9m` tinyint(1) DEFAULT NULL,
  `p3_liquids9m` tinyint(1) DEFAULT NULL,
  `p3_cereal9m` tinyint(1) DEFAULT NULL,
  `p3_introCowMilk9m` tinyint(1) DEFAULT NULL,
  `p3_egg9m` tinyint(1) DEFAULT NULL,
  `p3_choking9m` tinyint(1) DEFAULT NULL,
  `p3_nutrition12m` text,
  `p3_breastFeeding12m` tinyint(1) DEFAULT NULL,
  `p3_homoMilk12m` tinyint(1) DEFAULT NULL,
  `p3_cup12m` tinyint(1) DEFAULT NULL,
  `p3_appetite12m` tinyint(1) DEFAULT NULL,
  `p3_choking12m` tinyint(1) DEFAULT NULL,
  `p3_nutrition15m` text,
  `p3_breastFeeding15m` tinyint(1) DEFAULT NULL,
  `p3_homoMilk15m` tinyint(1) DEFAULT NULL,
  `p3_choking15m` tinyint(1) DEFAULT NULL,
  `p3_cup15m` tinyint(1) DEFAULT NULL,
  `p3_carSeatOk` tinyint(1) DEFAULT NULL,
  `p3_carSeatNo` tinyint(1) DEFAULT NULL,
  `p3_poisonsOk` tinyint(1) DEFAULT NULL,
  `p3_poisonsNo` tinyint(1) DEFAULT NULL,
  `p3_firearmSafetyOk` tinyint(1) DEFAULT NULL,
  `p3_firearmSafetyNo` tinyint(1) DEFAULT NULL,
  `p3_smokeSafetyOk` tinyint(1) DEFAULT NULL,
  `p3_smokeSafetyNo` tinyint(1) DEFAULT NULL,
  `p3_hotWaterOk` tinyint(1) DEFAULT NULL,
  `p3_hotWaterNo` tinyint(1) DEFAULT NULL,
  `p3_electricOk` tinyint(1) DEFAULT NULL,
  `p3_electricNo` tinyint(1) DEFAULT NULL,
  `p3_fallsOk` tinyint(1) DEFAULT NULL,
  `p3_fallsNo` tinyint(1) DEFAULT NULL,
  `p3_safeToysOk` tinyint(1) DEFAULT NULL,
  `p3_safeToysNo` tinyint(1) DEFAULT NULL,
  `p3_sleepCryOk` tinyint(1) DEFAULT NULL,
  `p3_sleepCryNo` tinyint(1) DEFAULT NULL,
  `p3_soothabilityOk` tinyint(1) DEFAULT NULL,
  `p3_soothabilityNo` tinyint(1) DEFAULT NULL,
  `p3_homeVisitOk` tinyint(1) DEFAULT NULL,
  `p3_homeVisitNo` tinyint(1) DEFAULT NULL,
  `p3_parentingOk` tinyint(1) DEFAULT NULL,
  `p3_parentingNo` tinyint(1) DEFAULT NULL,
  `p3_pFatigueOk` tinyint(1) DEFAULT NULL,
  `p3_pFatigueNo` tinyint(1) DEFAULT NULL,
  `p3_famConflictOk` tinyint(1) DEFAULT NULL,
  `p3_famConflictNo` tinyint(1) DEFAULT NULL,
  `p3_siblingsOk` tinyint(1) DEFAULT NULL,
  `p3_siblingsNo` tinyint(1) DEFAULT NULL,
  `p3_childCareOk` tinyint(1) DEFAULT NULL,
  `p3_childCareNo` tinyint(1) DEFAULT NULL,
  `p3_2ndSmokeOk` tinyint(1) DEFAULT NULL,
  `p3_2ndSmokeNo` tinyint(1) DEFAULT NULL,
  `p3_teethingOk` tinyint(1) DEFAULT NULL,
  `p3_teethingNo` tinyint(1) DEFAULT NULL,
  `p3_altMedOk` tinyint(1) DEFAULT NULL,
  `p3_altMedNo` tinyint(1) DEFAULT NULL,
  `p3_pacifierOk` tinyint(1) DEFAULT NULL,
  `p3_pacifierNo` tinyint(1) DEFAULT NULL,
  `p3_feverOk` tinyint(1) DEFAULT NULL,
  `p3_feverNo` tinyint(1) DEFAULT NULL,
  `p3_activeOk` tinyint(1) DEFAULT NULL,
  `p3_activeNo` tinyint(1) DEFAULT NULL,
  `p3_readingOk` tinyint(1) DEFAULT NULL,
  `p3_readingNo` tinyint(1) DEFAULT NULL,
  `p3_footwearOk` tinyint(1) DEFAULT NULL,
  `p3_footwearNo` tinyint(1) DEFAULT NULL,
  `p3_sunExposureOk` tinyint(1) DEFAULT NULL,
  `p3_sunExposureNo` tinyint(1) DEFAULT NULL,
  `p3_checkSerumOk` tinyint(1) DEFAULT NULL,
  `p3_checkSerumNo` tinyint(1) DEFAULT NULL,
  `p3_pesticidesOk` tinyint(1) DEFAULT NULL,
  `p3_pesticidesNo` tinyint(1) DEFAULT NULL,
  `p3_development9m` text,
  `p3_hiddenToyOk` tinyint(1) DEFAULT NULL,
  `p3_hiddenToyNo` tinyint(1) DEFAULT NULL,
  `p3_soundsOk` tinyint(1) DEFAULT NULL,
  `p3_soundsNo` tinyint(1) DEFAULT NULL,
  `p3_makeSoundsOk` tinyint(1) DEFAULT NULL,
  `p3_makeSoundsNo` tinyint(1) DEFAULT NULL,
  `p3_sitsOk` tinyint(1) DEFAULT NULL,
  `p3_sitsNo` tinyint(1) DEFAULT NULL,
  `p3_standsOk` tinyint(1) DEFAULT NULL,
  `p3_standsNo` tinyint(1) DEFAULT NULL,
  `p3_thumbOk` tinyint(1) DEFAULT NULL,
  `p3_thumbNo` tinyint(1) DEFAULT NULL,
  `p3_pickedupOk` tinyint(1) DEFAULT NULL,
  `p3_pickedupNo` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns9mOk` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns9mNo` tinyint(1) DEFAULT NULL,
  `p3_development12m` text,
  `p3_respondsOk` tinyint(1) DEFAULT NULL,
  `p3_respondsNo` tinyint(1) DEFAULT NULL,
  `p3_simpleRequestsOk` tinyint(1) DEFAULT NULL,
  `p3_simpleRequestsNo` tinyint(1) DEFAULT NULL,
  `p3_chattersOk` tinyint(1) DEFAULT NULL,
  `p3_chattersNo` tinyint(1) DEFAULT NULL,
  `p3_shufflesOk` tinyint(1) DEFAULT NULL,
  `p3_shufflesNo` tinyint(1) DEFAULT NULL,
  `p3_pull2standOk` tinyint(1) DEFAULT NULL,
  `p3_pull2standNo` tinyint(1) DEFAULT NULL,
  `p3_emotionsOk` tinyint(1) DEFAULT NULL,
  `p3_emotionsNo` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns12mOk` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns12mNo` tinyint(1) DEFAULT NULL,
  `p3_says2wordsOk` tinyint(1) DEFAULT NULL,
  `p3_says2wordsNo` tinyint(1) DEFAULT NULL,
  `p3_reachesOk` tinyint(1) DEFAULT NULL,
  `p3_reachesNo` tinyint(1) DEFAULT NULL,
  `p3_fingerFoodsOk` tinyint(1) DEFAULT NULL,
  `p3_fingerFoodsNo` tinyint(1) DEFAULT NULL,
  `p3_crawlsStairsOk` tinyint(1) DEFAULT NULL,
  `p3_crawlsStairsNo` tinyint(1) DEFAULT NULL,
  `p3_squatsOk` tinyint(1) DEFAULT NULL,
  `p3_squatsNo` tinyint(1) DEFAULT NULL,
  `p3_tieShoesOk` tinyint(1) DEFAULT NULL,
  `p3_tieShoesNo` tinyint(1) DEFAULT NULL,
  `p3_stacks2blocksOk` tinyint(1) DEFAULT NULL,
  `p3_stacks2blocksNo` tinyint(1) DEFAULT NULL,
  `p3_howToReactOk` tinyint(1) DEFAULT NULL,
  `p3_howToReactNo` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns15mOk` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns15mNo` tinyint(1) DEFAULT NULL,
  `p3_eyes9m` tinyint(1) DEFAULT NULL,
  `p3_corneal9m` tinyint(1) DEFAULT NULL,
  `p3_hearing9m` tinyint(1) DEFAULT NULL,
  `p3_hips9m` tinyint(1) DEFAULT NULL,
  `p3_eyes12m` tinyint(1) DEFAULT NULL,
  `p3_corneal12m` tinyint(1) DEFAULT NULL,
  `p3_hearing12m` tinyint(1) DEFAULT NULL,
  `p3_tonsil12m` tinyint(1) DEFAULT NULL,
  `p3_hips12m` tinyint(1) DEFAULT NULL,
  `p3_eyes15m` tinyint(1) DEFAULT NULL,
  `p3_corneal15m` tinyint(1) DEFAULT NULL,
  `p3_hearing15m` tinyint(1) DEFAULT NULL,
  `p3_tonsil15m` tinyint(1) DEFAULT NULL,
  `p3_hips15m` tinyint(1) DEFAULT NULL,
  `p3_problems9m` text,
  `p3_problems12m` text,
  `p3_problems15m` text,
  `p3_antiHB9m` tinyint(1) DEFAULT NULL,
  `p3_hemoglobin9m` tinyint(1) DEFAULT NULL,
  `p3_hemoglobin12m` tinyint(1) DEFAULT NULL,
  `p3_signature9m` varchar(250) DEFAULT NULL,
  `p3_signature12m` varchar(250) DEFAULT NULL,
  `p3_signature15m` varchar(250) DEFAULT NULL,
  `p4_date18m` date DEFAULT NULL,
  `p4_date24m` date DEFAULT NULL,
  `p4_date48m` date DEFAULT NULL,
  `p4_ht18m` varchar(5) DEFAULT NULL,
  `p4_wt18m` varchar(5) DEFAULT NULL,
  `p4_hc18m` varchar(5) DEFAULT NULL,
  `p4_ht24m` varchar(5) DEFAULT NULL,
  `p4_wt24m` varchar(5) DEFAULT NULL,
  `p4_hc24m` varchar(5) DEFAULT NULL,
  `p4_ht48m` varchar(5) DEFAULT NULL,
  `p4_wt48m` varchar(5) DEFAULT NULL,
  `p4_pConcern18m` text,
  `p4_pConcern24m` text,
  `p4_pConcern48m` text,
  `p4_breastFeeding18m` tinyint(1) DEFAULT NULL,
  `p4_homoMilk` tinyint(1) DEFAULT NULL,
  `p4_bottle18m` tinyint(1) DEFAULT NULL,
  `p4_homo2percent24m` tinyint(1) DEFAULT NULL,
  `p4_lowerfatdiet24m` tinyint(1) DEFAULT NULL,
  `p4_foodguide24m` tinyint(1) DEFAULT NULL,
  `p4_2pMilk48m` tinyint(1) DEFAULT NULL,
  `p4_foodguide48m` tinyint(1) DEFAULT NULL,
  `p4_carSeat18mOk` tinyint(1) DEFAULT NULL,
  `p4_carSeat18mNo` tinyint(1) DEFAULT NULL,
  `p4_bathSafetyOk` tinyint(1) DEFAULT NULL,
  `p4_bathSafetyNo` tinyint(1) DEFAULT NULL,
  `p4_safeToysOk` tinyint(1) DEFAULT NULL,
  `p4_safeToysNo` tinyint(1) DEFAULT NULL,
  `p4_parentChild18mOk` tinyint(1) DEFAULT NULL,
  `p4_parentChild18mNo` tinyint(1) DEFAULT NULL,
  `p4_discipline18mOk` tinyint(1) DEFAULT NULL,
  `p4_discipline18mNo` tinyint(1) DEFAULT NULL,
  `p4_pFatigue18mOk` tinyint(1) DEFAULT NULL,
  `p4_pFatigue18mNo` tinyint(1) DEFAULT NULL,
  `p4_highRisk18mOk` tinyint(1) DEFAULT NULL,
  `p4_highRisk18mNo` tinyint(1) DEFAULT NULL,
  `p4_socializing18mOk` tinyint(1) DEFAULT NULL,
  `p4_socializing18mNo` tinyint(1) DEFAULT NULL,
  `p4_dentalCareOk` tinyint(1) DEFAULT NULL,
  `p4_dentalCareNo` tinyint(1) DEFAULT NULL,
  `p4_toiletLearning18mOk` tinyint(1) DEFAULT NULL,
  `p4_toiletLearning18mNo` tinyint(1) DEFAULT NULL,
  `p4_carSeat24mOk` tinyint(1) DEFAULT NULL,
  `p4_carSeat24mNo` tinyint(1) DEFAULT NULL,
  `p4_bikeHelmetsOk` tinyint(1) DEFAULT NULL,
  `p4_bikeHelmetsNo` tinyint(1) DEFAULT NULL,
  `p4_firearmSafetyOk` tinyint(1) DEFAULT NULL,
  `p4_firearmSafetyNo` tinyint(1) DEFAULT NULL,
  `p4_smokeSafetyOk` tinyint(1) DEFAULT NULL,
  `p4_smokeSafetyNo` tinyint(1) DEFAULT NULL,
  `p4_matchesOk` tinyint(1) DEFAULT NULL,
  `p4_matchesNo` tinyint(1) DEFAULT NULL,
  `p4_waterSafetyOk` tinyint(1) DEFAULT NULL,
  `p4_waterSafetyNo` tinyint(1) DEFAULT NULL,
  `p4_parentChild24mOk` tinyint(1) DEFAULT NULL,
  `p4_parentChild24mNo` tinyint(1) DEFAULT NULL,
  `p4_discipline24mOk` tinyint(1) DEFAULT NULL,
  `p4_discipline24mNo` tinyint(1) DEFAULT NULL,
  `p4_highRisk24mOk` tinyint(1) DEFAULT NULL,
  `p4_highRisk24mNo` tinyint(1) DEFAULT NULL,
  `p4_pFatigue24mOk` tinyint(1) DEFAULT NULL,
  `p4_pFatigue24mNo` tinyint(1) DEFAULT NULL,
  `p4_famConflictOk` tinyint(1) DEFAULT NULL,
  `p4_famConflictNo` tinyint(1) DEFAULT NULL,
  `p4_siblingsOk` tinyint(1) DEFAULT NULL,
  `p4_siblingsNo` tinyint(1) DEFAULT NULL,
  `p4_2ndSmokeOk` tinyint(1) DEFAULT NULL,
  `p4_2ndSmokeNo` tinyint(1) DEFAULT NULL,
  `p4_dentalCleaningOk` tinyint(1) DEFAULT NULL,
  `p4_dentalCleaningNo` tinyint(1) DEFAULT NULL,
  `p4_altMedOk` tinyint(1) DEFAULT NULL,
  `p4_altMedNo` tinyint(1) DEFAULT NULL,
  `p4_toiletLearning24mOk` tinyint(1) DEFAULT NULL,
  `p4_toiletLearning24mNo` tinyint(1) DEFAULT NULL,
  `p4_activeOk` tinyint(1) DEFAULT NULL,
  `p4_activeNo` tinyint(1) DEFAULT NULL,
  `p4_socializing24mOk` tinyint(1) DEFAULT NULL,
  `p4_socializing24mNo` tinyint(1) DEFAULT NULL,
  `p4_readingOk` tinyint(1) DEFAULT NULL,
  `p4_readingNo` tinyint(1) DEFAULT NULL,
  `p4_dayCareOk` tinyint(1) DEFAULT NULL,
  `p4_dayCareNo` tinyint(1) DEFAULT NULL,
  `p4_sunExposureOk` tinyint(1) DEFAULT NULL,
  `p4_sunExposureNo` tinyint(1) DEFAULT NULL,
  `p4_pesticidesOk` tinyint(1) DEFAULT NULL,
  `p4_pesticidesNo` tinyint(1) DEFAULT NULL,
  `p4_checkSerumOk` tinyint(1) DEFAULT NULL,
  `p4_checkSerumNo` tinyint(1) DEFAULT NULL,
  `p4_manageableOk` tinyint(1) DEFAULT NULL,
  `p4_manageableNo` tinyint(1) DEFAULT NULL,
  `p4_soothabilityOk` tinyint(1) DEFAULT NULL,
  `p4_soothabilityNo` tinyint(1) DEFAULT NULL,
  `p4_comfortOk` tinyint(1) DEFAULT NULL,
  `p4_comfortNo` tinyint(1) DEFAULT NULL,
  `p4_pointsOk` tinyint(1) DEFAULT NULL,
  `p4_pointsNo` tinyint(1) DEFAULT NULL,
  `p4_getAttnOk` tinyint(1) DEFAULT NULL,
  `p4_getAttnNo` tinyint(1) DEFAULT NULL,
  `p4_pretendPlayOk` tinyint(1) DEFAULT NULL,
  `p4_pretendPlayNo` tinyint(1) DEFAULT NULL,
  `p4_recsNameOk` tinyint(1) DEFAULT NULL,
  `p4_recsNameNo` tinyint(1) DEFAULT NULL,
  `p4_initSpeechOk` tinyint(1) DEFAULT NULL,
  `p4_initSpeechNo` tinyint(1) DEFAULT NULL,
  `p4_3consonantsOk` tinyint(1) DEFAULT NULL,
  `p4_3consonantsNo` tinyint(1) DEFAULT NULL,
  `p4_walksbackOk` tinyint(1) DEFAULT NULL,
  `p4_walksbackNo` tinyint(1) DEFAULT NULL,
  `p4_feedsSelfOk` tinyint(1) DEFAULT NULL,
  `p4_feedsSelfNo` tinyint(1) DEFAULT NULL,
  `p4_removesHatOk` tinyint(1) DEFAULT NULL,
  `p4_removesHatNo` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns18mOk` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns18mNo` tinyint(1) DEFAULT NULL,
  `p4_newWordsOk` tinyint(1) DEFAULT NULL,
  `p4_newWordsNo` tinyint(1) DEFAULT NULL,
  `p4_2wSentenceOk` tinyint(1) DEFAULT NULL,
  `p4_2wSentenceNo` tinyint(1) DEFAULT NULL,
  `p4_runsOk` tinyint(1) DEFAULT NULL,
  `p4_runsNo` tinyint(1) DEFAULT NULL,
  `p4_smallContainerOk` tinyint(1) DEFAULT NULL,
  `p4_smallContainerNo` tinyint(1) DEFAULT NULL,
  `p4_copiesActionsOk` tinyint(1) DEFAULT NULL,
  `p4_copiesActionsNo` tinyint(1) DEFAULT NULL,
  `p4_newSkillsOk` tinyint(1) DEFAULT NULL,
  `p4_newSkillsNo` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns24mOk` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns24mNo` tinyint(1) DEFAULT NULL,
  `p4_3directionsOk` tinyint(1) DEFAULT NULL,
  `p4_3directionsNo` tinyint(1) DEFAULT NULL,
  `p4_asksQuestionsOk` tinyint(1) DEFAULT NULL,
  `p4_asksQuestionsNo` tinyint(1) DEFAULT NULL,
  `p4_stands1footOk` tinyint(1) DEFAULT NULL,
  `p4_stands1footNo` tinyint(1) DEFAULT NULL,
  `p4_drawsOk` tinyint(1) DEFAULT NULL,
  `p4_drawsNo` tinyint(1) DEFAULT NULL,
  `p4_toiletTrainedOk` tinyint(1) DEFAULT NULL,
  `p4_toiletTrainedNo` tinyint(1) DEFAULT NULL,
  `p4_tries2comfortOk` tinyint(1) DEFAULT NULL,
  `p4_tries2comfortNo` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns48mOk` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns48mNo` tinyint(1) DEFAULT NULL,
  `p4_2directionsOk` tinyint(1) DEFAULT NULL,
  `p4_2directionsNo` tinyint(1) DEFAULT NULL,
  `p4_twistslidsOk` tinyint(1) DEFAULT NULL,
  `p4_twistslidsNo` tinyint(1) DEFAULT NULL,
  `p4_turnsPagesOk` tinyint(1) DEFAULT NULL,
  `p4_turnsPagesNo` tinyint(1) DEFAULT NULL,
  `p4_sharesSometimeOk` tinyint(1) DEFAULT NULL,
  `p4_sharesSometimeNo` tinyint(1) DEFAULT NULL,
  `p4_listenMusikOk` tinyint(1) DEFAULT NULL,
  `p4_listenMusikNo` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns36mOk` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns36mNo` tinyint(1) DEFAULT NULL,
  `p4_counts2tenOk` tinyint(1) DEFAULT NULL,
  `p4_counts2tenNo` tinyint(1) DEFAULT NULL,
  `p4_speaksClearlyOk` tinyint(1) DEFAULT NULL,
  `p4_speaksClearlyNo` tinyint(1) DEFAULT NULL,
  `p4_throwsCatchesOk` tinyint(1) DEFAULT NULL,
  `p4_throwsCatchesNo` tinyint(1) DEFAULT NULL,
  `p4_hops1footOk` tinyint(1) DEFAULT NULL,
  `p4_hops1footNo` tinyint(1) DEFAULT NULL,
  `p4_sharesWillinglyOk` tinyint(1) DEFAULT NULL,
  `p4_sharesWillinglyNo` tinyint(1) DEFAULT NULL,
  `p4_worksAloneOk` tinyint(1) DEFAULT NULL,
  `p4_worksAloneNo` tinyint(1) DEFAULT NULL,
  `p4_separatesOk` tinyint(1) DEFAULT NULL,
  `p4_separatesNo` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns60mOk` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns60mNo` tinyint(1) DEFAULT NULL,
  `p4_eyes18m` tinyint(1) DEFAULT NULL,
  `p4_corneal18m` tinyint(1) DEFAULT NULL,
  `p4_hearing18m` tinyint(1) DEFAULT NULL,
  `p4_tonsil18m` tinyint(1) DEFAULT NULL,
  `p4_bloodpressure24m` tinyint(1) DEFAULT NULL,
  `p4_eyes24m` tinyint(1) DEFAULT NULL,
  `p4_corneal24m` tinyint(1) DEFAULT NULL,
  `p4_hearing24m` tinyint(1) DEFAULT NULL,
  `p4_tonsil24m` tinyint(1) DEFAULT NULL,
  `p4_bloodpressure48m` tinyint(1) DEFAULT NULL,
  `p4_eyes48m` tinyint(1) DEFAULT NULL,
  `p4_corneal48m` tinyint(1) DEFAULT NULL,
  `p4_hearing48m` tinyint(1) DEFAULT NULL,
  `p4_tonsil48m` tinyint(1) DEFAULT NULL,
  `p4_problems18m` text,
  `p4_problems24m` text,
  `p4_problems48m` text,
  `p4_signature18m` varchar(250) DEFAULT NULL,
  `p4_signature24m` varchar(250) DEFAULT NULL,
  `p4_signature48m` varchar(250) DEFAULT NULL,
  `p1_signature1w` varchar(250) DEFAULT NULL,
  `p1_signature1m` varchar(250) DEFAULT NULL,
  `p2_signature6m` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formRourke2009`
--

DROP TABLE IF EXISTS `formRourke2009`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formRourke2009` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `c_lastVisited` char(3) DEFAULT NULL,
  `c_birthRemarks` text,
  `c_riskFactors` text,
  `c_famHistory` text,
  `c_pName` varchar(60) DEFAULT NULL,
  `c_birthDate` date DEFAULT NULL,
  `c_length` varchar(6) DEFAULT NULL,
  `c_headCirc` varchar(6) DEFAULT NULL,
  `c_birthWeight` varchar(7) DEFAULT NULL,
  `c_dischargeWeight` varchar(7) DEFAULT NULL,
  `c_fsa` char(3) DEFAULT NULL,
  `c_APGAR1min` int(11) DEFAULT NULL,
  `c_APGAR5min` int(11) DEFAULT NULL,
  `p1_2ndhandsmoke` tinyint(1) DEFAULT NULL,
  `p1_alcohol` tinyint(1) DEFAULT NULL,
  `p1_drugs` tinyint(1) DEFAULT NULL,
  `p1_birthRemarksr1` tinyint(1) DEFAULT NULL,
  `p1_birthRemarksr2` tinyint(1) DEFAULT NULL,
  `p1_birthRemarksr3` tinyint(1) DEFAULT NULL,
  `p1_date1w` date DEFAULT NULL,
  `p1_date2w` date DEFAULT NULL,
  `p1_date1m` date DEFAULT NULL,
  `p1_ht1w` varchar(5) DEFAULT NULL,
  `p1_wt1w` varchar(5) DEFAULT NULL,
  `p1_hc1w` varchar(5) DEFAULT NULL,
  `p1_ht2w` varchar(5) DEFAULT NULL,
  `p1_wt2w` varchar(5) DEFAULT NULL,
  `p1_hc2w` varchar(5) DEFAULT NULL,
  `p1_ht1m` varchar(5) DEFAULT NULL,
  `p1_wt1m` varchar(5) DEFAULT NULL,
  `p1_hc1m` varchar(5) DEFAULT NULL,
  `p1_pConcern1w` text,
  `p1_pConcern2w` text,
  `p1_pConcern1m` text,
  `p1_breastFeeding1wOk` tinyint(1) DEFAULT NULL,
  `p1_breastFeeding1wOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1wOk` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1wOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine1wOk` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine1wOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_breastFeeding2wOk` tinyint(1) DEFAULT NULL,
  `p1_breastFeeding2wOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding2wOk` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding2wOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine2wOk` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine2wOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_breastFeeding1mOk` tinyint(1) DEFAULT NULL,
  `p1_breastFeeding1mOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1mOk` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1mOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine1mOk` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine1mOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_carSeatOk` tinyint(1) DEFAULT NULL,
  `p1_carSeatOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_sleepPosOk` tinyint(1) DEFAULT NULL,
  `p1_sleepPosOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_cribSafetyOk` tinyint(1) DEFAULT NULL,
  `p1_cribSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_firearmSafetyOk` tinyint(1) DEFAULT NULL,
  `p1_firearmSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_smokeSafetyOk` tinyint(1) DEFAULT NULL,
  `p1_smokeSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_hotWaterOk` tinyint(1) DEFAULT NULL,
  `p1_hotWaterOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_safeToysOk` tinyint(1) DEFAULT NULL,
  `p1_safeToysOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_sleepCryOk` tinyint(1) DEFAULT NULL,
  `p1_sleepCryOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_soothabilityOk` tinyint(1) DEFAULT NULL,
  `p1_soothabilityOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_homeVisitOk` tinyint(1) DEFAULT NULL,
  `p1_homeVisitOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_bondingOk` tinyint(1) DEFAULT NULL,
  `p1_bondingOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_pFatigueOk` tinyint(1) DEFAULT NULL,
  `p1_pFatigueOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_famConflictOk` tinyint(1) DEFAULT NULL,
  `p1_famConflictOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_siblingsOk` tinyint(1) DEFAULT NULL,
  `p1_siblingsOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_2ndSmokeOk` tinyint(1) DEFAULT NULL,
  `p1_2ndSmokeOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_altMedOk` tinyint(1) DEFAULT NULL,
  `p1_altMedOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_pacifierOk` tinyint(1) DEFAULT NULL,
  `p1_pacifierOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_feverOk` tinyint(1) DEFAULT NULL,
  `p1_feverOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_noCoughMedOk` tinyint(1) DEFAULT NULL,
  `p1_noCoughMedOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_tmpControlOk` tinyint(1) DEFAULT NULL,
  `p1_tmpControlOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_sunExposureOk` tinyint(1) DEFAULT NULL,
  `p1_sunExposureOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_development1w` text,
  `p1_development2w` text,
  `p1_sucks2wOk` tinyint(1) DEFAULT NULL,
  `p1_sucks2wNo` tinyint(1) DEFAULT NULL,
  `p1_noParentsConcerns2wOk` tinyint(1) DEFAULT NULL,
  `p1_noParentsConcerns2wNo` tinyint(1) DEFAULT NULL,
  `p1_development1m` text,
  `p1_focusGaze1mOk` tinyint(1) DEFAULT NULL,
  `p1_focusGaze1mNo` tinyint(1) DEFAULT NULL,
  `p1_startles1mOk` tinyint(1) DEFAULT NULL,
  `p1_startles1mNo` tinyint(1) DEFAULT NULL,
  `p1_calms1mOk` tinyint(1) DEFAULT NULL,
  `p1_calms1mNo` tinyint(1) DEFAULT NULL,
  `p1_sucks1mOk` tinyint(1) DEFAULT NULL,
  `p1_sucks1mNo` tinyint(1) DEFAULT NULL,
  `p1_noParentsConcerns1mOk` tinyint(1) DEFAULT NULL,
  `p1_noParentsConcerns1mNo` tinyint(1) DEFAULT NULL,
  `p1_skin1wOk` tinyint(1) DEFAULT NULL,
  `p1_skin1wNo` tinyint(1) DEFAULT NULL,
  `p1_fontanelles1wOk` tinyint(1) DEFAULT NULL,
  `p1_fontanelles1wNo` tinyint(1) DEFAULT NULL,
  `p1_eyes1wOk` tinyint(1) DEFAULT NULL,
  `p1_eyes1wNo` tinyint(1) DEFAULT NULL,
  `p1_ears1wOk` tinyint(1) DEFAULT NULL,
  `p1_ears1wNo` tinyint(1) DEFAULT NULL,
  `p1_heartLungs1wOk` tinyint(1) DEFAULT NULL,
  `p1_heartLungs1wNo` tinyint(1) DEFAULT NULL,
  `p1_umbilicus1wOk` tinyint(1) DEFAULT NULL,
  `p1_umbilicus1wNo` tinyint(1) DEFAULT NULL,
  `p1_femoralPulses1wOk` tinyint(1) DEFAULT NULL,
  `p1_femoralPulses1wNo` tinyint(1) DEFAULT NULL,
  `p1_hips1wOk` tinyint(1) DEFAULT NULL,
  `p1_hips1wNo` tinyint(1) DEFAULT NULL,
  `p1_muscleTone1wOk` tinyint(1) DEFAULT NULL,
  `p1_muscleTone1wNo` tinyint(1) DEFAULT NULL,
  `p1_testicles1wOk` tinyint(1) DEFAULT NULL,
  `p1_testicles1wNo` tinyint(1) DEFAULT NULL,
  `p1_maleUrinary1wOk` tinyint(1) DEFAULT NULL,
  `p1_maleUrinary1wNo` tinyint(1) DEFAULT NULL,
  `p1_skin2wOk` tinyint(1) DEFAULT NULL,
  `p1_skin2wNo` tinyint(1) DEFAULT NULL,
  `p1_fontanelles2wOk` tinyint(1) DEFAULT NULL,
  `p1_fontanelles2wNo` tinyint(1) DEFAULT NULL,
  `p1_eyes2wOk` tinyint(1) DEFAULT NULL,
  `p1_eyes2wNo` tinyint(1) DEFAULT NULL,
  `p1_ears2wOk` tinyint(1) DEFAULT NULL,
  `p1_ears2wNo` tinyint(1) DEFAULT NULL,
  `p1_heartLungs2wOk` tinyint(1) DEFAULT NULL,
  `p1_heartLungs2wNo` tinyint(1) DEFAULT NULL,
  `p1_umbilicus2wOk` tinyint(1) DEFAULT NULL,
  `p1_umbilicus2wNo` tinyint(1) DEFAULT NULL,
  `p1_femoralPulses2wOk` tinyint(1) DEFAULT NULL,
  `p1_femoralPulses2wNo` tinyint(1) DEFAULT NULL,
  `p1_hips2wOk` tinyint(1) DEFAULT NULL,
  `p1_hips2wNo` tinyint(1) DEFAULT NULL,
  `p1_muscleTone2wOk` tinyint(1) DEFAULT NULL,
  `p1_muscleTone2wNo` tinyint(1) DEFAULT NULL,
  `p1_testicles2wOk` tinyint(1) DEFAULT NULL,
  `p1_testicles2wNo` tinyint(1) DEFAULT NULL,
  `p1_maleUrinary2wOk` tinyint(1) DEFAULT NULL,
  `p1_maleUrinary2wNo` tinyint(1) DEFAULT NULL,
  `p1_skin1mOk` tinyint(1) DEFAULT NULL,
  `p1_skin1mNo` tinyint(1) DEFAULT NULL,
  `p1_fontanelles1mOk` tinyint(1) DEFAULT NULL,
  `p1_fontanelles1mNo` tinyint(1) DEFAULT NULL,
  `p1_eyes1mOk` tinyint(1) DEFAULT NULL,
  `p1_eyes1mNo` tinyint(1) DEFAULT NULL,
  `p1_corneal1mOk` tinyint(1) DEFAULT NULL,
  `p1_corneal1mNo` tinyint(1) DEFAULT NULL,
  `p1_hearing1mOk` tinyint(1) DEFAULT NULL,
  `p1_hearing1mNo` tinyint(1) DEFAULT NULL,
  `p1_heart1mOk` tinyint(1) DEFAULT NULL,
  `p1_heart1mNo` tinyint(1) DEFAULT NULL,
  `p1_hips1mOk` tinyint(1) DEFAULT NULL,
  `p1_hips1mNo` tinyint(1) DEFAULT NULL,
  `p1_muscleTone1mOk` tinyint(1) DEFAULT NULL,
  `p1_muscleTone1mNo` tinyint(1) DEFAULT NULL,
  `p1_pkuThyroid1wOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_hemoScreen1wOkConcerns` tinyint(1) DEFAULT NULL,
  `p1_problems1w` text,
  `p1_problems2w` text,
  `p1_problems1m` text,
  `p1_hepatitisVaccine1wOk` tinyint(1) DEFAULT NULL,
  `p1_hepatitisVaccine1mOk` tinyint(1) DEFAULT NULL,
  `p1_signature2w` varchar(250) DEFAULT NULL,
  `p2_date2m` date DEFAULT NULL,
  `p2_date4m` date DEFAULT NULL,
  `p2_date6m` date DEFAULT NULL,
  `p2_ht2m` varchar(5) DEFAULT NULL,
  `p2_wt2m` varchar(5) DEFAULT NULL,
  `p2_hc2m` varchar(5) DEFAULT NULL,
  `p2_ht4m` varchar(5) DEFAULT NULL,
  `p2_wt4m` varchar(5) DEFAULT NULL,
  `p2_hc4m` varchar(5) DEFAULT NULL,
  `p2_ht6m` varchar(5) DEFAULT NULL,
  `p2_wt6m` varchar(5) DEFAULT NULL,
  `p2_hc6m` varchar(5) DEFAULT NULL,
  `p2_pConcern2m` text,
  `p2_pConcern4m` text,
  `p2_pConcern6m` text,
  `p2_nutrition2m` text,
  `p2_breastFeeding2mOk` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding2mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding2mOk` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding2mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_nutrition4m` text,
  `p2_breastFeeding4mOk` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding4mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding4mOk` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding4mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding6mOk` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding6mOk` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_bottle6mOk` tinyint(1) DEFAULT NULL,
  `p2_bottle6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_liquids6mOk` tinyint(1) DEFAULT NULL,
  `p2_liquids6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_iron6mOk` tinyint(1) DEFAULT NULL,
  `p2_iron6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_vegFruit6mOk` tinyint(1) DEFAULT NULL,
  `p2_vegFruit6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_egg6mOk` tinyint(1) DEFAULT NULL,
  `p2_egg6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_choking6mOk` tinyint(1) DEFAULT NULL,
  `p2_choking6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_carSeatOk` tinyint(1) DEFAULT NULL,
  `p2_carSeatOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_sleepPosOk` tinyint(1) DEFAULT NULL,
  `p2_sleepPosOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_poisonsOk` tinyint(1) DEFAULT NULL,
  `p2_poisonsOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_firearmSafetyOk` tinyint(1) DEFAULT NULL,
  `p2_firearmSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_electricOk` tinyint(1) DEFAULT NULL,
  `p2_electricOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_smokeSafetyOk` tinyint(1) DEFAULT NULL,
  `p2_smokeSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_hotWaterOk` tinyint(1) DEFAULT NULL,
  `p2_hotWaterOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_fallsOk` tinyint(1) DEFAULT NULL,
  `p2_fallsOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_safeToysOk` tinyint(1) DEFAULT NULL,
  `p2_safeToysOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_sleepCryOk` tinyint(1) DEFAULT NULL,
  `p2_sleepCryOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_soothabilityOk` tinyint(1) DEFAULT NULL,
  `p2_soothabilityOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_homeVisitOk` tinyint(1) DEFAULT NULL,
  `p2_homeVisitOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_bondingOk` tinyint(1) DEFAULT NULL,
  `p2_bondingOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_pFatigueOk` tinyint(1) DEFAULT NULL,
  `p2_pFatigueOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_famConflictOk` tinyint(1) DEFAULT NULL,
  `p2_famConflictOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_siblingsOk` tinyint(1) DEFAULT NULL,
  `p2_siblingsOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_childCareOk` tinyint(1) DEFAULT NULL,
  `p2_childCareOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_2ndSmokeOk` tinyint(1) DEFAULT NULL,
  `p2_2ndSmokeOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_teethingOk` tinyint(1) DEFAULT NULL,
  `p2_teethingOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_altMedOk` tinyint(1) DEFAULT NULL,
  `p2_altMedOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_pacifierOk` tinyint(1) DEFAULT NULL,
  `p2_pacifierOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_tmpControlOk` tinyint(1) DEFAULT NULL,
  `p2_tmpControlOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_feverOk` tinyint(1) DEFAULT NULL,
  `p2_feverOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_sunExposureOk` tinyint(1) DEFAULT NULL,
  `p2_sunExposureOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_pesticidesOk` tinyint(1) DEFAULT NULL,
  `p2_pesticidesOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_readingOk` tinyint(1) DEFAULT NULL,
  `p2_readingOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_noCoughMedOk` tinyint(1) DEFAULT NULL,
  `p2_noCoughMedOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_development2m` text,
  `p2_eyesOk` tinyint(1) DEFAULT NULL,
  `p2_eyesOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_coosOk` tinyint(1) DEFAULT NULL,
  `p2_coosOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_respondsOk` tinyint(1) DEFAULT NULL,
  `p2_respondsOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_headUpTummyOk` tinyint(1) DEFAULT NULL,
  `p2_headUpTummyOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_cuddledOk` tinyint(1) DEFAULT NULL,
  `p2_cuddledOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_2sucksOk` tinyint(1) DEFAULT NULL,
  `p2_2sucksOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_smilesOk` tinyint(1) DEFAULT NULL,
  `p2_smilesOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns2mOk` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns2mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_development4m` text,
  `p2_turnsHeadOk` tinyint(1) DEFAULT NULL,
  `p2_turnsHeadOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_laughsOk` tinyint(1) DEFAULT NULL,
  `p2_laughsOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_headSteadyOk` tinyint(1) DEFAULT NULL,
  `p2_headSteadyOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_holdsObjOk` tinyint(1) DEFAULT NULL,
  `p2_holdsObjOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns4mOk` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns4mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_development6m` text,
  `p2_movingObjOk` tinyint(1) DEFAULT NULL,
  `p2_movingObjOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_vocalizesOk` tinyint(1) DEFAULT NULL,
  `p2_vocalizesOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_makesSoundOk` tinyint(1) DEFAULT NULL,
  `p2_makesSoundOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_rollsOk` tinyint(1) DEFAULT NULL,
  `p2_rollsOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_sitsOk` tinyint(1) DEFAULT NULL,
  `p2_sitsOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_reachesGraspsOk` tinyint(1) DEFAULT NULL,
  `p2_reachesGraspsOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns6mOk` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_fontanelles2mOk` tinyint(1) DEFAULT NULL,
  `p2_fontanelles2mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_eyes2mOk` tinyint(1) DEFAULT NULL,
  `p2_eyes2mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_corneal2mOk` tinyint(1) DEFAULT NULL,
  `p2_corneal2mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_hearing2mOk` tinyint(1) DEFAULT NULL,
  `p2_hearing2mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_heart2mOk` tinyint(1) DEFAULT NULL,
  `p2_heart2mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_hips2mOk` tinyint(1) DEFAULT NULL,
  `p2_hips2mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_muscleTone2mOk` tinyint(1) DEFAULT NULL,
  `p2_muscleTone2mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_fontanelles4mOk` tinyint(1) DEFAULT NULL,
  `p2_fontanelles4mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_eyes4mOk` tinyint(1) DEFAULT NULL,
  `p2_eyes4mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_corneal4mOk` tinyint(1) DEFAULT NULL,
  `p2_corneal4mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_hearing4mOk` tinyint(1) DEFAULT NULL,
  `p2_hearing4mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_hips4mOk` tinyint(1) DEFAULT NULL,
  `p2_hips4mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_muscleTone4mOk` tinyint(1) DEFAULT NULL,
  `p2_muscleTone4mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_fontanelles6mOk` tinyint(1) DEFAULT NULL,
  `p2_fontanelles6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_eyes6mOk` tinyint(1) DEFAULT NULL,
  `p2_eyes6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_corneal6mOk` tinyint(1) DEFAULT NULL,
  `p2_corneal6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_hearing6mOk` tinyint(1) DEFAULT NULL,
  `p2_hearing6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_hips6mOk` tinyint(1) DEFAULT NULL,
  `p2_hips6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_muscleTone6mOk` tinyint(1) DEFAULT NULL,
  `p2_muscleTone6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_problems2m` text,
  `p2_problems4m` text,
  `p2_problems6m` text,
  `p2_tb6mOkConcerns` tinyint(1) DEFAULT NULL,
  `p2_hepatitisVaccine6mOk` tinyint(1) DEFAULT NULL,
  `p2_signature2m` varchar(250) DEFAULT NULL,
  `p2_signature4m` varchar(250) DEFAULT NULL,
  `p3_date9m` date DEFAULT NULL,
  `p3_date12m` date DEFAULT NULL,
  `p3_date15m` date DEFAULT NULL,
  `p3_ht9m` varchar(5) DEFAULT NULL,
  `p3_wt9m` varchar(5) DEFAULT NULL,
  `p3_hc9m` varchar(5) DEFAULT NULL,
  `p3_ht12m` varchar(5) DEFAULT NULL,
  `p3_wt12m` varchar(5) DEFAULT NULL,
  `p3_hc12m` varchar(5) DEFAULT NULL,
  `p3_ht15m` varchar(5) DEFAULT NULL,
  `p3_wt15m` varchar(5) DEFAULT NULL,
  `p3_hc15m` varchar(5) DEFAULT NULL,
  `p3_pConcern9m` text,
  `p3_pConcern12m` text,
  `p3_pConcern15m` text,
  `p3_breastFeeding9mOk` tinyint(1) DEFAULT NULL,
  `p3_breastFeeding9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_formulaFeeding9mOk` tinyint(1) DEFAULT NULL,
  `p3_formulaFeeding9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_bottle9mOk` tinyint(1) DEFAULT NULL,
  `p3_bottle9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_liquids9mOk` tinyint(1) DEFAULT NULL,
  `p3_liquids9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_cereal9mOk` tinyint(1) DEFAULT NULL,
  `p3_cereal9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_introCowMilk9mOk` tinyint(1) DEFAULT NULL,
  `p3_introCowMilk9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_egg9mOk` tinyint(1) DEFAULT NULL,
  `p3_egg9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_choking9mOk` tinyint(1) DEFAULT NULL,
  `p3_choking9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_nutrition12m` text,
  `p3_breastFeeding12mOk` tinyint(1) DEFAULT NULL,
  `p3_breastFeeding12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_homoMilk12mOk` tinyint(1) DEFAULT NULL,
  `p3_homoMilk12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_cup12mOk` tinyint(1) DEFAULT NULL,
  `p3_cup12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_appetite12mOk` tinyint(1) DEFAULT NULL,
  `p3_appetite12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_choking12mOk` tinyint(1) DEFAULT NULL,
  `p3_choking12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_nutrition15m` text,
  `p3_breastFeeding15mOk` tinyint(1) DEFAULT NULL,
  `p3_breastFeeding15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_homoMilk15mOk` tinyint(1) DEFAULT NULL,
  `p3_homoMilk15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_choking15mOk` tinyint(1) DEFAULT NULL,
  `p3_choking15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_cup15mOk` tinyint(1) DEFAULT NULL,
  `p3_cup15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_carSeatOk` tinyint(1) DEFAULT NULL,
  `p3_carSeatOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_poisonsOk` tinyint(1) DEFAULT NULL,
  `p3_poisonsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_firearmSafetyOk` tinyint(1) DEFAULT NULL,
  `p3_firearmSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_smokeSafetyOk` tinyint(1) DEFAULT NULL,
  `p3_smokeSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_hotWaterOk` tinyint(1) DEFAULT NULL,
  `p3_hotWaterOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_electricOk` tinyint(1) DEFAULT NULL,
  `p3_electricOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_fallsOk` tinyint(1) DEFAULT NULL,
  `p3_fallsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_safeToysOk` tinyint(1) DEFAULT NULL,
  `p3_safeToysOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_sleepCryOk` tinyint(1) DEFAULT NULL,
  `p3_sleepCryOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_soothabilityOk` tinyint(1) DEFAULT NULL,
  `p3_soothabilityOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_homeVisitOk` tinyint(1) DEFAULT NULL,
  `p3_homeVisitOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_parentingOk` tinyint(1) DEFAULT NULL,
  `p3_parentingOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_pFatigueOk` tinyint(1) DEFAULT NULL,
  `p3_pFatigueOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_famConflictOk` tinyint(1) DEFAULT NULL,
  `p3_famConflictOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_siblingsOk` tinyint(1) DEFAULT NULL,
  `p3_siblingsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_childCareOk` tinyint(1) DEFAULT NULL,
  `p3_childCareOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_2ndSmokeOk` tinyint(1) DEFAULT NULL,
  `p3_2ndSmokeOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_teethingOk` tinyint(1) DEFAULT NULL,
  `p3_teethingOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_altMedOk` tinyint(1) DEFAULT NULL,
  `p3_altMedOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_pacifierOk` tinyint(1) DEFAULT NULL,
  `p3_pacifierOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_feverOk` tinyint(1) DEFAULT NULL,
  `p3_feverOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_coughMedOk` tinyint(1) DEFAULT NULL,
  `p3_coughMedOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_activeOk` tinyint(1) DEFAULT NULL,
  `p3_activeOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_readingOk` tinyint(1) DEFAULT NULL,
  `p3_readingOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_footwearOk` tinyint(1) DEFAULT NULL,
  `p3_footwearOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_sunExposureOk` tinyint(1) DEFAULT NULL,
  `p3_sunExposureOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_checkSerumOk` tinyint(1) DEFAULT NULL,
  `p3_checkSerumOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_pesticidesOk` tinyint(1) DEFAULT NULL,
  `p3_pesticidesOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_development9m` text,
  `p3_hiddenToyOk` tinyint(1) DEFAULT NULL,
  `p3_hiddenToyOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_soundsOk` tinyint(1) DEFAULT NULL,
  `p3_soundsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_responds2peopleOk` tinyint(1) DEFAULT NULL,
  `p3_responds2peopleOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_makeSoundsOk` tinyint(1) DEFAULT NULL,
  `p3_makeSoundsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_sitsOk` tinyint(1) DEFAULT NULL,
  `p3_sitsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_standsOk` tinyint(1) DEFAULT NULL,
  `p3_standsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_thumbOk` tinyint(1) DEFAULT NULL,
  `p3_thumbOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_playGamesOk` tinyint(1) DEFAULT NULL,
  `p3_playGamesOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_attention9mOk` tinyint(1) DEFAULT NULL,
  `p3_attention9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns9mOk` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_development12m` text,
  `p3_respondsOk` tinyint(1) DEFAULT NULL,
  `p3_respondsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_simpleRequestsOk` tinyint(1) DEFAULT NULL,
  `p3_simpleRequestsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_consonantOk` tinyint(1) DEFAULT NULL,
  `p3_consonantOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_says3wordsOk` tinyint(1) DEFAULT NULL,
  `p3_says3wordsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_shufflesOk` tinyint(1) DEFAULT NULL,
  `p3_shufflesOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_pull2standOk` tinyint(1) DEFAULT NULL,
  `p3_pull2standOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_showDistressOk` tinyint(1) DEFAULT NULL,
  `p3_showDistressOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_followGazeOk` tinyint(1) DEFAULT NULL,
  `p3_followGazeOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns12mOk` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_says5wordsOk` tinyint(1) DEFAULT NULL,
  `p3_says5wordsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_reachesOk` tinyint(1) DEFAULT NULL,
  `p3_reachesNo` tinyint(1) DEFAULT NULL,
  `p3_fingerFoodsOk` tinyint(1) DEFAULT NULL,
  `p3_fingerFoodsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_walksSidewaysOk` tinyint(1) DEFAULT NULL,
  `p3_walksSidewaysOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_showsFearStrangersOk` tinyint(1) DEFAULT NULL,
  `p3_showsFearStrangersOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_crawlsStairsOk` tinyint(1) DEFAULT NULL,
  `p3_crawlsStairsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_squatsOk` tinyint(1) DEFAULT NULL,
  `p3_squatsOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns15mOk` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_fontanelles9mOk` tinyint(1) DEFAULT NULL,
  `p3_fontanelles9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_eyes9mOk` tinyint(1) DEFAULT NULL,
  `p3_eyes9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_corneal9mOk` tinyint(1) DEFAULT NULL,
  `p3_corneal9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_hearing9mOk` tinyint(1) DEFAULT NULL,
  `p3_hearing9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_hips9mOk` tinyint(1) DEFAULT NULL,
  `p3_hips9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_fontanelles12mOk` tinyint(1) DEFAULT NULL,
  `p3_fontanelles12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_eyes12mOk` tinyint(1) DEFAULT NULL,
  `p3_eyes12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_corneal12mOk` tinyint(1) DEFAULT NULL,
  `p3_corneal12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_hearing12mOk` tinyint(1) DEFAULT NULL,
  `p3_hearing12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_tonsil12mOk` tinyint(1) DEFAULT NULL,
  `p3_tonsil12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_hips12mOk` tinyint(1) DEFAULT NULL,
  `p3_hips12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_development15m` text,
  `p3_fontanelles15mOk` tinyint(1) DEFAULT NULL,
  `p3_fontanelles15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_eyes15mOk` tinyint(1) DEFAULT NULL,
  `p3_eyes15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_corneal15mOk` tinyint(1) DEFAULT NULL,
  `p3_corneal15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_hearing15mOk` tinyint(1) DEFAULT NULL,
  `p3_hearing15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_tonsil15mOk` tinyint(1) DEFAULT NULL,
  `p3_tonsil15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_hips15mOk` tinyint(1) DEFAULT NULL,
  `p3_hips15mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_problems9m` text,
  `p3_problems12m` text,
  `p3_problems15m` text,
  `p3_antiHB9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_hemoglobin9mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_hemoglobin12mOkConcerns` tinyint(1) DEFAULT NULL,
  `p3_signature9m` varchar(250) DEFAULT NULL,
  `p3_signature12m` varchar(250) DEFAULT NULL,
  `p3_signature15m` varchar(250) DEFAULT NULL,
  `p4_date18m` date DEFAULT NULL,
  `p4_date24m` date DEFAULT NULL,
  `p4_date48m` date DEFAULT NULL,
  `p4_ht18m` varchar(5) DEFAULT NULL,
  `p4_wt18m` varchar(5) DEFAULT NULL,
  `p4_hc18m` varchar(5) DEFAULT NULL,
  `p4_ht24m` varchar(5) DEFAULT NULL,
  `p4_wt24m` varchar(5) DEFAULT NULL,
  `p4_hc24m` varchar(5) DEFAULT NULL,
  `p4_ht48m` varchar(5) DEFAULT NULL,
  `p4_wt48m` varchar(5) DEFAULT NULL,
  `p4_pConcern18m` text,
  `p4_pConcern24m` text,
  `p4_pConcern48m` text,
  `p4_breastFeeding18mOk` tinyint(1) DEFAULT NULL,
  `p4_breastFeeding18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_homoMilk18mOk` tinyint(1) DEFAULT NULL,
  `p4_homoMilk18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_bottle18mOk` tinyint(1) DEFAULT NULL,
  `p4_bottle18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_homo2percent24mOk` tinyint(1) DEFAULT NULL,
  `p4_homo2percent24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_lowerfatdiet24mOk` tinyint(1) DEFAULT NULL,
  `p4_lowerfatdiet24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_foodguide24mOk` tinyint(1) DEFAULT NULL,
  `p4_foodguide24mNo` tinyint(1) DEFAULT NULL,
  `p4_2pMilk48mOk` tinyint(1) DEFAULT NULL,
  `p4_2pMilk48mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_foodguide48mOk` tinyint(1) DEFAULT NULL,
  `p4_foodguide48mNo` tinyint(1) DEFAULT NULL,
  `p4_carSeat18mOk` tinyint(1) DEFAULT NULL,
  `p4_carSeat18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_bathSafetyOk` tinyint(1) DEFAULT NULL,
  `p4_bathSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_safeToysOk` tinyint(1) DEFAULT NULL,
  `p4_safeToysOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_parentChild18mOk` tinyint(1) DEFAULT NULL,
  `p4_parentChild18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_discipline18mOk` tinyint(1) DEFAULT NULL,
  `p4_discipline18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_pFatigue18mOk` tinyint(1) DEFAULT NULL,
  `p4_pFatigue18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_highRisk18mOk` tinyint(1) DEFAULT NULL,
  `p4_highRisk18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_socializing18mOk` tinyint(1) DEFAULT NULL,
  `p4_socializing18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_weanPacifier18mOk` tinyint(1) DEFAULT NULL,
  `p4_weanPacifier18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_dentalCareOk` tinyint(1) DEFAULT NULL,
  `p4_dentalCareOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_toiletLearning18mOk` tinyint(1) DEFAULT NULL,
  `p4_toiletLearning18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_encourageReading18mOk` tinyint(1) DEFAULT NULL,
  `p4_encourageReading18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_carSeat24mOk` tinyint(1) DEFAULT NULL,
  `p4_carSeat24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_bikeHelmetsOk` tinyint(1) DEFAULT NULL,
  `p4_bikeHelmetsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_firearmSafetyOk` tinyint(1) DEFAULT NULL,
  `p4_firearmSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_smokeSafetyOk` tinyint(1) DEFAULT NULL,
  `p4_smokeSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_matchesOk` tinyint(1) DEFAULT NULL,
  `p4_matchesOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_waterSafetyOk` tinyint(1) DEFAULT NULL,
  `p4_waterSafetyOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_parentChild24mOk` tinyint(1) DEFAULT NULL,
  `p4_parentChild24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_discipline24mOk` tinyint(1) DEFAULT NULL,
  `p4_discipline24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_highRisk24mOk` tinyint(1) DEFAULT NULL,
  `p4_highRisk24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_pFatigue24mOk` tinyint(1) DEFAULT NULL,
  `p4_pFatigue24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_famConflictOk` tinyint(1) DEFAULT NULL,
  `p4_famConflictOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_siblingsOk` tinyint(1) DEFAULT NULL,
  `p4_siblingsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_2ndSmokeOk` tinyint(1) DEFAULT NULL,
  `p4_2ndSmokeOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_dentalCleaningOk` tinyint(1) DEFAULT NULL,
  `p4_dentalCleaningOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_altMedOk` tinyint(1) DEFAULT NULL,
  `p4_altMedOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_toiletLearning24mOk` tinyint(1) DEFAULT NULL,
  `p4_toiletLearning24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_activeOk` tinyint(1) DEFAULT NULL,
  `p4_activeOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_socializing24mOk` tinyint(1) DEFAULT NULL,
  `p4_socializing24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_readingOk` tinyint(1) DEFAULT NULL,
  `p4_readingOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_noCough24mOk` tinyint(1) DEFAULT NULL,
  `p4_noCough24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_noPacifier24mOk` tinyint(1) DEFAULT NULL,
  `p4_noPacifier24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_dayCareOk` tinyint(1) DEFAULT NULL,
  `p4_dayCareOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_sunExposureOk` tinyint(1) DEFAULT NULL,
  `p4_sunExposureOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_pesticidesOk` tinyint(1) DEFAULT NULL,
  `p4_pesticidesOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_checkSerumOk` tinyint(1) DEFAULT NULL,
  `p4_checkSerumOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_manageableOk` tinyint(1) DEFAULT NULL,
  `p4_manageableOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_otherChildrenOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_otherChildrenOk` tinyint(1) DEFAULT NULL,
  `p4_soothabilityOk` tinyint(1) DEFAULT NULL,
  `p4_soothabilityOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_comfortOk` tinyint(1) DEFAULT NULL,
  `p4_comfortOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_pointsOk` tinyint(1) DEFAULT NULL,
  `p4_pointsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_getAttnOk` tinyint(1) DEFAULT NULL,
  `p4_getAttnOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_points2wantOk` tinyint(1) DEFAULT NULL,
  `p4_points2wantOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_looks4toyOk` tinyint(1) DEFAULT NULL,
  `p4_looks4toyOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_recsNameOk` tinyint(1) DEFAULT NULL,
  `p4_recsNameOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_initSpeechOk` tinyint(1) DEFAULT NULL,
  `p4_initSpeechOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_says20wordsOk` tinyint(1) DEFAULT NULL,
  `p4_says20wordsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_4consonantsOk` tinyint(1) DEFAULT NULL,
  `p4_4consonantsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_walksbackOk` tinyint(1) DEFAULT NULL,
  `p4_walksbackOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_feedsSelfOk` tinyint(1) DEFAULT NULL,
  `p4_feedsSelfOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_removesHatOk` tinyint(1) DEFAULT NULL,
  `p4_removesHatOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns18mOk` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_2wSentenceOk` tinyint(1) DEFAULT NULL,
  `p4_2wSentenceOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_one2stepdirectionsOk` tinyint(1) DEFAULT NULL,
  `p4_one2stepdirectionsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_walksbackwardOk` tinyint(1) DEFAULT NULL,
  `p4_walksbackwardOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_runsOk` tinyint(1) DEFAULT NULL,
  `p4_runsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_smallContainerOk` tinyint(1) DEFAULT NULL,
  `p4_smallContainerOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_pretendsPlayOk` tinyint(1) DEFAULT NULL,
  `p4_pretendsPlayOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_newSkillsOk` tinyint(1) DEFAULT NULL,
  `p4_newSkillsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns24mOk` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_3directionsOk` tinyint(1) DEFAULT NULL,
  `p4_3directionsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_asksQuestionsOk` tinyint(1) DEFAULT NULL,
  `p4_asksQuestionsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_upDownStairsOk` tinyint(1) DEFAULT NULL,
  `p4_upDownStairsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_undoesZippersOk` tinyint(1) DEFAULT NULL,
  `p4_undoesZippersOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_tries2comfortOk` tinyint(1) DEFAULT NULL,
  `p4_tries2comfortOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns48mOk` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns48mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_2directionsOk` tinyint(1) DEFAULT NULL,
  `p4_2directionsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_5ormoreWordsOk` tinyint(1) DEFAULT NULL,
  `p4_5ormoreWordsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_walksUpStairsOk` tinyint(1) DEFAULT NULL,
  `p4_walksUpStairsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_twistslidsOk` tinyint(1) DEFAULT NULL,
  `p4_twistslidsOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_turnsPagesOk` tinyint(1) DEFAULT NULL,
  `p4_turnsPagesOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_sharesSometimeOk` tinyint(1) DEFAULT NULL,
  `p4_sharesSometimeOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_playMakeBelieveOk` tinyint(1) DEFAULT NULL,
  `p4_playMakeBelieveOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_listenMusikOk` tinyint(1) DEFAULT NULL,
  `p4_listenMusikOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns36mOk` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns36mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_countsOutloudOk` tinyint(1) DEFAULT NULL,
  `p4_countsOutloudOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_speaksClearlyOk` tinyint(1) DEFAULT NULL,
  `p4_speaksClearlyOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_throwsCatchesOk` tinyint(1) DEFAULT NULL,
  `p4_throwsCatchesOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_hops1footOk` tinyint(1) DEFAULT NULL,
  `p4_hops1footOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_dressesUndressesOk` tinyint(1) DEFAULT NULL,
  `p4_dressesUndressesOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_obeysAdultOk` tinyint(1) DEFAULT NULL,
  `p4_obeysAdultOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_retellsStoryOk` tinyint(1) DEFAULT NULL,
  `p4_retellsStoryOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_separatesOk` tinyint(1) DEFAULT NULL,
  `p4_separatesOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns60mOk` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns60mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_fontanellesClosedOk` tinyint(1) DEFAULT NULL,
  `p4_fontanellesClosedOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_eyes18mOk` tinyint(1) DEFAULT NULL,
  `p4_eyes18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_corneal18mOk` tinyint(1) DEFAULT NULL,
  `p4_corneal18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_hearing18mOk` tinyint(1) DEFAULT NULL,
  `p4_hearing18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_tonsil18mOk` tinyint(1) DEFAULT NULL,
  `p4_tonsil18mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_bloodpressure24mOk` tinyint(1) DEFAULT NULL,
  `p4_bloodpressure24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_eyes24mOk` tinyint(1) DEFAULT NULL,
  `p4_eyes24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_corneal24mOk` tinyint(1) DEFAULT NULL,
  `p4_corneal24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_hearing24mOk` tinyint(1) DEFAULT NULL,
  `p4_hearing24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_tonsil24mOk` tinyint(1) DEFAULT NULL,
  `p4_tonsil24mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_bloodpressure48mOk` tinyint(1) DEFAULT NULL,
  `p4_bloodpressure48mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_eyes48mOk` tinyint(1) DEFAULT NULL,
  `p4_eyes48mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_corneal48mOk` tinyint(1) DEFAULT NULL,
  `p4_corneal48mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_hearing48mOk` tinyint(1) DEFAULT NULL,
  `p4_hearing48mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_tonsil48mOk` tinyint(1) DEFAULT NULL,
  `p4_tonsil48mOkConcerns` tinyint(1) DEFAULT NULL,
  `p4_problems18m` text,
  `p4_problems24m` text,
  `p4_problems48m` text,
  `p4_signature18m` varchar(250) DEFAULT NULL,
  `p4_signature24m` varchar(250) DEFAULT NULL,
  `p4_signature48m` varchar(250) DEFAULT NULL,
  `p1_signature1w` varchar(250) DEFAULT NULL,
  `p1_signature1m` varchar(250) DEFAULT NULL,
  `p2_signature6m` varchar(250) DEFAULT NULL,
  `p1_breastFeeding1wNo` tinyint(1) DEFAULT NULL,
  `p1_breastFeeding1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1wNo` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_breastFeeding2wNo` tinyint(1) DEFAULT NULL,
  `p1_breastFeeding2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding2wNo` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_breastFeeding1mNo` tinyint(1) DEFAULT NULL,
  `p1_breastFeeding1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1mNo` tinyint(1) DEFAULT NULL,
  `p1_formulaFeeding1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_stoolUrine1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_carSeatNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_sleepPosNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_cribSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_firearmSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_smokeSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_hotWaterNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_safeToysNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_sleepCryNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_soothabilityNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_bondingNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_pFatigueNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_famConflictNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_siblingsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_homeVisitNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_2ndSmokeNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_altMedNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_pacifierNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_feverNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_tmpControlNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_sunExposureNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_noCoughMedNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_sucks2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_noParentsConcerns2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_focusGaze1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_startles1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_calms1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_sucks1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_noParentsConcerns1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_skin1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_fontanelles1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_eyes1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_ears1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_heartLungs1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_umbilicus1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_femoralPulses1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_hips1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_muscleTone1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_testicles1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_maleUrinary1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_skin2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_fontanelles2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_eyes2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_ears2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_heartLungs2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_umbilicus2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_femoralPulses2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_hips2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_muscleTone2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_testicles2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_maleUrinary2wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_skin1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_fontanelles1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_eyes1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_corneal1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_hearing1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_heart1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_hips1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_muscleTone1mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_pkuThyroid1wOk` tinyint(1) DEFAULT NULL,
  `p1_pkuThyroid1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_hemoScreen1wOk` tinyint(1) DEFAULT NULL,
  `p1_hemoScreen1wNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_hepatitisVaccine1wNo` tinyint(1) DEFAULT NULL,
  `p1_hepatitisVaccine1mNo` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding2mNo` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding2mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding2mNo` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding2mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding4mNo` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding4mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding4mNo` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding4mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding6mNo` tinyint(1) DEFAULT NULL,
  `p2_breastFeeding6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding6mNo` tinyint(1) DEFAULT NULL,
  `p2_formulaFeeding6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_bottle6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_liquids6mNo` tinyint(1) DEFAULT NULL,
  `p2_liquids6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_iron6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_vegFruit6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_egg6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_choking6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_carSeatNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_sleepPosNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_poisonsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_firearmSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_electricNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_smokeSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_hotWaterNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_fallsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_safeToysNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_sleepCryNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_soothabilityNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_homeVisitNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_bondingNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_pFatigueNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_famConflictNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_siblingsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_childCareNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_2ndSmokeNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_teethingNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_altMedNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_pacifierNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_tmpControlNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_feverNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_sunExposureNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_pesticidesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_readingNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_noCoughMedNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_eyesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_coosNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_headUpTummyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_cuddledNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_2sucksNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_smilesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns2mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_movingObjNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_respondsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_headSteadyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_holdsObjNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_laughsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns4mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_turnsHeadNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_makesSoundNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_vocalizesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_rollsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_sitsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_reachesGraspsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_noParentsConcerns6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_fontanelles2mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_eyes2mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_corneal2mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_hearing2mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_heart2mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_hips2mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_muscleTone2mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_fontanelles4mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_eyes4mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_corneal4mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_hearing4mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_hips4mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_muscleTone4mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_fontanelles6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_eyes6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_corneal6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_hearing6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_hips6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_muscleTone6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p2_hepatitisVaccine6mNo` tinyint(1) DEFAULT NULL,
  `p2_tb6mOk` tinyint(1) DEFAULT NULL,
  `p2_tb6mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_breastFeeding9mNo` tinyint(1) DEFAULT NULL,
  `p3_breastFeeding9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_formulaFeeding9mNo` tinyint(1) DEFAULT NULL,
  `p3_formulaFeeding9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_bottle9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_liquids9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_cereal9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_introCowMilk9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_egg9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_choking9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_breastFeeding12mNo` tinyint(1) DEFAULT NULL,
  `p3_breastFeeding12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_homoMilk12mNo` tinyint(1) DEFAULT NULL,
  `p3_homoMilk12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_cup12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_appetite12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_choking12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_breastFeeding15mNo` tinyint(1) DEFAULT NULL,
  `p3_breastFeeding15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_homoMilk15mNo` tinyint(1) DEFAULT NULL,
  `p3_homoMilk15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_choking15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_cup15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_poisonsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_carSeatNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_firearmSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_smokeSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_hotWaterNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_electricNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_fallsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_safeToysNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_sleepCryNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_soothabilityNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_homeVisitNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_parentingNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_pFatigueNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_famConflictNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_siblingsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_childCareNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_2ndSmokeNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_teethingNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_altMedNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_pacifierNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_feverNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_activeNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_readingNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_footwearNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_coughMedNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_sunExposureNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_checkSerumNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_pesticidesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_hiddenToyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_soundsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_responds2peopleNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_makeSoundsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_sitsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_standsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_thumbNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_playGamesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_attention9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_respondsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_simpleRequestsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_consonantNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_says3wordsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_shufflesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_showDistressNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_pull2standNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_followGazeNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_says5wordsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_fingerFoodsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_walksSidewaysNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_showsFearStrangersNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_crawlsStairsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_squatsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_noParentsConcerns15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_fontanelles9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_eyes9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_corneal9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_hearing9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_hips9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_fontanelles12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_eyes12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_corneal12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_hearing12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_tonsil12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_hips12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_fontanelles15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_eyes15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_corneal15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_hearing15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_tonsil15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_hips15mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_antiHB9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_antiHB9mOk` tinyint(1) DEFAULT NULL,
  `p3_hemoglobin9mOk` tinyint(1) DEFAULT NULL,
  `p3_hemoglobin9mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p3_hemoglobin12mOk` tinyint(1) DEFAULT NULL,
  `p3_hemoglobin12mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_breastFeeding18mNo` tinyint(1) DEFAULT NULL,
  `p4_breastFeeding18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_homoMilk18mNo` tinyint(1) DEFAULT NULL,
  `p4_homoMilk18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_bottle18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_homo2percent24mNo` tinyint(1) DEFAULT NULL,
  `p4_homo2percent24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_lowerfatdiet24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_foodguide24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_2pMilk48mNo` tinyint(1) DEFAULT NULL,
  `p4_2pMilk48mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_foodguide48mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_carSeat18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_bathSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_safeToysNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_parentChild18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_discipline18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_pFatigue18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_highRisk18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_socializing18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_weanPacifier18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_dentalCareNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_toiletLearning18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_encourageReading18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_carSeat24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_bikeHelmetsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_firearmSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_smokeSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_matchesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_waterSafetyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_parentChild24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_discipline24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_highRisk24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_pFatigue24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_famConflictNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_siblingsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_2ndSmokeNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_dentalCleaningNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_noPacifier24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_altMedNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_toiletLearning24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_noCough24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_activeNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_socializing24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_readingNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_dayCareNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_sunExposureNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_pesticidesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_checkSerumNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_manageableNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_otherChildrenNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_soothabilityNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_comfortNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_pointsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_getAttnNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_recsNameNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_points2wantNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_looks4toyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_initSpeechNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_says20wordsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_4consonantsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_walksbackNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_feedsSelfNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_removesHatNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_2wSentenceNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_one2stepdirectionsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_walksbackwardNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_runsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_smallContainerNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_pretendsPlayNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_newSkillsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_3directionsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_asksQuestionsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_upDownStairsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_undoesZippersNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_tries2comfortNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns48mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_2directionsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_5ormoreWordsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_walksUpStairsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_twistslidsNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_sharesSometimeNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_playMakeBelieveNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_turnsPagesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_listenMusikNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns36mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_countsOutloudNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_speaksClearlyNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_throwsCatchesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_hops1footNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_dressesUndressesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_obeysAdultNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_retellsStoryNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_separatesNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_noParentsConcerns60mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_fontanellesClosedNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_eyes18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_corneal18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_hearing18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_tonsil18mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_bloodpressure24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_eyes24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_corneal24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_hearing24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_tonsil24mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_bloodpressure48mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_eyes48mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_corneal48mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_hearing48mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p4_tonsil48mNotDiscussed` tinyint(1) DEFAULT NULL,
  `p1_pNutrition1w` text,
  `p1_pNutrition2w` text,
  `p1_pNutrition1m` text,
  `p1_pEducation` text,
  `p1_pPhysical1w` text,
  `p1_pPhysical2w` text,
  `p1_pPhysical1m` text,
  `p1_immunization1w` text,
  `p1_immunization2w` text,
  `p1_immunization1m` text,
  `p2_nutrition6m` text,
  `p2_education` text,
  `p2_physical2m` text,
  `p2_physical4m` text,
  `p2_physical6m` text,
  `p2_immunization6m` text,
  `p3_nutrition9m` text,
  `p3_education` text,
  `p3_physical9m` text,
  `p3_physical12m` text,
  `p3_physical15m` text,
  `p4_nutrition18m` text,
  `p4_nutrition24m` text,
  `p4_nutrition48m` text,
  `p4_education18m` text,
  `p4_education48m` text,
  `p4_development18m` text,
  `p4_development24m` text,
  `p4_development48m` text,
  `p4_development36m` text,
  `p4_development60m` text,
  `p4_physical18m` text,
  `p4_physical24m` text,
  `p4_physical48m` text,
  `p4_nippisingattained` text,
  PRIMARY KEY (`ID`),
  KEY `formRourke2009_demographic_no` (`demographic_no`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formSF36`
--

DROP TABLE IF EXISTS `formSF36`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formSF36` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `Q1Ex` tinyint(1) DEFAULT NULL,
  `Q1VG` tinyint(1) DEFAULT NULL,
  `Q1G` tinyint(1) DEFAULT NULL,
  `Q1F` tinyint(1) DEFAULT NULL,
  `Q1P` tinyint(1) DEFAULT NULL,
  `Q1Cmt` varchar(255) DEFAULT NULL,
  `Q2MuchBetter` tinyint(1) DEFAULT NULL,
  `Q2Better` tinyint(1) DEFAULT NULL,
  `Q2Same` tinyint(1) DEFAULT NULL,
  `Q2Worse` tinyint(1) DEFAULT NULL,
  `Q2MuchWorse` tinyint(1) DEFAULT NULL,
  `Q2Cmt` varchar(255) DEFAULT NULL,
  `Q3aYesLot` tinyint(1) DEFAULT NULL,
  `Q3aYesLittle` tinyint(1) DEFAULT NULL,
  `Q3aNo` tinyint(1) DEFAULT NULL,
  `Q3aCmt` varchar(255) DEFAULT NULL,
  `Q3bYesLot` tinyint(1) DEFAULT NULL,
  `Q3bYesLittle` tinyint(1) DEFAULT NULL,
  `Q3bNo` tinyint(1) DEFAULT NULL,
  `Q3bCmt` varchar(255) DEFAULT NULL,
  `Q3cYesLot` tinyint(1) DEFAULT NULL,
  `Q3cYesLittle` tinyint(1) DEFAULT NULL,
  `Q3cNo` tinyint(1) DEFAULT NULL,
  `Q3cCmt` varchar(255) DEFAULT NULL,
  `Q3dYesLot` tinyint(1) DEFAULT NULL,
  `Q3dYesLittle` tinyint(1) DEFAULT NULL,
  `Q3dNo` tinyint(1) DEFAULT NULL,
  `Q3dCmt` varchar(255) DEFAULT NULL,
  `Q3eYesLot` tinyint(1) DEFAULT NULL,
  `Q3eYesLittle` tinyint(1) DEFAULT NULL,
  `Q3eNo` tinyint(1) DEFAULT NULL,
  `Q3eCmt` varchar(255) DEFAULT NULL,
  `Q3fYesLot` tinyint(1) DEFAULT NULL,
  `Q3fYesLittle` tinyint(1) DEFAULT NULL,
  `Q3fNo` tinyint(1) DEFAULT NULL,
  `Q3fCmt` varchar(255) DEFAULT NULL,
  `Q3gYesLot` tinyint(1) DEFAULT NULL,
  `Q3gYesLittle` tinyint(1) DEFAULT NULL,
  `Q3gNo` tinyint(1) DEFAULT NULL,
  `Q3gCmt` varchar(255) DEFAULT NULL,
  `Q3hYesLot` tinyint(1) DEFAULT NULL,
  `Q3hYesLittle` tinyint(1) DEFAULT NULL,
  `Q3hNo` tinyint(1) DEFAULT NULL,
  `Q3hCmt` varchar(255) DEFAULT NULL,
  `Q3iYesLot` tinyint(1) DEFAULT NULL,
  `Q3iYesLittle` tinyint(1) DEFAULT NULL,
  `Q3iNo` tinyint(1) DEFAULT NULL,
  `Q3iCmt` varchar(255) DEFAULT NULL,
  `Q3jYesLot` tinyint(1) DEFAULT NULL,
  `Q3jYesLittle` tinyint(1) DEFAULT NULL,
  `Q3jNo` tinyint(1) DEFAULT NULL,
  `Q3jCmt` varchar(255) DEFAULT NULL,
  `Q4aAll` tinyint(1) DEFAULT NULL,
  `Q4aMost` tinyint(1) DEFAULT NULL,
  `Q4aSome` tinyint(1) DEFAULT NULL,
  `Q4aLittle` tinyint(1) DEFAULT NULL,
  `Q4aNone` tinyint(1) DEFAULT NULL,
  `Q4aCmt` varchar(255) DEFAULT NULL,
  `Q4bAll` tinyint(1) DEFAULT NULL,
  `Q4bMost` tinyint(1) DEFAULT NULL,
  `Q4bSome` tinyint(1) DEFAULT NULL,
  `Q4bLittle` tinyint(1) DEFAULT NULL,
  `Q4bNone` tinyint(1) DEFAULT NULL,
  `Q4bCmt` varchar(255) DEFAULT NULL,
  `Q4cAll` tinyint(1) DEFAULT NULL,
  `Q4cMost` tinyint(1) DEFAULT NULL,
  `Q4cSome` tinyint(1) DEFAULT NULL,
  `Q4cLittle` tinyint(1) DEFAULT NULL,
  `Q4cNone` tinyint(1) DEFAULT NULL,
  `Q4cCmt` varchar(255) DEFAULT NULL,
  `Q4dAll` tinyint(1) DEFAULT NULL,
  `Q4dMost` tinyint(1) DEFAULT NULL,
  `Q4dSome` tinyint(1) DEFAULT NULL,
  `Q4dLittle` tinyint(1) DEFAULT NULL,
  `Q4dNone` tinyint(1) DEFAULT NULL,
  `Q4dCmt` varchar(255) DEFAULT NULL,
  `Q5aAll` tinyint(1) DEFAULT NULL,
  `Q5aMost` tinyint(1) DEFAULT NULL,
  `Q5aSome` tinyint(1) DEFAULT NULL,
  `Q5aLittle` tinyint(1) DEFAULT NULL,
  `Q5aNone` tinyint(1) DEFAULT NULL,
  `Q5aCmt` varchar(255) DEFAULT NULL,
  `Q5bAll` tinyint(1) DEFAULT NULL,
  `Q5bMost` tinyint(1) DEFAULT NULL,
  `Q5bSome` tinyint(1) DEFAULT NULL,
  `Q5bLittle` tinyint(1) DEFAULT NULL,
  `Q5bNone` tinyint(1) DEFAULT NULL,
  `Q5bCmt` varchar(255) DEFAULT NULL,
  `Q5cAll` tinyint(1) DEFAULT NULL,
  `Q5cMost` tinyint(1) DEFAULT NULL,
  `Q5cSome` tinyint(1) DEFAULT NULL,
  `Q5cLittle` tinyint(1) DEFAULT NULL,
  `Q5cNone` tinyint(1) DEFAULT NULL,
  `Q5cCmt` varchar(255) DEFAULT NULL,
  `Q6NotAtAll` tinyint(1) DEFAULT NULL,
  `Q6Slightly` tinyint(1) DEFAULT NULL,
  `Q6Moderately` tinyint(1) DEFAULT NULL,
  `Q6QuiteABit` tinyint(1) DEFAULT NULL,
  `Q6Extremely` tinyint(1) DEFAULT NULL,
  `Q6Cmt` varchar(255) DEFAULT NULL,
  `Q7None` tinyint(1) DEFAULT NULL,
  `Q7VeryMild` tinyint(1) DEFAULT NULL,
  `Q7Mild` tinyint(1) DEFAULT NULL,
  `Q7Moderate` tinyint(1) DEFAULT NULL,
  `Q7Severe` tinyint(1) DEFAULT NULL,
  `Q7VerySevere` tinyint(1) DEFAULT NULL,
  `Q7Cmt` varchar(255) DEFAULT NULL,
  `Q8NotAtAll` tinyint(1) DEFAULT NULL,
  `Q8Slightly` tinyint(1) DEFAULT NULL,
  `Q8Moderately` tinyint(1) DEFAULT NULL,
  `Q8QuiteABit` tinyint(1) DEFAULT NULL,
  `Q8Extremely` tinyint(1) DEFAULT NULL,
  `Q8Cmt` varchar(255) DEFAULT NULL,
  `Q9aAll` tinyint(1) DEFAULT NULL,
  `Q9aMost` tinyint(1) DEFAULT NULL,
  `Q9aSome` tinyint(1) DEFAULT NULL,
  `Q9aLittle` tinyint(1) DEFAULT NULL,
  `Q9aNone` tinyint(1) DEFAULT NULL,
  `Q9aCmt` varchar(255) DEFAULT NULL,
  `Q9bAll` tinyint(1) DEFAULT NULL,
  `Q9bMost` tinyint(1) DEFAULT NULL,
  `Q9bSome` tinyint(1) DEFAULT NULL,
  `Q9bLittle` tinyint(1) DEFAULT NULL,
  `Q9bNone` tinyint(1) DEFAULT NULL,
  `Q9bCmt` varchar(255) DEFAULT NULL,
  `Q9cAll` tinyint(1) DEFAULT NULL,
  `Q9cMost` tinyint(1) DEFAULT NULL,
  `Q9cSome` tinyint(1) DEFAULT NULL,
  `Q9cLittle` tinyint(1) DEFAULT NULL,
  `Q9cNone` tinyint(1) DEFAULT NULL,
  `Q9cCmt` varchar(255) DEFAULT NULL,
  `Q9dAll` tinyint(1) DEFAULT NULL,
  `Q9dMost` tinyint(1) DEFAULT NULL,
  `Q9dSome` tinyint(1) DEFAULT NULL,
  `Q9dLittle` tinyint(1) DEFAULT NULL,
  `Q9dNone` tinyint(1) DEFAULT NULL,
  `Q9dCmt` varchar(255) DEFAULT NULL,
  `Q9eAll` tinyint(1) DEFAULT NULL,
  `Q9eMost` tinyint(1) DEFAULT NULL,
  `Q9eSome` tinyint(1) DEFAULT NULL,
  `Q9eLittle` tinyint(1) DEFAULT NULL,
  `Q9eNone` tinyint(1) DEFAULT NULL,
  `Q9eCmt` varchar(255) DEFAULT NULL,
  `Q9fAll` tinyint(1) DEFAULT NULL,
  `Q9fMost` tinyint(1) DEFAULT NULL,
  `Q9fSome` tinyint(1) DEFAULT NULL,
  `Q9fLittle` tinyint(1) DEFAULT NULL,
  `Q9fNone` tinyint(1) DEFAULT NULL,
  `Q9fCmt` varchar(255) DEFAULT NULL,
  `Q9gAll` tinyint(1) DEFAULT NULL,
  `Q9gMost` tinyint(1) DEFAULT NULL,
  `Q9gSome` tinyint(1) DEFAULT NULL,
  `Q9gLittle` tinyint(1) DEFAULT NULL,
  `Q9gNone` tinyint(1) DEFAULT NULL,
  `Q9gCmt` varchar(255) DEFAULT NULL,
  `Q9hAll` tinyint(1) DEFAULT NULL,
  `Q9hMost` tinyint(1) DEFAULT NULL,
  `Q9hSome` tinyint(1) DEFAULT NULL,
  `Q9hLittle` tinyint(1) DEFAULT NULL,
  `Q9hNone` tinyint(1) DEFAULT NULL,
  `Q9hCmt` varchar(255) DEFAULT NULL,
  `Q9iAll` tinyint(1) DEFAULT NULL,
  `Q9iMost` tinyint(1) DEFAULT NULL,
  `Q9iSome` tinyint(1) DEFAULT NULL,
  `Q9iLittle` tinyint(1) DEFAULT NULL,
  `Q9iNone` tinyint(1) DEFAULT NULL,
  `Q9iCmt` varchar(255) DEFAULT NULL,
  `Q10All` tinyint(1) DEFAULT NULL,
  `Q10Most` tinyint(1) DEFAULT NULL,
  `Q10Some` tinyint(1) DEFAULT NULL,
  `Q10Little` tinyint(1) DEFAULT NULL,
  `Q10None` tinyint(1) DEFAULT NULL,
  `Q10Cmt` varchar(255) DEFAULT NULL,
  `Q11aDefTrue` tinyint(1) DEFAULT NULL,
  `Q11aMostTrue` tinyint(1) DEFAULT NULL,
  `Q11aNotSure` tinyint(1) DEFAULT NULL,
  `Q11aMostFalse` tinyint(1) DEFAULT NULL,
  `Q11aDefFalse` tinyint(1) DEFAULT NULL,
  `Q11aCmt` varchar(255) DEFAULT NULL,
  `Q11bDefTrue` tinyint(1) DEFAULT NULL,
  `Q11bMostTrue` tinyint(1) DEFAULT NULL,
  `Q11bNotSure` tinyint(1) DEFAULT NULL,
  `Q11bMostFalse` tinyint(1) DEFAULT NULL,
  `Q11bDefFalse` tinyint(1) DEFAULT NULL,
  `Q11bCmt` varchar(255) DEFAULT NULL,
  `Q11cDefTrue` tinyint(1) DEFAULT NULL,
  `Q11cMostTrue` tinyint(1) DEFAULT NULL,
  `Q11cNotSure` tinyint(1) DEFAULT NULL,
  `Q11cMostFalse` tinyint(1) DEFAULT NULL,
  `Q11cDefFalse` tinyint(1) DEFAULT NULL,
  `Q11cCmt` varchar(255) DEFAULT NULL,
  `Q11dDefTrue` tinyint(1) DEFAULT NULL,
  `Q11dMostTrue` tinyint(1) DEFAULT NULL,
  `Q11dNotSure` tinyint(1) DEFAULT NULL,
  `Q11dMostFalse` tinyint(1) DEFAULT NULL,
  `Q11dDefFalse` tinyint(1) DEFAULT NULL,
  `Q11dCmt` varchar(255) DEFAULT NULL,
  `Q12aNotAns` tinyint(1) DEFAULT NULL,
  `Q12aNot` tinyint(1) DEFAULT NULL,
  `Q12aLittle` tinyint(1) DEFAULT NULL,
  `Q12aSome` tinyint(1) DEFAULT NULL,
  `Q12aLot` tinyint(1) DEFAULT NULL,
  `Q12aMuch` tinyint(1) DEFAULT NULL,
  `Q12aCmt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formSF36Caregiver`
--

DROP TABLE IF EXISTS `formSF36Caregiver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formSF36Caregiver` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `Q1Ex` tinyint(1) DEFAULT NULL,
  `Q1VG` tinyint(1) DEFAULT NULL,
  `Q1G` tinyint(1) DEFAULT NULL,
  `Q1F` tinyint(1) DEFAULT NULL,
  `Q1P` tinyint(1) DEFAULT NULL,
  `Q1Cmt` varchar(255) DEFAULT NULL,
  `Q2MuchBetter` tinyint(1) DEFAULT NULL,
  `Q2Better` tinyint(1) DEFAULT NULL,
  `Q2Same` tinyint(1) DEFAULT NULL,
  `Q2Worse` tinyint(1) DEFAULT NULL,
  `Q2MuchWorse` tinyint(1) DEFAULT NULL,
  `Q2Cmt` varchar(255) DEFAULT NULL,
  `Q3aYesLot` tinyint(1) DEFAULT NULL,
  `Q3aYesLittle` tinyint(1) DEFAULT NULL,
  `Q3aNo` tinyint(1) DEFAULT NULL,
  `Q3aCmt` varchar(255) DEFAULT NULL,
  `Q3bYesLot` tinyint(1) DEFAULT NULL,
  `Q3bYesLittle` tinyint(1) DEFAULT NULL,
  `Q3bNo` tinyint(1) DEFAULT NULL,
  `Q3bCmt` varchar(255) DEFAULT NULL,
  `Q3cYesLot` tinyint(1) DEFAULT NULL,
  `Q3cYesLittle` tinyint(1) DEFAULT NULL,
  `Q3cNo` tinyint(1) DEFAULT NULL,
  `Q3cCmt` varchar(255) DEFAULT NULL,
  `Q3dYesLot` tinyint(1) DEFAULT NULL,
  `Q3dYesLittle` tinyint(1) DEFAULT NULL,
  `Q3dNo` tinyint(1) DEFAULT NULL,
  `Q3dCmt` varchar(255) DEFAULT NULL,
  `Q3eYesLot` tinyint(1) DEFAULT NULL,
  `Q3eYesLittle` tinyint(1) DEFAULT NULL,
  `Q3eNo` tinyint(1) DEFAULT NULL,
  `Q3eCmt` varchar(255) DEFAULT NULL,
  `Q3fYesLot` tinyint(1) DEFAULT NULL,
  `Q3fYesLittle` tinyint(1) DEFAULT NULL,
  `Q3fNo` tinyint(1) DEFAULT NULL,
  `Q3fCmt` varchar(255) DEFAULT NULL,
  `Q3gYesLot` tinyint(1) DEFAULT NULL,
  `Q3gYesLittle` tinyint(1) DEFAULT NULL,
  `Q3gNo` tinyint(1) DEFAULT NULL,
  `Q3gCmt` varchar(255) DEFAULT NULL,
  `Q3hYesLot` tinyint(1) DEFAULT NULL,
  `Q3hYesLittle` tinyint(1) DEFAULT NULL,
  `Q3hNo` tinyint(1) DEFAULT NULL,
  `Q3hCmt` varchar(255) DEFAULT NULL,
  `Q3iYesLot` tinyint(1) DEFAULT NULL,
  `Q3iYesLittle` tinyint(1) DEFAULT NULL,
  `Q3iNo` tinyint(1) DEFAULT NULL,
  `Q3iCmt` varchar(255) DEFAULT NULL,
  `Q3jYesLot` tinyint(1) DEFAULT NULL,
  `Q3jYesLittle` tinyint(1) DEFAULT NULL,
  `Q3jNo` tinyint(1) DEFAULT NULL,
  `Q3jCmt` varchar(255) DEFAULT NULL,
  `Q4aAll` tinyint(1) DEFAULT NULL,
  `Q4aMost` tinyint(1) DEFAULT NULL,
  `Q4aSome` tinyint(1) DEFAULT NULL,
  `Q4aLittle` tinyint(1) DEFAULT NULL,
  `Q4aNone` tinyint(1) DEFAULT NULL,
  `Q4aCmt` varchar(255) DEFAULT NULL,
  `Q4bAll` tinyint(1) DEFAULT NULL,
  `Q4bMost` tinyint(1) DEFAULT NULL,
  `Q4bSome` tinyint(1) DEFAULT NULL,
  `Q4bLittle` tinyint(1) DEFAULT NULL,
  `Q4bNone` tinyint(1) DEFAULT NULL,
  `Q4bCmt` varchar(255) DEFAULT NULL,
  `Q4cAll` tinyint(1) DEFAULT NULL,
  `Q4cMost` tinyint(1) DEFAULT NULL,
  `Q4cSome` tinyint(1) DEFAULT NULL,
  `Q4cLittle` tinyint(1) DEFAULT NULL,
  `Q4cNone` tinyint(1) DEFAULT NULL,
  `Q4cCmt` varchar(255) DEFAULT NULL,
  `Q4dAll` tinyint(1) DEFAULT NULL,
  `Q4dMost` tinyint(1) DEFAULT NULL,
  `Q4dSome` tinyint(1) DEFAULT NULL,
  `Q4dLittle` tinyint(1) DEFAULT NULL,
  `Q4dNone` tinyint(1) DEFAULT NULL,
  `Q4dCmt` varchar(255) DEFAULT NULL,
  `Q5aAll` tinyint(1) DEFAULT NULL,
  `Q5aMost` tinyint(1) DEFAULT NULL,
  `Q5aSome` tinyint(1) DEFAULT NULL,
  `Q5aLittle` tinyint(1) DEFAULT NULL,
  `Q5aNone` tinyint(1) DEFAULT NULL,
  `Q5aCmt` varchar(255) DEFAULT NULL,
  `Q5bAll` tinyint(1) DEFAULT NULL,
  `Q5bMost` tinyint(1) DEFAULT NULL,
  `Q5bSome` tinyint(1) DEFAULT NULL,
  `Q5bLittle` tinyint(1) DEFAULT NULL,
  `Q5bNone` tinyint(1) DEFAULT NULL,
  `Q5bCmt` varchar(255) DEFAULT NULL,
  `Q5cAll` tinyint(1) DEFAULT NULL,
  `Q5cMost` tinyint(1) DEFAULT NULL,
  `Q5cSome` tinyint(1) DEFAULT NULL,
  `Q5cLittle` tinyint(1) DEFAULT NULL,
  `Q5cNone` tinyint(1) DEFAULT NULL,
  `Q5cCmt` varchar(255) DEFAULT NULL,
  `Q6NotAtAll` tinyint(1) DEFAULT NULL,
  `Q6Slightly` tinyint(1) DEFAULT NULL,
  `Q6Moderately` tinyint(1) DEFAULT NULL,
  `Q6QuiteABit` tinyint(1) DEFAULT NULL,
  `Q6Extremely` tinyint(1) DEFAULT NULL,
  `Q6Cmt` varchar(255) DEFAULT NULL,
  `Q7None` tinyint(1) DEFAULT NULL,
  `Q7VeryMild` tinyint(1) DEFAULT NULL,
  `Q7Mild` tinyint(1) DEFAULT NULL,
  `Q7Moderate` tinyint(1) DEFAULT NULL,
  `Q7Severe` tinyint(1) DEFAULT NULL,
  `Q7VerySevere` tinyint(1) DEFAULT NULL,
  `Q7Cmt` varchar(255) DEFAULT NULL,
  `Q8NotAtAll` tinyint(1) DEFAULT NULL,
  `Q8Slightly` tinyint(1) DEFAULT NULL,
  `Q8Moderately` tinyint(1) DEFAULT NULL,
  `Q8QuiteABit` tinyint(1) DEFAULT NULL,
  `Q8Extremely` tinyint(1) DEFAULT NULL,
  `Q8Cmt` varchar(255) DEFAULT NULL,
  `Q9aAll` tinyint(1) DEFAULT NULL,
  `Q9aMost` tinyint(1) DEFAULT NULL,
  `Q9aSome` tinyint(1) DEFAULT NULL,
  `Q9aLittle` tinyint(1) DEFAULT NULL,
  `Q9aNone` tinyint(1) DEFAULT NULL,
  `Q9aCmt` varchar(255) DEFAULT NULL,
  `Q9bAll` tinyint(1) DEFAULT NULL,
  `Q9bMost` tinyint(1) DEFAULT NULL,
  `Q9bSome` tinyint(1) DEFAULT NULL,
  `Q9bLittle` tinyint(1) DEFAULT NULL,
  `Q9bNone` tinyint(1) DEFAULT NULL,
  `Q9bCmt` varchar(255) DEFAULT NULL,
  `Q9cAll` tinyint(1) DEFAULT NULL,
  `Q9cMost` tinyint(1) DEFAULT NULL,
  `Q9cSome` tinyint(1) DEFAULT NULL,
  `Q9cLittle` tinyint(1) DEFAULT NULL,
  `Q9cNone` tinyint(1) DEFAULT NULL,
  `Q9cCmt` varchar(255) DEFAULT NULL,
  `Q9dAll` tinyint(1) DEFAULT NULL,
  `Q9dMost` tinyint(1) DEFAULT NULL,
  `Q9dSome` tinyint(1) DEFAULT NULL,
  `Q9dLittle` tinyint(1) DEFAULT NULL,
  `Q9dNone` tinyint(1) DEFAULT NULL,
  `Q9dCmt` varchar(255) DEFAULT NULL,
  `Q9eAll` tinyint(1) DEFAULT NULL,
  `Q9eMost` tinyint(1) DEFAULT NULL,
  `Q9eSome` tinyint(1) DEFAULT NULL,
  `Q9eLittle` tinyint(1) DEFAULT NULL,
  `Q9eNone` tinyint(1) DEFAULT NULL,
  `Q9eCmt` varchar(255) DEFAULT NULL,
  `Q9fAll` tinyint(1) DEFAULT NULL,
  `Q9fMost` tinyint(1) DEFAULT NULL,
  `Q9fSome` tinyint(1) DEFAULT NULL,
  `Q9fLittle` tinyint(1) DEFAULT NULL,
  `Q9fNone` tinyint(1) DEFAULT NULL,
  `Q9fCmt` varchar(255) DEFAULT NULL,
  `Q9gAll` tinyint(1) DEFAULT NULL,
  `Q9gMost` tinyint(1) DEFAULT NULL,
  `Q9gSome` tinyint(1) DEFAULT NULL,
  `Q9gLittle` tinyint(1) DEFAULT NULL,
  `Q9gNone` tinyint(1) DEFAULT NULL,
  `Q9gCmt` varchar(255) DEFAULT NULL,
  `Q9hAll` tinyint(1) DEFAULT NULL,
  `Q9hMost` tinyint(1) DEFAULT NULL,
  `Q9hSome` tinyint(1) DEFAULT NULL,
  `Q9hLittle` tinyint(1) DEFAULT NULL,
  `Q9hNone` tinyint(1) DEFAULT NULL,
  `Q9hCmt` varchar(255) DEFAULT NULL,
  `Q9iAll` tinyint(1) DEFAULT NULL,
  `Q9iMost` tinyint(1) DEFAULT NULL,
  `Q9iSome` tinyint(1) DEFAULT NULL,
  `Q9iLittle` tinyint(1) DEFAULT NULL,
  `Q9iNone` tinyint(1) DEFAULT NULL,
  `Q9iCmt` varchar(255) DEFAULT NULL,
  `Q10All` tinyint(1) DEFAULT NULL,
  `Q10Most` tinyint(1) DEFAULT NULL,
  `Q10Some` tinyint(1) DEFAULT NULL,
  `Q10Little` tinyint(1) DEFAULT NULL,
  `Q10None` tinyint(1) DEFAULT NULL,
  `Q10Cmt` varchar(255) DEFAULT NULL,
  `Q11aDefTrue` tinyint(1) DEFAULT NULL,
  `Q11aMostTrue` tinyint(1) DEFAULT NULL,
  `Q11aNotSure` tinyint(1) DEFAULT NULL,
  `Q11aMostFalse` tinyint(1) DEFAULT NULL,
  `Q11aDefFalse` tinyint(1) DEFAULT NULL,
  `Q11aCmt` varchar(255) DEFAULT NULL,
  `Q11bDefTrue` tinyint(1) DEFAULT NULL,
  `Q11bMostTrue` tinyint(1) DEFAULT NULL,
  `Q11bNotSure` tinyint(1) DEFAULT NULL,
  `Q11bMostFalse` tinyint(1) DEFAULT NULL,
  `Q11bDefFalse` tinyint(1) DEFAULT NULL,
  `Q11bCmt` varchar(255) DEFAULT NULL,
  `Q11cDefTrue` tinyint(1) DEFAULT NULL,
  `Q11cMostTrue` tinyint(1) DEFAULT NULL,
  `Q11cNotSure` tinyint(1) DEFAULT NULL,
  `Q11cMostFalse` tinyint(1) DEFAULT NULL,
  `Q11cDefFalse` tinyint(1) DEFAULT NULL,
  `Q11cCmt` varchar(255) DEFAULT NULL,
  `Q11dDefTrue` tinyint(1) DEFAULT NULL,
  `Q11dMostTrue` tinyint(1) DEFAULT NULL,
  `Q11dNotSure` tinyint(1) DEFAULT NULL,
  `Q11dMostFalse` tinyint(1) DEFAULT NULL,
  `Q11dDefFalse` tinyint(1) DEFAULT NULL,
  `Q11dCmt` varchar(255) DEFAULT NULL,
  `Q12aNotAns` tinyint(1) DEFAULT NULL,
  `Q12aNot` tinyint(1) DEFAULT NULL,
  `Q12aLittle` tinyint(1) DEFAULT NULL,
  `Q12aSome` tinyint(1) DEFAULT NULL,
  `Q12aLot` tinyint(1) DEFAULT NULL,
  `Q12aMuch` tinyint(1) DEFAULT NULL,
  `Q12aCmt` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formSatisfactionScale`
--

DROP TABLE IF EXISTS `formSatisfactionScale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formSatisfactionScale` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `believe1Y` tinyint(1) DEFAULT NULL,
  `believe1N` tinyint(1) DEFAULT NULL,
  `receive2Y` tinyint(1) DEFAULT NULL,
  `receive2N` tinyint(1) DEFAULT NULL,
  `receiveOT3Y` tinyint(1) DEFAULT NULL,
  `receiveP3Y` tinyint(1) DEFAULT NULL,
  `receiveB3Y` tinyint(1) DEFAULT NULL,
  `otTreats4` char(4) DEFAULT NULL,
  `ptTreats4` char(4) DEFAULT NULL,
  `explaining1` char(2) DEFAULT NULL,
  `everythingNeeded2` char(2) DEFAULT NULL,
  `perfect3` char(2) DEFAULT NULL,
  `wonder4` char(2) DEFAULT NULL,
  `confident5` char(2) DEFAULT NULL,
  `careful6` char(2) DEFAULT NULL,
  `afford7` char(2) DEFAULT NULL,
  `easyaccess8` char(2) DEFAULT NULL,
  `toolong9` char(2) DEFAULT NULL,
  `businesslike10` char(2) DEFAULT NULL,
  `veryfriendly11` char(2) DEFAULT NULL,
  `hurrytoomuch12` char(2) DEFAULT NULL,
  `ignore13` char(2) DEFAULT NULL,
  `doubtability14` char(2) DEFAULT NULL,
  `plentyoftime15` char(2) DEFAULT NULL,
  `hardtogetanappointment16` char(2) DEFAULT NULL,
  `dissatisfied17` char(2) DEFAULT NULL,
  `abletogetrehabilitation18` char(2) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formSelfAdministered`
--

DROP TABLE IF EXISTS `formSelfAdministered`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formSelfAdministered` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `sex` varchar(1) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `healthEx` tinyint(1) DEFAULT NULL,
  `healthVG` tinyint(1) DEFAULT NULL,
  `healthG` tinyint(1) DEFAULT NULL,
  `healthF` tinyint(1) DEFAULT NULL,
  `healthP` tinyint(1) DEFAULT NULL,
  `stayInHospNo` tinyint(1) DEFAULT NULL,
  `stayInHosp1` tinyint(1) DEFAULT NULL,
  `stayInHosp2Or3` tinyint(1) DEFAULT NULL,
  `stayInHospMore3` tinyint(1) DEFAULT NULL,
  `visitPhyNo` tinyint(1) DEFAULT NULL,
  `visitPhy1` tinyint(1) DEFAULT NULL,
  `visitPhy2Or3` tinyint(1) DEFAULT NULL,
  `visitPhyMore3` tinyint(1) DEFAULT NULL,
  `diabetesY` tinyint(1) DEFAULT NULL,
  `diabetesN` tinyint(1) DEFAULT NULL,
  `heartDiseaseY` tinyint(1) DEFAULT NULL,
  `heartDiseaseN` tinyint(1) DEFAULT NULL,
  `anginaPectorisY` tinyint(1) DEFAULT NULL,
  `anginaPectorisN` tinyint(1) DEFAULT NULL,
  `myocardialInfarctionY` tinyint(1) DEFAULT NULL,
  `myocardialInfarctionN` tinyint(1) DEFAULT NULL,
  `anyHeartAttackY` tinyint(1) DEFAULT NULL,
  `anyHeartAttackN` tinyint(1) DEFAULT NULL,
  `relativeTakeCareY` tinyint(1) DEFAULT NULL,
  `relativeTakeCareN` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formSelfEfficacy`
--

DROP TABLE IF EXISTS `formSelfEfficacy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formSelfEfficacy` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `ex1` varchar(2) DEFAULT NULL,
  `ex2` varchar(2) DEFAULT NULL,
  `ex3` varchar(2) DEFAULT NULL,
  `exerScore` varchar(5) DEFAULT NULL,
  `disease1` varchar(2) DEFAULT NULL,
  `diseaseScore` varchar(5) DEFAULT NULL,
  `help1` varchar(2) DEFAULT NULL,
  `help2` varchar(2) DEFAULT NULL,
  `help3` varchar(2) DEFAULT NULL,
  `help4` varchar(2) DEFAULT NULL,
  `helpScore` varchar(5) DEFAULT NULL,
  `communicateWithPhy1` varchar(2) DEFAULT NULL,
  `communicateWithPhy2` varchar(2) DEFAULT NULL,
  `communicateWithPhy3` varchar(2) DEFAULT NULL,
  `commScore` varchar(5) DEFAULT NULL,
  `manageDisease1` varchar(2) DEFAULT NULL,
  `manageDisease2` varchar(2) DEFAULT NULL,
  `manageDisease3` varchar(2) DEFAULT NULL,
  `manageDisease4` varchar(2) DEFAULT NULL,
  `manageDisease5` varchar(2) DEFAULT NULL,
  `manDiseaseScore` varchar(5) DEFAULT NULL,
  `doChore1` varchar(2) DEFAULT NULL,
  `doChore2` varchar(2) DEFAULT NULL,
  `doChore3` varchar(2) DEFAULT NULL,
  `choresScore` varchar(5) DEFAULT NULL,
  `social1` varchar(2) DEFAULT NULL,
  `social2` varchar(2) DEFAULT NULL,
  `socialScore` varchar(5) DEFAULT NULL,
  `shortBreath1` varchar(2) DEFAULT NULL,
  `breathScore` varchar(5) DEFAULT NULL,
  `manageSymptoms1` varchar(2) DEFAULT NULL,
  `manageSymptoms2` varchar(2) DEFAULT NULL,
  `manageSymptoms3` varchar(2) DEFAULT NULL,
  `manageSymptoms4` varchar(2) DEFAULT NULL,
  `manageSymptoms5` varchar(2) DEFAULT NULL,
  `manSymScore` varchar(5) DEFAULT NULL,
  `controlDepress1` varchar(2) DEFAULT NULL,
  `controlDepress2` varchar(2) DEFAULT NULL,
  `controlDepress3` varchar(2) DEFAULT NULL,
  `controlDepress4` varchar(2) DEFAULT NULL,
  `controlDepress5` varchar(2) DEFAULT NULL,
  `controlDepress6` varchar(2) DEFAULT NULL,
  `manDprScore` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formSelfManagement`
--

DROP TABLE IF EXISTS `formSelfManagement`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formSelfManagement` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `ex1` int(1) DEFAULT NULL,
  `ex2` int(1) DEFAULT NULL,
  `ex3` int(1) DEFAULT NULL,
  `ex4` int(1) DEFAULT NULL,
  `ex5` int(1) DEFAULT NULL,
  `ex6Spec` varchar(255) DEFAULT NULL,
  `ex6` int(1) DEFAULT NULL,
  `exTime1` int(3) DEFAULT NULL,
  `exTime2To6` int(3) DEFAULT NULL,
  `cog1` varchar(1) DEFAULT NULL,
  `cog2` varchar(1) DEFAULT NULL,
  `cog3` varchar(1) DEFAULT NULL,
  `cog4` varchar(1) DEFAULT NULL,
  `cog5` varchar(1) DEFAULT NULL,
  `cog6` varchar(1) DEFAULT NULL,
  `cogScore` varchar(4) DEFAULT NULL,
  `mentalStressTimes` int(3) DEFAULT NULL,
  `mentalStressToRelax` varchar(255) DEFAULT NULL,
  `mentalStressScore` varchar(10) DEFAULT NULL,
  `tangibleHelpHouseN` tinyint(1) DEFAULT NULL,
  `tangibleHelpHouseY` tinyint(1) DEFAULT NULL,
  `tangibleHelpYardN` tinyint(1) DEFAULT NULL,
  `tangibleHelpYardY` tinyint(1) DEFAULT NULL,
  `tangibleHelpHomeN` tinyint(1) DEFAULT NULL,
  `tangibleHelpHomeY` tinyint(1) DEFAULT NULL,
  `tangibleHelpMealN` tinyint(1) DEFAULT NULL,
  `tangibleHelpMealY` tinyint(1) DEFAULT NULL,
  `tangibleHelpHygieneN` tinyint(1) DEFAULT NULL,
  `tangibleHelpHygieneY` tinyint(1) DEFAULT NULL,
  `tangibleHelpErrandsN` tinyint(1) DEFAULT NULL,
  `tangibleHelpErrandsY` tinyint(1) DEFAULT NULL,
  `tangibleHelpTransportN` tinyint(1) DEFAULT NULL,
  `tangibleHelpTransportY` tinyint(1) DEFAULT NULL,
  `tangibleHelpScore` int(1) DEFAULT NULL,
  `emotionalSupportN` tinyint(1) DEFAULT NULL,
  `emotionalSupportY` tinyint(1) DEFAULT NULL,
  `emotionalSupportScore` int(1) DEFAULT NULL,
  `healthEducationN` tinyint(1) DEFAULT NULL,
  `healthEducationY` tinyint(1) DEFAULT NULL,
  `healthEducationHours` int(4) DEFAULT NULL,
  `healthEducationScore` varchar(10) DEFAULT NULL,
  `exercisePrgmN` tinyint(1) DEFAULT NULL,
  `exercisePrgmY` tinyint(1) DEFAULT NULL,
  `exercisePrgmHours` int(4) DEFAULT NULL,
  `exercisePrgmScore` int(1) DEFAULT NULL,
  `communicate1` varchar(1) DEFAULT NULL,
  `communicate2` varchar(1) DEFAULT NULL,
  `communicate3` varchar(1) DEFAULT NULL,
  `communicateScore` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formTreatmentPref`
--

DROP TABLE IF EXISTS `formTreatmentPref`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formTreatmentPref` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `studyID` varchar(20) NOT NULL DEFAULT 'N/A',
  `treatmentGr` tinyint(1) DEFAULT NULL,
  `controlGr` tinyint(1) DEFAULT NULL,
  `eitherGr` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formType2Diabetes`
--

DROP TABLE IF EXISTS `formType2Diabetes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formType2Diabetes` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pName` varchar(60) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `dateDx` date DEFAULT NULL,
  `height` varchar(10) DEFAULT NULL,
  `date1` date DEFAULT NULL,
  `date2` date DEFAULT NULL,
  `date3` date DEFAULT NULL,
  `date4` date DEFAULT NULL,
  `date5` date DEFAULT NULL,
  `weight1` varchar(20) DEFAULT NULL,
  `weight2` varchar(20) DEFAULT NULL,
  `weight3` varchar(20) DEFAULT NULL,
  `weight4` varchar(20) DEFAULT NULL,
  `weight5` varchar(20) DEFAULT NULL,
  `bp1` varchar(20) DEFAULT NULL,
  `bp2` varchar(20) DEFAULT NULL,
  `bp3` varchar(20) DEFAULT NULL,
  `bp4` varchar(20) DEFAULT NULL,
  `bp5` varchar(20) DEFAULT NULL,
  `glucoseA1` varchar(50) DEFAULT NULL,
  `glucoseA2` varchar(50) DEFAULT NULL,
  `glucoseA3` varchar(50) DEFAULT NULL,
  `glucoseA4` varchar(50) DEFAULT NULL,
  `glucoseA5` varchar(50) DEFAULT NULL,
  `glucoseB1` varchar(50) DEFAULT NULL,
  `glucoseB2` varchar(50) DEFAULT NULL,
  `glucoseB3` varchar(50) DEFAULT NULL,
  `glucoseB4` varchar(50) DEFAULT NULL,
  `glucoseB5` varchar(50) DEFAULT NULL,
  `glucoseC1` varchar(50) DEFAULT NULL,
  `glucoseC2` varchar(50) DEFAULT NULL,
  `glucoseC3` varchar(50) DEFAULT NULL,
  `glucoseC4` varchar(50) DEFAULT NULL,
  `glucoseC5` varchar(50) DEFAULT NULL,
  `renal1` varchar(50) DEFAULT NULL,
  `renal2` varchar(50) DEFAULT NULL,
  `renal3` varchar(50) DEFAULT NULL,
  `renal4` varchar(50) DEFAULT NULL,
  `renal5` varchar(50) DEFAULT NULL,
  `urineRatio1` varchar(50) DEFAULT NULL,
  `urineRatio2` varchar(50) DEFAULT NULL,
  `urineRatio3` varchar(50) DEFAULT NULL,
  `urineRatio4` varchar(50) DEFAULT NULL,
  `urineRatio5` varchar(50) DEFAULT NULL,
  `urineClearance1` varchar(100) DEFAULT NULL,
  `urineClearance2` varchar(100) DEFAULT NULL,
  `urineClearance3` varchar(100) DEFAULT NULL,
  `urineClearance4` varchar(100) DEFAULT NULL,
  `urineClearance5` varchar(100) DEFAULT NULL,
  `lipidsA1` varchar(30) DEFAULT NULL,
  `lipidsA2` varchar(30) DEFAULT NULL,
  `lipidsA3` varchar(30) DEFAULT NULL,
  `lipidsA4` varchar(30) DEFAULT NULL,
  `lipidsA5` varchar(30) DEFAULT NULL,
  `lipidsB1` varchar(30) DEFAULT NULL,
  `lipidsB2` varchar(30) DEFAULT NULL,
  `lipidsB3` varchar(30) DEFAULT NULL,
  `lipidsB4` varchar(30) DEFAULT NULL,
  `lipidsB5` varchar(30) DEFAULT NULL,
  `lipidsC1` varchar(30) DEFAULT NULL,
  `lipidsC2` varchar(30) DEFAULT NULL,
  `lipidsC3` varchar(30) DEFAULT NULL,
  `lipidsC4` varchar(30) DEFAULT NULL,
  `lipidsC5` varchar(30) DEFAULT NULL,
  `ophthalmologist` varchar(50) DEFAULT NULL,
  `eyes1` varchar(50) DEFAULT NULL,
  `eyes2` varchar(50) DEFAULT NULL,
  `eyes3` varchar(50) DEFAULT NULL,
  `eyes4` varchar(50) DEFAULT NULL,
  `eyes5` varchar(50) DEFAULT NULL,
  `feet1` varchar(100) DEFAULT NULL,
  `feet2` varchar(100) DEFAULT NULL,
  `feet3` varchar(100) DEFAULT NULL,
  `feet4` varchar(100) DEFAULT NULL,
  `feet5` varchar(100) DEFAULT NULL,
  `metformin` tinyint(1) DEFAULT NULL,
  `aceInhibitor` tinyint(1) DEFAULT NULL,
  `glyburide` tinyint(1) DEFAULT NULL,
  `asa` tinyint(1) DEFAULT NULL,
  `otherOha` tinyint(1) DEFAULT NULL,
  `otherBox7` varchar(20) DEFAULT NULL,
  `insulin` tinyint(1) DEFAULT NULL,
  `otherBox8` varchar(20) DEFAULT NULL,
  `meds1` varchar(100) DEFAULT NULL,
  `meds2` varchar(100) DEFAULT NULL,
  `meds3` varchar(100) DEFAULT NULL,
  `meds4` varchar(100) DEFAULT NULL,
  `meds5` varchar(100) DEFAULT NULL,
  `lifestyle1` varchar(50) DEFAULT NULL,
  `lifestyle2` varchar(50) DEFAULT NULL,
  `lifestyle3` varchar(50) DEFAULT NULL,
  `lifestyle4` varchar(50) DEFAULT NULL,
  `lifestyle5` varchar(50) DEFAULT NULL,
  `exercise1` varchar(50) DEFAULT NULL,
  `exercise2` varchar(50) DEFAULT NULL,
  `exercise3` varchar(50) DEFAULT NULL,
  `exercise4` varchar(50) DEFAULT NULL,
  `exercise5` varchar(50) DEFAULT NULL,
  `alcohol1` varchar(50) DEFAULT NULL,
  `alcohol2` varchar(50) DEFAULT NULL,
  `alcohol3` varchar(50) DEFAULT NULL,
  `alcohol4` varchar(50) DEFAULT NULL,
  `alcohol5` varchar(50) DEFAULT NULL,
  `sexualFunction1` varchar(50) DEFAULT NULL,
  `sexualFunction2` varchar(50) DEFAULT NULL,
  `sexualFunction3` varchar(50) DEFAULT NULL,
  `sexualFunction4` varchar(50) DEFAULT NULL,
  `sexualFunction5` varchar(50) DEFAULT NULL,
  `diet1` varchar(50) DEFAULT NULL,
  `diet2` varchar(50) DEFAULT NULL,
  `diet3` varchar(50) DEFAULT NULL,
  `diet4` varchar(50) DEFAULT NULL,
  `diet5` varchar(50) DEFAULT NULL,
  `otherPlan1` varchar(100) DEFAULT NULL,
  `otherPlan2` varchar(100) DEFAULT NULL,
  `otherPlan3` varchar(100) DEFAULT NULL,
  `otherPlan4` varchar(100) DEFAULT NULL,
  `otherPlan5` varchar(100) DEFAULT NULL,
  `consultant` varchar(30) DEFAULT NULL,
  `educator` varchar(30) DEFAULT NULL,
  `nutritionist` varchar(30) DEFAULT NULL,
  `cdn1` varchar(100) DEFAULT NULL,
  `cdn2` varchar(100) DEFAULT NULL,
  `cdn3` varchar(100) DEFAULT NULL,
  `cdn4` varchar(100) DEFAULT NULL,
  `cdn5` varchar(100) DEFAULT NULL,
  `initials1` varchar(30) DEFAULT NULL,
  `initials2` varchar(30) DEFAULT NULL,
  `initials3` varchar(30) DEFAULT NULL,
  `initials4` varchar(30) DEFAULT NULL,
  `initials5` varchar(30) DEFAULT NULL,
  `resource1` tinyint(1) DEFAULT NULL,
  `resource2` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formVTForm`
--

DROP TABLE IF EXISTS `formVTForm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formVTForm` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `visitCod` varchar(10) DEFAULT NULL,
  `HTValue` varchar(10) DEFAULT NULL,
  `HTDate` varchar(10) DEFAULT NULL,
  `HTComments` varchar(255) DEFAULT NULL,
  `WTValue` varchar(10) DEFAULT NULL,
  `WTDate` varchar(10) DEFAULT NULL,
  `WTComments` varchar(255) DEFAULT NULL,
  `WHRValue` varchar(10) DEFAULT NULL,
  `WHRDate` varchar(10) DEFAULT NULL,
  `WHRComments` varchar(255) DEFAULT NULL,
  `WCValue` varchar(10) DEFAULT NULL,
  `WCDate` varchar(10) DEFAULT NULL,
  `WCComments` varchar(255) DEFAULT NULL,
  `HCValue` varchar(10) DEFAULT NULL,
  `HCDate` varchar(10) DEFAULT NULL,
  `HCComments` varchar(255) DEFAULT NULL,
  `BPValue` varchar(10) DEFAULT NULL,
  `BPDate` varchar(10) DEFAULT NULL,
  `BPComments` varchar(255) DEFAULT NULL,
  `HRValue` varchar(10) DEFAULT NULL,
  `HRDate` varchar(10) DEFAULT NULL,
  `HRComments` varchar(255) DEFAULT NULL,
  `HbA1Value` varchar(10) DEFAULT NULL,
  `HbA1Date` varchar(10) DEFAULT NULL,
  `HbA1Comments` varchar(255) DEFAULT NULL,
  `BGValue` varchar(10) DEFAULT NULL,
  `BGDate` varchar(10) DEFAULT NULL,
  `BGComments` varchar(255) DEFAULT NULL,
  `LDLValue` varchar(10) DEFAULT NULL,
  `LDLDate` varchar(10) DEFAULT NULL,
  `LDLComments` varchar(255) DEFAULT NULL,
  `HDLValue` varchar(10) DEFAULT NULL,
  `HDLDate` varchar(10) DEFAULT NULL,
  `HDLComments` varchar(255) DEFAULT NULL,
  `TCHLValue` varchar(10) DEFAULT NULL,
  `TCHLDate` varchar(10) DEFAULT NULL,
  `TCHLComments` varchar(255) DEFAULT NULL,
  `TRIGValue` varchar(10) DEFAULT NULL,
  `TRIGDate` varchar(10) DEFAULT NULL,
  `TRIGComments` varchar(255) DEFAULT NULL,
  `UALBValue` varchar(10) DEFAULT NULL,
  `UALBDate` varchar(10) DEFAULT NULL,
  `UALBComments` varchar(255) DEFAULT NULL,
  `24UAValue` varchar(10) DEFAULT NULL,
  `24UADate` varchar(10) DEFAULT NULL,
  `24UAComments` varchar(255) DEFAULT NULL,
  `FTExValue` varchar(10) DEFAULT NULL,
  `FTExDate` varchar(10) DEFAULT NULL,
  `FTExComments` varchar(255) DEFAULT NULL,
  `FTNeValue` varchar(10) DEFAULT NULL,
  `FTNeDate` varchar(10) DEFAULT NULL,
  `FTNeComments` varchar(255) DEFAULT NULL,
  `FTIsValue` varchar(10) DEFAULT NULL,
  `FTIsDate` varchar(10) DEFAULT NULL,
  `FTIsComments` varchar(255) DEFAULT NULL,
  `FTUlValue` varchar(10) DEFAULT NULL,
  `FTUlDate` varchar(10) DEFAULT NULL,
  `FTUlComments` varchar(255) DEFAULT NULL,
  `FTInValue` varchar(10) DEFAULT NULL,
  `FTInDate` varchar(10) DEFAULT NULL,
  `FTInComments` varchar(255) DEFAULT NULL,
  `FTOtValue` varchar(10) DEFAULT NULL,
  `FTOtDate` varchar(10) DEFAULT NULL,
  `FTOtComments` varchar(255) DEFAULT NULL,
  `FTReValue` varchar(10) DEFAULT NULL,
  `FTReDate` varchar(10) DEFAULT NULL,
  `FTReComments` varchar(255) DEFAULT NULL,
  `iExValue` varchar(10) DEFAULT NULL,
  `iExDate` varchar(10) DEFAULT NULL,
  `iExComments` varchar(255) DEFAULT NULL,
  `iDiaValue` varchar(10) DEFAULT NULL,
  `iDiaDate` varchar(10) DEFAULT NULL,
  `iDiaComments` varchar(255) DEFAULT NULL,
  `iHypValue` varchar(10) DEFAULT NULL,
  `iHypDate` varchar(10) DEFAULT NULL,
  `iHypComments` varchar(255) DEFAULT NULL,
  `iOthValue` varchar(10) DEFAULT NULL,
  `iOthDate` varchar(10) DEFAULT NULL,
  `iOthComments` varchar(255) DEFAULT NULL,
  `iRefValue` varchar(10) DEFAULT NULL,
  `iRefDate` varchar(10) DEFAULT NULL,
  `iRefComments` varchar(255) DEFAULT NULL,
  `SmkSValue` varchar(10) DEFAULT NULL,
  `SmkSDate` varchar(10) DEFAULT NULL,
  `SmkSComments` varchar(255) DEFAULT NULL,
  `SmkHValue` varchar(10) DEFAULT NULL,
  `SmkHDate` varchar(10) DEFAULT NULL,
  `SmkHComments` varchar(255) DEFAULT NULL,
  `SmkCValue` varchar(10) DEFAULT NULL,
  `SmkCDate` varchar(10) DEFAULT NULL,
  `SmkCComments` varchar(255) DEFAULT NULL,
  `ExerValue` varchar(10) DEFAULT NULL,
  `ExerDate` varchar(10) DEFAULT NULL,
  `ExerComments` varchar(255) DEFAULT NULL,
  `DietValue` varchar(10) DEFAULT NULL,
  `DietDate` varchar(10) DEFAULT NULL,
  `DietComments` varchar(255) DEFAULT NULL,
  `DpScValue` varchar(10) DEFAULT NULL,
  `DpScDate` varchar(10) DEFAULT NULL,
  `DpScComments` varchar(255) DEFAULT NULL,
  `StScValue` varchar(10) DEFAULT NULL,
  `StScDate` varchar(10) DEFAULT NULL,
  `StScComments` varchar(255) DEFAULT NULL,
  `LcCtValue` varchar(10) DEFAULT NULL,
  `LcCtDate` varchar(10) DEFAULT NULL,
  `LcCtComments` varchar(255) DEFAULT NULL,
  `MedGValue` varchar(10) DEFAULT NULL,
  `MedGDate` varchar(10) DEFAULT NULL,
  `MedGComments` varchar(255) DEFAULT NULL,
  `MedNValue` varchar(10) DEFAULT NULL,
  `MedNDate` varchar(10) DEFAULT NULL,
  `MedNComments` varchar(255) DEFAULT NULL,
  `MedRValue` varchar(10) DEFAULT NULL,
  `MedRDate` varchar(10) DEFAULT NULL,
  `MedRComments` varchar(255) DEFAULT NULL,
  `MedAValue` varchar(10) DEFAULT NULL,
  `MedADate` varchar(10) DEFAULT NULL,
  `MedAComments` varchar(255) DEFAULT NULL,
  `NtrCValue` varchar(10) DEFAULT NULL,
  `NtrCDate` varchar(10) DEFAULT NULL,
  `NtrCComments` varchar(255) DEFAULT NULL,
  `ExeCValue` varchar(10) DEFAULT NULL,
  `ExeCDate` varchar(10) DEFAULT NULL,
  `ExeCComments` varchar(255) DEFAULT NULL,
  `SmCCValue` varchar(10) DEFAULT NULL,
  `SmCCDate` varchar(10) DEFAULT NULL,
  `SmCCComments` varchar(255) DEFAULT NULL,
  `DiaCValue` varchar(10) DEFAULT NULL,
  `DiaCDate` varchar(10) DEFAULT NULL,
  `DiaCComments` varchar(255) DEFAULT NULL,
  `PsyCValue` varchar(10) DEFAULT NULL,
  `PsyCDate` varchar(10) DEFAULT NULL,
  `PsyCComments` varchar(255) DEFAULT NULL,
  `OthCValue` varchar(10) DEFAULT NULL,
  `OthCDate` varchar(10) DEFAULT NULL,
  `OthCComments` varchar(255) DEFAULT NULL,
  `DMValue` varchar(10) DEFAULT NULL,
  `HTNValue` varchar(10) DEFAULT NULL,
  `HchlValue` varchar(10) DEFAULT NULL,
  `MIValue` varchar(10) DEFAULT NULL,
  `AngValue` varchar(10) DEFAULT NULL,
  `ACSValue` varchar(10) DEFAULT NULL,
  `RVTNValue` varchar(10) DEFAULT NULL,
  `CVDValue` varchar(10) DEFAULT NULL,
  `PVDValue` varchar(10) DEFAULT NULL,
  `Diagnosis` text,
  `Subjective` text,
  `Objective` text,
  `Assessment` text,
  `Plan` text,
  `WHRBValue` varchar(10) DEFAULT NULL,
  `WHRBDate` varchar(10) DEFAULT NULL,
  `WHRBComments` varchar(255) DEFAULT NULL,
  `WHRBLastData` varchar(10) DEFAULT NULL,
  `WHRBLastDataEnteredDate` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID` (`ID`),
  KEY `demographic_no` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `form_hsfo2_visit`
--

DROP TABLE IF EXISTS `form_hsfo2_visit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `form_hsfo2_visit` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL,
  `provider_no` varchar(10) NOT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Patient_Id` varchar(255) NOT NULL,
  `VisitDate_Id` date NOT NULL,
  `Drugcoverage` enum('yes','no','null') DEFAULT NULL,
  `SBP` int(3) DEFAULT NULL,
  `SBP_goal` int(3) DEFAULT NULL,
  `DBP` int(3) DEFAULT NULL,
  `DBP_goal` int(3) DEFAULT NULL,
  `Height` double(4,1) NOT NULL,
  `Height_unit` enum('cm','inch') NOT NULL,
  `Bptru_used` enum('yes','no','null') DEFAULT NULL,
  `Weight` double(4,1) DEFAULT NULL,
  `Weight_unit` enum('kg','lb','null') DEFAULT NULL,
  `Waist` double(4,1) DEFAULT NULL,
  `Waist_unit` enum('cm','inch','null') DEFAULT NULL,
  `TC_HDL` double(3,1) DEFAULT NULL,
  `LDL` double(3,1) DEFAULT NULL,
  `HDL` double(2,1) DEFAULT NULL,
  `Triglycerides` double(3,1) DEFAULT NULL,
  `Nextvisit` enum('Under1Mo','1to2Mo','3to6Mo','Over6Mo','null') DEFAULT NULL,
  `Bpactionplan` tinyint(1) NOT NULL,
  `PressureOff` tinyint(1) NOT NULL,
  `PatientProvider` tinyint(1) NOT NULL,
  `ABPM` tinyint(1) NOT NULL,
  `Home` tinyint(1) NOT NULL,
  `CommunityRes` tinyint(1) NOT NULL,
  `ProRefer` tinyint(1) NOT NULL,
  `HtnDxType` enum('PrimaryHtn','ElevatedBpReadings','null') DEFAULT NULL,
  `Dyslipid` tinyint(1) NOT NULL,
  `Diabetes` tinyint(1) NOT NULL,
  `KidneyDis` tinyint(1) NOT NULL,
  `Obesity` tinyint(1) NOT NULL,
  `CHD` tinyint(1) NOT NULL,
  `Stroke_TIA` tinyint(1) NOT NULL,
  `Risk_weight` tinyint(1) DEFAULT NULL,
  `Risk_activity` tinyint(1) DEFAULT NULL,
  `Risk_diet` tinyint(1) DEFAULT NULL,
  `Risk_smoking` tinyint(1) DEFAULT NULL,
  `Risk_alcohol` tinyint(1) DEFAULT NULL,
  `Risk_stress` tinyint(1) DEFAULT NULL,
  `PtView` enum('Uninterested','Thinking','Deciding','TakingAction','Maintaining','Relapsing','null') DEFAULT NULL,
  `Change_importance` int(2) DEFAULT NULL,
  `Change_confidence` int(2) DEFAULT NULL,
  `exercise_minPerWk` int(3) DEFAULT NULL,
  `smoking_cigsPerDay` int(2) DEFAULT NULL,
  `alcohol_drinksPerWk` int(2) DEFAULT NULL,
  `sel_DashDiet` enum('Always','Often','Sometimes','Never','null') DEFAULT NULL,
  `sel_HighSaltFood` enum('Always','Often','Sometimes','Never','null') DEFAULT NULL,
  `sel_Stressed` enum('Always','Often','Sometimes','Never','null') DEFAULT NULL,
  `LifeGoal` enum('Goal_weight','Goal_activity','Goal_dietDash','Goal_dietSalt','Goal_smoking','Goal_alcohol','Goal_stress','null') DEFAULT NULL,
  `FamHx_Htn` tinyint(1) NOT NULL,
  `FamHx_Dyslipid` tinyint(1) NOT NULL,
  `FamHx_Diabetes` tinyint(1) NOT NULL,
  `FamHx_KidneyDis` tinyint(1) NOT NULL,
  `FamHx_Obesity` tinyint(1) NOT NULL,
  `FamHx_CHD` tinyint(1) NOT NULL,
  `FamHx_Stroke_TIA` tinyint(1) NOT NULL,
  `Diuret_rx` tinyint(1) NOT NULL,
  `Diuret_SideEffects` tinyint(1) NOT NULL,
  `Diuret_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  `Ace_rx` tinyint(1) NOT NULL,
  `Ace_SideEffects` tinyint(1) NOT NULL,
  `Ace_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  `Arecept_rx` tinyint(1) NOT NULL,
  `Arecept_SideEffects` tinyint(1) NOT NULL,
  `Arecept_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  `Beta_rx` tinyint(1) NOT NULL,
  `Beta_SideEffects` tinyint(1) NOT NULL,
  `Beta_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  `Calc_rx` tinyint(1) NOT NULL,
  `Calc_SideEffects` tinyint(1) NOT NULL,
  `Calc_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  `Anti_rx` tinyint(1) NOT NULL,
  `Anti_SideEffects` tinyint(1) NOT NULL,
  `Anti_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  `Statin_rx` tinyint(1) NOT NULL,
  `Statin_SideEffects` tinyint(1) NOT NULL,
  `Statin_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  `Lipid_rx` tinyint(1) NOT NULL,
  `Lipid_SideEffects` tinyint(1) NOT NULL,
  `Lipid_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  `Hypo_rx` tinyint(1) NOT NULL,
  `Hypo_SideEffects` tinyint(1) NOT NULL,
  `Hypo_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  `Insul_rx` tinyint(1) NOT NULL,
  `Insul_SideEffects` tinyint(1) NOT NULL,
  `Insul_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  `Often_miss` int(2) DEFAULT NULL,
  `Herbal` enum('yes','no','null') DEFAULT NULL,
  `TC_HDL_LabresultsDate` date DEFAULT NULL,
  `LDL_LabresultsDate` date DEFAULT NULL,
  `HDL_LabresultsDate` date DEFAULT NULL,
  `A1C_LabresultsDate` date DEFAULT NULL,
  `Locked` tinyint(1) DEFAULT NULL,
  `depression` tinyint(1) DEFAULT NULL,
  `famHx_depression` tinyint(1) DEFAULT NULL,
  `assessActivity` int(3) DEFAULT NULL,
  `assessSmoking` int(3) DEFAULT NULL,
  `assessAlcohol` int(3) DEFAULT NULL,
  `nextVisitInMonths` int(3) DEFAULT NULL,
  `nextVisitInWeeks` int(3) DEFAULT NULL,
  `monitor` tinyint(1) DEFAULT NULL,
  `egfrDate` date DEFAULT NULL,
  `egfr` int(3) DEFAULT NULL,
  `acr` double(5,1) DEFAULT NULL,
  `lastBaseLineRecord` tinyint(1) NOT NULL,
  `A1C` double(3,3) DEFAULT NULL,
  `fbs` double(3,1) DEFAULT NULL,
  `ASA_rx` tinyint(1) NOT NULL,
  `ASA_SideEffects` tinyint(1) NOT NULL,
  `ASA_RxDecToday` enum('Same','Increase','Decrease','Stop','Start','InClassSwitch','null') DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formchf`
--

DROP TABLE IF EXISTS `formchf`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formchf` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `pName` varchar(60) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `birthDate` varchar(15) DEFAULT NULL,
  `SHFDx` tinyint(1) DEFAULT NULL,
  `PSFDx` tinyint(1) DEFAULT NULL,
  `dateFlu` date DEFAULT NULL,
  `datePneumo` date DEFAULT NULL,
  `dateEcho` date DEFAULT NULL,
  `dateCXR` date DEFAULT NULL,
  `CXRedema` tinyint(1) DEFAULT NULL,
  `CXRcardiomegaly` tinyint(1) DEFAULT NULL,
  `CXReffusion` tinyint(1) DEFAULT NULL,
  `dateEKG` date DEFAULT NULL,
  `CBC` tinyint(1) DEFAULT NULL,
  `lytes` tinyint(1) DEFAULT NULL,
  `creat` tinyint(1) DEFAULT NULL,
  `ua` tinyint(1) DEFAULT NULL,
  `RBS` tinyint(1) DEFAULT NULL,
  `lipids` tinyint(1) DEFAULT NULL,
  `LFT` tinyint(1) DEFAULT NULL,
  `TSH` tinyint(1) DEFAULT NULL,
  `date1` date DEFAULT NULL,
  `date2` date DEFAULT NULL,
  `date3` date DEFAULT NULL,
  `weight1` varchar(5) DEFAULT NULL,
  `weight2` varchar(5) DEFAULT NULL,
  `weight3` varchar(5) DEFAULT NULL,
  `fatigue1` tinyint(1) DEFAULT NULL,
  `dizzy1` tinyint(1) DEFAULT NULL,
  `SOBOE1` tinyint(1) DEFAULT NULL,
  `SOBresting1` tinyint(1) DEFAULT NULL,
  `orthopnea1` tinyint(1) DEFAULT NULL,
  `PND1` tinyint(1) DEFAULT NULL,
  `fatigue2` tinyint(1) DEFAULT NULL,
  `dizzy2` tinyint(1) DEFAULT NULL,
  `SOBOE2` tinyint(1) DEFAULT NULL,
  `SOBresting2` tinyint(1) DEFAULT NULL,
  `orthopnea2` tinyint(1) DEFAULT NULL,
  `PND2` tinyint(1) DEFAULT NULL,
  `fatigue3` tinyint(1) DEFAULT NULL,
  `dizzy3` tinyint(1) DEFAULT NULL,
  `SOBOE3` tinyint(1) DEFAULT NULL,
  `SOBresting3` tinyint(1) DEFAULT NULL,
  `orthopnea3` tinyint(1) DEFAULT NULL,
  `PND3` tinyint(1) DEFAULT NULL,
  `NYHAI1` tinyint(1) DEFAULT NULL,
  `NYHAII1` tinyint(1) DEFAULT NULL,
  `NYHAIII1` tinyint(1) DEFAULT NULL,
  `NYHAIV1` tinyint(1) DEFAULT NULL,
  `NYHAI2` tinyint(1) DEFAULT NULL,
  `NYHAII2` tinyint(1) DEFAULT NULL,
  `NYHAIII2` tinyint(1) DEFAULT NULL,
  `NYHAIV2` tinyint(1) DEFAULT NULL,
  `NYHAI3` tinyint(1) DEFAULT NULL,
  `NYHAII3` tinyint(1) DEFAULT NULL,
  `NYHAIII3` tinyint(1) DEFAULT NULL,
  `NYHAIV3` tinyint(1) DEFAULT NULL,
  `BP1` varchar(8) DEFAULT NULL,
  `BP2` varchar(8) DEFAULT NULL,
  `BP3` varchar(8) DEFAULT NULL,
  `JVPyes1` tinyint(1) DEFAULT NULL,
  `JVPno1` tinyint(1) DEFAULT NULL,
  `JVPyes2` tinyint(1) DEFAULT NULL,
  `JVPno2` tinyint(1) DEFAULT NULL,
  `JVPyes3` tinyint(1) DEFAULT NULL,
  `JVPno3` tinyint(1) DEFAULT NULL,
  `edemayes1` tinyint(1) DEFAULT NULL,
  `edemano1` tinyint(1) DEFAULT NULL,
  `edema1` varchar(30) DEFAULT NULL,
  `edemayes2` tinyint(1) DEFAULT NULL,
  `edemano2` tinyint(1) DEFAULT NULL,
  `edema2` varchar(30) DEFAULT NULL,
  `edemayes3` tinyint(1) DEFAULT NULL,
  `edemano3` tinyint(1) DEFAULT NULL,
  `edema3` varchar(30) DEFAULT NULL,
  `cracklesyes1` tinyint(1) DEFAULT NULL,
  `cracklesno1` tinyint(1) DEFAULT NULL,
  `crackles1` varchar(30) DEFAULT NULL,
  `cracklesyes2` tinyint(1) DEFAULT NULL,
  `cracklesno2` tinyint(1) DEFAULT NULL,
  `crackles2` varchar(30) DEFAULT NULL,
  `cracklesyes3` tinyint(1) DEFAULT NULL,
  `cracklesno3` tinyint(1) DEFAULT NULL,
  `crackles3` varchar(30) DEFAULT NULL,
  `PI1` varchar(60) DEFAULT NULL,
  `PI2` varchar(60) DEFAULT NULL,
  `PI3` varchar(60) DEFAULT NULL,
  `Na1` varchar(10) DEFAULT NULL,
  `Na2` varchar(10) DEFAULT NULL,
  `Na3` varchar(10) DEFAULT NULL,
  `K1` varchar(4) DEFAULT NULL,
  `K2` varchar(4) DEFAULT NULL,
  `K3` varchar(4) DEFAULT NULL,
  `creat1` varchar(4) DEFAULT NULL,
  `creat2` varchar(4) DEFAULT NULL,
  `creat3` varchar(4) DEFAULT NULL,
  `eGFR1` varchar(4) DEFAULT NULL,
  `eGFR2` varchar(4) DEFAULT NULL,
  `eGFR3` varchar(4) DEFAULT NULL,
  `ervisits1` varchar(20) DEFAULT NULL,
  `ervisits2` varchar(20) DEFAULT NULL,
  `ervisits3` varchar(20) DEFAULT NULL,
  `compliance1` tinyint(1) DEFAULT NULL,
  `fluids1` tinyint(1) DEFAULT NULL,
  `weights1` tinyint(1) DEFAULT NULL,
  `exercise1` tinyint(1) DEFAULT NULL,
  `compliance2` tinyint(1) DEFAULT NULL,
  `fluids2` tinyint(1) DEFAULT NULL,
  `weights2` tinyint(1) DEFAULT NULL,
  `exercise2` tinyint(1) DEFAULT NULL,
  `compliance3` tinyint(1) DEFAULT NULL,
  `fluids3` tinyint(1) DEFAULT NULL,
  `weights3` tinyint(1) DEFAULT NULL,
  `exercise3` tinyint(1) DEFAULT NULL,
  `discussbp1` tinyint(1) DEFAULT NULL,
  `discussdm1` tinyint(1) DEFAULT NULL,
  `discusslipids1` tinyint(1) DEFAULT NULL,
  `discusssmoking1` tinyint(1) DEFAULT NULL,
  `discussweight1` tinyint(1) DEFAULT NULL,
  `discussbp2` tinyint(1) DEFAULT NULL,
  `discussdm2` tinyint(1) DEFAULT NULL,
  `discusslipids2` tinyint(1) DEFAULT NULL,
  `discusssmoking2` tinyint(1) DEFAULT NULL,
  `discussweight2` tinyint(1) DEFAULT NULL,
  `discussbp3` tinyint(1) DEFAULT NULL,
  `discussdm3` tinyint(1) DEFAULT NULL,
  `discusslipids3` tinyint(1) DEFAULT NULL,
  `discusssmoking3` tinyint(1) DEFAULT NULL,
  `discussweight3` tinyint(1) DEFAULT NULL,
  `goal1` varchar(60) DEFAULT NULL,
  `goal2` varchar(60) DEFAULT NULL,
  `goal3` varchar(60) DEFAULT NULL,
  `challange1` varchar(60) DEFAULT NULL,
  `challange2` varchar(60) DEFAULT NULL,
  `challange3` varchar(60) DEFAULT NULL,
  `ACEintolerant` tinyint(1) DEFAULT NULL,
  `ACEcontraindicated` tinyint(1) DEFAULT NULL,
  `ACE1` varchar(40) DEFAULT NULL,
  `ACEtargetY1` tinyint(1) DEFAULT NULL,
  `ACEtargetN1` tinyint(1) DEFAULT NULL,
  `ACE2` varchar(40) DEFAULT NULL,
  `ACEtargetY2` tinyint(1) DEFAULT NULL,
  `ACEtargetN2` tinyint(1) DEFAULT NULL,
  `ACE3` varchar(40) DEFAULT NULL,
  `ACEtargetY3` tinyint(1) DEFAULT NULL,
  `ACEtargetN3` tinyint(1) DEFAULT NULL,
  `bbintolerant` tinyint(1) DEFAULT NULL,
  `bbcontraindicated` tinyint(1) DEFAULT NULL,
  `bb1` varchar(40) DEFAULT NULL,
  `bbtargetY1` tinyint(1) DEFAULT NULL,
  `bbtargetN1` tinyint(1) DEFAULT NULL,
  `bb2` varchar(40) DEFAULT NULL,
  `bbtargetY2` tinyint(1) DEFAULT NULL,
  `bbtargetN2` tinyint(1) DEFAULT NULL,
  `bb3` varchar(40) DEFAULT NULL,
  `bbtargetY3` tinyint(1) DEFAULT NULL,
  `bbtargetN3` tinyint(1) DEFAULT NULL,
  `ARB1` varchar(40) DEFAULT NULL,
  `ARBtargetY1` tinyint(1) DEFAULT NULL,
  `ARBtargetN1` tinyint(1) DEFAULT NULL,
  `ARB2` varchar(40) DEFAULT NULL,
  `ARBtargetY2` tinyint(1) DEFAULT NULL,
  `ARBtargetN2` tinyint(1) DEFAULT NULL,
  `ARB3` varchar(40) DEFAULT NULL,
  `ARBtargetY3` tinyint(1) DEFAULT NULL,
  `ARBtargetN3` tinyint(1) DEFAULT NULL,
  `loop1` varchar(40) DEFAULT NULL,
  `loop2` varchar(40) DEFAULT NULL,
  `loop3` varchar(40) DEFAULT NULL,
  `spironolactone1` varchar(10) DEFAULT NULL,
  `spironolactone2` varchar(10) DEFAULT NULL,
  `spironolactone3` varchar(10) DEFAULT NULL,
  `digoxin1` varchar(10) DEFAULT NULL,
  `digoxin2` varchar(10) DEFAULT NULL,
  `digoxin3` varchar(10) DEFAULT NULL,
  `ASA1` varchar(20) DEFAULT NULL,
  `ASA2` varchar(20) DEFAULT NULL,
  `ASA3` varchar(20) DEFAULT NULL,
  `anticoagulant1` varchar(40) DEFAULT NULL,
  `anticoagulant2` varchar(40) DEFAULT NULL,
  `anticoagulant3` varchar(40) DEFAULT NULL,
  `sig1` varchar(20) DEFAULT NULL,
  `sig2` varchar(20) DEFAULT NULL,
  `sig3` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formfollowup`
--

DROP TABLE IF EXISTS `formfollowup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formfollowup` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `cbox_assistWithHealthCard` char(1) DEFAULT NULL,
  `commentsOnEducation` varchar(255) DEFAULT NULL,
  `typeOfIncome` varchar(120) DEFAULT NULL,
  `historyOfJail` varchar(50) DEFAULT NULL,
  `dateEnteredSeaton` varchar(24) DEFAULT NULL,
  `commentsOnStreetDrugs` varchar(255) DEFAULT NULL,
  `whenMadeAppforOtherIncome` varchar(24) DEFAULT NULL,
  `cbox_ODSP` char(1) DEFAULT NULL,
  `cbox_fortYork` char(1) DEFAULT NULL,
  `cbox_oNeillHouse` char(1) DEFAULT NULL,
  `cbox_other` char(1) DEFAULT NULL,
  `cbox_haveOther1` char(1) DEFAULT NULL,
  `radio_drinkThese` varchar(24) DEFAULT NULL,
  `cbox_OAS` char(1) DEFAULT NULL,
  `whySponsorshipBreakdown` varchar(255) DEFAULT NULL,
  `radio_everBeenJailed` varchar(24) DEFAULT NULL,
  `doctor2Phone` varchar(24) DEFAULT NULL,
  `radio_caredForDepression` varchar(24) DEFAULT NULL,
  `radio_caredForOther` varchar(24) DEFAULT NULL,
  `cbox_getMoreMedication` char(1) DEFAULT NULL,
  `radio_drugUse` varchar(24) DEFAULT NULL,
  `radio_haveMentalProblem` varchar(24) DEFAULT NULL,
  `radio_requireReferralToESL` varchar(24) DEFAULT NULL,
  `radio_haveHealthCoverage` varchar(24) DEFAULT NULL,
  `day` char(2) DEFAULT NULL,
  `cbox_speakFrench` char(1) DEFAULT NULL,
  `commentsOnLegalIssues` varchar(255) DEFAULT NULL,
  `radio_howMuchDrink` varchar(24) DEFAULT NULL,
  `radio_needAssistInLegal` varchar(24) DEFAULT NULL,
  `commentsOnHousing` varchar(255) DEFAULT NULL,
  `cbox_downsviewDells` char(1) DEFAULT NULL,
  `cbox_haveUniversity` char(1) DEFAULT NULL,
  `publicTrusteeInfo` varchar(255) DEFAULT NULL,
  `cbox_longTermProgram` char(1) DEFAULT NULL,
  `dateAssessment` varchar(24) DEFAULT NULL,
  `cbox_assistWithSINCard` char(1) DEFAULT NULL,
  `drinksPerDay` char(3) DEFAULT NULL,
  `speakOther` varchar(50) DEFAULT NULL,
  `cbox_rememberToTakeMedication` char(1) DEFAULT NULL,
  `dateLastContact3` varchar(24) DEFAULT NULL,
  `usualOccupation` varchar(70) DEFAULT NULL,
  `radio_wantAppmt` varchar(24) DEFAULT NULL,
  `radio_hasIDInFile` varchar(24) DEFAULT NULL,
  `drinksPerMonth` varchar(5) DEFAULT NULL,
  `sponsorName` varchar(50) DEFAULT NULL,
  `cbox_pamphletIssued` char(1) DEFAULT NULL,
  `dateLastContact1` varchar(24) DEFAULT NULL,
  `cbox_OW` char(1) DEFAULT NULL,
  `assessCompleteTime` varchar(50) DEFAULT NULL,
  `cbox_birchmountResidence` char(1) DEFAULT NULL,
  `contact4Name` varchar(50) DEFAULT NULL,
  `clientLastAddressPayRent` varchar(255) DEFAULT NULL,
  `dateLastContact2` varchar(24) DEFAULT NULL,
  `contact2Name` varchar(50) DEFAULT NULL,
  `radio_currentlyEmployed` varchar(24) DEFAULT NULL,
  `commentsOnFinance` varchar(255) DEFAULT NULL,
  `cbox_haveODSP` char(1) DEFAULT NULL,
  `agency3Name` varchar(70) DEFAULT NULL,
  `amtOwing` varchar(16) DEFAULT NULL,
  `cbox_rotaryClub` char(1) DEFAULT NULL,
  `clientSurname` varchar(50) DEFAULT NULL,
  `completedBy1` varchar(50) DEFAULT NULL,
  `commentsOnEmployment` varchar(255) DEFAULT NULL,
  `radio_entitledToOtherIncome` varchar(24) DEFAULT NULL,
  `dateLastContact4` varchar(24) DEFAULT NULL,
  `whereBeforeSeaton` varchar(255) DEFAULT NULL,
  `doctor2NameAddr` varchar(255) DEFAULT NULL,
  `radio_sponsorshipBreakdown` varchar(24) DEFAULT NULL,
  `cbox_assistWithBirthCert` char(1) DEFAULT NULL,
  `howHearAboutSeaton` varchar(255) DEFAULT NULL,
  `howMuchYouReceive` varchar(12) DEFAULT NULL,
  `everMadeAppforOtherIncome` varchar(120) DEFAULT NULL,
  `contact4Phone` varchar(24) DEFAULT NULL,
  `assistProvided1` varchar(120) DEFAULT NULL,
  `cbox_employment` char(1) DEFAULT NULL,
  `yourCanadianStatus` varchar(50) DEFAULT NULL,
  `radio_everMadeAppforOtherIncome` varchar(24) DEFAULT NULL,
  `cbox_haveSchizophrenia` char(1) DEFAULT NULL,
  `commentsOnID` varchar(255) DEFAULT NULL,
  `cbox_haveOther2` char(1) DEFAULT NULL,
  `radio_needAssistWithMedication` varchar(24) DEFAULT NULL,
  `assessStartTime` varchar(24) DEFAULT NULL,
  `cbox_haveDepression` char(1) DEFAULT NULL,
  `cbox_assistWithImmigrant` char(1) DEFAULT NULL,
  `clientLastAddress` varchar(255) DEFAULT NULL,
  `mainSourceOfIncome` varchar(70) DEFAULT NULL,
  `cbox_assistWithNone` char(1) DEFAULT NULL,
  `dateExitedSeaton` varchar(24) DEFAULT NULL,
  `cbox_haveOHIP` char(1) DEFAULT NULL,
  `housingInterested` varchar(70) DEFAULT NULL,
  `assistWithOther` varchar(50) DEFAULT NULL,
  `needHelpWithImmigration` varchar(50) DEFAULT NULL,
  `cbox_speakEnglish` char(1) DEFAULT NULL,
  `cbox_assistWithOther` char(1) DEFAULT NULL,
  `contact2Phone` varchar(24) DEFAULT NULL,
  `cbox_haveCollege` char(1) DEFAULT NULL,
  `dateLivedThere` varchar(24) DEFAULT NULL,
  `radio_involvedOtherAgencies` varchar(24) DEFAULT NULL,
  `assistProvided2` varchar(120) DEFAULT NULL,
  `radio_wantHelpQuitDrug` varchar(24) DEFAULT NULL,
  `contact1Phone` varchar(24) DEFAULT NULL,
  `radio_need60DaysSeatonServices` varchar(24) DEFAULT NULL,
  `completedBy2` varchar(50) DEFAULT NULL,
  `radio_interestedInTraining` varchar(24) DEFAULT NULL,
  `contact3Phone` varchar(24) DEFAULT NULL,
  `followupAppmts` varchar(120) DEFAULT NULL,
  `cbox_haveAnxiety` char(1) DEFAULT NULL,
  `radio_interestBackToSchool` varchar(24) DEFAULT NULL,
  `cbox_assistWithCitizenCard` char(1) DEFAULT NULL,
  `cbox_haveHighSchool` char(1) DEFAULT NULL,
  `cbox_haveOther3` char(1) DEFAULT NULL,
  `radio_citizen` varchar(24) DEFAULT NULL,
  `clientFirstName` varchar(50) DEFAULT NULL,
  `month` char(2) DEFAULT NULL,
  `cbox_CPP` char(1) DEFAULT NULL,
  `radio_seenDoctorRegAlcohol` varchar(24) DEFAULT NULL,
  `radio_wantHelpQuit` varchar(24) DEFAULT NULL,
  `radio_owedRent` varchar(24) DEFAULT NULL,
  `whereOweRent` varchar(255) DEFAULT NULL,
  `howLongUnemployed` char(3) DEFAULT NULL,
  `cbox_haveODB` char(1) DEFAULT NULL,
  `howLongEmployed` char(3) DEFAULT NULL,
  `cbox_annexHarm` char(1) DEFAULT NULL,
  `formEdited` datetime DEFAULT NULL,
  `dateLastDoctor2Contact` varchar(24) DEFAULT NULL,
  `yearsOfEducation` varchar(4) DEFAULT NULL,
  `radio_yourCanadianStatus` varchar(24) DEFAULT NULL,
  `radio_drugUseFrequency` varchar(24) DEFAULT NULL,
  `provider_no` bigint(20) DEFAULT NULL,
  `doctor1Phone` varchar(24) DEFAULT NULL,
  `agency1Name` varchar(70) DEFAULT NULL,
  `cbox_hostel` char(1) DEFAULT NULL,
  `commentsOnAlcohol` varchar(255) DEFAULT NULL,
  `radio_mentalIllness` varchar(24) DEFAULT NULL,
  `cbox_speakSpanish` char(1) DEFAULT NULL,
  `drinksPerWeek` varchar(4) DEFAULT NULL,
  `commentsOnImmigration` varchar(255) DEFAULT NULL,
  `radio_behaviorProblem` varchar(24) DEFAULT NULL,
  `agency2Name` varchar(70) DEFAULT NULL,
  `commentsOnNeedHelp` varchar(255) DEFAULT NULL,
  `radio_havePublicTrustee` varchar(24) DEFAULT NULL,
  `cbox_speakOther` char(1) DEFAULT NULL,
  `cbox_takePrescribedMedication` char(1) DEFAULT NULL,
  `needAssistInLegal` varchar(255) DEFAULT NULL,
  `radio_caredForSchizophrenia` varchar(24) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `demographic_no` bigint(20) NOT NULL DEFAULT '0',
  `radio_doYouDrink` varchar(24) DEFAULT NULL,
  `radio_drinking` varchar(24) DEFAULT NULL,
  `radio_healthProblem` varchar(24) DEFAULT NULL,
  `cbox_UI` char(1) DEFAULT NULL,
  `livedWithWhom` varchar(120) DEFAULT NULL,
  `assistProvided3` varchar(120) DEFAULT NULL,
  `cbox_haveManic` char(1) DEFAULT NULL,
  `contact1Name` varchar(50) DEFAULT NULL,
  `year` varchar(4) DEFAULT NULL,
  `radio_caredForManic` varchar(24) DEFAULT NULL,
  `cbox_assistWithRefugee` char(1) DEFAULT NULL,
  `radio_livedInSubsidized` varchar(24) DEFAULT NULL,
  `radio_useDrugs` varchar(24) DEFAULT NULL,
  `cbox_needHelpInOther` char(1) DEFAULT NULL,
  `assistProvided4` varchar(120) DEFAULT NULL,
  `doctor1NameAddr` varchar(255) DEFAULT NULL,
  `contact3Name` varchar(50) DEFAULT NULL,
  `haveOther` varchar(70) DEFAULT NULL,
  `cbox_storeMedication` char(1) DEFAULT NULL,
  `agency4Name` varchar(70) DEFAULT NULL,
  `radio_caredForAnxiety` varchar(24) DEFAULT NULL,
  `dateLastDoctor1Contact` varchar(24) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formintakea`
--

DROP TABLE IF EXISTS `formintakea`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formintakea` (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT,
  `demographic_no` bigint(11) NOT NULL DEFAULT '0',
  `provider_no` bigint(11) DEFAULT '0',
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `assessDate` varchar(24) DEFAULT '',
  `assessStartTime` varchar(24) DEFAULT '',
  `enterSeatonDate` varchar(24) DEFAULT '',
  `cbox_newClient` char(1) DEFAULT '',
  `cbox_dateOfReadmission` char(1) DEFAULT '',
  `dateOfReadmission` varchar(24) DEFAULT '',
  `cbox_isStatementRead` char(1) DEFAULT '',
  `clientSurname` varchar(50) DEFAULT '',
  `clientFirstName` varchar(50) DEFAULT '',
  `month` char(2) DEFAULT '',
  `day` char(2) DEFAULT '',
  `year` varchar(4) DEFAULT '',
  `cbox_speakEnglish` char(1) DEFAULT '',
  `cbox_speakFrench` char(1) DEFAULT '',
  `cbox_speakOther` char(1) DEFAULT '',
  `speakOther` varchar(36) DEFAULT '',
  `reasonToSeaton` varchar(255) DEFAULT '',
  `everAtSeatonBefore` varchar(24) DEFAULT NULL,
  `datesAtSeaton` varchar(70) DEFAULT '',
  `cbox_assistInHealth` char(1) DEFAULT '',
  `cbox_assistInIdentification` char(1) DEFAULT '',
  `cbox_assistInAddictions` char(1) DEFAULT '',
  `cbox_assistInHousing` char(1) DEFAULT '',
  `cbox_assistInEducation` char(1) DEFAULT '',
  `cbox_assistInEmployment` char(1) DEFAULT '',
  `cbox_assistInFinance` char(1) DEFAULT '',
  `cbox_assistInLegal` char(1) DEFAULT '',
  `cbox_assistInImmigration` char(1) DEFAULT '',
  `hasWhatID` varchar(120) DEFAULT '',
  `cbox_noID` char(1) DEFAULT '',
  `cbox_sinCard` char(1) DEFAULT '',
  `sinNum` varchar(24) DEFAULT '',
  `cbox_healthCard` char(1) DEFAULT '',
  `healthCardNum` varchar(24) DEFAULT '',
  `healthCardVer` char(2) DEFAULT '',
  `cbox_birthCertificate` char(1) DEFAULT '',
  `birthCertificateNum` varchar(24) DEFAULT '',
  `cbox_citzenshipCard` char(1) DEFAULT '',
  `citzenshipCardNum` varchar(24) DEFAULT '',
  `cbox_immigrant` char(1) DEFAULT '',
  `immigrantNum` varchar(24) DEFAULT '',
  `cbox_refugee` char(1) DEFAULT '',
  `refugeeNum` varchar(24) DEFAULT '',
  `cbox_otherID` char(1) DEFAULT '',
  `otherIdentification` varchar(70) DEFAULT '',
  `cbox_idFiled` char(1) DEFAULT '',
  `cbox_idNone` char(1) DEFAULT '',
  `commentsOnID` varchar(255) DEFAULT '',
  `cbox_OW` char(1) DEFAULT '',
  `cbox_ODSP` char(1) DEFAULT '',
  `cbox_WSIB` char(1) DEFAULT '',
  `cbox_Employment` char(1) DEFAULT '',
  `cbox_EI` char(1) DEFAULT '',
  `cbox_OAS` char(1) DEFAULT '',
  `cbox_CPP` char(1) DEFAULT '',
  `cbox_OtherIncome` char(1) DEFAULT '',
  `radio_onlineCheck` varchar(36) DEFAULT '',
  `radio_active` varchar(36) DEFAULT '',
  `cbox_noRecord` char(1) DEFAULT '',
  `lastIssueDate` varchar(24) DEFAULT '',
  `office` varchar(50) DEFAULT '',
  `workerNum` varchar(36) DEFAULT '',
  `amtReceived` varchar(9) DEFAULT '',
  `radio_hasDoctor` varchar(36) DEFAULT '',
  `doctorName` varchar(50) DEFAULT '',
  `doctorName2` varchar(50) DEFAULT '',
  `doctorPhone` varchar(24) DEFAULT '',
  `doctorPhoneExt` varchar(8) DEFAULT '',
  `doctorAddress` varchar(120) DEFAULT '',
  `radio_seeDoctor` varchar(36) DEFAULT '',
  `radio_healthIssue` varchar(36) DEFAULT '',
  `healthIssueDetails` varchar(255) DEFAULT '',
  `cbox_hasDiabetes` char(1) DEFAULT '',
  `cbox_insulin` char(1) DEFAULT '',
  `cbox_epilepsy` char(1) DEFAULT '',
  `cbox_bleeding` char(1) DEFAULT '',
  `cbox_hearingImpair` char(1) DEFAULT '',
  `cbox_visualImpair` char(1) DEFAULT '',
  `cbox_mobilityImpair` char(1) DEFAULT '',
  `mobilityImpair` varchar(255) DEFAULT '',
  `radio_otherHealthConcern` varchar(36) DEFAULT '',
  `otherHealthConerns` varchar(255) DEFAULT '',
  `radio_takeMedication` varchar(36) DEFAULT '',
  `namesOfMedication` varchar(120) DEFAULT '',
  `radio_helpObtainMedication` varchar(36) DEFAULT '',
  `helpObtainMedication` varchar(255) DEFAULT '',
  `radio_allergicToMedication` varchar(36) DEFAULT '',
  `allergicToMedicationName` varchar(255) DEFAULT '',
  `reactionToMedication` varchar(255) DEFAULT '',
  `radio_mentalHealthConcerns` varchar(36) DEFAULT '',
  `mentalHealthConcerns` varchar(255) DEFAULT '',
  `cbox_isStatement6Read` char(1) DEFAULT '',
  `frequencyOfSeeingDoctor` varchar(8) DEFAULT '',
  `cbox_visitWalkInClinic` char(1) DEFAULT '',
  `cbox_visitHealthCenter` char(1) DEFAULT '',
  `cbox_visitEmergencyRoom` char(1) DEFAULT '',
  `cbox_visitOthers` char(1) DEFAULT '',
  `otherSpecify` varchar(120) DEFAULT '',
  `cbox_visitHealthOffice` char(1) DEFAULT '',
  `radio_seeSameDoctor` varchar(36) DEFAULT '',
  `frequencyOfSeeingEmergencyRoomDoctor` varchar(8) DEFAULT '',
  `radio_didNotReceiveHealthCare` varchar(36) DEFAULT '',
  `cbox_treatPhysicalHealth` char(1) DEFAULT '',
  `cbox_treatMentalHealth` char(1) DEFAULT '',
  `cbox_regularCheckup` char(1) DEFAULT '',
  `cbox_treatOtherReasons` char(1) DEFAULT '',
  `treatOtherReasons` varchar(255) DEFAULT '',
  `cbox_treatInjury` char(1) DEFAULT '',
  `cbox_goToWalkInClinic` char(1) DEFAULT '',
  `cbox_goToHealthCenter` char(1) DEFAULT '',
  `cbox_goToEmergencyRoom` char(1) DEFAULT '',
  `cbox_goToOthers` char(1) DEFAULT '',
  `goToOthers` varchar(255) DEFAULT '',
  `cbox_HealthOffice` char(1) DEFAULT '',
  `radio_appmtSeeDoctorIn3Mths` varchar(36) DEFAULT '',
  `radio_needRegularDoctor` varchar(36) DEFAULT '',
  `radio_objectToRegularDoctorIn4Wks` varchar(36) DEFAULT '',
  `radio_rateOverallHealth` varchar(36) DEFAULT '',
  `radio_speakToResearcher` varchar(36) DEFAULT '',
  `contactName` varchar(70) DEFAULT '',
  `contactPhone` varchar(24) DEFAULT '',
  `contactAddress` varchar(255) DEFAULT '',
  `contactRelationship` varchar(120) DEFAULT '',
  `radio_hasMentalIllness` varchar(36) DEFAULT '',
  `radio_hasDrinkingProblem` varchar(36) DEFAULT '',
  `radio_hasDrugProblem` varchar(36) DEFAULT '',
  `radio_hasHealthProblem` varchar(36) DEFAULT '',
  `radio_hasBehaviorProblem` varchar(36) DEFAULT '',
  `radio_needSeatonService` varchar(36) DEFAULT '',
  `radio_seatonTour` varchar(36) DEFAULT '',
  `seatonNotToured` varchar(255) DEFAULT '',
  `radio_pamphletIssued` varchar(36) DEFAULT '',
  `pamphletNotIssued` varchar(255) DEFAULT '',
  `summary` varchar(255) DEFAULT '',
  `completedBy` varchar(120) DEFAULT '',
  `assessCompleteTime` varchar(36) DEFAULT '',
  `cbox_pamphletIssued` char(1) DEFAULT '',
  `cbox_hostel` char(1) DEFAULT '',
  `cbox_hostel_fusion_care` char(1) DEFAULT '',
  `cbox_rotaryClub` char(1) DEFAULT '',
  `cbox_annexHarm` char(1) DEFAULT '',
  `cbox_longTermProgram` char(1) DEFAULT '',
  `cbox_birchmountResidence` char(1) DEFAULT '',
  `cbox_oNeillHouse` char(1) DEFAULT '',
  `cbox_fortYork` char(1) DEFAULT '',
  `cbox_downsviewDells` char(1) DEFAULT '',
  `cbox_sharing` char(1) DEFAULT '',
  `radio_sex` varchar(36) DEFAULT NULL,
  `effDate` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formintakeb`
--

DROP TABLE IF EXISTS `formintakeb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formintakeb` (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT,
  `demographic_no` bigint(11) NOT NULL DEFAULT '0',
  `provider_no` bigint(11) DEFAULT '0',
  `formCreated` date DEFAULT '0001-01-01',
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dateAssessment` varchar(24) DEFAULT '',
  `assessStartTime` varchar(24) DEFAULT '',
  `dateEnteredSeaton` varchar(24) DEFAULT '',
  `dateExitedSeaton` varchar(24) DEFAULT '',
  `clientSurname` varchar(50) DEFAULT '',
  `clientFirstName` varchar(50) DEFAULT '',
  `month` char(2) DEFAULT '',
  `day` char(2) DEFAULT '',
  `year` varchar(4) DEFAULT '',
  `cbox_speakEnglish` char(1) DEFAULT '',
  `cbox_speakFrench` char(1) DEFAULT '',
  `cbox_speakSpanish` char(1) DEFAULT '',
  `cbox_speakOther` char(1) DEFAULT '',
  `speakOther` varchar(50) DEFAULT '',
  `howHearAboutSeaton` varchar(255) DEFAULT '',
  `whereBeforeSeaton` varchar(255) DEFAULT '',
  `radio_hasIDInFile` varchar(24) DEFAULT '',
  `cbox_assistWithSINCard` char(1) DEFAULT '',
  `cbox_assistWithImmigrant` char(1) DEFAULT '',
  `cbox_assistWithHealthCard` char(1) DEFAULT '',
  `cbox_assistWithRefugee` char(1) DEFAULT '',
  `cbox_assistWithBirthCert` char(1) DEFAULT '',
  `cbox_assistWithNone` char(1) DEFAULT '',
  `cbox_assistWithCitizenCard` char(1) DEFAULT '',
  `cbox_assistWithOther` char(1) DEFAULT '',
  `assistWithOther` varchar(50) DEFAULT '',
  `commentsOnID` varchar(255) DEFAULT '',
  `radio_haveHealthCoverage` varchar(24) DEFAULT '',
  `cbox_haveOHIP` char(1) DEFAULT '',
  `cbox_haveODSP` char(1) DEFAULT '',
  `cbox_haveODB` char(1) DEFAULT '',
  `cbox_haveOther1` char(1) DEFAULT '',
  `haveOther` varchar(70) DEFAULT '',
  `radio_haveMentalProblem` varchar(24) DEFAULT '',
  `cbox_haveSchizophrenia` char(1) DEFAULT '',
  `radio_caredForSchizophrenia` varchar(24) DEFAULT '',
  `cbox_haveManic` char(1) DEFAULT '',
  `radio_caredForManic` varchar(24) DEFAULT '',
  `cbox_haveDepression` char(1) DEFAULT '',
  `radio_caredForDepression` varchar(24) DEFAULT '',
  `cbox_haveAnxiety` char(1) DEFAULT '',
  `radio_caredForAnxiety` varchar(24) DEFAULT '',
  `cbox_haveOther2` char(1) DEFAULT '',
  `radio_caredForOther` varchar(24) DEFAULT '',
  `doctor1NameAddr` varchar(255) DEFAULT '',
  `doctor1Phone` varchar(24) DEFAULT '',
  `dateLastDoctor1Contact` varchar(24) DEFAULT '',
  `doctor2NameAddr` varchar(255) DEFAULT '',
  `doctor2Phone` varchar(24) DEFAULT '',
  `dateLastDoctor2Contact` varchar(24) DEFAULT '',
  `radio_needAssistWithMedication` varchar(24) DEFAULT '',
  `cbox_rememberToTakeMedication` char(1) DEFAULT '',
  `cbox_getMoreMedication` char(1) DEFAULT '',
  `cbox_storeMedication` char(1) DEFAULT '',
  `cbox_needHelpInOther` char(1) DEFAULT '',
  `cbox_takePrescribedMedication` char(1) DEFAULT '',
  `commentsOnNeedHelp` varchar(255) DEFAULT '',
  `radio_doYouDrink` varchar(24) DEFAULT '',
  `drinksPerDay` char(3) DEFAULT '',
  `drinksPerWeek` varchar(4) DEFAULT '',
  `drinksPerMonth` varchar(5) DEFAULT '',
  `radio_howMuchDrink` varchar(24) DEFAULT '',
  `radio_drinkThese` varchar(24) DEFAULT '',
  `radio_seenDoctorRegAlcohol` varchar(24) DEFAULT '',
  `radio_wantHelpQuit` varchar(24) DEFAULT '',
  `commentsOnAlcohol` varchar(255) DEFAULT '',
  `radio_useDrugs` varchar(24) DEFAULT '',
  `radio_drugUseFrequency` varchar(24) DEFAULT '',
  `radio_wantHelpQuitDrug` varchar(24) DEFAULT '',
  `commentsOnStreetDrugs` varchar(255) DEFAULT '',
  `housingInterested` varchar(70) DEFAULT '',
  `radio_wantAppmt` varchar(24) DEFAULT '',
  `clientLastAddress` varchar(255) DEFAULT '',
  `clientLastAddressPayRent` varchar(255) DEFAULT '',
  `dateLivedThere` varchar(24) DEFAULT '',
  `livedWithWhom` varchar(120) DEFAULT '',
  `radio_livedInSubsidized` varchar(24) DEFAULT '',
  `radio_owedRent` varchar(24) DEFAULT '',
  `whereOweRent` varchar(255) DEFAULT '',
  `amtOwing` varchar(16) DEFAULT '',
  `commentsOnHousing` varchar(255) DEFAULT '',
  `yearsOfEducation` varchar(4) DEFAULT '',
  `cbox_haveHighSchool` char(1) DEFAULT '',
  `cbox_haveCollege` char(1) DEFAULT '',
  `cbox_haveUniversity` char(1) DEFAULT '',
  `cbox_haveOther3` char(1) DEFAULT '',
  `radio_interestBackToSchool` varchar(24) DEFAULT '',
  `radio_requireReferralToESL` varchar(24) DEFAULT '',
  `commentsOnEducation` varchar(255) DEFAULT '',
  `radio_currentlyEmployed` varchar(24) DEFAULT '',
  `howLongEmployed` char(3) DEFAULT '',
  `howLongUnemployed` char(3) DEFAULT '',
  `usualOccupation` varchar(70) DEFAULT '',
  `radio_interestedInTraining` varchar(24) DEFAULT '',
  `commentsOnEmployment` varchar(255) DEFAULT '',
  `mainSourceOfIncome` varchar(70) DEFAULT '',
  `cbox_OW` char(1) DEFAULT '',
  `cbox_ODSP` char(1) DEFAULT '',
  `cbox_employment` char(1) DEFAULT '',
  `cbox_UI` char(1) DEFAULT '',
  `cbox_OAS` char(1) DEFAULT '',
  `cbox_CPP` char(1) DEFAULT '',
  `cbox_other` char(1) DEFAULT '',
  `howMuchYouReceive` varchar(12) DEFAULT '',
  `radio_havePublicTrustee` varchar(24) DEFAULT '',
  `publicTrusteeInfo` varchar(255) DEFAULT '',
  `radio_entitledToOtherIncome` varchar(24) DEFAULT '',
  `typeOfIncome` varchar(120) DEFAULT '',
  `radio_everMadeAppforOtherIncome` varchar(24) DEFAULT '',
  `everMadeAppforOtherIncome` varchar(120) DEFAULT '',
  `whenMadeAppforOtherIncome` varchar(24) DEFAULT '',
  `commentsOnFinance` varchar(255) DEFAULT '',
  `radio_everBeenJailed` varchar(24) DEFAULT '',
  `historyOfJail` varchar(50) DEFAULT '',
  `radio_needAssistInLegal` varchar(24) DEFAULT '',
  `needAssistInLegal` varchar(255) DEFAULT '',
  `commentsOnLegalIssues` varchar(255) DEFAULT '',
  `radio_citizen` varchar(24) DEFAULT '',
  `radio_yourCanadianStatus` varchar(24) DEFAULT '',
  `yourCanadianStatus` varchar(50) DEFAULT '',
  `radio_sponsorshipBreakdown` varchar(24) DEFAULT '',
  `whySponsorshipBreakdown` varchar(255) DEFAULT '',
  `sponsorName` varchar(50) DEFAULT '',
  `needHelpWithImmigration` varchar(50) DEFAULT '',
  `commentsOnImmigration` varchar(255) DEFAULT '',
  `radio_involvedOtherAgencies` varchar(24) DEFAULT '',
  `agency1Name` varchar(70) DEFAULT '',
  `contact1Name` varchar(50) DEFAULT '',
  `contact1Phone` varchar(24) DEFAULT '',
  `assistProvided1` varchar(120) DEFAULT '',
  `dateLastContact1` varchar(24) DEFAULT '',
  `agency2Name` varchar(70) DEFAULT '',
  `contact2Name` varchar(50) DEFAULT '',
  `contact2Phone` varchar(24) DEFAULT '',
  `assistProvided2` varchar(120) DEFAULT '',
  `dateLastContact2` varchar(24) DEFAULT '',
  `agency3Name` varchar(70) DEFAULT '',
  `contact3Name` varchar(50) DEFAULT '',
  `contact3Phone` varchar(24) DEFAULT '',
  `assistProvided3` varchar(120) DEFAULT '',
  `dateLastContact3` varchar(24) DEFAULT '',
  `agency4Name` varchar(70) DEFAULT '',
  `contact4Name` varchar(50) DEFAULT '',
  `contact4Phone` varchar(24) DEFAULT '',
  `assistProvided4` varchar(120) DEFAULT '',
  `dateLastContact4` varchar(24) DEFAULT '',
  `radio_mentalIllness` varchar(24) DEFAULT '',
  `radio_drinking` varchar(24) DEFAULT '',
  `radio_drugUse` varchar(24) DEFAULT '',
  `radio_healthProblem` varchar(24) DEFAULT '',
  `radio_behaviorProblem` varchar(24) DEFAULT '',
  `radio_need60DaysSeatonServices` varchar(24) DEFAULT '',
  `completedBy1` varchar(50) DEFAULT '',
  `completedBy2` varchar(50) DEFAULT '',
  `assessCompleteTime` varchar(50) DEFAULT '',
  `followupAppmts` varchar(120) DEFAULT '',
  `cbox_pamphletIssued` char(1) DEFAULT '',
  `cbox_hostel` char(1) DEFAULT '',
  `cbox_rotaryClub` char(1) DEFAULT '',
  `cbox_annexHarm` char(1) DEFAULT '',
  `cbox_longTermProgram` char(1) DEFAULT '',
  `cbox_birchmountResidence` char(1) DEFAULT '',
  `cbox_oNeillHouse` char(1) DEFAULT '',
  `cbox_fortYork` char(1) DEFAULT '',
  `cbox_downsviewDells` char(1) DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formintakec`
--

DROP TABLE IF EXISTS `formintakec`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formintakec` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `cboxReferralByPolice` char(2) DEFAULT NULL,
  `radioGender` varchar(16) DEFAULT NULL,
  `cboxSocialServiceIssueOther` char(2) DEFAULT NULL,
  `cboxBase2ndIncomeNone` char(2) DEFAULT NULL,
  `cboxCurrHasSIn` char(2) DEFAULT NULL,
  `cboxReferralByFredVictorCentreOther` char(2) DEFAULT NULL,
  `cboxReferralByDetentionCenter` char(2) DEFAULT NULL,
  `currDescriptionOfHousing` varchar(255) DEFAULT NULL,
  `cboxBaseUseHealthBus` char(2) DEFAULT NULL,
  `dateOfHospitalization` varchar(10) DEFAULT NULL,
  `cboxHousingIssue` char(2) DEFAULT NULL,
  `cboxBaseHasCommunity` char(2) DEFAULT NULL,
  `cboxBaseHasFriends` char(2) DEFAULT NULL,
  `cboxRelocationExit` char(2) DEFAULT NULL,
  `cbox2ndPersonalityDisorder` char(2) DEFAULT NULL,
  `cboxBase2ndIncomeSocialAssistance` char(2) DEFAULT NULL,
  `cbox2ndMedicalMentalDisorder` char(2) DEFAULT NULL,
  `cboxReferralByCriminalJusticeSystem` char(2) DEFAULT NULL,
  `cboxThreatIssue` char(2) DEFAULT NULL,
  `cboxSubstanceAnxietyDisorder` char(2) DEFAULT NULL,
  `referralComment` varchar(255) DEFAULT NULL,
  `cboxBase2ndIncomeEi` char(2) DEFAULT NULL,
  `cboxCurrHasSupportUnknown` char(2) DEFAULT NULL,
  `cboxReferralBySelf` char(2) DEFAULT NULL,
  `cboxPhysicalIssueOther` char(2) DEFAULT NULL,
  `cboxCurrLivingWithSpouse` char(2) DEFAULT NULL,
  `cboxReferralByOtherInstitution` char(2) DEFAULT NULL,
  `cboxPhysicalHospitalization` char(2) DEFAULT NULL,
  `currWhyClientDoNotAccessSocialServices` varchar(255) DEFAULT NULL,
  `cboxFinancialIssue` char(2) DEFAULT NULL,
  `cboxIsolationIssueOther` char(2) DEFAULT NULL,
  `cboxCurrLivingWithUnknown` char(2) DEFAULT NULL,
  `cbox2ndIncomeOther` char(2) DEFAULT NULL,
  `cboxCurrHasUnknown` char(2) DEFAULT NULL,
  `cboxReferralByPhysician` char(2) DEFAULT NULL,
  `cbox2ndDisassociativeDisorder` char(2) DEFAULT NULL,
  `cboxImmigrationIssueOther` char(2) DEFAULT NULL,
  `entryDate` varchar(10) DEFAULT NULL,
  `admissionDate` varchar(10) DEFAULT NULL,
  `cboxCurrHasCommunity` char(2) DEFAULT NULL,
  `cboxDailyActivityIssue` char(2) DEFAULT NULL,
  `cboxCurrLivingWithParents` char(2) DEFAULT NULL,
  `cboxIdentificationIssueOther` char(2) DEFAULT NULL,
  `radioBaseEmploymentStatus` varchar(16) DEFAULT NULL,
  `radioCanadianBorn` varchar(16) DEFAULT NULL,
  `cboxBaseLivingWithNonrelatives` char(2) DEFAULT NULL,
  `cboxCurrIncomeMgmentDoNotNeedTrustee` char(2) DEFAULT NULL,
  `cboxBase2ndIncomeFamily` char(2) DEFAULT NULL,
  `radioCurrEmploymentStatus` varchar(16) DEFAULT NULL,
  `cboxSuicideExit` char(2) DEFAULT NULL,
  `cboxReferralByStreetNurseOther` char(2) DEFAULT NULL,
  `dayOfBirth` char(2) DEFAULT NULL,
  `cboxDualDisorder` char(2) DEFAULT NULL,
  `cbox2ndIncomeODSp` char(2) DEFAULT NULL,
  `cboxPsychiatricHospitalization` char(2) DEFAULT NULL,
  `cbox2ndSomatoformDisorder` char(2) DEFAULT NULL,
  `cboxPreAdmission` char(2) DEFAULT NULL,
  `cboxReferralByStreetHealthReceptionOther` char(2) DEFAULT NULL,
  `cbox2ndAnxietyDisorder` char(2) DEFAULT NULL,
  `radioCurrParticipateInEduction` varchar(16) DEFAULT NULL,
  `cbox2ndChildhoodDisorder` char(2) DEFAULT NULL,
  `cboxCurrIncomeMgmentHasTrustee` char(2) DEFAULT NULL,
  `radioCountryOfOrigin` varchar(16) DEFAULT NULL,
  `cboxOtherChronicIllness` char(2) DEFAULT NULL,
  `cboxMOHLTCDisorder` char(2) DEFAULT NULL,
  `cboxPTSd` char(2) DEFAULT NULL,
  `cboxBase2ndIncomeDisabilityAssistance` char(2) DEFAULT NULL,
  `lengthOfHospitalization` varchar(25) DEFAULT NULL,
  `radioCurrPrimaryIncomeSource` varchar(16) DEFAULT NULL,
  `baseWhyClientDoNotAccessSocialServices` varchar(255) DEFAULT NULL,
  `cbox2ndIncomeInformalOther` char(2) DEFAULT NULL,
  `cbox2ndIncomeEi` char(2) DEFAULT NULL,
  `cbox2ndGenderIdentityDisorder` char(2) DEFAULT NULL,
  `cboxBaseDoNotAccessHealthCare` char(2) DEFAULT NULL,
  `currSocialServiceClientAccesses` varchar(255) DEFAULT NULL,
  `cbox2ndIncomeUnknown` char(2) DEFAULT NULL,
  `radioBaseHealthCareAccess` varchar(16) DEFAULT NULL,
  `cboxBase2ndIncomeODSp` char(2) DEFAULT NULL,
  `cboxCurrUseWalkinClinic` char(2) DEFAULT NULL,
  `cboxReferralByPsychiatrists` char(2) DEFAULT NULL,
  `cboxReferralByMentalOrg` char(2) DEFAULT NULL,
  `radioBasePrimaryResidenceType` varchar(16) DEFAULT NULL,
  `cbox2ndIncomeDisabilityAssistance` char(2) DEFAULT NULL,
  `cboxAddictionIssue` char(2) DEFAULT NULL,
  `cboxBase2ndIncomePanhandlingOther` char(2) DEFAULT NULL,
  `cboxCurrIncomeMgmentUnknown` char(2) DEFAULT NULL,
  `cboxLegalIssue` char(2) DEFAULT NULL,
  `radioResistTreatment` varchar(16) DEFAULT NULL,
  `cbox2ndSchizophrenia` char(2) DEFAULT NULL,
  `radioBaseSocialServiceAccess` varchar(16) DEFAULT NULL,
  `radioCurrSocialServiceAccess` varchar(16) DEFAULT NULL,
  `radioBaseResidenceStatus` varchar(16) DEFAULT NULL,
  `cbox2ndIncomeEmployment` char(2) DEFAULT NULL,
  `cbox2ndAnxietyDisorderFromSubstance` char(2) DEFAULT NULL,
  `radioCurrPrimaryResidenceType` varchar(16) DEFAULT NULL,
  `radioCurrPrimaryIncomeSourceOther` varchar(16) DEFAULT NULL,
  `cboxReferralByProbation` char(2) DEFAULT NULL,
  `radioCurrLegalStatus` varchar(16) DEFAULT NULL,
  `cboxProblemsWithPolice2` char(2) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `cbox2ndIncomeSocialAssistance` char(2) DEFAULT NULL,
  `cboxBaseUseHospitalEmergency` char(2) DEFAULT NULL,
  `cboxReferralByPublic` char(2) DEFAULT NULL,
  `cboxReferralByHospital` char(2) DEFAULT NULL,
  `cboxBaseLivingWithSpousePlus` char(2) DEFAULT NULL,
  `cboxWithdrawalExit` char(2) DEFAULT NULL,
  `cboxCurrLivingWithSelf` char(2) DEFAULT NULL,
  `cbox2ndCognitiveDisorder` char(2) DEFAULT NULL,
  `cboxBaseIncomeMgmentUnknown` char(2) DEFAULT NULL,
  `cboxBaseHasHealthCard` char(2) DEFAULT NULL,
  `radioCurrHighestEductionLevel` varchar(16) DEFAULT NULL,
  `cboxReferralByPsychiatricHospital` char(2) DEFAULT NULL,
  `cboxCurrLivingWithNonrelatives` char(2) DEFAULT NULL,
  `cboxFamilyLawIssues1` char(2) DEFAULT NULL,
  `cboxProblemsWithPolice1` char(2) DEFAULT NULL,
  `cboxBaseHasRegularHealthProvider` char(2) DEFAULT NULL,
  `cboxFamilyLawIssues2` char(2) DEFAULT NULL,
  `cboxCurrUseShelterClinic` char(2) DEFAULT NULL,
  `clientNum` varchar(16) DEFAULT NULL,
  `cbox2ndImpulsiveDisorder` char(2) DEFAULT NULL,
  `radioIsAboriginal` varchar(16) DEFAULT NULL,
  `baseSocialServiceClientAccesses` varchar(255) DEFAULT NULL,
  `cboxBase2ndIncomeOther` char(2) DEFAULT NULL,
  `cboxBaseIncomeMgmentNeedsTrusteeButDoNotWant` char(2) DEFAULT NULL,
  `cbox2ndSleepDisorder` char(2) DEFAULT NULL,
  `cboxBaseHasNonStatus` char(2) DEFAULT NULL,
  `cboxHealthCareIssueOther` char(2) DEFAULT NULL,
  `radioCurrHealthCareAccess` varchar(16) DEFAULT NULL,
  `cboxBaseHasCertificate` char(2) DEFAULT NULL,
  `cboxBaseLivingWithSelf` char(2) DEFAULT NULL,
  `cboxCurrIncomeMgmentNeedsTrustee` char(2) DEFAULT NULL,
  `cboxBase2ndIncomeUnknown` char(2) DEFAULT NULL,
  `radioLanguageEnglish` varchar(16) DEFAULT NULL,
  `yearArrivedInCanada` varchar(16) DEFAULT NULL,
  `cboxDateOfBirthUnknown` char(2) DEFAULT NULL,
  `cboxOtherIssue` char(2) DEFAULT NULL,
  `cboxCurrHasHealthCard` char(2) DEFAULT NULL,
  `cboxCurrHasSomeone` char(2) DEFAULT NULL,
  `cboxCurrHasRegularHealthProvider` char(2) DEFAULT NULL,
  `cbox2ndDevelopmentalDisorder` char(2) DEFAULT NULL,
  `cboxBase2ndIncomeInformalOther` char(2) DEFAULT NULL,
  `cboxOCd` char(2) DEFAULT NULL,
  `cboxCurrUseHospitalEmergency` char(2) DEFAULT NULL,
  `cboxBaseLivingWithUnknown` char(2) DEFAULT NULL,
  `cbox2ndFactitiousDisorder` char(2) DEFAULT NULL,
  `cboxBaseHasSomeone` char(2) DEFAULT NULL,
  `cboxRelationalIssue` char(2) DEFAULT NULL,
  `cboxBaseHasNativeCard` char(2) DEFAULT NULL,
  `radioBaseLegalStatus` varchar(16) DEFAULT NULL,
  `cbox2ndIncomeFamily` char(2) DEFAULT NULL,
  `cboxCurrHasRelatives` char(2) DEFAULT NULL,
  `cboxCurrHasCertificate` char(2) DEFAULT NULL,
  `monthOfBirth` char(2) DEFAULT NULL,
  `cboxBaseHasSIn` char(2) DEFAULT NULL,
  `clientSurname` varchar(40) DEFAULT NULL,
  `cbox2ndAnxietyDisorderOCd` char(2) DEFAULT NULL,
  `staffName` varchar(60) DEFAULT NULL,
  `cboxReferralByStreetIDWorkerOther` char(2) DEFAULT NULL,
  `cbox2ndSubstanceDisorder` char(2) DEFAULT NULL,
  `radioCurrNeedSocialServices` varchar(16) DEFAULT NULL,
  `radioBaseHighestEductionLevel` varchar(16) DEFAULT NULL,
  `cboxBaseHasSupportUnknown` char(2) DEFAULT NULL,
  `radioCurrResidenceStatus` varchar(16) DEFAULT NULL,
  `cboxBaseIncomeMgmentDoNotNeedTrustee` char(2) DEFAULT NULL,
  `countryOfOrigin` varchar(60) DEFAULT NULL,
  `cboxCurrHasFriends` char(2) DEFAULT NULL,
  `radioBasePrimaryIncomeSource` varchar(16) DEFAULT NULL,
  `cbox2ndAnxietyDisorderOther` char(2) DEFAULT NULL,
  `cboxEducationalIssue` char(2) DEFAULT NULL,
  `radioBasePrimaryIncomeSourceOther` varchar(16) DEFAULT NULL,
  `radioBaseParticipateInEduction` varchar(16) DEFAULT NULL,
  `cboxCurrLivingWithRelatives` char(2) DEFAULT NULL,
  `baseDescriptionOfHousing` varchar(255) DEFAULT NULL,
  `cboxReferralByCourt` char(2) DEFAULT NULL,
  `cbox2ndIncomePanhandlingOther` char(2) DEFAULT NULL,
  `cboxReferralByOtherAgency` char(2) DEFAULT NULL,
  `cboxCaseFile` char(2) DEFAULT NULL,
  `cboxCurrLivingWithChildren` char(2) DEFAULT NULL,
  `cboxReferralByMentalHealthWorker` char(2) DEFAULT NULL,
  `cboxCurrIncomeMgmentNeedsTrusteeButDoNotWant` char(2) DEFAULT NULL,
  `clientFirstName` varchar(40) DEFAULT NULL,
  `cboxBankingIssueOther` char(2) DEFAULT NULL,
  `cboxBase2ndIncomeEmployment` char(2) DEFAULT NULL,
  `cboxNAExit` char(2) DEFAULT NULL,
  `cbox2ndIncomeNone` char(2) DEFAULT NULL,
  `cboxNa` char(2) DEFAULT NULL,
  `cboxBaseHasRelatives` char(2) DEFAULT NULL,
  `cboxCurrHasNonStatus` char(2) DEFAULT NULL,
  `cboxEmploymentIssue` char(2) DEFAULT NULL,
  `yearOfBirth` varchar(4) DEFAULT NULL,
  `cboxBase2ndIncomePension` char(2) DEFAULT NULL,
  `cboxCurrLivingWithSpousePlus` char(2) DEFAULT NULL,
  `cboxPreferredLanguageUnknown` char(2) DEFAULT NULL,
  `cbox2ndAnxietyDisorderPSd` char(2) DEFAULT NULL,
  `cboxSexualAbuseIssue` char(2) DEFAULT NULL,
  `formEdited` datetime DEFAULT NULL,
  `cboxBaseUseShelterClinic` char(2) DEFAULT NULL,
  `cboxCurrAccessHealthCareUnknown` char(2) DEFAULT NULL,
  `cbox2ndIncomePension` char(2) DEFAULT NULL,
  `provider_no` bigint(20) DEFAULT NULL,
  `cboxCurrDoNotAccessHealthCare` char(2) DEFAULT NULL,
  `cboxCurrUseHealthBus` char(2) DEFAULT NULL,
  `cboxBaseLivingWithParents` char(2) DEFAULT NULL,
  `cboxBaseHasUnknown` char(2) DEFAULT NULL,
  `radioBaseNeedSocialServices` varchar(16) DEFAULT NULL,
  `cboxNoneListedIssue` char(2) DEFAULT NULL,
  `cbox2ndUnknown` char(2) DEFAULT NULL,
  `cboxReferralBySafeBeds` char(2) DEFAULT NULL,
  `cbox2ndAdjustDisorder` char(2) DEFAULT NULL,
  `cboxHospitalizationUnknown` char(2) DEFAULT NULL,
  `cboxConcurrentDisorder` char(2) DEFAULT NULL,
  `cbox2ndEatingDisorder` char(2) DEFAULT NULL,
  `cboxCompleteWithReferral` char(2) DEFAULT NULL,
  `cboxBaseUseWalkinClinic` char(2) DEFAULT NULL,
  `monthlyProgressReport` varchar(255) DEFAULT NULL,
  `cboxOtherAnxietyDisorder` char(2) DEFAULT NULL,
  `cboxBaseIncomeMgmentHasTrustee` char(2) DEFAULT NULL,
  `demographic_no` bigint(20) NOT NULL DEFAULT '0',
  `cboxBaseIncomeMgmentNeedsTrustee` char(2) DEFAULT NULL,
  `radioRaceCaucasian` varchar(16) DEFAULT NULL,
  `cboxMentalIssue` char(2) DEFAULT NULL,
  `preferredLanguage` varchar(30) DEFAULT NULL,
  `cbox2ndMoodDisorder` char(2) DEFAULT NULL,
  `radioPrimaryDiagnosis` varchar(16) DEFAULT NULL,
  `cboxCurrHasNativeCard` char(2) DEFAULT NULL,
  `cboxBaseLivingWithChildren` char(2) DEFAULT NULL,
  `cboxBaseLivingWithSpouse` char(2) DEFAULT NULL,
  `radioTreatmentOrders` varchar(16) DEFAULT NULL,
  `cboxReferralByOtherPeople` char(2) DEFAULT NULL,
  `cboxBaseAccessHealthCareUnknown` char(2) DEFAULT NULL,
  `cboxCompleteWithoutReferral` char(2) DEFAULT NULL,
  `cboxDeathExit` char(2) DEFAULT NULL,
  `cboxBaseLivingWithRelatives` char(2) DEFAULT NULL,
  `currAddress` varchar(255) DEFAULT NULL,
  `currPhone` varchar(255) DEFAULT NULL,
  `pastAddresses` text,
  `contactsInfo` text,
  `ids` text,
  `hospitalizations` text,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formovulation`
--

DROP TABLE IF EXISTS `formovulation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formovulation` (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT,
  `demographic_no` bigint(11) NOT NULL DEFAULT '0',
  `provider_no` bigint(11) DEFAULT '0',
  `formCreated` date DEFAULT '0000-00-00',
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `clientFirstName` varchar(30) DEFAULT '',
  `clientLastName` varchar(30) DEFAULT '',
  `dob` varchar(16) DEFAULT '',
  `healthNum` varchar(24) DEFAULT '',
  `workPhone` varchar(18) DEFAULT '',
  `homePhone` varchar(18) DEFAULT '',
  `otherPhone` varchar(18) DEFAULT '',
  `diag` varchar(24) DEFAULT '',
  `femara` varchar(24) DEFAULT '',
  `tamoxi` varchar(24) DEFAULT '',
  `ccNol` varchar(24) DEFAULT '',
  `gonad` varchar(24) DEFAULT '',
  `metForMin` varchar(24) DEFAULT '',
  `parlodEl` varchar(24) DEFAULT '',
  `folicAcid` varchar(24) DEFAULT '',
  `ovul` varchar(24) DEFAULT '',
  `postOv` varchar(24) DEFAULT '',
  `iui` varchar(24) DEFAULT '',
  `tdi` varchar(24) DEFAULT '',
  `semenVolume` varchar(24) DEFAULT '',
  `semenPMotility` varchar(24) DEFAULT '',
  `semenTMotility` varchar(24) DEFAULT '',
  `semenMorphology` varchar(24) DEFAULT '',
  `semenConcentration` varchar(24) DEFAULT '',
  `semenSperm` varchar(24) DEFAULT '',
  `semenSpermPh` varchar(24) DEFAULT '',
  `diagnosis` varchar(255) DEFAULT '',
  `sideEffects` varchar(255) DEFAULT '',
  `abnormalResult` varchar(255) DEFAULT '',
  `previousCycles` varchar(255) DEFAULT '',
  `fsh` varchar(24) DEFAULT '',
  `collectionDate` varchar(24) DEFAULT '',
  `abstinenceDays` varchar(24) DEFAULT '',
  `collectionTime` varchar(24) DEFAULT '',
  `collectionAmPm` varchar(24) DEFAULT '',
  `collectionMethod` varchar(24) DEFAULT '',
  `bmiAge` char(3) DEFAULT '',
  `bmiPpWt` varchar(5) DEFAULT '',
  `bmiPpHt` varchar(5) DEFAULT '',
  `bmi` varchar(5) DEFAULT '',
  `preColor` varchar(24) DEFAULT '',
  `preViscosity` varchar(24) DEFAULT '',
  `preLiquefaction` varchar(24) DEFAULT '',
  `prePh` varchar(24) DEFAULT '',
  `preRoundCells` varchar(24) DEFAULT '',
  `preProgression` varchar(24) DEFAULT '',
  `preVolume` varchar(24) DEFAULT '',
  `preDensity` varchar(24) DEFAULT '',
  `preMotility` varchar(24) DEFAULT '',
  `preTmc` varchar(24) DEFAULT '',
  `preMorphology` varchar(24) DEFAULT '',
  `preAgglutination` varchar(24) DEFAULT '',
  `preDebris` varchar(24) DEFAULT '',
  `postProgression` varchar(24) DEFAULT '',
  `postVolume` varchar(24) DEFAULT '',
  `postDensity` varchar(24) DEFAULT '',
  `postMotility` varchar(24) DEFAULT '',
  `postTmc` varchar(24) DEFAULT '',
  `date1` varchar(16) DEFAULT '',
  `date2` varchar(16) DEFAULT '',
  `date3` varchar(16) DEFAULT '',
  `date4` varchar(16) DEFAULT '',
  `date5` varchar(16) DEFAULT '',
  `date6` varchar(16) DEFAULT '',
  `date7` varchar(16) DEFAULT '',
  `date8` varchar(16) DEFAULT '',
  `date9` varchar(16) DEFAULT '',
  `date10` varchar(16) DEFAULT '',
  `date11` varchar(16) DEFAULT '',
  `date12` varchar(16) DEFAULT '',
  `day1` varchar(8) DEFAULT '',
  `day2` varchar(8) DEFAULT '',
  `day3` varchar(8) DEFAULT '',
  `day4` varchar(8) DEFAULT '',
  `day5` varchar(8) DEFAULT '',
  `day6` varchar(8) DEFAULT '',
  `day7` varchar(8) DEFAULT '',
  `day8` varchar(8) DEFAULT '',
  `day9` varchar(8) DEFAULT '',
  `day10` varchar(8) DEFAULT '',
  `day11` varchar(8) DEFAULT '',
  `day12` varchar(8) DEFAULT '',
  `e2Lh1a` varchar(12) DEFAULT '',
  `e2Lh1b` varchar(12) DEFAULT '',
  `e2Lh2a` varchar(12) DEFAULT '',
  `e2Lh2b` varchar(12) DEFAULT '',
  `e2Lh3a` varchar(12) DEFAULT '',
  `e2Lh3b` varchar(12) DEFAULT '',
  `e2Lh4a` varchar(12) DEFAULT '',
  `e2Lh4b` varchar(12) DEFAULT '',
  `e2Lh5a` varchar(12) DEFAULT '',
  `e2Lh5b` varchar(12) DEFAULT '',
  `e2Lh6a` varchar(12) DEFAULT '',
  `e2Lh6b` varchar(12) DEFAULT '',
  `e2Lh7a` varchar(12) DEFAULT '',
  `e2Lh7b` varchar(12) DEFAULT '',
  `e2Lh8a` varchar(12) DEFAULT '',
  `e2Lh8b` varchar(12) DEFAULT '',
  `e2Lh9a` varchar(12) DEFAULT '',
  `e2Lh9b` varchar(12) DEFAULT '',
  `e2Lh10a` varchar(12) DEFAULT '',
  `e2Lh10b` varchar(12) DEFAULT '',
  `e2Lh11a` varchar(12) DEFAULT '',
  `e2Lh11b` varchar(12) DEFAULT '',
  `e2Lh12a` varchar(12) DEFAULT '',
  `e2Lh12b` varchar(12) DEFAULT '',
  `tshPrl1a` varchar(12) DEFAULT '',
  `tshPrl1b` varchar(12) DEFAULT '',
  `tshPrl2a` varchar(12) DEFAULT '',
  `tshPrl2b` varchar(12) DEFAULT '',
  `tshPrl3a` varchar(12) DEFAULT '',
  `tshPrl3b` varchar(12) DEFAULT '',
  `tshPrl4a` varchar(12) DEFAULT '',
  `tshPrl4b` varchar(12) DEFAULT '',
  `tshPrl5a` varchar(12) DEFAULT '',
  `tshPrl5b` varchar(12) DEFAULT '',
  `tshPrl6a` varchar(12) DEFAULT '',
  `tshPrl6b` varchar(12) DEFAULT '',
  `tshPrl7a` varchar(12) DEFAULT '',
  `tshPrl7b` varchar(12) DEFAULT '',
  `tshPrl8a` varchar(12) DEFAULT '',
  `tshPrl8b` varchar(12) DEFAULT '',
  `tshPrl9a` varchar(12) DEFAULT '',
  `tshPrl9b` varchar(12) DEFAULT '',
  `tshPrl10a` varchar(12) DEFAULT '',
  `tshPrl10b` varchar(12) DEFAULT '',
  `tshPrl11a` varchar(12) DEFAULT '',
  `tshPrl11b` varchar(12) DEFAULT '',
  `tshPrl12a` varchar(12) DEFAULT '',
  `tshPrl12b` varchar(12) DEFAULT '',
  `progBhog1a` varchar(12) DEFAULT '',
  `progBhog1b` varchar(12) DEFAULT '',
  `progBhog2a` varchar(12) DEFAULT '',
  `progBhog2b` varchar(12) DEFAULT '',
  `progBhog3a` varchar(12) DEFAULT '',
  `progBhog3b` varchar(12) DEFAULT '',
  `progBhog4a` varchar(12) DEFAULT '',
  `progBhog4b` varchar(12) DEFAULT '',
  `progBhog5a` varchar(12) DEFAULT '',
  `progBhog5b` varchar(12) DEFAULT '',
  `progBhog6a` varchar(12) DEFAULT '',
  `progBhog6b` varchar(12) DEFAULT '',
  `progBhog7a` varchar(12) DEFAULT '',
  `progBhog7b` varchar(12) DEFAULT '',
  `progBhog8a` varchar(12) DEFAULT '',
  `progBhog8b` varchar(12) DEFAULT '',
  `progBhog9a` varchar(12) DEFAULT '',
  `progBhog9b` varchar(12) DEFAULT '',
  `progBhog10a` varchar(12) DEFAULT '',
  `progBhog10b` varchar(12) DEFAULT '',
  `progBhog11a` varchar(12) DEFAULT '',
  `progBhog11b` varchar(12) DEFAULT '',
  `progBhog12a` varchar(12) DEFAULT '',
  `progBhog12b` varchar(12) DEFAULT '',
  `flag_e2Lh1a` varchar(8) DEFAULT '',
  `flag_e2Lh1b` varchar(8) DEFAULT '',
  `flag_e2Lh2a` varchar(8) DEFAULT '',
  `flag_e2Lh2b` varchar(8) DEFAULT '',
  `flag_e2Lh3a` varchar(8) DEFAULT '',
  `flag_e2Lh3b` varchar(8) DEFAULT '',
  `flag_e2Lh4a` varchar(8) DEFAULT '',
  `flag_e2Lh4b` varchar(8) DEFAULT '',
  `flag_e2Lh5a` varchar(8) DEFAULT '',
  `flag_e2Lh5b` varchar(8) DEFAULT '',
  `flag_e2Lh6a` varchar(8) DEFAULT '',
  `flag_e2Lh6b` varchar(8) DEFAULT '',
  `flag_e2Lh7a` varchar(8) DEFAULT '',
  `flag_e2Lh7b` varchar(8) DEFAULT '',
  `flag_e2Lh8a` varchar(8) DEFAULT '',
  `flag_e2Lh8b` varchar(8) DEFAULT '',
  `flag_e2Lh9a` varchar(8) DEFAULT '',
  `flag_e2Lh9b` varchar(8) DEFAULT '',
  `flag_e2Lh10a` varchar(8) DEFAULT '',
  `flag_e2Lh10b` varchar(8) DEFAULT '',
  `flag_e2Lh11a` varchar(8) DEFAULT '',
  `flag_e2Lh11b` varchar(8) DEFAULT '',
  `flag_e2Lh12a` varchar(8) DEFAULT '',
  `flag_e2Lh12b` varchar(8) DEFAULT '',
  `flag_tshPrl1a` varchar(8) DEFAULT '',
  `flag_tshPrl1b` varchar(8) DEFAULT '',
  `flag_tshPrl2a` varchar(8) DEFAULT '',
  `flag_tshPrl2b` varchar(8) DEFAULT '',
  `flag_tshPrl3a` varchar(8) DEFAULT '',
  `flag_tshPrl3b` varchar(8) DEFAULT '',
  `flag_tshPrl4a` varchar(8) DEFAULT '',
  `flag_tshPrl4b` varchar(8) DEFAULT '',
  `flag_tshPrl5a` varchar(8) DEFAULT '',
  `flag_tshPrl5b` varchar(8) DEFAULT '',
  `flag_tshPrl6a` varchar(8) DEFAULT '',
  `flag_tshPrl6b` varchar(8) DEFAULT '',
  `flag_tshPrl7a` varchar(8) DEFAULT '',
  `flag_tshPrl7b` varchar(8) DEFAULT '',
  `flag_tshPrl8a` varchar(8) DEFAULT '',
  `flag_tshPrl8b` varchar(8) DEFAULT '',
  `flag_tshPrl9a` varchar(8) DEFAULT '',
  `flag_tshPrl9b` varchar(8) DEFAULT '',
  `flag_tshPrl10a` varchar(8) DEFAULT '',
  `flag_tshPrl10b` varchar(8) DEFAULT '',
  `flag_tshPrl11a` varchar(8) DEFAULT '',
  `flag_tshPrl11b` varchar(8) DEFAULT '',
  `flag_tshPrl12a` varchar(8) DEFAULT '',
  `flag_tshPrl12b` varchar(8) DEFAULT '',
  `flag_progBhog1a` varchar(8) DEFAULT '',
  `flag_progBhog1b` varchar(8) DEFAULT '',
  `flag_progBhog2a` varchar(8) DEFAULT '',
  `flag_progBhog2b` varchar(8) DEFAULT '',
  `flag_progBhog3a` varchar(8) DEFAULT '',
  `flag_progBhog3b` varchar(8) DEFAULT '',
  `flag_progBhog4a` varchar(8) DEFAULT '',
  `flag_progBhog4b` varchar(8) DEFAULT '',
  `flag_progBhog5a` varchar(8) DEFAULT '',
  `flag_progBhog5b` varchar(8) DEFAULT '',
  `flag_progBhog6a` varchar(8) DEFAULT '',
  `flag_progBhog6b` varchar(8) DEFAULT '',
  `flag_progBhog7a` varchar(8) DEFAULT '',
  `flag_progBhog7b` varchar(8) DEFAULT '',
  `flag_progBhog8a` varchar(8) DEFAULT '',
  `flag_progBhog8b` varchar(8) DEFAULT '',
  `flag_progBhog9a` varchar(8) DEFAULT '',
  `flag_progBhog9b` varchar(8) DEFAULT '',
  `flag_progBhog10a` varchar(8) DEFAULT '',
  `flag_progBhog10b` varchar(8) DEFAULT '',
  `flag_progBhog11a` varchar(8) DEFAULT '',
  `flag_progBhog11b` varchar(8) DEFAULT '',
  `flag_progBhog12a` varchar(8) DEFAULT '',
  `flag_progBhog12b` varchar(8) DEFAULT '',
  `rightCyst1a` varchar(24) DEFAULT '',
  `rightCyst1b` varchar(24) DEFAULT '',
  `rightCyst2a` varchar(24) DEFAULT '',
  `rightCyst2b` varchar(24) DEFAULT '',
  `rightCyst3a` varchar(24) DEFAULT '',
  `rightCyst3b` varchar(24) DEFAULT '',
  `rightCyst4a` varchar(24) DEFAULT '',
  `rightCyst4b` varchar(24) DEFAULT '',
  `rightCyst5a` varchar(24) DEFAULT '',
  `rightCyst5b` varchar(24) DEFAULT '',
  `rightCyst6a` varchar(24) DEFAULT '',
  `rightCyst6b` varchar(24) DEFAULT '',
  `rightCyst7a` varchar(24) DEFAULT '',
  `rightCyst7b` varchar(24) DEFAULT '',
  `rightCyst8a` varchar(24) DEFAULT '',
  `rightCyst8b` varchar(24) DEFAULT '',
  `rightCyst9a` varchar(24) DEFAULT '',
  `rightCyst9b` varchar(24) DEFAULT '',
  `rightCyst10a` varchar(24) DEFAULT '',
  `rightCyst10b` varchar(24) DEFAULT '',
  `rightCyst11a` varchar(24) DEFAULT '',
  `rightCyst11b` varchar(24) DEFAULT '',
  `rightCyst12a` varchar(24) DEFAULT '',
  `rightCyst12b` varchar(24) DEFAULT '',
  `leftCyst1a` varchar(24) DEFAULT '',
  `leftCyst1b` varchar(24) DEFAULT '',
  `leftCyst2a` varchar(24) DEFAULT '',
  `leftCyst2b` varchar(24) DEFAULT '',
  `leftCyst3a` varchar(24) DEFAULT '',
  `leftCyst3b` varchar(24) DEFAULT '',
  `leftCyst4a` varchar(24) DEFAULT '',
  `leftCyst4b` varchar(24) DEFAULT '',
  `leftCyst5a` varchar(24) DEFAULT '',
  `leftCyst5b` varchar(24) DEFAULT '',
  `leftCyst6a` varchar(24) DEFAULT '',
  `leftCyst6b` varchar(24) DEFAULT '',
  `leftCyst7a` varchar(24) DEFAULT '',
  `leftCyst7b` varchar(24) DEFAULT '',
  `leftCyst8a` varchar(24) DEFAULT '',
  `leftCyst8b` varchar(24) DEFAULT '',
  `leftCyst9a` varchar(24) DEFAULT '',
  `leftCyst9b` varchar(24) DEFAULT '',
  `leftCyst10a` varchar(24) DEFAULT '',
  `leftCyst10b` varchar(24) DEFAULT '',
  `leftCyst11a` varchar(24) DEFAULT '',
  `leftCyst11b` varchar(24) DEFAULT '',
  `leftCyst12a` varchar(24) DEFAULT '',
  `leftCyst12b` varchar(24) DEFAULT '',
  `etTEX1a` varchar(24) DEFAULT '',
  `etTEX1b` varchar(24) DEFAULT '',
  `etTEX2a` varchar(24) DEFAULT '',
  `etTEX2b` varchar(24) DEFAULT '',
  `etTEX3a` varchar(24) DEFAULT '',
  `etTEX3b` varchar(24) DEFAULT '',
  `etTEX4a` varchar(24) DEFAULT '',
  `etTEX4b` varchar(24) DEFAULT '',
  `etTEX5a` varchar(24) DEFAULT '',
  `etTEX5b` varchar(24) DEFAULT '',
  `etTEX6a` varchar(24) DEFAULT '',
  `etTEX6b` varchar(24) DEFAULT '',
  `etTEX7a` varchar(24) DEFAULT '',
  `etTEX7b` varchar(24) DEFAULT '',
  `etTEX8a` varchar(24) DEFAULT '',
  `etTEX8b` varchar(24) DEFAULT '',
  `etTEX9a` varchar(24) DEFAULT '',
  `etTEX9b` varchar(24) DEFAULT '',
  `etTEX10a` varchar(24) DEFAULT '',
  `etTEX10b` varchar(24) DEFAULT '',
  `etTEX11a` varchar(24) DEFAULT '',
  `etTEX11b` varchar(24) DEFAULT '',
  `etTEX12a` varchar(24) DEFAULT '',
  `etTEX12b` varchar(24) DEFAULT '',
  `ff1` varchar(12) DEFAULT '',
  `ff2` varchar(12) DEFAULT '',
  `ff3` varchar(12) DEFAULT '',
  `ff4` varchar(12) DEFAULT '',
  `ff5` varchar(12) DEFAULT '',
  `ff6` varchar(12) DEFAULT '',
  `ff7` varchar(12) DEFAULT '',
  `ff8` varchar(12) DEFAULT '',
  `ff9` varchar(12) DEFAULT '',
  `ff10` varchar(12) DEFAULT '',
  `ff11` varchar(12) DEFAULT '',
  `ff12` varchar(12) DEFAULT '',
  `rightLo1` varchar(255) DEFAULT '',
  `rightLo2` varchar(255) DEFAULT '',
  `rightLo3` varchar(255) DEFAULT '',
  `rightLo4` varchar(255) DEFAULT '',
  `rightLo5` varchar(255) DEFAULT '',
  `rightLo6` varchar(255) DEFAULT '',
  `rightLo7` varchar(255) DEFAULT '',
  `rightLo8` varchar(255) DEFAULT '',
  `rightLo9` varchar(255) DEFAULT '',
  `rightLo10` varchar(255) DEFAULT '',
  `rightLo11` varchar(255) DEFAULT '',
  `rightLo12` varchar(255) DEFAULT '',
  `leftLo1` varchar(255) DEFAULT '',
  `leftLo2` varchar(255) DEFAULT '',
  `leftLo3` varchar(255) DEFAULT '',
  `leftLo4` varchar(255) DEFAULT '',
  `leftLo5` varchar(255) DEFAULT '',
  `leftLo6` varchar(255) DEFAULT '',
  `leftLo7` varchar(255) DEFAULT '',
  `leftLo8` varchar(255) DEFAULT '',
  `leftLo9` varchar(255) DEFAULT '',
  `leftLo10` varchar(255) DEFAULT '',
  `leftLo11` varchar(255) DEFAULT '',
  `leftLo12` varchar(255) DEFAULT '',
  `meds1` varchar(255) DEFAULT '',
  `meds2` varchar(255) DEFAULT '',
  `meds3` varchar(255) DEFAULT '',
  `meds4` varchar(255) DEFAULT '',
  `meds5` varchar(255) DEFAULT '',
  `meds6` varchar(255) DEFAULT '',
  `meds7` varchar(255) DEFAULT '',
  `meds8` varchar(255) DEFAULT '',
  `meds9` varchar(255) DEFAULT '',
  `meds10` varchar(255) DEFAULT '',
  `meds11` varchar(255) DEFAULT '',
  `meds12` varchar(255) DEFAULT '',
  `comment1` varchar(255) DEFAULT '',
  `comment2` varchar(255) DEFAULT '',
  `comment3` varchar(255) DEFAULT '',
  `comment4` varchar(255) DEFAULT '',
  `comment5` varchar(255) DEFAULT '',
  `comment6` varchar(255) DEFAULT '',
  `comment7` varchar(255) DEFAULT '',
  `comment8` varchar(255) DEFAULT '',
  `comment9` varchar(255) DEFAULT '',
  `comment10` varchar(255) DEFAULT '',
  `comment11` varchar(255) DEFAULT '',
  `comment12` varchar(255) DEFAULT '',
  `postComment` varchar(255) DEFAULT '',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formreceptionassessment`
--

DROP TABLE IF EXISTS `formreceptionassessment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formreceptionassessment` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` int(10) DEFAULT NULL,
  `formCreated` date DEFAULT NULL,
  `formEdited` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `assessDate` varchar(24) DEFAULT NULL,
  `assessStartTime` varchar(24) DEFAULT NULL,
  `enterSeatonDate` varchar(24) DEFAULT NULL,
  `cbox_newClient` char(1) DEFAULT NULL,
  `cbox_dateOfReadmission` char(1) DEFAULT NULL,
  `dateOfReadmission` varchar(24) DEFAULT NULL,
  `clientSurname` varchar(50) DEFAULT NULL,
  `clientFirstName` varchar(50) DEFAULT NULL,
  `month` char(2) DEFAULT NULL,
  `day` char(2) DEFAULT NULL,
  `year` varchar(4) DEFAULT NULL,
  `cbox_speakEnglish` char(1) DEFAULT NULL,
  `cbox_speakFrench` char(1) DEFAULT NULL,
  `cbox_speakOther` char(1) DEFAULT NULL,
  `speakOther` varchar(36) DEFAULT NULL,
  `reasonToSeaton` varchar(255) DEFAULT NULL,
  `datesAtSeaton` varchar(70) DEFAULT NULL,
  `cbox_assistInHealth` char(1) DEFAULT NULL,
  `cbox_assistInIdentification` char(1) DEFAULT NULL,
  `cbox_assistInAddictions` char(1) DEFAULT NULL,
  `cbox_assistInHousing` char(1) DEFAULT NULL,
  `cbox_assistInEducation` char(1) DEFAULT NULL,
  `cbox_assistInEmployment` char(1) DEFAULT NULL,
  `cbox_assistInFinance` char(1) DEFAULT NULL,
  `cbox_assistInLegal` char(1) DEFAULT NULL,
  `cbox_assistInImmigration` char(1) DEFAULT NULL,
  `cbox_noID` char(1) DEFAULT NULL,
  `cbox_sinCard` char(1) DEFAULT NULL,
  `cbox_healthCard` char(1) DEFAULT NULL,
  `healthCardNum` varchar(24) DEFAULT NULL,
  `cbox_birthCertificate` char(1) DEFAULT NULL,
  `cbox_citzenshipCard` char(1) DEFAULT NULL,
  `cbox_immigrant` char(1) DEFAULT NULL,
  `cbox_refugee` char(1) DEFAULT NULL,
  `cbox_otherID` char(1) DEFAULT NULL,
  `otherIdentification` varchar(70) DEFAULT NULL,
  `cbox_idFiled` char(1) DEFAULT NULL,
  `cbox_idNone` char(1) DEFAULT NULL,
  `commentsOnID` varchar(255) DEFAULT NULL,
  `cbox_OW` char(1) DEFAULT NULL,
  `cbox_ODSP` char(1) DEFAULT NULL,
  `cbox_WSIB` char(1) DEFAULT NULL,
  `cbox_Employment` char(1) DEFAULT NULL,
  `cbox_EI` char(1) DEFAULT NULL,
  `cbox_OAS` char(1) DEFAULT NULL,
  `cbox_CPP` char(1) DEFAULT NULL,
  `cbox_OtherIncome` char(1) DEFAULT NULL,
  `radio_onlineCheck` varchar(36) DEFAULT NULL,
  `radio_active` varchar(36) DEFAULT NULL,
  `cbox_noRecord` char(1) DEFAULT NULL,
  `lastIssueDate` varchar(24) DEFAULT NULL,
  `office` varchar(50) DEFAULT NULL,
  `workerNum` varchar(36) DEFAULT NULL,
  `amtReceived` varchar(9) DEFAULT NULL,
  `radio_hasDoctor` varchar(36) DEFAULT NULL,
  `doctorName` varchar(50) DEFAULT NULL,
  `doctorPhone` varchar(24) DEFAULT NULL,
  `doctorPhoneExt` varchar(8) DEFAULT NULL,
  `doctorAddress` varchar(120) DEFAULT NULL,
  `radio_seeDoctor` varchar(36) DEFAULT NULL,
  `radio_healthIssue` varchar(36) DEFAULT NULL,
  `healthIssueDetails` varchar(255) DEFAULT NULL,
  `cbox_hasDiabetes` char(1) DEFAULT NULL,
  `cbox_insulin` char(1) DEFAULT NULL,
  `cbox_epilepsy` char(1) DEFAULT NULL,
  `cbox_bleeding` char(1) DEFAULT NULL,
  `cbox_hearingImpair` char(1) DEFAULT NULL,
  `cbox_visualImpair` char(1) DEFAULT NULL,
  `cbox_mobilityImpair` char(1) DEFAULT NULL,
  `mobilityImpair` varchar(255) DEFAULT NULL,
  `radio_otherHealthConcern` varchar(36) DEFAULT NULL,
  `otherHealthConerns` varchar(255) DEFAULT NULL,
  `radio_takeMedication` varchar(36) DEFAULT NULL,
  `namesOfMedication` varchar(120) DEFAULT NULL,
  `radio_helpObtainMedication` varchar(36) DEFAULT NULL,
  `helpObtainMedication` varchar(255) DEFAULT NULL,
  `radio_allergicToMedication` varchar(36) DEFAULT NULL,
  `allergicToMedicationName` varchar(255) DEFAULT NULL,
  `reactionToMedication` varchar(255) DEFAULT NULL,
  `radio_mentalHealthConcerns` varchar(36) DEFAULT NULL,
  `mentalHealthConcerns` varchar(255) DEFAULT NULL,
  `frequencyOfSeeingDoctor` varchar(8) DEFAULT NULL,
  `cbox_visitWalkInClinic` char(1) DEFAULT NULL,
  `cbox_visitHealthCenter` char(1) DEFAULT NULL,
  `cbox_visitEmergencyRoom` char(1) DEFAULT NULL,
  `cbox_visitOthers` char(1) DEFAULT NULL,
  `cbox_visitHealthOffice` char(1) DEFAULT NULL,
  `radio_seeSameDoctor` varchar(36) DEFAULT NULL,
  `frequencyOfSeeingEmergencyRoomDoctor` varchar(8) DEFAULT NULL,
  `radio_didNotReceiveHealthCare` varchar(36) DEFAULT NULL,
  `cbox_treatPhysicalHealth` char(1) DEFAULT NULL,
  `cbox_treatMentalHealth` char(1) DEFAULT NULL,
  `cbox_regularCheckup` char(1) DEFAULT NULL,
  `cbox_treatOtherReasons` char(1) DEFAULT NULL,
  `treatOtherReasons` varchar(255) DEFAULT NULL,
  `cbox_treatInjury` char(1) DEFAULT NULL,
  `cbox_goToWalkInClinic` char(1) DEFAULT NULL,
  `cbox_goToHealthCenter` char(1) DEFAULT NULL,
  `cbox_goToEmergencyRoom` char(1) DEFAULT NULL,
  `cbox_goToOthers` char(1) DEFAULT NULL,
  `goToOthers` varchar(255) DEFAULT NULL,
  `cbox_HealthOffice` char(1) DEFAULT NULL,
  `radio_appmtSeeDoctorIn3Mths` varchar(36) DEFAULT NULL,
  `radio_needRegularDoctor` varchar(36) DEFAULT NULL,
  `radio_objectToRegularDoctorIn4Wks` varchar(36) DEFAULT NULL,
  `radio_rateOverallHealth` varchar(36) DEFAULT NULL,
  `radio_speakToResearcher` varchar(36) DEFAULT NULL,
  `contactName` varchar(70) DEFAULT NULL,
  `contactPhone` varchar(24) DEFAULT NULL,
  `contactAddress` varchar(255) DEFAULT NULL,
  `contactRelationship` varchar(120) DEFAULT NULL,
  `radio_hasMentalIllness` varchar(36) DEFAULT NULL,
  `radio_hasDrinkingProblem` varchar(36) DEFAULT NULL,
  `radio_hasDrugProblem` varchar(36) DEFAULT NULL,
  `radio_hasHealthProblem` varchar(36) DEFAULT NULL,
  `radio_hasBehaviorProblem` varchar(36) DEFAULT NULL,
  `radio_needSeatonService` varchar(36) DEFAULT NULL,
  `radio_seatonTour` varchar(36) DEFAULT NULL,
  `seatonNotToured` varchar(255) DEFAULT NULL,
  `radio_pamphletIssued` varchar(36) DEFAULT NULL,
  `pamphletNotIssued` varchar(255) DEFAULT NULL,
  `summary` varchar(255) DEFAULT NULL,
  `completedBy` varchar(120) DEFAULT NULL,
  `assessCompleteTime` varchar(36) DEFAULT NULL,
  `cbox_pamphletIssued` char(1) DEFAULT NULL,
  `cbox_hostel` char(1) DEFAULT NULL,
  `cbox_rotaryClub` char(1) DEFAULT NULL,
  `cbox_annexHarm` char(1) DEFAULT NULL,
  `cbox_longTermProgram` char(1) DEFAULT NULL,
  `cbox_birchmountResidence` char(1) DEFAULT NULL,
  `cbox_oNeillHouse` char(1) DEFAULT NULL,
  `cbox_fortYork` char(1) DEFAULT NULL,
  `cbox_downsviewDells` char(1) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `functional_user_type`
--

DROP TABLE IF EXISTS `functional_user_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `functional_user_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groupMembers_tbl`
--

DROP TABLE IF EXISTS `groupMembers_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groupMembers_tbl` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `groupID` int(10) DEFAULT NULL,
  `provider_No` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `groups_tbl`
--

DROP TABLE IF EXISTS `groups_tbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups_tbl` (
  `groupID` int(10) NOT NULL AUTO_INCREMENT,
  `parentID` int(10) DEFAULT NULL,
  `groupDesc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gstControl`
--

DROP TABLE IF EXISTS `gstControl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gstControl` (
  `gstFlag` int(1) NOT NULL DEFAULT '0',
  `gstPercent` int(3) NOT NULL DEFAULT '0',
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hash_audit`
--

DROP TABLE IF EXISTS `hash_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hash_audit` (
  `pkid` int(10) NOT NULL AUTO_INCREMENT,
  `signature` varchar(255) NOT NULL,
  `id` int(10) DEFAULT '0',
  `type` char(3) NOT NULL,
  `algorithm` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`pkid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `health_safety`
--

DROP TABLE IF EXISTS `health_safety`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `health_safety` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `demographic_no` bigint(20) NOT NULL DEFAULT '0',
  `message` text,
  `username` varchar(128) DEFAULT NULL,
  `updatedate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `health_safety_demographic_no_index` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hl7TextInfo`
--

DROP TABLE IF EXISTS `hl7TextInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7TextInfo` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `lab_no` int(10) NOT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `health_no` varchar(12) DEFAULT NULL,
  `result_status` varchar(1) DEFAULT NULL,
  `final_result_count` int(10) DEFAULT NULL,
  `obr_date` varchar(20) DEFAULT NULL,
  `priority` varchar(1) DEFAULT NULL,
  `requesting_client` varchar(100) DEFAULT NULL,
  `discipline` varchar(100) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `report_status` varchar(1) NOT NULL,
  `accessionNum` varchar(20) DEFAULT NULL,
  `filler_order_num` varchar(50) DEFAULT NULL,
  `sending_facility` varchar(50) DEFAULT NULL,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `labno_index` (`lab_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hl7TextMessage`
--

DROP TABLE IF EXISTS `hl7TextMessage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hl7TextMessage` (
  `lab_id` int(10) NOT NULL AUTO_INCREMENT,
  `fileUploadCheck_id` int(10) NOT NULL,
  `message` longtext NOT NULL,
  `type` varchar(100) NOT NULL,
  `serviceName` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  `privateKey` text NOT NULL,
  PRIMARY KEY (`lab_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hsfo2_patient`
--

DROP TABLE IF EXISTS `hsfo2_patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hsfo2_patient` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `SiteCode` varchar(10) NOT NULL,
  `Patient_Id` varchar(255) NOT NULL,
  `FName` text NOT NULL,
  `LName` text NOT NULL,
  `BirthDate` date NOT NULL,
  `Sex` enum('m','f') NOT NULL,
  `PostalCode` varchar(7) NOT NULL,
  `Ethnic_White` tinyint(1) NOT NULL,
  `Ethnic_Black` tinyint(1) NOT NULL,
  `Ethnic_EIndian` tinyint(1) NOT NULL,
  `Ethnic_Pakistani` tinyint(1) NOT NULL,
  `Ethnic_SriLankan` tinyint(1) NOT NULL,
  `Ethnic_Bangladeshi` tinyint(1) NOT NULL,
  `Ethnic_Chinese` tinyint(1) NOT NULL,
  `Ethnic_Japanese` tinyint(1) NOT NULL,
  `Ethnic_Korean` tinyint(1) NOT NULL,
  `Ethnic_Hispanic` tinyint(1) NOT NULL,
  `Ethnic_FirstNation` tinyint(1) NOT NULL,
  `Ethnic_Other` tinyint(1) NOT NULL,
  `Ethnic_Refused` tinyint(1) NOT NULL,
  `Ethnic_Unknown` tinyint(1) NOT NULL,
  `PharmacyName` text,
  `PharmacyLocation` text,
  `sel_TimeAgoDx` enum('AtLeast1YrAgo','Under1YrAgo','NA','null') DEFAULT NULL,
  `EmrHCPId` text,
  `ConsentDate` date NOT NULL,
  `statusInHmp` enum('enrolled','notEnrolled') DEFAULT NULL,
  `dateOfHmpStatus` date DEFAULT NULL,
  `registrationId` varchar(64) DEFAULT NULL,
  `submitted` tinyint(1) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hsfo2_system`
--

DROP TABLE IF EXISTS `hsfo2_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hsfo2_system` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `LastUploadDate` date NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hsfo_recommit_schedule`
--

DROP TABLE IF EXISTS `hsfo_recommit_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hsfo_recommit_schedule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(2) DEFAULT NULL,
  `memo` text,
  `schedule_time` datetime DEFAULT NULL,
  `user_no` varchar(6) DEFAULT NULL,
  `check_flag` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ichppccode`
--

DROP TABLE IF EXISTS `ichppccode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ichppccode` (
  `ichppccode` varchar(10) DEFAULT NULL,
  `diagnostic_code` varchar(10) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `immunizations`
--

DROP TABLE IF EXISTS `immunizations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `immunizations` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `immunizations` text,
  `save_date` date NOT NULL DEFAULT '0001-01-01',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `demographic_no` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `incomingLabRules`
--

DROP TABLE IF EXISTS `incomingLabRules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `incomingLabRules` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) NOT NULL,
  `status` varchar(1) DEFAULT NULL,
  `frwdProvider_no` varchar(6) DEFAULT NULL,
  `archive` varchar(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `indivoDocs`
--

DROP TABLE IF EXISTS `indivoDocs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `indivoDocs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `oscarDocNo` int(10) NOT NULL,
  `indivoDocIdx` varchar(255) NOT NULL,
  `docType` varchar(20) NOT NULL,
  `dateSent` date NOT NULL,
  `update` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intake`
--

DROP TABLE IF EXISTS `intake`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intake` (
  `intake_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `intake_node_id` int(10) unsigned NOT NULL,
  `client_id` int(10) unsigned NOT NULL,
  `staff_id` varchar(6) NOT NULL,
  `creation_date` datetime NOT NULL,
  `intake_status` varchar(10) NOT NULL DEFAULT 'Signed',
  `intake_location` int(10) DEFAULT '0',
  `facility_id` int(11) DEFAULT NULL,
  `program_id` int(10) DEFAULT NULL,
  `lastUpdateDate` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  PRIMARY KEY (`intake_id`),
  KEY `IDX_intake_intake_node` (`intake_node_id`),
  KEY `IDX_intake_client_creation_date` (`client_id`,`creation_date`),
  CONSTRAINT `FK_intake_intake_node` FOREIGN KEY (`intake_node_id`) REFERENCES `intake_node` (`intake_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intake_answer`
--

DROP TABLE IF EXISTS `intake_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intake_answer` (
  `intake_answer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `intake_id` int(10) unsigned NOT NULL,
  `idx` int(10) NOT NULL DEFAULT '0',
  `intake_node_id` int(10) unsigned NOT NULL,
  `val` text NOT NULL,
  PRIMARY KEY (`intake_answer_id`),
  KEY `IDX_intake_answer_intake` (`intake_id`),
  KEY `IDX_intake_answer_intake_node` (`intake_node_id`),
  CONSTRAINT `FK_intake_answer_intake` FOREIGN KEY (`intake_id`) REFERENCES `intake` (`intake_id`),
  CONSTRAINT `FK_intake_answer_intake_node` FOREIGN KEY (`intake_node_id`) REFERENCES `intake_node` (`intake_node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intake_answer_element`
--

DROP TABLE IF EXISTS `intake_answer_element`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intake_answer_element` (
  `intake_answer_element_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `intake_node_template_id` int(10) unsigned NOT NULL,
  `intake_answer_validation_id` int(10) unsigned DEFAULT NULL,
  `dflt` tinyint(1) DEFAULT '0',
  `element` varchar(255) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`intake_answer_element_id`),
  KEY `IDX_intake_answer_element_intake_node_template` (`intake_node_template_id`),
  KEY `IDX_intake_answer_element_intake_answer_validation` (`intake_answer_validation_id`),
  CONSTRAINT `FK_intake_answer_element_intake_answer_validation` FOREIGN KEY (`intake_answer_validation_id`) REFERENCES `intake_answer_validation` (`intake_answer_validation_id`),
  CONSTRAINT `FK_intake_answer_element_intake_node_template` FOREIGN KEY (`intake_node_template_id`) REFERENCES `intake_node_template` (`intake_node_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intake_answer_validation`
--

DROP TABLE IF EXISTS `intake_answer_validation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intake_answer_validation` (
  `intake_answer_validation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`intake_answer_validation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intake_node`
--

DROP TABLE IF EXISTS `intake_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intake_node` (
  `intake_node_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `intake_node_template_id` int(10) unsigned NOT NULL,
  `intake_node_label_id` int(10) unsigned DEFAULT NULL,
  `pos` int(10) unsigned DEFAULT '0',
  `parent_intake_node_id` int(10) unsigned DEFAULT NULL,
  `mandatory` tinyint(1) NOT NULL DEFAULT '0',
  `repeating` tinyint(1) NOT NULL DEFAULT '0',
  `common_list` tinyint(1) NOT NULL DEFAULT '0',
  `eq_to_id` int(10) DEFAULT NULL,
  `form_version` int(10) unsigned DEFAULT NULL,
  `publish_date` date DEFAULT NULL,
  `publish_by` varchar(60) DEFAULT NULL,
  `form_type` int(11) DEFAULT '0',
  `question_id` varchar(255) DEFAULT NULL,
  `validations` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`intake_node_id`),
  KEY `IDX_intake_node_intake_node_template` (`intake_node_template_id`),
  KEY `IDX_intake_node_intake_node_label` (`intake_node_label_id`),
  KEY `IDX_intake_node_intake_node` (`parent_intake_node_id`),
  CONSTRAINT `FK_intake_node_intake_node` FOREIGN KEY (`parent_intake_node_id`) REFERENCES `intake_node` (`intake_node_id`),
  CONSTRAINT `FK_intake_node_intake_node_label` FOREIGN KEY (`intake_node_label_id`) REFERENCES `intake_node_label` (`intake_node_label_id`),
  CONSTRAINT `FK_intake_node_intake_node_template` FOREIGN KEY (`intake_node_template_id`) REFERENCES `intake_node_template` (`intake_node_template_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intake_node_js`
--

DROP TABLE IF EXISTS `intake_node_js`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intake_node_js` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intake_node_label`
--

DROP TABLE IF EXISTS `intake_node_label`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intake_node_label` (
  `intake_node_label_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lbl` text NOT NULL,
  PRIMARY KEY (`intake_node_label_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intake_node_template`
--

DROP TABLE IF EXISTS `intake_node_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intake_node_template` (
  `intake_node_template_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `remote_intake_node_template_id` int(10) unsigned DEFAULT NULL,
  `intake_node_type_id` int(10) unsigned NOT NULL,
  `intake_node_label_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`intake_node_template_id`),
  KEY `IDX_intake_node_template_intake_node_type` (`intake_node_type_id`),
  KEY `IDX_intake_node_template_intake_node_label` (`intake_node_label_id`),
  CONSTRAINT `FK_intake_node_template_intake_node_label` FOREIGN KEY (`intake_node_label_id`) REFERENCES `intake_node_label` (`intake_node_label_id`),
  CONSTRAINT `FK_intake_node_template_intake_node_type` FOREIGN KEY (`intake_node_type_id`) REFERENCES `intake_node_type` (`intake_node_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `intake_node_type`
--

DROP TABLE IF EXISTS `intake_node_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `intake_node_type` (
  `intake_node_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  PRIMARY KEY (`intake_node_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `issue`
--

DROP TABLE IF EXISTS `issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `issue` (
  `issue_id` int(10) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL,
  `description` varchar(255) NOT NULL,
  `role` varchar(100) NOT NULL,
  `update_date` datetime NOT NULL,
  `priority` char(10) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `sortOrderId` int(11) NOT NULL,
  PRIMARY KEY (`issue_id`),
  KEY `description_index` (`description`(20)),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `joint_admissions`
--

DROP TABLE IF EXISTS `joint_admissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `joint_admissions` (
  `id` bigint(11) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(11) NOT NULL DEFAULT '0',
  `type_id` bigint(3) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '0',
  `admission_date` datetime DEFAULT NULL,
  `head_client_id` bigint(11) NOT NULL DEFAULT '0',
  `archived` tinyint(1) DEFAULT '0',
  `archiving_provider_no` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`client_id`),
  KEY `head_client_id` (`head_client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labPatientPhysicianInfo`
--

DROP TABLE IF EXISTS `labPatientPhysicianInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labPatientPhysicianInfo` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `labReportInfo_id` int(10) DEFAULT NULL,
  `accession_num` varchar(64) DEFAULT NULL,
  `physician_account_num` varchar(30) DEFAULT NULL,
  `service_date` varchar(10) DEFAULT NULL,
  `patient_first_name` varchar(100) DEFAULT NULL,
  `patient_last_name` varchar(100) DEFAULT NULL,
  `patient_sex` char(1) DEFAULT NULL,
  `patient_health_num` varchar(20) DEFAULT NULL,
  `patient_dob` varchar(15) DEFAULT NULL,
  `lab_status` char(1) DEFAULT NULL,
  `doc_num` varchar(50) DEFAULT NULL,
  `doc_name` varchar(100) DEFAULT NULL,
  `doc_addr1` varchar(100) DEFAULT NULL,
  `doc_addr2` varchar(100) DEFAULT NULL,
  `doc_addr3` varchar(100) DEFAULT NULL,
  `doc_postal` varchar(15) DEFAULT NULL,
  `doc_route` varchar(50) DEFAULT NULL,
  `comment1` text,
  `comment2` text,
  `patient_phone` varchar(20) DEFAULT NULL,
  `doc_phone` varchar(20) DEFAULT NULL,
  `collection_date` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labReportInformation`
--

DROP TABLE IF EXISTS `labReportInformation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labReportInformation` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `location_id` varchar(255) DEFAULT NULL,
  `print_date` varchar(10) DEFAULT NULL,
  `print_time` varchar(10) DEFAULT NULL,
  `total_BType` varchar(5) DEFAULT NULL,
  `total_CType` varchar(5) DEFAULT NULL,
  `total_DType` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labRequestReportLink`
--

DROP TABLE IF EXISTS `labRequestReportLink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labRequestReportLink` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `request_table` varchar(60) DEFAULT NULL,
  `request_id` int(10) DEFAULT NULL,
  `request_date` datetime DEFAULT NULL,
  `report_table` varchar(60) NOT NULL,
  `report_id` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `labTestResults`
--

DROP TABLE IF EXISTS `labTestResults`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `labTestResults` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `labPatientPhysicianInfo_id` int(10) DEFAULT NULL,
  `line_type` char(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `notUsed1` varchar(255) DEFAULT NULL,
  `notUsed2` varchar(255) DEFAULT NULL,
  `test_name` varchar(255) DEFAULT NULL,
  `abn` char(1) DEFAULT NULL,
  `minimum` varchar(65) DEFAULT NULL,
  `maximum` varchar(65) DEFAULT NULL,
  `units` varchar(65) DEFAULT NULL,
  `result` varchar(65) DEFAULT NULL,
  `description` text,
  `location_id` varchar(255) DEFAULT NULL,
  `last` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log`
--

DROP TABLE IF EXISTS `log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `dateTime` datetime NOT NULL,
  `provider_no` varchar(10) DEFAULT NULL,
  `action` varchar(64) DEFAULT NULL,
  `content` varchar(80) DEFAULT NULL,
  `contentId` varchar(80) DEFAULT NULL,
  `ip` varchar(30) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT NULL,
  `data` text,
  `securityId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `datetime` (`dateTime`,`provider_no`),
  KEY `action` (`action`),
  KEY `content` (`content`),
  KEY `contentId` (`contentId`),
  KEY `demographic_no` (`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `log_letters`
--

DROP TABLE IF EXISTS `log_letters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `log_letters` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `date_time` datetime DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `log` text,
  `report_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `report_id` (`report_id`),
  KEY `provider_no` (`provider_no`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lst_admission_status`
--

DROP TABLE IF EXISTS `lst_admission_status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lst_admission_status` (
  `code` varchar(20) NOT NULL,
  `description` varchar(80) DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  `displayorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lst_discharge_reason`
--

DROP TABLE IF EXISTS `lst_discharge_reason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lst_discharge_reason` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `description` varchar(80) DEFAULT NULL,
  `needsecondary` tinyint(1) DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  `displayorder` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lst_field_category`
--

DROP TABLE IF EXISTS `lst_field_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lst_field_category` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `description` varchar(80) DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  `displayorder` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lst_gender`
--

DROP TABLE IF EXISTS `lst_gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lst_gender` (
  `code` char(1) NOT NULL,
  `description` varchar(80) DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  `displayorder` int(10) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lst_organization`
--

DROP TABLE IF EXISTS `lst_organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lst_organization` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `description` varchar(80) DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  `displayorder` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lst_orgcd`
--

DROP TABLE IF EXISTS `lst_orgcd`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lst_orgcd` (
  `code` varchar(8) NOT NULL,
  `description` varchar(240) DEFAULT NULL,
  `activeyn` varchar(1) DEFAULT NULL,
  `orderbyindex` int(11) DEFAULT NULL,
  `codetree` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`code`),
  KEY `IDX_ORGCD_CODE` (`codetree`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lst_program_type`
--

DROP TABLE IF EXISTS `lst_program_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lst_program_type` (
  `code` varchar(20) NOT NULL,
  `description` varchar(80) DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  `displayorder` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lst_sector`
--

DROP TABLE IF EXISTS `lst_sector`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lst_sector` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `description` varchar(80) DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  `displayorder` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lst_service_restriction`
--

DROP TABLE IF EXISTS `lst_service_restriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lst_service_restriction` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `description` varchar(80) DEFAULT NULL,
  `isactive` tinyint(1) DEFAULT NULL,
  `displayorder` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsMSH`
--

DROP TABLE IF EXISTS `mdsMSH`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsMSH` (
  `segmentID` int(10) NOT NULL AUTO_INCREMENT,
  `sendingApp` char(180) DEFAULT NULL,
  `dateTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `type` char(7) DEFAULT NULL,
  `messageConID` char(20) DEFAULT NULL,
  `processingID` char(3) DEFAULT NULL,
  `versionID` char(8) DEFAULT NULL,
  `acceptAckType` char(2) DEFAULT NULL,
  `appAckType` char(2) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT '0',
  PRIMARY KEY (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsNTE`
--

DROP TABLE IF EXISTS `mdsNTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsNTE` (
  `segmentID` int(10) DEFAULT NULL,
  `sourceOfComment` varchar(8) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `associatedOBX` int(10) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsOBR`
--

DROP TABLE IF EXISTS `mdsOBR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsOBR` (
  `segmentID` int(10) DEFAULT NULL,
  `obrID` int(10) DEFAULT NULL,
  `placerOrderNo` char(75) DEFAULT NULL,
  `universalServiceID` char(200) DEFAULT NULL,
  `observationDateTime` char(26) DEFAULT NULL,
  `specimenRecDateTime` char(26) DEFAULT NULL,
  `fillerFieldOne` char(60) DEFAULT NULL,
  `quantityTiming` char(200) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsOBX`
--

DROP TABLE IF EXISTS `mdsOBX`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsOBX` (
  `segmentID` int(10) DEFAULT NULL,
  `obxID` int(10) DEFAULT '0',
  `valueType` char(2) DEFAULT NULL,
  `observationIden` varchar(80) DEFAULT NULL,
  `observationSubID` varchar(255) DEFAULT NULL,
  `observationValue` varchar(255) DEFAULT NULL,
  `abnormalFlags` varchar(5) DEFAULT NULL,
  `observationResultStatus` char(2) DEFAULT NULL,
  `producersID` varchar(60) DEFAULT NULL,
  `associatedOBR` int(10) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsPID`
--

DROP TABLE IF EXISTS `mdsPID`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsPID` (
  `segmentID` int(10) DEFAULT NULL,
  `intPatientID` char(16) DEFAULT NULL,
  `altPatientID` char(15) DEFAULT NULL,
  `patientName` char(48) DEFAULT NULL,
  `dOB` char(26) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `homePhone` char(40) DEFAULT NULL,
  `healthNumber` char(16) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsPV1`
--

DROP TABLE IF EXISTS `mdsPV1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsPV1` (
  `segmentID` int(10) DEFAULT NULL,
  `patientClass` char(1) DEFAULT NULL,
  `patientLocation` char(80) DEFAULT NULL,
  `refDoctor` char(60) DEFAULT NULL,
  `conDoctor` char(60) DEFAULT NULL,
  `admDoctor` char(60) DEFAULT NULL,
  `vNumber` char(20) DEFAULT NULL,
  `accStatus` char(2) DEFAULT NULL,
  `admDateTime` char(26) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsZCL`
--

DROP TABLE IF EXISTS `mdsZCL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsZCL` (
  `segmentID` int(10) DEFAULT NULL,
  `setID` char(4) DEFAULT NULL,
  `consultDoc` char(60) DEFAULT NULL,
  `clientAddress` char(106) DEFAULT NULL,
  `route` char(6) DEFAULT NULL,
  `stop` char(6) DEFAULT NULL,
  `area` char(2) DEFAULT NULL,
  `reportSet` char(1) DEFAULT NULL,
  `clientType` char(5) DEFAULT NULL,
  `clientModemPool` char(2) DEFAULT NULL,
  `clientFaxNumber` char(40) DEFAULT NULL,
  `clientBakFax` char(40) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsZCT`
--

DROP TABLE IF EXISTS `mdsZCT`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsZCT` (
  `segmentID` int(10) DEFAULT NULL,
  `barCodeIdentifier` char(14) DEFAULT NULL,
  `placerGroupNo` char(14) DEFAULT NULL,
  `observationDateTime` char(26) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsZFR`
--

DROP TABLE IF EXISTS `mdsZFR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsZFR` (
  `segmentID` int(10) DEFAULT NULL,
  `reportForm` char(1) DEFAULT NULL,
  `reportFormStatus` char(1) DEFAULT NULL,
  `testingLab` varchar(5) DEFAULT NULL,
  `medicalDirector` varchar(255) DEFAULT NULL,
  `editFlag` varchar(255) DEFAULT NULL,
  `abnormalFlag` varchar(255) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsZLB`
--

DROP TABLE IF EXISTS `mdsZLB`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsZLB` (
  `segmentID` int(10) DEFAULT NULL,
  `labID` varchar(5) DEFAULT NULL,
  `labIDVersion` varchar(255) DEFAULT NULL,
  `labAddress` varchar(100) DEFAULT NULL,
  `primaryLab` varchar(5) DEFAULT NULL,
  `primaryLabVersion` varchar(5) DEFAULT NULL,
  `MDSLU` varchar(5) DEFAULT NULL,
  `MDSLV` varchar(5) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsZMC`
--

DROP TABLE IF EXISTS `mdsZMC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsZMC` (
  `segmentID` int(10) DEFAULT NULL,
  `setID` varchar(10) DEFAULT NULL,
  `messageCodeIdentifier` varchar(10) DEFAULT NULL,
  `messageCodeVersion` varchar(255) DEFAULT NULL,
  `noMessageCodeDescLines` varchar(30) DEFAULT NULL,
  `sigFlag` varchar(5) DEFAULT NULL,
  `messageCodeDesc` varchar(255) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsZMN`
--

DROP TABLE IF EXISTS `mdsZMN`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsZMN` (
  `segmentID` int(10) DEFAULT NULL,
  `resultMnemonic` varchar(20) DEFAULT NULL,
  `resultMnemonicVersion` varchar(255) DEFAULT NULL,
  `reportName` varchar(255) DEFAULT NULL,
  `units` varchar(60) DEFAULT NULL,
  `cumulativeSequence` varchar(255) DEFAULT NULL,
  `referenceRange` varchar(255) DEFAULT NULL,
  `resultCode` varchar(20) DEFAULT NULL,
  `reportForm` varchar(255) DEFAULT NULL,
  `reportGroup` varchar(10) DEFAULT NULL,
  `reportGroupVersion` varchar(255) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mdsZRG`
--

DROP TABLE IF EXISTS `mdsZRG`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mdsZRG` (
  `segmentID` int(10) DEFAULT NULL,
  `reportSequence` varchar(255) DEFAULT NULL,
  `reportGroupID` varchar(10) DEFAULT NULL,
  `reportGroupVersion` varchar(10) DEFAULT NULL,
  `reportFlags` varchar(255) DEFAULT NULL,
  `reportGroupDesc` varchar(30) DEFAULT NULL,
  `MDSIndex` varchar(255) DEFAULT NULL,
  `reportGroupHeading` varchar(255) DEFAULT NULL,
  KEY `segmentID` (`segmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurementCSSLocation`
--

DROP TABLE IF EXISTS `measurementCSSLocation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurementCSSLocation` (
  `cssID` int(9) NOT NULL AUTO_INCREMENT,
  `location` varchar(255) NOT NULL,
  PRIMARY KEY (`cssID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurementGroup`
--

DROP TABLE IF EXISTS `measurementGroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurementGroup` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `typeDisplayName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurementGroupStyle`
--

DROP TABLE IF EXISTS `measurementGroupStyle`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurementGroupStyle` (
  `groupID` int(9) NOT NULL AUTO_INCREMENT,
  `groupName` varchar(100) NOT NULL,
  `cssID` int(9) NOT NULL,
  PRIMARY KEY (`groupID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurementMap`
--

DROP TABLE IF EXISTS `measurementMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurementMap` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `loinc_code` varchar(20) DEFAULT NULL,
  `ident_code` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `lab_type` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ident_code` (`ident_code`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurementType`
--

DROP TABLE IF EXISTS `measurementType`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurementType` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(4) NOT NULL,
  `typeDisplayName` varchar(255) NOT NULL,
  `typeDescription` varchar(255) NOT NULL,
  `measuringInstruction` varchar(255) NOT NULL,
  `validation` varchar(100) NOT NULL,
  `createDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `type` (`type`),
  KEY `measuringInstruction` (`measuringInstruction`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurementTypeDeleted`
--

DROP TABLE IF EXISTS `measurementTypeDeleted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurementTypeDeleted` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(4) NOT NULL,
  `typeDisplayName` varchar(20) NOT NULL,
  `typeDescription` varchar(255) NOT NULL,
  `measuringInstruction` varchar(255) NOT NULL,
  `validation` varchar(100) NOT NULL,
  `dateDeleted` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurements`
--

DROP TABLE IF EXISTS `measurements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `demographicNo` int(10) NOT NULL DEFAULT '0',
  `providerNo` varchar(6) NOT NULL DEFAULT '',
  `dataField` varchar(255) NOT NULL,
  `measuringInstruction` varchar(255) NOT NULL,
  `comments` varchar(255) NOT NULL,
  `dateObserved` datetime NOT NULL,
  `dateEntered` datetime NOT NULL,
  `appointmentNo` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `measuringInstruction` (`measuringInstruction`),
  KEY `demographicNo` (`demographicNo`),
  KEY `measurements_appointmentNo_index` (`appointmentNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurementsDeleted`
--

DROP TABLE IF EXISTS `measurementsDeleted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurementsDeleted` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(4) NOT NULL,
  `demographicNo` int(10) NOT NULL DEFAULT '0',
  `providerNo` varchar(6) NOT NULL DEFAULT '',
  `dataField` varchar(10) NOT NULL,
  `measuringInstruction` varchar(255) NOT NULL,
  `comments` varchar(255) NOT NULL,
  `dateObserved` datetime NOT NULL,
  `dateEntered` datetime NOT NULL,
  `dateDeleted` datetime NOT NULL,
  `originalId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `measurementsExt`
--

DROP TABLE IF EXISTS `measurementsExt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `measurementsExt` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `measurement_id` int(10) NOT NULL,
  `keyval` varchar(20) NOT NULL,
  `val` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `measurement_id` (`measurement_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messagelisttbl`
--

DROP TABLE IF EXISTS `messagelisttbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messagelisttbl` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `message` mediumint(9) DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `status` varchar(10) DEFAULT NULL,
  `remoteLocation` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `message` (`message`),
  KEY `provider_no` (`provider_no`),
  KEY `status` (`status`),
  KEY `remoteLocation` (`remoteLocation`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messagetbl`
--

DROP TABLE IF EXISTS `messagetbl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messagetbl` (
  `messageid` mediumint(9) NOT NULL AUTO_INCREMENT,
  `thedate` date DEFAULT NULL,
  `theime` time DEFAULT NULL,
  `themessage` text,
  `thesubject` varchar(128) DEFAULT NULL,
  `sentby` varchar(62) DEFAULT NULL,
  `sentto` varchar(255) DEFAULT NULL,
  `sentbyNo` varchar(6) DEFAULT NULL,
  `sentByLocation` int(10) DEFAULT NULL,
  `attachment` text,
  `pdfattachment` blob,
  `actionstatus` char(2) DEFAULT NULL,
  PRIMARY KEY (`messageid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `msgDemoMap`
--

DROP TABLE IF EXISTS `msgDemoMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `msgDemoMap` (
  `messageID` mediumint(9) NOT NULL DEFAULT '0',
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`messageID`,`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mygroup`
--

DROP TABLE IF EXISTS `mygroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mygroup` (
  `mygroup_no` varchar(10) NOT NULL DEFAULT '',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `last_name` varchar(30) NOT NULL DEFAULT '',
  `first_name` varchar(30) NOT NULL DEFAULT '',
  `vieworder` char(2) DEFAULT NULL,
  PRIMARY KEY (`mygroup_no`,`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `officeCommunication`
--

DROP TABLE IF EXISTS `officeCommunication`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `officeCommunication` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `appointment_no` int(11) DEFAULT NULL,
  `demographic_no` int(11) DEFAULT NULL,
  `note` mediumtext,
  `signed` tinyint(1) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `officeCommunication_appointment_no_index` (`appointment_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oncall_questionnaire`
--

DROP TABLE IF EXISTS `oncall_questionnaire`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oncall_questionnaire` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `providerNo` varchar(40) NOT NULL,
  `type` varchar(250) NOT NULL,
  `health_type` varchar(50) NOT NULL,
  `nurse_involved` varchar(50) NOT NULL,
  `course_of_action` varchar(50) NOT NULL,
  `physician_consultation_reqd` varchar(50) NOT NULL,
  `call_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oscarKeys`
--

DROP TABLE IF EXISTS `oscarKeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oscarKeys` (
  `name` varchar(100) NOT NULL,
  `pubKey` text,
  `privKey` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oscar_annotations`
--

DROP TABLE IF EXISTS `oscar_annotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oscar_annotations` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `table_id` int(10) DEFAULT NULL,
  `table_name` int(10) DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `observation_date` datetime DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  `note` text,
  `uuid` char(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `oscarcommlocations`
--

DROP TABLE IF EXISTS `oscarcommlocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `oscarcommlocations` (
  `locationId` int(10) NOT NULL DEFAULT '0',
  `locationDesc` varchar(50) NOT NULL DEFAULT '',
  `locationAuth` varchar(30) DEFAULT NULL,
  `current1` tinyint(1) NOT NULL DEFAULT '0',
  `addressBook` text,
  `remoteServerURL` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`locationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `other_id`
--

DROP TABLE IF EXISTS `other_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `other_id` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` int(11) NOT NULL,
  `table_id` varchar(30) NOT NULL,
  `other_key` varchar(30) NOT NULL,
  `other_id` varchar(30) NOT NULL,
  `deleted` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partial_date`
--

DROP TABLE IF EXISTS `partial_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `partial_date` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` int(11) DEFAULT NULL,
  `table_id` int(11) DEFAULT NULL,
  `field_name` int(11) DEFAULT NULL,
  `format` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `patientLabRouting`
--

DROP TABLE IF EXISTS `patientLabRouting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patientLabRouting` (
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `lab_no` int(10) NOT NULL DEFAULT '0',
  `lab_type` char(3) NOT NULL DEFAULT 'MDS',
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `demographic` (`demographic_no`),
  KEY `lab_type_index` (`lab_type`),
  KEY `lab_no_index` (`lab_no`),
  KEY `all_index` (`lab_type`,`lab_no`,`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pharmacyInfo`
--

DROP TABLE IF EXISTS `pharmacyInfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pharmacyInfo` (
  `recordID` int(10) NOT NULL AUTO_INCREMENT,
  `ID` int(5) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` text,
  `city` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `postalCode` varchar(20) DEFAULT NULL,
  `phone1` varchar(20) DEFAULT NULL,
  `phone2` varchar(20) DEFAULT NULL,
  `fax` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `serviceLocationIdentifier` varchar(255) DEFAULT NULL,
  `notes` text,
  `addDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` char(1) DEFAULT '1',
  PRIMARY KEY (`recordID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pmm_log`
--

DROP TABLE IF EXISTS `pmm_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pmm_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(255) DEFAULT NULL,
  `dateTime` datetime DEFAULT NULL,
  `action` varchar(20) DEFAULT NULL,
  `contentId` varchar(80) DEFAULT NULL,
  `content` varchar(80) NOT NULL,
  `ip` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prescribe`
--

DROP TABLE IF EXISTS `prescribe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prescribe` (
  `prescribe_no` int(12) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `prescribe_date` date NOT NULL DEFAULT '0001-01-01',
  `prescribe_time` time NOT NULL DEFAULT '00:00:00',
  `content` text,
  PRIMARY KEY (`prescribe_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `prescription`
--

DROP TABLE IF EXISTS `prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `prescription` (
  `script_no` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT NULL,
  `date_prescribed` date DEFAULT NULL,
  `date_printed` date DEFAULT NULL,
  `dates_reprinted` text,
  `textView` text,
  `rx_comments` text,
  `lastUpdateDate` datetime NOT NULL,
  PRIMARY KEY (`script_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preventions`
--

DROP TABLE IF EXISTS `preventions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preventions` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `creation_date` datetime DEFAULT NULL,
  `prevention_date` date DEFAULT NULL,
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `provider_name` varchar(255) DEFAULT NULL,
  `prevention_type` varchar(20) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  `refused` char(1) DEFAULT '0',
  `next_date` date DEFAULT NULL,
  `never` char(1) DEFAULT '0',
  `creator` int(10) DEFAULT NULL,
  `lastUpdateDate` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `preventions_demographic_no` (`demographic_no`),
  KEY `preventions_provider_no` (`provider_no`),
  KEY `preventions_prevention_type` (`prevention_type`(10)),
  KEY `preventions_refused` (`refused`),
  KEY `preventions_deleted` (`deleted`),
  KEY `preventions_never` (`never`),
  KEY `preventions_creation_date` (`creation_date`),
  KEY `preventions_next_date` (`next_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `preventionsExt`
--

DROP TABLE IF EXISTS `preventionsExt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `preventionsExt` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `prevention_id` int(10) DEFAULT NULL,
  `keyval` varchar(20) DEFAULT NULL,
  `val` text,
  PRIMARY KEY (`id`),
  KEY `preventionsExt_prevention_id` (`prevention_id`),
  KEY `preventionsExt_keyval` (`keyval`(10))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `professionalSpecialists`
--

DROP TABLE IF EXISTS `professionalSpecialists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `professionalSpecialists` (
  `specId` int(10) NOT NULL AUTO_INCREMENT,
  `fName` varchar(32) DEFAULT NULL,
  `lName` varchar(32) DEFAULT NULL,
  `proLetters` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `fax` varchar(30) DEFAULT NULL,
  `website` varchar(128) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `specType` varchar(128) DEFAULT NULL,
  `eDataUrl` varchar(255) DEFAULT NULL,
  `eDataOscarKey` varchar(1024) DEFAULT NULL,
  `eDataServiceKey` varchar(1024) DEFAULT NULL,
  `eDataServiceName` varchar(255) DEFAULT NULL,
  `lastUpdated` datetime NOT NULL,
  `annotation` text,
  `referralNo` varchar(6) DEFAULT NULL,
  `eReferralUrl` varchar(255) DEFAULT NULL,
  `eReferralOscarKey` varchar(1024) DEFAULT NULL,
  `eReferralServiceKey` varchar(1024) DEFAULT NULL,
  `eReferralServiceName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`specId`),
  KEY `professionalSpecialists_referralNo_index` (`referralNo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program`
--

DROP TABLE IF EXISTS `program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `facilityId` int(11) NOT NULL,
  `intakeProgram` int(11) DEFAULT NULL,
  `name` varchar(70) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `functionalCentreId` varchar(64) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `fax` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `emergencyNumber` varchar(255) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  `location` varchar(70) DEFAULT NULL,
  `maxAllowed` int(11) NOT NULL,
  `holdingTank` tinyint(1) DEFAULT NULL,
  `allowBatchAdmission` tinyint(1) DEFAULT NULL,
  `allowBatchDischarge` tinyint(1) DEFAULT NULL,
  `hic` tinyint(1) DEFAULT NULL,
  `programStatus` varchar(8) NOT NULL,
  `bedProgramLinkId` int(11) DEFAULT NULL,
  `manOrWoman` varchar(6) DEFAULT NULL,
  `transgender` tinyint(1) NOT NULL,
  `firstNation` tinyint(1) NOT NULL,
  `bedProgramAffiliated` tinyint(1) NOT NULL,
  `alcohol` tinyint(1) NOT NULL,
  `abstinenceSupport` varchar(20) DEFAULT NULL,
  `physicalHealth` tinyint(1) NOT NULL,
  `mentalHealth` tinyint(1) NOT NULL,
  `housing` tinyint(1) NOT NULL,
  `exclusiveView` varchar(20) NOT NULL,
  `maximumServiceRestrictionDays` int(11) DEFAULT NULL,
  `defaultServiceRestrictionDays` int(11) DEFAULT NULL,
  `ageMin` int(11) NOT NULL,
  `ageMax` int(11) NOT NULL,
  `userDefined` int(1) DEFAULT NULL,
  `shelter_id` int(11) DEFAULT NULL,
  `facility_id` int(10) DEFAULT NULL,
  `capacity_funding` int(10) DEFAULT NULL,
  `capacity_space` int(10) DEFAULT NULL,
  `lastUpdateUser` varchar(6) DEFAULT NULL,
  `lastUpdateDate` date DEFAULT NULL,
  `enableEncounterTime` tinyint(1) DEFAULT NULL,
  `enableEncounterTransportationTime` tinyint(1) DEFAULT NULL,
  `siteSpecificField` varchar(255) DEFAULT NULL,
  `emailNotificationAddressesCsv` varchar(255) DEFAULT NULL,
  `lastReferralNotification` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `facilityId` (`facilityId`),
  CONSTRAINT `program_ibfk_1` FOREIGN KEY (`facilityId`) REFERENCES `Facility` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `programSignature`
--

DROP TABLE IF EXISTS `programSignature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `programSignature` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `programId` int(10) NOT NULL DEFAULT '0',
  `programName` varchar(70) NOT NULL DEFAULT '',
  `providerId` varchar(6) NOT NULL DEFAULT '0',
  `providerName` varchar(60) NOT NULL DEFAULT '',
  `caisiRoleName` varchar(255) NOT NULL DEFAULT '',
  `updateDate` datetime DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_access`
--

DROP TABLE IF EXISTS `program_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_access` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `program_id` bigint(20) DEFAULT NULL,
  `access_type_id` varchar(255) DEFAULT NULL,
  `all_roles` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKC385F77F9BCAF076` (`access_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_access_roles`
--

DROP TABLE IF EXISTS `program_access_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_access_roles` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `role_id` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`role_id`),
  KEY `FK55BF0DFDBC1003F0` (`id`),
  KEY `FK55BF0DFD60605436` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_client_restriction`
--

DROP TABLE IF EXISTS `program_client_restriction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_client_restriction` (
  `id` bigint(22) NOT NULL AUTO_INCREMENT,
  `program_id` int(10) NOT NULL,
  `demographic_no` int(10) NOT NULL,
  `provider_no` varchar(6) NOT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `early_termination_provider` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_pcr_program` (`program_id`),
  KEY `FK_pcr_provider` (`provider_no`),
  KEY `FK_pcr_demographic` (`demographic_no`),
  CONSTRAINT `FK_pcr_demographic` FOREIGN KEY (`demographic_no`) REFERENCES `demographic` (`demographic_no`),
  CONSTRAINT `FK_pcr_program` FOREIGN KEY (`program_id`) REFERENCES `program` (`id`),
  CONSTRAINT `FK_pcr_provider` FOREIGN KEY (`provider_no`) REFERENCES `provider` (`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_clientstatus`
--

DROP TABLE IF EXISTS `program_clientstatus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_clientstatus` (
  `clientstatus_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `program_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`clientstatus_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_functional_user`
--

DROP TABLE IF EXISTS `program_functional_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_functional_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `program_id` bigint(20) DEFAULT NULL,
  `user_type_id` bigint(20) DEFAULT NULL,
  `provider_no` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK13B70CCFE0B12E7` (`user_type_id`),
  KEY `FK13B70CCE6DF0AD3` (`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_provider`
--

DROP TABLE IF EXISTS `program_provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_provider` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `program_id` bigint(20) DEFAULT NULL,
  `provider_no` varchar(6) NOT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `team_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK3EFA2D4C60605436` (`role_id`),
  KEY `FK3EFA2D4CE6DF0AD3` (`provider_no`),
  KEY `FK3EFA2D4CDAA8624B` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_provider_team`
--

DROP TABLE IF EXISTS `program_provider_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_provider_team` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `elt` bigint(20) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`,`elt`),
  KEY `FK5E7B3D703D01BC3D` (`id`),
  KEY `FK5E7B3D703073B4BB` (`elt`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_queue`
--

DROP TABLE IF EXISTS `program_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_queue` (
  `queue_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) NOT NULL DEFAULT '0',
  `referral_date` datetime DEFAULT NULL,
  `provider_no` bigint(20) NOT NULL DEFAULT '0',
  `notes` varchar(255) DEFAULT NULL,
  `program_id` bigint(20) NOT NULL DEFAULT '0',
  `status` varchar(30) DEFAULT NULL,
  `referral_id` bigint(20) DEFAULT NULL,
  `temporary_admission_flag` tinyint(1) DEFAULT NULL,
  `present_problems` varchar(255) DEFAULT NULL,
  `intake_id` int(10) DEFAULT NULL,
  PRIMARY KEY (`queue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `program_team`
--

DROP TABLE IF EXISTS `program_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `program_team` (
  `team_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `program_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `property`
--

DROP TABLE IF EXISTS `property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `property` (
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` varchar(255) DEFAULT NULL,
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `property_provider_no_index` (`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider` (
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `last_name` varchar(30) NOT NULL DEFAULT '',
  `first_name` varchar(30) NOT NULL DEFAULT '',
  `provider_type` varchar(15) NOT NULL DEFAULT '',
  `specialty` varchar(40) NOT NULL DEFAULT '',
  `team` varchar(20) DEFAULT '',
  `sex` char(1) NOT NULL DEFAULT '',
  `dob` date DEFAULT NULL,
  `address` varchar(40) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `work_phone` varchar(50) DEFAULT NULL,
  `ohip_no` varchar(20) DEFAULT NULL,
  `rma_no` varchar(20) DEFAULT NULL,
  `billing_no` varchar(20) DEFAULT NULL,
  `hso_no` varchar(10) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `comments` text,
  `provider_activity` char(3) DEFAULT NULL,
  `practitionerNo` varchar(20) DEFAULT NULL,
  `init` varchar(10) DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `lastUpdateUser` varchar(6) DEFAULT NULL,
  `lastUpdateDate` date DEFAULT NULL,
  `signed_confidentiality` datetime DEFAULT NULL,
  PRIMARY KEY (`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `providerArchive`
--

DROP TABLE IF EXISTS `providerArchive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providerArchive` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) DEFAULT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `first_name` varchar(30) DEFAULT NULL,
  `provider_type` varchar(15) DEFAULT NULL,
  `specialty` varchar(40) DEFAULT NULL,
  `team` varchar(20) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(40) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `work_phone` varchar(50) DEFAULT NULL,
  `ohip_no` varchar(20) DEFAULT NULL,
  `rma_no` varchar(20) DEFAULT NULL,
  `billing_no` varchar(20) DEFAULT NULL,
  `hso_no` varchar(10) DEFAULT NULL,
  `status` char(1) DEFAULT NULL,
  `comments` text,
  `provider_activity` char(3) DEFAULT NULL,
  `practitionerNo` varchar(20) DEFAULT NULL,
  `init` varchar(10) DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  `title` varchar(20) DEFAULT NULL,
  `lastUpdateUser` varchar(6) DEFAULT NULL,
  `lastUpdateDate` date DEFAULT NULL,
  `signed_confidentiality` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `providerExt`
--

DROP TABLE IF EXISTS `providerExt`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providerExt` (
  `provider_no` varchar(6) DEFAULT NULL,
  `signature` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `providerLabRouting`
--

DROP TABLE IF EXISTS `providerLabRouting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providerLabRouting` (
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `lab_no` int(10) NOT NULL DEFAULT '0',
  `status` char(1) DEFAULT '',
  `comment` varchar(255) DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `lab_type` char(3) DEFAULT 'MDS',
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  KEY `labno_index` (`lab_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `providerLabRoutingFavorites`
--

DROP TABLE IF EXISTS `providerLabRoutingFavorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providerLabRoutingFavorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) DEFAULT NULL,
  `route_to_provider_no` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `provider_no` (`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `providerSpireIdMap`
--

DROP TABLE IF EXISTS `providerSpireIdMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providerSpireIdMap` (
  `spire_id` int(10) NOT NULL,
  `ohip_no` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`spire_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provider_default_program`
--

DROP TABLE IF EXISTS `provider_default_program`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_default_program` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `program_id` int(10) NOT NULL DEFAULT '0',
  `signnote` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `provider_default_program_provider_no_index` (`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provider_facility`
--

DROP TABLE IF EXISTS `provider_facility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider_facility` (
  `provider_no` varchar(6) NOT NULL,
  `facility_id` int(11) NOT NULL,
  UNIQUE KEY `provider_no` (`provider_no`,`facility_id`),
  KEY `facility_id` (`facility_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `providerbillcenter`
--

DROP TABLE IF EXISTS `providerbillcenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providerbillcenter` (
  `provider_no` varchar(6) NOT NULL DEFAULT '""',
  `billcenter_code` char(2) NOT NULL DEFAULT '""',
  PRIMARY KEY (`provider_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `providersite`
--

DROP TABLE IF EXISTS `providersite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providersite` (
  `provider_no` varchar(6) NOT NULL,
  `site_id` int(11) NOT NULL,
  PRIMARY KEY (`provider_no`,`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `publicKeys`
--

DROP TABLE IF EXISTS `publicKeys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `publicKeys` (
  `service` varchar(100) NOT NULL,
  `type` varchar(100) NOT NULL,
  `pubKey` text NOT NULL,
  `privateKey` text NOT NULL,
  `matchingProfessionalSpecialistId` int(11) DEFAULT NULL,
  PRIMARY KEY (`service`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue`
--

DROP TABLE IF EXISTS `queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `queue_document_link`
--

DROP TABLE IF EXISTS `queue_document_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `queue_document_link` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `queue_id` int(10) NOT NULL,
  `document_id` int(10) NOT NULL,
  `status` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quickList`
--

DROP TABLE IF EXISTS `quickList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quickList` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `quickListName` varchar(255) NOT NULL,
  `createdByProvider` int(10) DEFAULT NULL,
  `dxResearchCode` varchar(10) DEFAULT NULL,
  `codingSystem` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `quickListUser`
--

DROP TABLE IF EXISTS `quickListUser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quickListUser` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `providerNo` int(10) NOT NULL,
  `quickListName` varchar(10) NOT NULL,
  `lastUsed` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `radetail`
--

DROP TABLE IF EXISTS `radetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `radetail` (
  `radetail_no` int(6) NOT NULL AUTO_INCREMENT,
  `raheader_no` int(6) NOT NULL DEFAULT '0',
  `providerohip_no` varchar(12) NOT NULL DEFAULT '',
  `billing_no` int(6) NOT NULL DEFAULT '0',
  `provider_group_billing_no` varchar(4) DEFAULT NULL,
  `service_code` varchar(5) NOT NULL DEFAULT '',
  `service_count` char(2) NOT NULL DEFAULT '',
  `hin` varchar(12) NOT NULL DEFAULT '',
  `amountclaim` varchar(8) NOT NULL DEFAULT '',
  `amountpay` varchar(8) NOT NULL DEFAULT '',
  `service_date` varchar(12) NOT NULL DEFAULT '',
  `error_code` char(2) NOT NULL DEFAULT '',
  `billtype` char(3) NOT NULL DEFAULT '',
  `claim_no` varchar(12) NOT NULL DEFAULT '',
  PRIMARY KEY (`radetail_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `raheader`
--

DROP TABLE IF EXISTS `raheader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `raheader` (
  `raheader_no` int(6) NOT NULL AUTO_INCREMENT,
  `filename` varchar(12) NOT NULL DEFAULT '',
  `paymentdate` varchar(8) NOT NULL DEFAULT '',
  `payable` varchar(30) NOT NULL DEFAULT '',
  `totalamount` varchar(10) NOT NULL DEFAULT '',
  `records` varchar(5) NOT NULL DEFAULT '',
  `claims` varchar(5) NOT NULL DEFAULT '',
  `status` char(1) NOT NULL DEFAULT '',
  `readdate` varchar(12) NOT NULL DEFAULT '',
  `content` text,
  PRIMARY KEY (`raheader_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recycle_bin`
--

DROP TABLE IF EXISTS `recycle_bin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recycle_bin` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `table_name` varchar(30) NOT NULL DEFAULT '',
  `table_content` text,
  `updatedatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recyclebin`
--

DROP TABLE IF EXISTS `recyclebin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recyclebin` (
  `recyclebin_no` int(12) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) DEFAULT NULL,
  `updatedatetime` datetime DEFAULT NULL,
  `table_name` varchar(30) DEFAULT NULL,
  `keyword` varchar(50) DEFAULT NULL,
  `table_content` text,
  PRIMARY KEY (`recyclebin_no`),
  KEY `keyword` (`keyword`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rehabStudy2004`
--

DROP TABLE IF EXISTS `rehabStudy2004`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rehabStudy2004` (
  `studyID` int(10) NOT NULL,
  `demographic_no` int(10) NOT NULL,
  PRIMARY KEY (`studyID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `relationships`
--

DROP TABLE IF EXISTS `relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `relationships` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `facility_id` int(11) DEFAULT NULL,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `relation_demographic_no` int(10) NOT NULL DEFAULT '0',
  `relation` varchar(20) DEFAULT NULL,
  `creation_date` datetime DEFAULT NULL,
  `creator` varchar(6) NOT NULL DEFAULT '',
  `sub_decision_maker` char(1) DEFAULT '0',
  `emergency_contact` char(1) DEFAULT '0',
  `notes` text,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remoteAttachments`
--

DROP TABLE IF EXISTS `remoteAttachments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remoteAttachments` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `messageid` mediumint(9) DEFAULT NULL,
  `savedBy` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report`
--

DROP TABLE IF EXISTS `report`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report` (
  `reportno` bigint(10) NOT NULL AUTO_INCREMENT,
  `title` varchar(80) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `orgapplicable` tinyint(1) DEFAULT '0',
  `reporttype` char(3) DEFAULT NULL,
  `dateoption` char(1) DEFAULT NULL,
  `datepart` char(1) DEFAULT NULL,
  `reportgroup` int(10) DEFAULT '0',
  `notes` text,
  `tablename` varchar(30) DEFAULT NULL,
  `updatedby` varchar(20) DEFAULT NULL,
  `updateddate` datetime DEFAULT NULL,
  `sptorun` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`reportno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportByExamples`
--

DROP TABLE IF EXISTS `reportByExamples`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportByExamples` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `providerNo` varchar(6) NOT NULL,
  `query` blob NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportByExamplesFavorite`
--

DROP TABLE IF EXISTS `reportByExamplesFavorite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportByExamplesFavorite` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `providerNo` varchar(6) NOT NULL,
  `query` blob NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportConfig`
--

DROP TABLE IF EXISTS `reportConfig`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportConfig` (
  `id` int(7) NOT NULL AUTO_INCREMENT,
  `report_id` int(5) DEFAULT NULL,
  `name` varchar(80) NOT NULL DEFAULT '',
  `caption` varchar(80) NOT NULL DEFAULT '',
  `order_no` int(3) DEFAULT NULL,
  `table_name` varchar(80) NOT NULL DEFAULT '',
  `save` varchar(80) NOT NULL DEFAULT 'default',
  PRIMARY KEY (`id`),
  KEY `report_id` (`report_id`),
  KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportFilter`
--

DROP TABLE IF EXISTS `reportFilter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportFilter` (
  `id` int(7) NOT NULL AUTO_INCREMENT,
  `report_id` int(5) DEFAULT NULL,
  `description` text,
  `value` varchar(255) NOT NULL DEFAULT '',
  `position` varchar(80) NOT NULL DEFAULT '',
  `status` int(1) DEFAULT '1',
  `order_no` int(3) DEFAULT NULL,
  `javascript` text,
  `date_format` varchar(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `order_no` (`report_id`,`order_no`),
  KEY `report_id` (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportItem`
--

DROP TABLE IF EXISTS `reportItem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportItem` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(80) NOT NULL DEFAULT '',
  `status` int(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportTableFieldCaption`
--

DROP TABLE IF EXISTS `reportTableFieldCaption`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportTableFieldCaption` (
  `id` int(7) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(80) NOT NULL DEFAULT '',
  `name` varchar(80) NOT NULL DEFAULT '',
  `caption` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `table_name` (`table_name`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportTemplates`
--

DROP TABLE IF EXISTS `reportTemplates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportTemplates` (
  `templateid` int(11) NOT NULL AUTO_INCREMENT,
  `templatetitle` varchar(80) NOT NULL DEFAULT '',
  `templatedescription` text NOT NULL,
  `templatesql` text NOT NULL,
  `templatexml` text NOT NULL,
  `active` tinyint(4) NOT NULL DEFAULT '1',
  `type` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`templateid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_date`
--

DROP TABLE IF EXISTS `report_date`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_date` (
  `sessionid` varchar(32) NOT NULL,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `asofdate` date DEFAULT NULL,
  `startdate_s` varchar(8) DEFAULT NULL,
  `enddate_s` varchar(8) DEFAULT NULL,
  `asofdate_s` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`sessionid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_date_sp`
--

DROP TABLE IF EXISTS `report_date_sp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_date_sp` (
  `reportno` int(10) NOT NULL AUTO_INCREMENT,
  `startdate` date DEFAULT NULL,
  `enddate` date DEFAULT NULL,
  `asofdate` date DEFAULT NULL,
  `startdate_s` varchar(8) DEFAULT NULL,
  `enddate_s` varchar(8) DEFAULT NULL,
  `asofdate_s` varchar(8) DEFAULT NULL,
  `sptorun` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`reportno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_doctext`
--

DROP TABLE IF EXISTS `report_doctext`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_doctext` (
  `docid` int(10) NOT NULL AUTO_INCREMENT,
  `docdata` text,
  `revdatetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`docid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_document`
--

DROP TABLE IF EXISTS `report_document`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_document` (
  `docid` int(10) NOT NULL AUTO_INCREMENT,
  `subject` varchar(256) DEFAULT NULL,
  `privacycd` varchar(3) DEFAULT NULL,
  `ownerid` varchar(12) DEFAULT NULL,
  `checkoutyn` char(1) DEFAULT NULL,
  `checkoutuserid` varchar(12) DEFAULT NULL,
  `checkoutdate` datetime DEFAULT NULL,
  `doctype` varchar(3) DEFAULT NULL,
  `filename` varchar(128) DEFAULT NULL,
  `moduleid` varchar(6) DEFAULT NULL,
  `refno` varchar(12) DEFAULT NULL,
  `filetype` varchar(5) DEFAULT NULL,
  `viewid` varchar(36) DEFAULT NULL,
  `viewrefno` varchar(12) DEFAULT NULL,
  `revdatetime` datetime DEFAULT NULL,
  PRIMARY KEY (`docid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_filter`
--

DROP TABLE IF EXISTS `report_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_filter` (
  `fieldno` int(10) NOT NULL AUTO_INCREMENT,
  `reportno` int(10) DEFAULT '0',
  `fieldname` varchar(32) DEFAULT NULL,
  `fielddesc` varchar(80) DEFAULT NULL,
  `fieldtype` varchar(10) DEFAULT NULL,
  `lookup_table` varchar(30) DEFAULT NULL,
  `iscrosstabheaders` char(1) DEFAULT NULL,
  `operator` varchar(10) DEFAULT NULL,
  `lookup_tree` char(1) DEFAULT NULL,
  `fieldsql` varchar(32) DEFAULT NULL,
  `lookup_script` varchar(50) DEFAULT NULL,
  `note` varchar(128) DEFAULT NULL,
  `valueformat` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`fieldno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_letters`
--

DROP TABLE IF EXISTS `report_letters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_letters` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) DEFAULT NULL,
  `report_name` varchar(255) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `report_file` mediumblob,
  `date_time` datetime DEFAULT NULL,
  `archive` char(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `archive` (`archive`),
  KEY `provider_no` (`provider_no`),
  KEY `date_time` (`date_time`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_lk_reportgroup`
--

DROP TABLE IF EXISTS `report_lk_reportgroup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_lk_reportgroup` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `description` varchar(40) DEFAULT NULL,
  `shortdesc` varchar(10) DEFAULT NULL,
  `activeyn` char(1) DEFAULT NULL,
  `orderbyindex` int(10) DEFAULT '0',
  `note` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_option`
--

DROP TABLE IF EXISTS `report_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_option` (
  `reportoptionid` int(10) NOT NULL AUTO_INCREMENT,
  `reportno` int(10) NOT NULL,
  `optiontitle` varchar(120) DEFAULT NULL,
  `longdesc` varchar(120) DEFAULT NULL,
  `activeyn` tinyint(1) DEFAULT '0',
  `defaultyn` tinyint(1) DEFAULT '0',
  `datefield` varchar(32) DEFAULT NULL,
  `datefielddesc` varchar(32) DEFAULT NULL,
  `sqlwhere` text,
  `sqlorderby` text,
  `rptfilename` varchar(128) DEFAULT NULL,
  `rptfileno` int(10) DEFAULT '0',
  `rptversion` datetime DEFAULT NULL,
  `datefieldtype` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`reportoptionid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_qgviewfield`
--

DROP TABLE IF EXISTS `report_qgviewfield`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_qgviewfield` (
  `qgviewno` int(10) NOT NULL AUTO_INCREMENT,
  `fieldno` int(10) NOT NULL,
  `fieldname` varchar(32) NOT NULL,
  `description` varchar(80) DEFAULT NULL,
  `fieldtypecode` varchar(8) DEFAULT NULL,
  `numbermask` varchar(16) DEFAULT NULL,
  `fieldlength` int(10) DEFAULT '0',
  `sourcetxt` text,
  `note` varchar(255) DEFAULT NULL,
  `grouprank` int(10) DEFAULT '0',
  `lookuptable` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`qgviewno`,`fieldno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_qgviewsummary`
--

DROP TABLE IF EXISTS `report_qgviewsummary`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_qgviewsummary` (
  `qgviewno` int(10) NOT NULL AUTO_INCREMENT,
  `qgviewcode` varchar(30) NOT NULL,
  `description` varchar(80) DEFAULT NULL,
  `groupcode` varchar(10) DEFAULT NULL,
  `mastertype` char(1) DEFAULT NULL,
  `updatedby` varchar(12) DEFAULT NULL,
  `updateddate` datetime DEFAULT NULL,
  `note` text,
  `activeyn` char(1) DEFAULT NULL,
  `secureyn` char(1) DEFAULT NULL,
  `dbentity` varchar(40) DEFAULT NULL,
  `refviews` varchar(512) DEFAULT NULL,
  `relations` text,
  `filters` text,
  `object_type` varchar(5) DEFAULT NULL,
  `distinctyn` char(1) DEFAULT NULL,
  PRIMARY KEY (`qgviewno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_role`
--

DROP TABLE IF EXISTS `report_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_role` (
  `reportno` int(10) NOT NULL DEFAULT '0',
  `rolecode` varchar(20) NOT NULL,
  `access_type` char(1) DEFAULT NULL,
  PRIMARY KEY (`reportno`,`rolecode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_template`
--

DROP TABLE IF EXISTS `report_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_template` (
  `templateno` int(10) NOT NULL AUTO_INCREMENT,
  `reportno` int(10) NOT NULL DEFAULT '0',
  `reportoptionid` int(10) DEFAULT '0',
  `description` varchar(120) DEFAULT NULL,
  `startdate` datetime DEFAULT NULL,
  `enddate` datetime DEFAULT NULL,
  `startpayperiod` varchar(10) DEFAULT NULL,
  `endpayperiod` varchar(10) DEFAULT NULL,
  `loginid` varchar(20) DEFAULT NULL,
  `updatedate` datetime DEFAULT NULL,
  `privateyn` char(1) DEFAULT NULL,
  PRIMARY KEY (`templateno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_template_criteria`
--

DROP TABLE IF EXISTS `report_template_criteria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_template_criteria` (
  `counter` int(10) NOT NULL DEFAULT '0',
  `templateno` int(10) NOT NULL DEFAULT '0',
  `relation` varchar(10) DEFAULT NULL,
  `fieldno` int(10) DEFAULT '0',
  `operator` varchar(10) DEFAULT NULL,
  `operators` varchar(10) DEFAULT NULL,
  `val` varchar(40) DEFAULT NULL,
  `valdesc` varchar(120) DEFAULT NULL,
  `required` char(1) DEFAULT NULL,
  PRIMARY KEY (`templateno`,`counter`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `report_template_org`
--

DROP TABLE IF EXISTS `report_template_org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `report_template_org` (
  `counter` int(10) NOT NULL,
  `templateno` int(10) NOT NULL,
  `orgcd` varchar(72) DEFAULT NULL,
  PRIMARY KEY (`templateno`,`counter`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportagesex`
--

DROP TABLE IF EXISTS `reportagesex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportagesex` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT NULL,
  `age` int(4) DEFAULT '0',
  `roster` varchar(4) DEFAULT '',
  `sex` char(2) DEFAULT '',
  `provider_no` varchar(6) DEFAULT NULL,
  `reportdate` date DEFAULT NULL,
  `status` char(2) DEFAULT '',
  `date_joined` date DEFAULT '0001-01-01',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reportprovider`
--

DROP TABLE IF EXISTS `reportprovider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reportprovider` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(10) DEFAULT '',
  `team` varchar(10) DEFAULT '',
  `action` varchar(20) DEFAULT '',
  `status` char(1) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reporttemp`
--

DROP TABLE IF EXISTS `reporttemp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reporttemp` (
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `edb` date NOT NULL DEFAULT '0001-01-01',
  `demo_name` varchar(60) NOT NULL DEFAULT '',
  `provider_no` varchar(6) DEFAULT NULL,
  `address` text,
  `creator` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`demographic_no`,`edb`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `room_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `room_type_id` int(10) unsigned NOT NULL DEFAULT '1',
  `program_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `floor` varchar(45) DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `facility_id` int(11) NOT NULL,
  `assigned_bed` tinyint(1) NOT NULL DEFAULT '1',
  `occupancy` int(10) DEFAULT '0',
  PRIMARY KEY (`room_id`),
  KEY `FK_room_facility` (`facility_id`),
  CONSTRAINT `FK_room_facility` FOREIGN KEY (`facility_id`) REFERENCES `Facility` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_bed`
--

DROP TABLE IF EXISTS `room_bed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_bed` (
  `room_id` int(10) unsigned NOT NULL DEFAULT '0',
  `bed_id` int(10) unsigned NOT NULL DEFAULT '0',
  `assign_start` date DEFAULT '0000-00-00',
  `assign_end` date DEFAULT '0000-00-00',
  `comments` varchar(50) DEFAULT '',
  PRIMARY KEY (`room_id`,`bed_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_bed_historical`
--

DROP TABLE IF EXISTS `room_bed_historical`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_bed_historical` (
  `room_id` int(10) unsigned NOT NULL,
  `bed_id` int(10) unsigned NOT NULL,
  `contain_start` date NOT NULL,
  `contain_end` date NOT NULL,
  PRIMARY KEY (`room_id`,`bed_id`,`contain_start`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_demographic`
--

DROP TABLE IF EXISTS `room_demographic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_demographic` (
  `room_id` int(10) unsigned NOT NULL DEFAULT '0',
  `demographic_no` int(10) unsigned NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `assign_start` date DEFAULT '0000-00-00',
  `assign_end` date DEFAULT '0000-00-00',
  `comments` varchar(50) DEFAULT '',
  PRIMARY KEY (`room_id`,`demographic_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `room_type`
--

DROP TABLE IF EXISTS `room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room_type` (
  `room_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `dflt` tinyint(1) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`room_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `rschedule`
--

DROP TABLE IF EXISTS `rschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rschedule` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `sdate` date NOT NULL DEFAULT '0001-01-01',
  `edate` date DEFAULT NULL,
  `available` char(1) NOT NULL DEFAULT '',
  `day_of_week` varchar(30) DEFAULT NULL,
  `avail_hourB` varchar(255) DEFAULT NULL,
  `avail_hour` text,
  `creator` varchar(50) DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduledate`
--

DROP TABLE IF EXISTS `scheduledate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduledate` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `sdate` date NOT NULL DEFAULT '0001-01-01',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `available` char(1) NOT NULL DEFAULT '',
  `priority` char(1) DEFAULT NULL,
  `siteId` int(11) DEFAULT NULL,
  `hour` varchar(255) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `status` char(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `scheduledate_sdate_index` (`sdate`),
  KEY `scheduledate_provider_no_index` (`provider_no`),
  KEY `scheduledate_status_index` (`status`),
  KEY `scheduledate_key1` (`sdate`,`provider_no`,`hour`,`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduleholiday`
--

DROP TABLE IF EXISTS `scheduleholiday`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduleholiday` (
  `sdate` date NOT NULL DEFAULT '0001-01-01',
  `holiday_name` varchar(100) NOT NULL DEFAULT '',
  PRIMARY KEY (`sdate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduletemplate`
--

DROP TABLE IF EXISTS `scheduletemplate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduletemplate` (
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `name` varchar(20) NOT NULL DEFAULT '',
  `summary` varchar(80) DEFAULT NULL,
  `timecode` text,
  PRIMARY KEY (`provider_no`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scheduletemplatecode`
--

DROP TABLE IF EXISTS `scheduletemplatecode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scheduletemplatecode` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `code` char(1) NOT NULL DEFAULT '',
  `description` varchar(80) DEFAULT NULL,
  `duration` char(3) DEFAULT '',
  `color` varchar(10) DEFAULT NULL,
  `confirm` char(3) NOT NULL DEFAULT 'No',
  `bookinglimit` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `filename` varchar(255) NOT NULL,
  PRIMARY KEY (`filename`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scratch_pad`
--

DROP TABLE IF EXISTS `scratch_pad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scratch_pad` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) DEFAULT NULL,
  `date_time` datetime DEFAULT NULL,
  `scratch_text` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `secObjPrivilege`
--

DROP TABLE IF EXISTS `secObjPrivilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secObjPrivilege` (
  `roleUserGroup` varchar(30) NOT NULL DEFAULT '',
  `objectName` varchar(100) NOT NULL DEFAULT '',
  `privilege` varchar(100) NOT NULL DEFAULT '|0|',
  `priority` int(2) DEFAULT '0',
  `provider_no` varchar(6) DEFAULT NULL,
  PRIMARY KEY (`roleUserGroup`,`objectName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `secObjectName`
--

DROP TABLE IF EXISTS `secObjectName`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secObjectName` (
  `objectName` varchar(100) NOT NULL DEFAULT '',
  `description` varchar(60) DEFAULT NULL,
  `orgapplicable` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`objectName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `secPrivilege`
--

DROP TABLE IF EXISTS `secPrivilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secPrivilege` (
  `id` int(2) NOT NULL AUTO_INCREMENT,
  `privilege` varchar(5) NOT NULL DEFAULT '0',
  `description` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `privilege` (`privilege`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `secRole`
--

DROP TABLE IF EXISTS `secRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secRole` (
  `role_no` int(3) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(60) NOT NULL DEFAULT '',
  `description` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`role_no`),
  UNIQUE KEY `role_name` (`role_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `secUserRole`
--

DROP TABLE IF EXISTS `secUserRole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `secUserRole` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) NOT NULL,
  `role_name` varchar(30) NOT NULL,
  `orgcd` varchar(80) DEFAULT 'R0000001',
  `activeyn` int(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `security`
--

DROP TABLE IF EXISTS `security`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `security` (
  `security_no` int(6) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(30) NOT NULL DEFAULT '',
  `password` varchar(80) NOT NULL DEFAULT '',
  `provider_no` varchar(6) DEFAULT NULL,
  `pin` varchar(6) DEFAULT NULL,
  `b_ExpireSet` int(1) DEFAULT '1',
  `date_ExpireDate` date DEFAULT '2100-01-01',
  `b_LocalLockSet` int(1) DEFAULT '1',
  `b_RemoteLockSet` int(1) DEFAULT '1',
  PRIMARY KEY (`security_no`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `serviceSpecialists`
--

DROP TABLE IF EXISTS `serviceSpecialists`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serviceSpecialists` (
  `serviceId` int(10) DEFAULT NULL,
  `specId` int(10) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `site` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `short_name` varchar(10) NOT NULL DEFAULT '',
  `phone` varchar(50) DEFAULT '',
  `fax` varchar(50) DEFAULT '',
  `bg_color` varchar(20) NOT NULL DEFAULT '',
  `address` varchar(255) DEFAULT '',
  `city` varchar(25) DEFAULT '',
  `province` varchar(25) DEFAULT '',
  `postal` varchar(10) DEFAULT '',
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `providerId_from` int(11) DEFAULT NULL,
  `providerId_to` int(11) DEFAULT NULL,
  `clinicNo` int(11) DEFAULT NULL,
  PRIMARY KEY (`site_id`),
  UNIQUE KEY `unique_name` (`name`),
  UNIQUE KEY `unique_shortname` (`short_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `specialistsJavascript`
--

DROP TABLE IF EXISTS `specialistsJavascript`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `specialistsJavascript` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `setId` char(1) DEFAULT NULL,
  `javascriptString` mediumtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spireAccessionNumberMap`
--

DROP TABLE IF EXISTS `spireAccessionNumberMap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spireAccessionNumberMap` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `uaccn` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `spireCommonAccessionNumber`
--

DROP TABLE IF EXISTS `spireCommonAccessionNumber`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `spireCommonAccessionNumber` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `caccn` varchar(20) NOT NULL,
  `lab_no` int(10) DEFAULT NULL,
  `map_id` int(10) DEFAULT NULL,
  `order_index` int(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `study`
--

DROP TABLE IF EXISTS `study`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `study` (
  `study_no` int(3) NOT NULL AUTO_INCREMENT,
  `study_name` varchar(20) NOT NULL DEFAULT '',
  `study_link` varchar(255) NOT NULL DEFAULT '',
  `description` varchar(255) NOT NULL DEFAULT '',
  `form_name` varchar(30) DEFAULT NULL,
  `current1` tinyint(1) DEFAULT '0',
  `remote_serverurl` varchar(50) DEFAULT NULL,
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`study_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studydata`
--

DROP TABLE IF EXISTS `studydata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studydata` (
  `studydata_no` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `study_no` int(3) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` varchar(30) DEFAULT NULL,
  `content` text,
  PRIMARY KEY (`studydata_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `studylogin`
--

DROP TABLE IF EXISTS `studylogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `studylogin` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `provider_no` varchar(6) DEFAULT NULL,
  `study_no` int(3) DEFAULT NULL,
  `remote_login_url` varchar(100) DEFAULT NULL,
  `url_name_username` varchar(20) NOT NULL DEFAULT '',
  `url_name_password` varchar(20) NOT NULL DEFAULT '',
  `username` varchar(30) NOT NULL DEFAULT '',
  `password` varchar(100) NOT NULL DEFAULT '',
  `current1` tinyint(1) DEFAULT NULL,
  `creator` varchar(6) NOT NULL DEFAULT '',
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey`
--

DROP TABLE IF EXISTS `survey`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey` (
  `surveyid` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `surveyData` text,
  `status` smallint(6) DEFAULT NULL,
  `userId` bigint(20) DEFAULT NULL,
  `facilityId` int(11) DEFAULT NULL,
  `dateCreated` datetime DEFAULT NULL,
  `dateLaunched` datetime DEFAULT NULL,
  `dateClosed` datetime DEFAULT NULL,
  `launched_instance_id` bigint(20) DEFAULT NULL,
  `version` bigint(20) DEFAULT '0',
  PRIMARY KEY (`surveyid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `surveyData`
--

DROP TABLE IF EXISTS `surveyData`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `surveyData` (
  `surveyDataId` int(10) NOT NULL AUTO_INCREMENT,
  `surveyId` varchar(5) DEFAULT NULL,
  `demographic_no` int(10) DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `status` char(2) DEFAULT NULL,
  `survey_date` date DEFAULT NULL,
  `answer` varchar(10) DEFAULT NULL,
  `processed` int(10) DEFAULT NULL,
  PRIMARY KEY (`surveyDataId`),
  KEY `surveyId_index` (`surveyId`),
  KEY `demographic_no_index` (`demographic_no`),
  KEY `provider_no_index` (`provider_no`),
  KEY `status_index` (`status`),
  KEY `survey_date_index` (`survey_date`),
  KEY `answer_index` (`answer`),
  KEY `processed_index` (`processed`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey_test_data`
--

DROP TABLE IF EXISTS `survey_test_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_test_data` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `instance_id` bigint(20) DEFAULT NULL,
  `page_number` bigint(20) DEFAULT NULL,
  `section_id` bigint(20) DEFAULT NULL,
  `question_id` bigint(20) DEFAULT NULL,
  `value` text,
  `data_key` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKB5082892A9437DC8` (`instance_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `survey_test_instance`
--

DROP TABLE IF EXISTS `survey_test_instance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `survey_test_instance` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `survey_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `client_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `table_modification`
--

DROP TABLE IF EXISTS `table_modification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `table_modification` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `provider_no` varchar(6) NOT NULL DEFAULT '',
  `modification_date` datetime DEFAULT NULL,
  `modification_type` varchar(20) DEFAULT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `row_id` varchar(20) DEFAULT NULL,
  `resultSet` text,
  PRIMARY KEY (`id`),
  KEY `table_modification_demographic_no` (`demographic_no`),
  KEY `table_modification_provider_no` (`provider_no`),
  KEY `table_modification_modification_type` (`modification_type`(10))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tickler`
--

DROP TABLE IF EXISTS `tickler`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickler` (
  `tickler_no` int(10) NOT NULL AUTO_INCREMENT,
  `demographic_no` int(10) DEFAULT '0',
  `program_id` int(11) DEFAULT NULL,
  `message` text,
  `status` char(1) DEFAULT NULL,
  `update_date` datetime DEFAULT '0001-01-01 00:00:00',
  `service_date` datetime DEFAULT NULL,
  `creator` varchar(6) DEFAULT NULL,
  `priority` varchar(6) DEFAULT 'Normal',
  `task_assigned_to` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`tickler_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tickler_comments`
--

DROP TABLE IF EXISTS `tickler_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickler_comments` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `tickler_no` int(10) NOT NULL,
  `message` text,
  `provider_no` varchar(6) NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tickler_link`
--

DROP TABLE IF EXISTS `tickler_link`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickler_link` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `table_name` char(3) NOT NULL,
  `table_id` int(10) NOT NULL,
  `tickler_no` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tickler_link_tickler_no_index` (`tickler_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tickler_text_suggest`
--

DROP TABLE IF EXISTS `tickler_text_suggest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickler_text_suggest` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `creator` varchar(6) NOT NULL,
  `suggested_text` varchar(255) NOT NULL,
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tickler_update`
--

DROP TABLE IF EXISTS `tickler_update`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickler_update` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `tickler_no` int(10) NOT NULL,
  `status` char(1) DEFAULT NULL,
  `assignedTo` varchar(6) DEFAULT NULL,
  `serviceDate` datetime DEFAULT NULL,
  `priority` varchar(6) DEFAULT NULL,
  `provider_no` varchar(6) NOT NULL,
  `update_date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `uploadfile_from`
--

DROP TABLE IF EXISTS `uploadfile_from`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `uploadfile_from` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from_name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_ds_message_prefs`
--

DROP TABLE IF EXISTS `user_ds_message_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_ds_message_prefs` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(255) DEFAULT NULL,
  `resource_id` varchar(255) DEFAULT NULL,
  `resource_updated_date` date DEFAULT NULL,
  `provider_no` varchar(6) DEFAULT NULL,
  `record_created` date DEFAULT NULL,
  `archived` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `archived` (`archived`),
  KEY `provider_no` (`provider_no`),
  KEY `resource_id` (`resource_id`),
  KEY `resource_type` (`resource_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `vacancy_template`
--

DROP TABLE IF EXISTS `vacancy_template`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vacancy_template` (
  `TEMPLATE_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PROGRAM_ID` int(11) NOT NULL,
  `NAME` varchar(32) NOT NULL,
  `ACTIVE` tinyint(1) NOT NULL,
  `WL_PROGRAM_ID` int(11) NOT NULL,
  PRIMARY KEY (`TEMPLATE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `validations`
--

DROP TABLE IF EXISTS `validations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `validations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `regularExp` varchar(100) DEFAULT NULL,
  `maxValue` double DEFAULT NULL,
  `minValue` double DEFAULT NULL,
  `maxLength` int(3) DEFAULT NULL,
  `minLength` int(3) DEFAULT NULL,
  `isNumeric` tinyint(1) DEFAULT NULL,
  `isTrue` tinyint(1) DEFAULT NULL,
  `isDate` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `view`
--

DROP TABLE IF EXISTS `view`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `view` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `view_name` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  `value` text,
  `role` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `waitingList`
--

DROP TABLE IF EXISTS `waitingList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waitingList` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `listID` int(11) DEFAULT NULL,
  `demographic_no` int(10) NOT NULL DEFAULT '0',
  `note` varchar(255) DEFAULT NULL,
  `position` bigint(20) NOT NULL DEFAULT '0',
  `onListSince` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_history` char(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `listID` (`listID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `waitingListName`
--

DROP TABLE IF EXISTS `waitingListName`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `waitingListName` (
  `ID` bigint(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL DEFAULT '',
  `group_no` varchar(10) DEFAULT '',
  `provider_no` varchar(6) DEFAULT '',
  `create_date` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `is_history` char(1) DEFAULT 'N',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-03-27 14:45:13
