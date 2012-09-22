/* table of RCA images */
drop table T_RCA_IMAGES;

create table T_RCA_IMAGES (
	ID_RCA		bigint			foreign key references T_RCA (ID_RCA)
,	IMAGE_NAME	varchar (1024)	not null
,	IMAGE_SIZE	int				not null
,	UPLOAD_DATE	datetime		not null default current_timestamp
,	UPLOADER	varchar (20)	foreign key references __USER (NIPG)
);
