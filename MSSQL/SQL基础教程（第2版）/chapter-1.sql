-- 1.1
CREATE TABLE Addressbook(
	regist_no integer not null primary key,
	name varchar(128) not null,
	address varchar(256) not null,
	tel_no char(10),
	mail_address char(20)
);

-- 1.2
ALTER TABLE Addressbook ADD postal_code char(8) not null;

--1.3 
DROP TALBE Addressbook;

-- 1.4 无法恢复