
drop table generic_master;
drop table form_st3;
drop table  ret_filed_srvs_cat;
drop table ip_srvc_credit_srvs;  
DROP  TABLE pay_det_srvctax_cat;
DROP  TABLE pay_det_srvctax_cat_det;

create table generic_master
(
 mastercode varchar(100),
 answ1 varchar(100),
 code1 varchar(20),
 disp_order SMALLINT(2),
 answ2 varchar(100),
 answ3 varchar(100),
 answ4 varchar(100),
 answ5 varchar(100)
);

CREATE TABLE form_st3(
 fst3_fin_yr varchar(10),
 fst3_fin_period_cd varchar(3),
 fst3_assessee_name varchar(50),
 fst3_premises_reg_no varchar(50),
 fst3_lastday_amt_payable varchar(500),
 fst3_place varchar(50),
 fst3_date varchar(20),
 fst3_fin_period_text1 varchar(50)
);


CREATE TABLE ret_filed_srvs_cat(
  rfsc_fin_yr varchar(10),
  rfsc_fin_period_cd varchar(3),
  rfsc_desc varchar(1000),
  rfsc_order_no SMALLINT(2) UNSIGNED
);


CREATE TABLE ip_srvc_credit_srvs(
  ipsvcs_fin_yr varchar(10),
  ipsvcs_fin_period_cd varchar(3),
  ipsvcs_desc varchar(1000),
  ipsvcs_order_no SMALLINT(2) UNSIGNED
);

CREATE TABLE pay_det_srvctax_cat(
  pdsc_id int primary key auto_increment,
  pdsc_fin_yr varchar(10),
  pdsc_fin_period_cd varchar(3),
  pdsc_group_no varchar(2),
  pdsc_header varchar(500)
);


CREATE TABLE pay_det_srvctax_cat_det(
  pdscd_pdsc_id int,
  pdscd_desc_cd varchar(100),
  pdscd_f1  varchar(50),
  pdscd_f2  varchar(50),
  pdscd_f3  varchar(50),
  pdscd_f4  varchar(50),
  pdscd_f5  varchar(50),
  pdscd_f6  varchar(50),
  pdscd_ftotal  varchar(50)
);

DELETE FROM generic_master
where mastercode IN (
'FINANCIAL_PERIOD',
'PAN_NO',
'SERVICE_TAX_NO',
'AUTHORISED_SIGNATORY',
'ADDRESS_LINE1',
'TELEPHONE_NO',
'EMAIL_ID'
);

INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2 )
VALUES('FINANCIAL_PERIOD','April - September','01',1,'April $1 - September $1');

INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2 )
VALUES('FINANCIAL_PERIOD','October - March','02',2,'October $1 - March $2');

INSERT INTO generic_master(mastercode,answ1)
VALUES('PAN_NO','ABAFS1309M');

INSERT INTO generic_master(mastercode,answ1)
VALUES('SERVICE_TAX_NO','STC/K-III/TH-I/BAS/36/04-05');

INSERT INTO generic_master(mastercode,answ1)
VALUES('AUTHORISED_SIGNATORY','Shri Durga Eximport Services');

INSERT INTO generic_master(mastercode,answ1)
VALUES('ADDRESS_LINE1','B-703,SUNFLOWER, Flower Valley Complex, Khadakpadada Cricle, Kalyan(W) Pin - 421301');

INSERT INTO generic_master(mastercode,answ1)
VALUES('TELEPHONE_NO','98190 21728');

INSERT INTO generic_master(mastercode,answ1)
VALUES('EMAIL_ID','shri.durga@rediffmail.com');


/*
PAY_DET_SRV_TAX_CAT values START
*/

DELETE FROM generic_master
WHERE mastercode = 'PAY_DET_SRV_TAX_CAT';

INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Amount received towards taxable
 service(s) provided','01',1,'NUMBER');

INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2 )
VALUES('PAY_DET_SRV_TAX_CAT','Amount received in advance towards
 taxable service(s) to be provided','02',2,'NUMBER');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Amount Billed- gross','03',3,'NUMBER');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Amount billed for exempted services
 other than export','04',4,'NUMBER');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Amount billed for exported services,
 without payment of tax','05',5,'NUMBER');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Amount billed for services on 
which tax is to be paid','06',6,'NUMBER');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Abatement claimed - Value ','07',7,'NUMBER');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Notification number of Abatement','08',8,'STRING');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Notification number of exemption','09',9,'STRING');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Provisional Assessment order No.','10',10,'STRING');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Service Tax payable','11',11,'NUMBER');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Education cess payable','12',12,'NUMBER');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Service tax paid in cash','13',13,'NUMBER');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Challan Number','14',14,'STRING');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Challan date','15',15,'DATE');
 
 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Service tax paid through cenvat credit','16',16,'NUMBER');

 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Education cess paid in cash','17',17,'NUMBER');

 INSERT INTO generic_master(mastercode,answ1,code1,disp_order,answ2)
VALUES('PAY_DET_SRV_TAX_CAT','Education cess paid through education cess credit','18',18,'NUMBER');

/*
PAY_DET_SRV_TAX_CAT values END
*/

