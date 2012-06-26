alter table R_JABATAN_KOMITE_SUB_KOMITE add NOTULEN tinyint default 0
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1=true; 0=false',
   'user', @CurrentUser, 'table', 'R_JABATAN_KOMITE_SUB_KOMITE', 'column', 'NOTULEN'
go
