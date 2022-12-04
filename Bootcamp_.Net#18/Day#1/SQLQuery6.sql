-- insert data into tabel hr.regions -- 
--autoincerement on/off
select * from hr.REGIONS
insert into hr.REGIONS (region_name) 
values
('Asia');

set identity_insert hr.regions on;
insert into hr.regions (region_id, region_name)
values
(3,'Europe');
set identity_insert hr.regions off;

-- update data tabee
update hr.regions set region_name='Africa' where region_id=1 ; 


-- delete data tabel
delete from hr.regions
delete from hr.countries
select*from hr.regions

--reset identity column region_id di table hr.region ke "0" lagi
dbcc checkident('hr.regions', RESEED,0);

-- insert ke tabel hr.countries harus ada parent key di tabel hr.regions untuk region_id
insert into hr.countries (country_id, country_name, region_id)
values
('SG', 'Singapore', 1);
select * from hr.countries

SET IDENTITY_INSERT hr.regions ON;
Insert into HR.REGIONS (REGION_ID,REGION_NAME) values ('1','Europe');
Insert into HR.REGIONS (REGION_ID,REGION_NAME) values ('2','Americas');
Insert into HR.REGIONS (REGION_ID,REGION_NAME) values ('3','Asia');
Insert into HR.REGIONS (REGION_ID,REGION_NAME) values ('4','Middle East and Africa');
SET IDENTITY_INSERT hr.regions OFF;

Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('AR','Argentina','2');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('AU','Australia','3');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('BE','Belgium','1');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('BR','Brazil','2');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CA','Canada','2');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CH','Switzerland','1');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('CN','China','3');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DE','Germany','1');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('DK','Denmark','1');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('EG','Egypt','4');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('FR','France','1');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IL','Israel','4');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IN','India','3');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('IT','Italy','1');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('JP','Japan','3');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('KW','Kuwait','4');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ML','Malaysia','3');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('MX','Mexico','2');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('NG','Nigeria','4');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('NL','Netherlands','1');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('SG','Singapore','3');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('UK','United Kingdom','1');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('US','United States of America','2');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ZM','Zambia','4');
Insert into HR.COUNTRIES (COUNTRY_ID,COUNTRY_NAME,REGION_ID) values ('ZW','Zimbabwe','4');

