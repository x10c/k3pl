alter table R_KEL_JABATAN_KOMITE_SUB_KOMITE add TYPE_KOMITE tinyint not null default 1
go

declare @CurrentUser sysname
select @CurrentUser = user_name()
execute sp_addextendedproperty 'MS_Description', 
   '1=csc; 2=sc',
   'user', @CurrentUser, 'table', 'R_KEL_JABATAN_KOMITE_SUB_KOMITE', 'column', 'TYPE_KOMITE'
go
