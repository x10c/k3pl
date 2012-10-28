create table T_RCA_IMAGES (
	ID			bigint 			identity (1,1)	not null
,	ID_RCA		bigint			not null
,	IMAGE_NAME	varchar (1024)	not null
,	IMAGE_SIZE	int				not null
,	UPLOAD_DATE	datetime		not null default getdate()
,	UPLOADER	varchar (20)	not null
,	constraint PK_T_RCA_IMAGES primary key (ID)
,	constraint T_RCA_IMAGES_FK_RCA	foreign key (ID_RCA)	references T_RCA (ID_RCA)
,	constraint T_RCA_IMAGES_FK_USER	foreign key (UPLOADER)	references __USER (NIPG)
)
go

create index T_RCA_IMAGES_FK on T_RCA_IMAGES (
UPLOADER ASC
)
go
