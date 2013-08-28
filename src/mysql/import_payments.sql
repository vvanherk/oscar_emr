
CREATE TABLE `billing_on_payment` (
  `id` int(12) NOT NULL AUTO_INCREMENT,
  `ch1_id` int(12) NOT NULL,
  `payment` decimal(10,2) NOT NULL,
  `paymentTypeId` int(12) NOT NULL,
  `paymentDate` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ch1_id` (`ch1_id`),
  KEY `paymentTypeId` (`paymentTypeId`)
) ENGINE=InnoDB;

UPDATE billing_on_ext SET VALUE=REPLACE(VALUE,',','') WHERE key_val='payment' OR key_val='total' OR key_val='refund';
UPDATE billing_on_ext SET VALUE=REPLACE(VALUE,'..','.') WHERE key_val='payment' OR key_val='total' OR key_val='refund';
UPDATE billing_on_ext SET VALUE=REPLACE(VALUE,'--','-') WHERE key_val='payment' OR key_val='total' OR key_val='refund';
UPDATE billing_on_ext SET VALUE=REPLACE(VALUE,' ','') WHERE key_val='payment' OR key_val='total' OR key_val='refund';
##replace period typed instead of comma in numbers
CREATE TABLE evk_ext_temp AS
(SELECT be.id
FROM billing_on_ext be WHERE ROUND((LENGTH(be.VALUE)-LENGTH(REPLACE(be.VALUE, '.', '')))/LENGTH(','))>1
AND (be.key_val='total' OR be.key_val='payment' OR be.key_val='refund'));
UPDATE billing_on_ext SET VALUE=REPLACE(VALUE,LEFT(VALUE,LOCATE('.',VALUE)), 
CONCAT(LEFT(VALUE,LOCATE('.',VALUE)-1),'')) WHERE id IN (SELECT id FROM evk_ext_temp);
DROP TABLE evk_ext_temp;

UPDATE billing_on_ext SET VALUE=CONCAT(VALUE,'00') WHERE SUBSTR(VALUE,LENGTH(VALUE))='.';

INSERT INTO billing_on_payment (ch1_id,payment) (SELECT sb.billing_no,SUM(sb.av) FROM 
(SELECT billing_no,ABS(be.value) AS av FROM billing_on_ext be WHERE (be.key_val='payment' OR be.key_val='total') AND VALUE<>'0.00' AND VALUE<>'0'
 UNION SELECT billing_no,-ABS(be.value) AS av FROM billing_on_ext be WHERE be.key_val='refund' AND VALUE<>'0.00' AND VALUE<>'0') sb
GROUP BY billing_no);
UPDATE billing_on_payment bp JOIN billing_on_ext be ON bp.ch1_id=be.billing_no SET bp.paymentDate=DATE(be.value) WHERE be.key_val='payDate' AND be.value IS NOT NULL;
UPDATE billing_on_payment bp JOIN billing_on_ext be ON bp.ch1_id=be.billing_no SET bp.paymentTypeId=be.value WHERE be.key_val='payMethod' AND be.value IS NOT NULL AND be.value<>0;
UPDATE billing_on_payment SET paymentDate='0000-00-00' WHERE paymentDate IS NULL;
UPDATE billing_on_payment SET paymentTypeId=1 WHERE paymentTypeId IS NULL;

ALTER TABLE billing_on_payment MODIFY payment DECIMAL(10,2) NOT NULL;
ALTER TABLE billing_on_payment MODIFY paymentTypeId INT(12) NOT NULL;
ALTER TABLE billing_on_payment MODIFY paymentDate DATE NOT NULL;
