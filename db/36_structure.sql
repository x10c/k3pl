create table T_RCA_IMAGES (
	ID_RCA		bigint			not null
,	IMAGE_NAME	varchar (1024)	not null
,	IMAGE_SIZE	int				not null
,	UPLOAD_DATE	datetime		not null default getdate()
,	UPLOADER	varchar (20)	not null
,	constraint PK_T_RCA_IMAGES primary key (ID_RCA)
)
go

create index T_RCA_IMAGES_FK on T_RCA_IMAGES (
UPLOADER ASC
)
go

alter table T_RCA_IMAGES
   add constraint FK_T_RCA_T_RCA_IMAGES foreign key (ID_RCA)
      references T_RCA (ID_RCA)
go

alter table T_RCA_IMAGES
   add constraint FK___USER_T_RCA_IMAGES foreign key (UPLOADER)
      references __USER (NIPG)
go
